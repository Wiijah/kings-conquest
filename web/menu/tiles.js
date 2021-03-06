var ICON_SCALE_FACTOR = 0.65;
var MOVEMENT_STEP = 6.5;

var stage = new createjs.Stage("gameCanvas");
stage.scaleX = 0.675;
stage.scaleY = stage.scaleX;

var that = this;
var team = 0;

var isDragging = false;
var offX;
var offY;


var path = [];
var highlighted = [];
var sub_highlighted = [];
var units = [];
var maps;
var blockMap;
var tile_display;
var highLight_tile;
var tile_info_text;


var moveButton;
var attackButton;
var skillButton;
var cancelButton;
var menuBackground;

var bottomInterface  = new createjs.Container();
var statsDisplay = new createjs.Container();
var unitCreationMenu = new createjs.Container();
var unitCards = [];

var isDisplayingMenu = false;
var isInHighlight = false;
var changed = false;
var movingPlayer = false;
var isAttacking = false;
var remainingAttackTimes;
var isCasting = false;
var currentGold;
var currentGoldDisplay;
var turn = 0;
var showUnitInfo = false;
var resized = false;
function resize() {
	// stage.canvas.width = window.innerWidth;
	//stage.canvas.height = window.innerHeight;
	//drawGame();
	//drawStatsDisplay();
	resized = true;
}

// typeName : king, red_castle, wizard, etc
// initial: true / false

$(document).ready(function() {
    var bg_x = 0;
    setInterval(function(){
        bg_x += 5;
        $('body').css('background-position', '-' + bg_x + 'px 0');
        $('.clouds').css('background-position', bg_x + 'px 0');
    }, 125);
});

function spawnUnit(data, isCreation){
	//|| data.address == "graphics/spritesheet/stand/ss_scarecrow_stand.png"
    if (data.address == "graphics/spritesheet/stand/ss_rogue_stand.png") return;
		var spriteSheet = new createjs.SpriteSheet({
          	"images": [data.address],
          	"frames": {"regX": 0, "height": 142, "count": 2, "regY": -10, "width": 113 },
          	"animations": {
            	"stand":[0,1]
          	},
          	framerate: 2
    	});

		var unit = new createjs.Sprite(spriteSheet, "stand");

		
		createjs.Ticker.timingMode = createjs.Ticker.RAF;	
			createjs.Ticker.addEventListener("tick", stage);
		// Configure unit coordinates
		unit.hp = data.hp;
		unit.max_hp = data.max_hp;
		unit.attack = data.attack;
		unit.base_attack = unit.attack;
		unit.luck = data.luck;

		var damageEffect = new createjs.SpriteSheet({
			"images": [data.damageEffect],
			"frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 95},
			"animations": {
				"damage":{
					frames: [0,1,2,3],
					next: false
				}
			},
			framerate: 4
		});
		unit.damageEffect = damageEffect;

		unit.team = data.team;
        if (isCreation) {
            var coord = findFreeSpace();
            unit.row = coord[0];
            unit.column = coord[1];
        } else {
		  unit.column = data.y;
		  unit.row = data.x;
        }
		unit.x = originX +  (unit.column - unit.row) * 65;
		unit.y = unit.column * 32.5 + originY + unit.row * 32.5;
	

		unit.regX = 56.5;
		unit.regY = 130;
		if (unit.team == 0 && data.skill_no != -1) unit.scaleX = -0.7;
        else unit.scaleX = 0.7
		unit.scaleY = 0.7;
		unit.skill = data.skill;
		unit.address = data.address;
		unit.info = data.info;

		unit.spritesheet = new createjs.SpriteSheet({
			"images": [data.spritesheet],
			"frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 95},
			"animations": {
				"attack":{
					frames: [0,1,2,3],
					next: false	
				}
			},
			framerate: 4
		});
		unit.skill_no = data.skill_no;
		unit.buffs = [];
		unit.buff_icons = [];

		// Configure the hp bar of the unit
		hp_bar = new createjs.Shape();
		hp_bar.x = unit.x - 40;
		hp_bar.y = unit.y - 95;
		// if (unit.team === 0){
		// 	hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
		// 	hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
		// 	hp_bar.graphics.beginFill("#ff0000").drawRect(1, 1, (getHealth(data)/getMaxHealth(data)) * 80, 10);
		// } else {
		// 	hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
		// 	hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
		// 	hp_bar.graphics.beginFill("#3399ff").drawRect(1, 1, (getHealth(data)/getMaxHealth(data)) * 80, 10);
		// }
		unit.hp_bar = hp_bar;


		// Configure move and attack range of the unit
		unit.moveRange = data.moveRange;
		unit.attackRange = data.attackRange;

		// Configure action control informations
		unit.canMove = data.canMove;
		unit.canAttack = data.canAttack;
		unit.skillCoolDown = data.skillCoolDown;
		unit.outOfMoves = data.outOfMoves;

		// Adding the unit to the list of units in the game
		units.push(unit);


		blockMaps[unit.row][unit.column] = 1;

		// Add the unit and its hp bar to the stage
		draggable.addChild(unit);
		draggable.addChild(hp_bar);

		sortIndices(unit);

		unit.cache(0,0,150,150);
		hp_bar.cache(0,0,100,120);

		//addEventListenersToUnit(unit);
	// });		
}

function findFreeSpace(){
	if (turn == 0){
		//red castle postion[0,0]
		var empty = findReachableTiles(0, 0, 10, false);
		var x,y;
		for (i = 1; i < empty.length; i++){
			x = empty[i][0];
			y = empty[i][1];
			if (blockMaps[x][y] == 0) {
				return [x,y];
			}
		}
	} else {
		//blue castle postion [12,13]
		var empty = findReachableTiles(12, 13, 10, false);
		var x,y;
		for (i = 1; i < empty.length; i++){
			x = empty[i][0];
			y = empty[i][1];
			if (blockMaps[x][y] == 0) {
				return [x,y];
			}
		}
	}
}

function initGame() {
	createjs.Ticker.addEventListener("tick", keyEvent);
    this.document.onkeydown = keyEvent;
	stage.enableMouseOver(20);

	chars = new createjs.Container();
	stage.addChild(chars);

	$.getJSON('game-map.json', function(data) {
		that.mapData = data['main'];
        that.classStats = data.classStats;
		console.log("init game");
		mapHeight = parseInt(data.map_dimensions.height);
		mapWidth = parseInt(data.map_dimensions.width);

		blockMaps = new Array(mapHeight);
		for (var i = 0; i < mapHeight; i++) {
			blockMaps[i] = new Array(mapWidth);
			for (var j = 0; j < mapWidth; j++) {
				blockMaps[i][j] = 0;
			}
		}



		currentGold = data.currentGold;
		drawGoldDisplay();
		
		that.drawMap(that.mapData);

		//should only spawn 2 kings and castles
		$.each(data.characters, function(i, value) {
			// console.log(data.characters[i].x);
			spawnUnit(data.characters[i], false);
		});
	});


	stage.canvas.width = $("body").prop("clientWidth");
	stage.canvas.height = $("body").prop("clientHeight") + 200;


	draggable = new createjs.Container();
	var box = new createjs.Shape();
	draggable.addChild(box);
	
	draggable.on("pressup", function(event) {
		if (isDragging) {
			isDragging = false;
		}
	})
	stage.addChild(draggable);

	upper = new createjs.Container();
	upper.x = draggable.x;
	upper.y = draggable.y;
	stage.addChild(upper);

	stage.setChildIndex(draggable, stage.getNumChildren()-1);
	stage.setChildIndex( upper, stage.getNumChildren()-1);
	stage.setChildIndex( chars, stage.getNumChildren()-1);

	drawStatsDisplay();
	drawUnitCreationMenu();
	drawBottomInterface();


	changed = true;

	window.addEventListener('resize', resize, false);
}

function removeBuff(buffType, unit) {
    var success = false;

    for (var i = 0; i < unit.buffs.length; i++) {
        if (unit.buffs[i][0] === buffType) {
            chars.removeChild(unit.buffs[i][3]);
            unit.buffs.splice(i, 1);
            success = true;
            break;
        } 
    }

    for (var i = 0; i < unit.buffs.length; i++) {
        unit.buffs[i][3].x = unit.hp_bar.x + i * 25;
        stage.update();
    }
    return success;
}


function applyBuff(buffType, unit) {
    for (var i = 0; i < unit.buffs.length; i++) {
        if (unit.buffs[i][0] === buffType) {
            chars.removeChild(unit.buffs[i][3]);
            unit.buffs.splice(i, 1);
            break;
        }
    }
	switch (buffType) {
		case 0: // hp Buff 
            break;
		case 1: // max hp Buff
            break;
		case 2: // inc attack Buff
			var buffIcon = new createjs.Bitmap("graphics/buff/buff_inc_attack.png");
			unit.buffs.push([2, 1.2, 3, buffIcon]);
			break;
		case 3: // dec attack Buff
            var buttIcon = new createjs.Bitmap("graphics/buff/buff_dec_attack.png");
            unit.buffs.push([3, 0.8, 3, buffIcon]);
            break;
		case 4:	// shield Buff
			var buffIcon = new createjs.Bitmap("graphics/buff/buff_shield.png");
			unit.buffs.push([4, 0, -1, buffIcon]);
			break;
        case 5: // burn Buff
            var buffIcon = new createjs.Bitmap("graphics/buff/buff_burning.png");
            unit.buffs.push([5, 0.02, 5, buffIcon]);
	}

	buffIcon.x = unit.hp_bar.x + (unit.buffs.length - 1) * 25;
	buffIcon.y = unit.hp_bar.y - 20;
	buffIcon.scaleY = 0.8;
	chars.addChild(buffIcon);
}


function getHealth(unit) {
	var base = unit.hp;
	$.each(unit.buffs, function(i, value) {
		if (value[0] == 0) {
			base = base + value[1];
		} // if type == health, add to base
	});

	return base;
}


function getMaxHealth(unit) {
	var base = unit.max_hp;
	$.each(unit.buffs, function(i, value) {
		if (value[0] == 1) {
			base += value[1];
		} // if type == max_health, add to base
	});
	return base;
}


function getAttack(unit) {
	var base = unit.attack;
	$.each(unit.buffs, function(i, value) {
		if (value[0] == 2) {
			base *= value[1]
		} // if type == attack, add to base
	});
	return base;
}


function getLuck(unit) {
	var base = unit.luck;
	$.each(unit.buffs, function(i, value) {
		if (value[0] == 3) {
			base += value[1];
		} // if type == luck, add to base
	});
	return base;
}
function updateHP_bar(unit){
	//stage.update();
	if (getHealth(unit) <= 0){
		chars.removeChild(unit);
		chars.removeChild(unit.hp_bar);
        blockMaps[unit.row][unit.column] = 0;
		units.splice(units.indexOf(unit), 1);
	} else {
		// unit.hp_bar.graphics.clear();
		// unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 80, 10);
		// unit.hp_bar.graphics.beginFill("#ff0000").drawRect(0, 0, (getHealth(unit) / getMaxHealth(unit)) * 80, 10);
		// if (unit.team == 0){
		// 	unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
		// 	unit.hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
		// 	unit.hp_bar.graphics.beginFill("#ff0000").drawRect(1, 1, (getHealth(unit)/getMaxHealth(unit)) * 80, 10);
		// } else {
		// 	unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
		// 	unit.hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
		// 	unit.hp_bar.graphics.beginFill("#3399ff").drawRect(1, 1, (getHealth(unit)/getMaxHealth(unit)) * 80, 10);
		// }
	}
	unit.hp_bar.updateCache();
}

function drawBottomInterface()  {
	bottomInterface.x = 0;
	bottomInterface.y = stage.canvas.height - 240;
	// bottomInterface.y = 0;
	draggable.addChild(bottomInterface);
}



function drawUnitCreationMenu() {
	var listOfSources = [];
	listOfSources.push("graphics/card/knight_card.png");
	listOfSources.push("graphics/card/archer_card.png");
	listOfSources.push("graphics/card/wizard_card.png");
	//listOfSources.push("graphics/card/rogue_card.png");

	createFloatingCards(listOfSources, ["knight","archer","wizard","rogue"]);
	unitCreationMenu.x = 50;
	unitCreationMenu.y = window.innerHeight - 130;
	bottomInterface.addChild(unitCreationMenu);
}

function createFloatingCards(listOfSources, correspondingUnit) {
	var numOfCards = listOfSources.length;
	for (i = 0; i < listOfSources.length; i++) {
		unitCards[i] = new createjs.Bitmap(listOfSources[i]);
		var unit_card_text = new createjs.Text("$ 100", "12px 'Arial'", "#ffffff");
		unitCards[i].y = 0;
		unitCards[i].x = i * (110);
		unitCards[i].scaleX = 0.60;
		unitCards[i].scaleY = 0.60;
		unitCards[i].index = i;
		unitCards[i].unitName = correspondingUnit[i];
		unitCards[i].text = unit_card_text;
		unitCards[i].text.y = unitCards[i].y+80;
		unitCards[i].text.x = unitCards[i].x+28;
		switch(unitCards[i].unitName ){
			case "knight": 
				unitCards[i].addEventListener("click", function(event) {
					createNewUnit("knight");
				});
				break;
			case "archer": 
				unitCards[i].addEventListener("click", function(event) {
					createNewUnit("archer");
				});
				break;
			case "wizard": 
				unitCards[i].addEventListener("click", function(event) {
					createNewUnit("wizard");
				});
				break;
			// case "rogue": 
			// 	unitCards[i].addEventListener("click", function(event) {
			// 		if (currentGold >= 100) {
			// 			spawnUnit("rogue",false, 5,2,turn);
			// 			currentGold -= 100;
			// 			currentGoldDisplay.text = ("Gold: " + currentGold);
			// 		}
			// 		changed = true;
			// 	});
			// 	break;
		}
		
		unitCards[i].addEventListener("mouseover", function(event) {
			unitCards[event.target.index].y -= 20;
			unitCards[event.target.index].text.y  -= 20;
			changed = true;
		});
		unitCards[i].addEventListener("mouseout", function(event) {
			unitCards[event.target.index].y += 20;
			unitCards[event.target.index].text.y += 20;
			changed = true;
		});

		//unitCreationMenu.addChild(unitCards[i]);
		//unitCreationMenu.addChild(unitCards[i].text);

	}
}

function createNewUnit(unitType) {

    switch (unitType) {
        case "knight":
            if (currentGold >= 100) {
                spawnUnit(that.classStats.knightClass, true);
                currentGold -= 100;
            }
            break;
        case "wizard":
            if (currentGold >= 100) {
                spawnUnit(that.classStats.wizardClass, true);
                currentGold -= 100;
            }
            break;
        case "archer":
            if (currentGold >= 100) {
                spawnUnit(that.classStats.archerClass, true);
                currentGold -= 100;
            }
            break;
    }

    currentGoldDisplay.text = ("Gold: " + currentGold);

}

function addEventListenersToUnit(unit) {
    unit.addEventListener("click", function(event) {
            if (isInHighlight && !isAttacking && !isCasting){
                return;
            }
            if (!movingPlayer && !isAttacking && !isCasting) {
                clearSelectionEffects();
                selectedCharacter = unit;;
                showUnitInfo = true;
                showActionMenuNextToPlayer(unit);
                displayStats(unit);
            }


            // In this case, we are selecting the unit to be attacked
            if (selectedCharacter != unit && isAttacking && selectedCharacter.team != unit.team) {
                $.each(highlighted, function(i, coord) {
                    if (unit.row === coord.row && unit.column === coord.column) {
                        attack(selectedCharacter, unit);
                        clearSelectionEffects();
                        if (remainingAttackTimes > 0) {
                            remainingAttackTimes - 1;
                            performAttack();
                        }
                    }
                });
            }

            if (selectedCharacter != unit && isCasting && selectedCharacter.team != unit.team) {

                $.each(units, function(i, otherUnit) {

                    if (otherUnit.column == unit.column && otherUnit.row == unit.row && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                    }
                    if (otherUnit.column == unit.column
                        && (otherUnit.row == unit.row-1 || otherUnit.row == unit.row+1) && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                    }
                    if (otherUnit.row == unit.row
                        && (otherUnit.column == unit.column-1 || otherUnit.column == unit.column+1) && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                    }
                    clearSelectionEffects();
                    selectedCharacter.outOfMoves = 0;
                    selectedCharacter.skillCoolDown = 3;
                    isCasting = false;

                });
            }
            changed = true;
        });

        unit.addEventListener("mouseover", function(event) {
            if (isCasting && selectedCharacter.skill_no == 4) {
                var i;
                for (i = 0; i < highlighted.length; i++) {
                    if (unit.row == highlighted[i].row && unit.column == highlighted[i].column) {
                        break;
                    }
                }
                if (i == highlighted.length) return;
                for (i = 0; i < sub_highlighted.length; i++) {
                    upper.removeChild(sub_highlighted[i]);
                }

                sub_highlighted = [];

                var surroudingTiles = getSurroundingTiles(unit.row, unit.column);
                for (i = 0; i < surroudingTiles.length; i++) {
                    var bmp = new createjs.Bitmap("graphics/tile/green_tile.png");
                    bmp.x = (surroudingTiles[i][1]-surroudingTiles[i][0]) * 65 + 540;
                    bmp.y = (surroudingTiles[i][1]+surroudingTiles[i][0]) * 32.5 + 220;
                    bmp.regX = 65;
                    bmp.regY = 32.5;
                    bmp.row = surroudingTiles[i][0];
                    bmp.column = surroudingTiles[i][1];
                    upper.addChild(bmp);
                    sub_highlighted.push(bmp);
                }
                changed = true;
            }
        }); 
        unit.addEventListener("mouseout", function(event) {
            $.each(sub_highlighted, function(i, tile) {
                upper.removeChild(tile);
            });
            sub_highlighted = [];
            change = true;
        });
}

function destroyGoldDisplay() {
	stage.removeChild(coin_pic);
	stage.removeChild(currentGoldDisplay);
}

function drawGoldDisplay() {

	coin_pic = new createjs.Bitmap("graphics/coin.png");
	coin_pic.x = stage.canvas.width - 170;
	coin_pic.y = 10;
	coin_pic.scaleX = 1;
	coin_pic.scaleY = 1

	currentGoldDisplay = new createjs.Text("Gold: " + currentGold, "20px '04b_19'", "#ffffff");
	currentGoldDisplay.x = coin_pic.x + 40;
	currentGoldDisplay.y = coin_pic.y  +5;
	currentGoldDisplay.textBasline = "alphabetic";

	// stage.addChild(coin_background);
	//stage.addChild(coin_pic);
	//stage.addChild(currentGoldDisplay);
}

function drawStatsDisplay() {
	statsDisplay.x = window.innerWidth - 350;
	statsDisplay.y = window.innerHeight - 180;
	// stage.addChild(statsDisplay);
}

function displayStats(unit) {
	if(unit.team === 1){
		var box = new createjs.Bitmap("graphics/stats_background_self.png");
	} else {
		var box = new createjs.Bitmap("graphics/stats_background_opponent.png");
	}
	
	box.scaleX = 0.8;
	box.scaleY = 0.8;
	statsDisplay.addChild(box);

	var bmp = new createjs.Bitmap(unit.info);
	bmp.scaleX = 0.75;
	bmp.scaleY = 0.75;

	bmp.y = 10;
	bmp.x = 20; // 226
	//stage.update();
	var text = unit.team == team ? new createjs.Text("HP : " + getHealth(unit) + "/" + getMaxHealth(unit) + "\n" +
		"ATK : "  + getAttack(unit) + "\n" + "RNG : " + unit.attackRange + "\n" +
		"SKILL : " + unit.skill +  "\n" + "CD: " + unit.skillCoolDown  + "\n" +
		"MOV. RANGE : " + unit.moveRange + "\n" +
		"LCK : " + getLuck(unit), "15px Arial", "#000000")
	: new createjs.Text("HP : " + getHealth(unit) + "/" + getMaxHealth(unit) + "\n" +
		"ATK : "  + "???"  + "\n" + "RNG : " + "???" + "\n" +
		"SKILL : " + "???"  + "\n" +"CD: " + "???" + "\n" +
		"MOV. RANGE : " + "???" + "\n" +
		"LCK : " + "???", "15px Arial", "#000000");
	text.y = 25;
	text.x = 156;
	text.textBasline = "alphabetic";

	statsDisplay.addChild(bmp);
	statsDisplay.addChild(text);
}

function drawGame() {
	$.getJSON('game-map.json', function(data) {
		that.mapData = data['main'];
		that.drawMap(that.mapData);

		$.each(units, function(i, value) {
			chars.addChild(value);
			chars.addChild(value.hp_bar);
		});

		changed = true;
	});	
}

initGame();

function createClickableImage(imgSource, x, y, callBack) {
	button = new createjs.Bitmap(imgSource);

	button.x = x;
	button.y = y;
    button.scaleX = ICON_SCALE_FACTOR;
    button.scaleY = ICON_SCALE_FACTOR;

	button.addEventListener("click", callBack);
	return button;

}


// Show the action menu next to a player (when selected)
function showActionMenuNextToPlayer(unit) {


	menuBackground = new createjs.Bitmap("graphics/ingame_menu/new_ingame_bg2.png");
	menuBackground.x = unit.x + 43;
	menuBackground.y = unit.y - 150;
	menuBackground.scaleX = 0.7;
    menuBackground.scaleY = 0.7;

	moveSource = unit.canMove === 1 && unit.outOfMoves === 0 ? "graphics/ingame_menu/new_move.png"
								    : "graphics/ingame_menu/new_move_gray.png";
	moveButton = createClickableImage(moveSource, unit.x + 48, unit.y - 147, function() {
		if (unit.canMove) {
			undoHighlights();
			// drawRange(findReachableTiles(unit.column, unit.row, unit.moveRange, true), 0);
			moveCharacter(unit);
		}
	});

	attackSource = unit.canAttack === 1 && unit.outOfMoves === 0 ? "graphics/ingame_menu/new_attack.png"
								   : "graphics/ingame_menu/new_attack_gray.png";
	attackButton = createClickableImage(attackSource, unit.x + 48, unit.y - 119, function() {
		if (unit.canAttack) {
			undoHighlights();
			// isAttacking = true;
			// drawRange(findReachableTiles(unit.column, unit.row, unit.attackRange, false), 1);
			remainingAttackTimes = 1;
			performAttack();
		}
	});

	skillSource = unit.skillCoolDown === 0 && unit.outOfMoves === 0 ? "graphics/ingame_menu/new_skill.png"
								   : "graphics/ingame_menu/new_skill_gray.png";
	skillButton = createClickableImage(skillSource, unit.x + 48, unit.y - 91, function() {
		if (unit.skillCoolDown === 0) {
			undoHighlights();
			isCasting = true;
			cast(unit.skill_no, unit);
		}
	});

	cancelSource = "graphics/ingame_menu/new_cancel.png";
	cancelButton = createClickableImage(cancelSource, unit.x + 48, unit.y - 63, function() {
		clearSelectionEffects();
	});

	chars.addChild(menuBackground);
    chars.addChild(moveButton);
    chars.addChild(attackButton);
    chars.addChild(skillButton);
    chars.addChild(cancelButton);

	var min = moveButton;
	min = chars.getChildIndex(attackButton) < chars.getChildIndex(min) ? attackButton : min;
	min = chars.getChildIndex(skillButton) < chars.getChildIndex(min) ? skillButton : min;
	min = chars.getChildIndex(cancelButton) < chars.getChildIndex(min) ? cancelButton : min;

	if (chars.getChildIndex(menuBackground) > chars.getChildIndex(min)) {
		chars.swapChildren(menuBackground, min);
	}


    isDisplayingMenu = true;
    changed = true;
}	

function cast(skillNo, unit) {
	switch (skillNo) {
		case 0: // King's skill
			// display effect
			$.each(units, function(i, value) {
				if (value.team === selectedCharacter.team) {
					//buff health
					var add = Math.ceil(0.1 * value.max_hp);
					if (value.hp + add < value.max_hp){
						value.hp += add;
					} else {
						value.hp = value.max_hp;
					}
					updateHP_bar(value);
					//value.buffs.push([0,add,3]);
					//value.buffs.push([1,add,3]);
					//buff dmg
					applyBuff(2, value);
					// value.buffs.push([2,5,3]);

					destroyStats();
					displayStats(unit);


					selectedCharacter.outOfMoves = 1;
					unit.skillCoolDown = 3;
					destroyMenu();
					showActionMenuNextToPlayer(unit);

					changed = true;
				}
			});
			isCasting = false;
			// notify server

			// display updated json
			break;
		case 1: // Archer's skill
		 //    var atk = selectedCharacter.attack;
		 //    selectedCharacter.attack = 2 * atk;

			// isAttacking = true;
			// undoHighlights();
			// drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 1);
			var reachableTiles = findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false);
			isCasting = true;
			undoHighlights();
			remainingAttackTimes = 2;
			performAttack();


			
			break;
	    case 3: // Warrior's skill
	    	undoHighlights();
            applyBuff(4, selectedCharacter);


	    	selectedCharacter.outOfMoves = 1;
	    	unit.skillCoolDown = 3;
	    	isCasting = false;
			destroyMenu();
			showActionMenuNextToPlayer(selectedCharacter);

			changed = true;

	    	break;
	    case 4: // Wizard's skill
	    	isCasting = true;

	    	// drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 2);
	    	var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, false);
	    	highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click", "mouseover", "mouseout"], [castWizardSpellOnClick, highlightWizardSpellCross, clearWizardSpellCross]);
			break;
		case 5:
			remainingAttackTimes = 1;
			performAttack();

	}
}

function castWizardSpellOnClick(event) {
	$.each(units, function(i, unit) {
		if (unit.column == event.target.column && unit.row == event.target.row && unit.team != selectedCharacter.team) {
			attack(selectedCharacter, unit);
            applyBuff(5, unit);
		}
		if (unit.column == event.target.column
			&& (unit.row == event.target.row-1 || unit.row == event.target.row + 1) && unit.team != selectedCharacter.team) {
			attack(selectedCharacter, unit);
            applyBuff(5, unit);
		}
		if (unit.row == event.target.row
			&& (unit.column == event.target.column-1 || unit.column == event.target.column + 1) && unit.team != selectedCharacter.team) {
			attack(selectedCharacter, unit);
            applyBuff(5, unit);
		}
		clearSelectionEffects();
		selectedCharacter.outOfMoves = 1;
		selectedCharacter.skillCoolDown = 3;
		isCasting = false;
		changed = true;
	});
} 


function highlightWizardSpellCross(event) {
	var tiles = getSurroundingTiles(event.target.row, event.target.column);
	$.each(tiles, function(i, tile) {
		var sub_bmp = new createjs.Bitmap("graphics/tile/green_tile.png");
		sub_bmp.x = (tile[1]-tile[0]) * 65 + 540;
		sub_bmp.y = (tile[1]+tile[0]) * 32.5 + 220;
		sub_bmp.regX = 65;
		sub_bmp.regY = 32.5;
		upper.addChild(sub_bmp);
		sub_highlighted.push(sub_bmp);
		changed = true;
	});
	drawGame();
}	

function clearWizardSpellCross(event) {
	$.each(sub_highlighted, function(i, tile) {
		upper.removeChild(tile);
	});
	sub_highlighted = [];
	changed = true;
}

// Start moving the player
function move() {
	movingPlayer = true;
}

// Convert row/column to actual coordinates	
function rcToCoord(x, y) {

	var result = [0, 0];
	result[0] = originX + (y - x) * 65;
	result[1] = originY + (y + x) * 32.5;
		
	return result;
}

function getSurroundingTiles(row, col) {
	var result = [];
	result.push([row,col]);
	if (col > 0) {
		result.push([row, col - 1]);
	}
	if (col < mapWidth-1) {
		result.push([row, col + 1]);
	}
	if (row > 0) {
		result.push([row - 1, col]);
	}
	if (row < mapHeight-1) {
		result.push([row + 1, col]);
	}
	return result;
}

function getRandom(luck){
  	var num = Math.random();
 	if(num < luck){ 
 		return 1;
  	} else {
  		return 2; 
	} 
}
var showingDamage;




function demageEffect(damageText,damageBackground ){
	damageText.y -= 0.1;
	damageBackground.y -= 0.1;
	//stage.update(damageText,damageBackground);
	for (var i = 0; i < 100; i++) {
		setTimeout(function (){
			damageText.y -= 0.1;
			damageBackground.y -= 0.1;
	//		stage.update(damageText,damageBackground);
		}, 5);
		
	}
	
}
function showDamage(unit, critical, damage){
	unit.damageBackground = new createjs.Shape();
	if (critical == 2) {
		unit.damageBackground.graphics.beginFill("#ffeb00").drawRect(unit.x - 10, unit.y - 50, 40, 20);
		unit.damageText = new createjs.Text(damage, "20px Arial", "#000000");
	} else {
		unit.damageBackground.graphics.beginFill("#ff0000").drawRect(unit.x - 10, unit.y - 50, 40, 20);
		unit.damageText = new createjs.Text(damage, "20px Arial", "#000000");
	}
	unit.damageText.x = unit.x;
	unit.damageText.y = unit.y - 50;
	unit.damageText.textBasline = "alphabetic";

	chars.addChild(unit.damageBackground);
	chars.addChild(unit.damageText);
	//stage.update();
	unit.showingDamage = true;
	demageEffect(unit.damageText, unit.damageBackground);	

	setTimeout(function (){
		chars.removeChild(unit.damageBackground);
		chars.removeChild(unit.damageText);
		unit.showingDamage = false;
		//stage.update();
	}, 750);
}
function showDamage2(unit, critical, damage){
	unit.damageBackground2 = new createjs.Shape();
	if (critical == 2) {
		unit.damageBackground2.graphics.beginFill("#ffeb00").drawRect(unit.x - 10, unit.y - 50, 40, 20);
		unit.damageText2 = new createjs.Text(damage, "20px Arial", "#000000");
	} else {
		unit.damageBackground2.graphics.beginFill("#ff0000").drawRect(unit.x - 10, unit.y - 50, 40, 20);
		unit.damageText2 = new createjs.Text(damage, "20px Arial", "#000000");
	}
	unit.damageText2.x = unit.x;
	unit.damageText2.y = unit.y - 50;
	unit.damageText2.textBasline = "alphabetic";

	chars.addChild(unit.damageBackground2);
	chars.addChild(unit.damageText2);
	//stage.update();
	unit.showingDamage = true;
	demageEffect(unit.damageText2, unit.damageBackground2);	

	setTimeout(function (){
		chars.removeChild(unit.damageBackground2);
		chars.removeChild(unit.damageText2);
		unit.showingDamage = false;
		//stage.update();
	}, 750);
}


function attack(attacker, target){
	// if (attacker.team != target.team) {
		
		var sprite = new createjs.Sprite(attacker.spritesheet, "attack");
		sprite.x = attacker.x;
		sprite.y = attacker.y;
		sprite.scaleX = 0.7;
		sprite.scaleY = 0.7;
		chars.removeChild(attacker);	
		chars.addChild(sprite);

		
		var criticalHit = getRandom(getLuck(attacker));
		var damage = getAttack(attacker) * criticalHit

		if (!removeBuff(4, target)) {
			showDamage(target, criticalHit, damage);
			target.hp -= damage;
			updateHP_bar(target);
			
			var damageAnimation = new createjs.Sprite(attacker.damageEffect, "damage");
			damageAnimation.x = target.x;
			damageAnimation.y = target.y;
		}

		chars.addChild(damageAnimation);
		
		attacker.outOfMoves = 1;
		attacker.canAttack = 0;
		remainingAttackTimes--;
		isAttacking = false;


		setTimeout(function() {
			chars.removeChild(sprite);
			chars.addChild(attacker);
			chars.removeChild(damageAnimation);
		}, 1000);

		changed = true;
	// } 
}

function clearSelectionEffects() {
	destroyMenu();
    undoHighlights();
    destroyStats();
    isAttacking = false;
    isCasting = false;
}

function destroyStats() {
	statsDisplay.removeAllChildren();
	stage.removeChild(statsDisplay);
	// statsDisplay.removeChild(2, 3);

	// var box = new createjs.Bitmap("graphics/stats_background.png");
	// box.scaleX = 0.8;
	// box.scaleY = 0.8;
	// statsDisplay.addChild(box);
	changed = true;
}

function destroyMenu() {
	if (!isDisplayingMenu) return;
	chars.removeChild(menuBackground);
	chars.removeChild(moveButton);
	chars.removeChild(attackButton);
	chars.removeChild(skillButton);
	chars.removeChild(cancelButton);
	changed = true;
}

function undoHighlights() {
	// console.log(isInHighlight);
	if (!isInHighlight) return;
	$.each(highlighted, function(i, tile) {
		upper.removeChild(tile);
	});
	$.each(sub_highlighted, function(i, tile) {
		upper.removeChild(tile);
	})
	isInHighlight = false;
	highlighted = [];
	changed = true;
}

// Move the player by a fixed amount
function movePlayer() {
  var playerX = selectedCharacter.x,
      playerY = selectedCharacter.y,
      destX = path[0][0],
      destY = path[0][1];

  if (playerX < destX && playerY < destY) {
    selectedCharacter.x += MOVEMENT_STEP;
    selectedCharacter.y += MOVEMENT_STEP / 2;

    selectedCharacter.hp_bar.x += MOVEMENT_STEP;
    selectedCharacter.hp_bar.y += MOVEMENT_STEP / 2;
  } else if (playerX > destX && playerY > destY) {
    selectedCharacter.x -= MOVEMENT_STEP;
    selectedCharacter.y -= MOVEMENT_STEP / 2;


    selectedCharacter.hp_bar.x -= MOVEMENT_STEP;
    selectedCharacter.hp_bar.y -= MOVEMENT_STEP / 2;
  } else if (playerX < destX && playerY > destY) {
    selectedCharacter.x += MOVEMENT_STEP;
    selectedCharacter.y -= MOVEMENT_STEP / 2;


    selectedCharacter.hp_bar.x += MOVEMENT_STEP;
    selectedCharacter.hp_bar.y -= MOVEMENT_STEP / 2;
  } else if (playerX > destX && playerY < destY){
  	selectedCharacter.x -= MOVEMENT_STEP;
  	selectedCharacter.y += MOVEMENT_STEP / 2;


    selectedCharacter.hp_bar.x -= MOVEMENT_STEP;
    selectedCharacter.hp_bar.y += MOVEMENT_STEP / 2;
  }

  if ((playerX === destX) && (playerY === destY)) {
      path.splice(0,1);
      if (path.length == 0) {

      	sortIndices(selectedCharacter);
        movingPlayer = false;
        selectedCharacter.canMove = 0;

		showActionMenuNextToPlayer(selectedCharacter);
      }
  }

  sortIndices(selectedCharacter);
  //stage.update();
  changed = true;
}

function sortIndices(unit) {
	$.each(units, function(i, value) {
		if (unit.y > value.y) {
			if (chars.getChildIndex(unit) < chars.getChildIndex(value)) {
				chars.swapChildren(unit, value);
			}
			if (chars.getChildIndex(unit.hp_bar) < chars.getChildIndex(value.hp_bar)) {
				chars.swapChildren(unit.hp_bar, value.hp_bar);
			}
			if (chars.getChildIndex(unit.hp_bar) < chars.getChildIndex(value)) {
				chars.swapChildren(unit.hp_bar, value);
			}
		} else if (unit.y < value.y) {
			if (chars.getChildIndex(unit) > chars.getChildIndex(value)) {
				chars.swapChildren(unit, value);
			}
			if (chars.getChildIndex(unit.hp_bar) > chars.getChildIndex(value.hp_bar)) {
				chars.swapChildren(unit.hp_bar, value.hp_bar);
			}
			if (chars.getChildIndex(unit) > chars.getChildIndex(value.hp_bar)) {
				chars.swapChildren(unit, value.hp_bar);
			}
		}
	});
}


function findPath(fromX, fromY, toX, toY) {
	var parent = new Array(mapWidth * mapHeight);
	var vis = new Array(mapWidth * mapHeight);
	var q = [];
	q.push([fromX, fromY]);
	for (i = 0; i < vis.length; i++) vis[i] = false;
	vis[fromX * mapWidth + fromY] = true;

	// Breadth first search
	while (q.length > 0) {
		coord = q.splice(0, 1)[0];

		if (coord[0] == toX && coord[1] == toY) {
			break;				
		}
		for (dx = -1; dx <= 1; dx++) {
			for (dy = -1; dy <= 1; dy++) {

				// Make sure only vertical or horizontal moves
				if (dx != 0 && dy != 0) continue;

				var nx = coord[0] + dx;
				var ny = coord[1] + dy;

				// Bounds check
				if (nx < 0 || nx >= mapHeight || ny < 0 || ny >= mapWidth) continue;

				// Terrain check
				if (blockMaps[nx][ny] != 0) continue;

				// bounds and obstacle check here
				if (vis[nx * mapWidth + ny] === false) {
					vis[nx * mapWidth + ny] = true;
					q.push([nx, ny]);
					parent[nx * mapWidth + ny] = [coord[0], coord[1]];
				}
				
			}
		}
	}

	path = [];
	path = [[toX, toY]];
	var currX = toX;
	var currY = toY;
	while (currX != fromX || currY != fromY) {
		path.unshift(parent[currX * mapWidth + currY]);
		currX = path[0][0];
		currY = path[0][1];
	}

	for (i = 0; i < path.length; i++) {
		path[i] = rcToCoord(path[i][0], path[i][1]);
	}

}


// A call back function that highlights all the possible definitions 
// when a character is clicked.
function findReachableTiles(x, y, range, isMoving) {
	var q = [];
	var start = [x, y, 0];
	var marked = [];
	marked.push(x * mapWidth + y);
	q.push(start);

	// Breadth first search to find all possible destinations
	while (q.length > 0) {

		pair = q.splice(0, 1)[0];
		// console.log(pair[0] + " " + pair[1]);

		// Move range check
		if (pair[2] >= range) continue;

		// Enumerate all possible moves
		for (dx = -1; dx <= 1; dx++) {
			for (dy = -1; dy <= 1; dy++) {

				// Make sure only vertical or horizontal moves
				if (dx != 0 && dy != 0) continue;

				var nx = pair[0] + dx;
				var ny = pair[1] + dy;
				var d = pair[2] + 1;

				// Bounds check
				if (nx < 0 || nx >= mapHeight || ny < 0 || ny >= mapWidth) continue;

				// Terrain check
				if (blockMaps[nx][ny] != 0 && isMoving) continue;

				// bounds and obstacle check here
				if ($.inArray(nx * mapWidth + ny, marked) === -1) {
					marked.push(nx * mapWidth + ny);
					q.push([nx, ny, d]);
				}
				
			}
		}	
		
	}

	$.each(marked, function(i, coord) {
		var x = Math.floor(coord / mapWidth);
		var y = coord % mapWidth;
		marked[i] = [x, y];
		//console.log(marked[i]);
	});
	return marked;
}





function drawMap(data) {

	maps = new Array(mapHeight);
	for (var i = 0; i < mapHeight; i++) {
		maps[i] = new Array(mapWidth);
	}


	originX = 540;
	originY = 220;
	for (i = 0; i < mapHeight; i++) {
		for (j = 0; j < mapWidth; j++) {
			var terrain = data[i][j];
            if (terrain == 5 || terrain == 5.1 ||terrain == 5.12|| terrain == 5.2 || terrain == 5.22) blockMaps[i][j] = 1;
            if (terrain == 5) {
            	img = imageNumber(terrain);
		       var spriteSheet = new createjs.SpriteSheet({
		               "images": [img],
		               "frames": {"regX": 0, "height": 130, "count": 2, "regY": 0, "width": 130 },
		               "animations": {
		               "water":[0,1]
		               },
		               framerate: 3
		           });
		       	maps[i][j] = new createjs.Sprite(spriteSheet, "water");
		       	maps[i][j].name = i + "," + j + "," + tile_type + "," + tile_info_address;
				maps[i][j].x = (j-i) * 65 + 540;
				maps[i][j].y = (j+i) * 32.5 + 220;
				maps[i][j].regX = 65;
				maps[i][j].regY = 32.5;
				maps[i][j].addEventListener("mouseover",mouseOver);
				maps[i][j].addEventListener("mouseout", mouseOut);
				maps[i][j].addEventListener("click", function(event) {
					clearSelectionEffects();
				});
            } else if (terrain == 1.1) {
		      	img = imageNumber(terrain);
				maps[i][j] = new createjs.Bitmap(img);
		       	maps[i][j].name = i + "," + j + "," + tile_type + "," + tile_info_address;
				maps[i][j].x = (j-i) * 65 - 473;
				maps[i][j].y = (j+i) * 32.5 -348;
				maps[i][j].regX = 65;
				maps[i][j].regY = 32.5;
				maps[i][j].addEventListener("mouseover",mouseOver);
				maps[i][j].addEventListener("mouseout", mouseOut);
				maps[i][j].addEventListener("click", function(event) {
					clearSelectionEffects();
				});
		      
		      }else if (terrain == 5.1 || terrain == 5.12) {
		       img = imageNumber(terrain);
		       var spriteSheet = new createjs.SpriteSheet({
		               "images": [img],
		               "frames": {"regX": 0, "height": 1200, "count": 10, "regY": 0, "width": 165 },
		               "animations": {
		               "water":[0,1,2,3,4,5,6,7,8,9]
		               },
		               framerate: 3
		           });
		       	maps[i][j] = new createjs.Sprite(spriteSheet, "water");
		       	maps[i][j].name = i + "," + j + "," + tile_type + "," + tile_info_address;
				maps[i][j].x = (j-i) * 65 + 540;
				maps[i][j].y = (j+i) * 32.5 + 220;
				maps[i][j].regX = 65;
				maps[i][j].regY = 32.5;
				maps[i][j].addEventListener("mouseover",mouseOver);
				maps[i][j].addEventListener("mouseout", mouseOut);
				maps[i][j].addEventListener("click", function(event) {
					clearSelectionEffects();
				});
		      
		      }else if (terrain == 5.2 || terrain == 5.22) {
		       img = imageNumber(terrain);
		       var spriteSheet = new createjs.SpriteSheet({
		               "images": [img],
		               "frames": {"regX": 30, "height": 1200, "count": 10, "regY": 20, "width": 165 },
		               "animations": {
		               "water":[0,1,2,3,4,5,6,7,8,9]
		               },
		               framerate: 3
		           });
		       	maps[i][j] = new createjs.Sprite(spriteSheet, "water");
		       	maps[i][j].name = i + "," + j + "," + tile_type + "," + tile_info_address;
				maps[i][j].x = (j-i) * 65 + 540;
				maps[i][j].y = (j+i) * 32.5 + 220;
				maps[i][j].regX = 65;
				maps[i][j].regY = 32.5;
				maps[i][j].addEventListener("mouseover",mouseOver);
				maps[i][j].addEventListener("mouseout", mouseOut);
				maps[i][j].addEventListener("click", function(event) {
					clearSelectionEffects();
				});
		      
		      } else {
				img = imageNumber(terrain);
				maps[i][j] = new createjs.Bitmap(img);
				maps[i][j].name = i + "," + j + "," + tile_type + "," + tile_info_address;
				maps[i][j].x = (j-i) * 65 + 540;
				maps[i][j].y = (j+i) * 32.5 + 220;
				maps[i][j].regX = 65;
				maps[i][j].regY = 32.5;
				maps[i][j].addEventListener("mouseover",mouseOver);
				maps[i][j].addEventListener("mouseout", mouseOut);
				maps[i][j].addEventListener("click", function(event) {
					clearSelectionEffects();
				});
			}
			draggable.addChild(maps[i][j]);
		}
	}

}

	function mouseOut(evt){
		if (!isDragging) {
			upper.removeChild(highLight_tile);
			stage.removeChild(tile_display);
			stage.removeChild(tile_info_text);
			stage.update();
		}
	}

	function mouseOver(evt) {
		if (!isDragging) {
			if (upper.removeChild(highLight_tile)){
				stage.removeChild(tile_display);
				stage.removeChild(tile_info_text);
				stage.update();
			}
			stage.removeChild(tile_display);
			stage.removeChild(tile_info_text);
			var position = evt.target.name.split(",");
			var i = parseInt(position[0]);
			var j = parseInt(position[1])
			tile_info = position[2];
			tile_display = new createjs.Bitmap(position[3]);
			tile_display.x = 0;
			tile_display.y = 0;
			tile_display.scaleX = 0.6;
			tile_display.scaleY = 0.6;
			
			tile_info_text = new createjs.Text(tile_info, "20px Arial", "#ffffff");
			tile_info_text.x = 90;
			tile_info_text.y = 100;
			tile_info_text.textBaseline = "alphabetic";
			tile_info_text.textAlign = "center";
			stage.addChild(tile_display);
			stage.addChild(tile_info_text);


			highLight_tile = new createjs.Bitmap("graphics/tile/highlight_tile.png");
			highLight_tile.x = (j-i) * 65 + 540;
			highLight_tile.y = (j+i) * 32.5 + 220;
			if (that.mapData[i][j] == 5) highLight_tile.y += 10;
			highLight_tile.regX = 65;
			highLight_tile.regY = 32.5;
			upper.addChild(highLight_tile);
		}
		stage.update();
	}

createjs.Ticker.addEventListener("tick", update);
createjs.Ticker.on("tick", function() {

	$.each(units, function(i, value) {
		value.updateCache();
	});
}, this);	
// createjs.Ticker.setFPS(30);
function keyEvent(event) {
    switch(event.keyCode) {
        case 27:
            if (isDisplayingMenu) {
            	destroyMenu();
            	destroyStats();
            	clearSelectionEffects();
            }
            break;

    }
} 

function update() {
	if (movingPlayer === true) {
		movePlayer();
	}
	if (resized) {	
		stage.canvas.width = window.innerWidth;
		stage.canvas.height = window.innerHeight + 200;
		drawGame();
		drawStatsDisplay();
		destroyGoldDisplay();
		drawGoldDisplay();

		$.each(unitCards, function(i, value) {
			stage.removeChild(value.text);
			stage.removeChild(value);
		});
		unitCards = [];
		drawUnitCreationMenu();
		resized = false;
	}
	if (changed) {
		stage.update();
		changed = false;
	}
	upper.x = draggable.x;
	upper.y = draggable.y;

	chars.x = draggable.x;
	chars.y = draggable.y;

	stage.addChild(statsDisplay);
	stage.addChild(unitCreationMenu);
}
var tile_type;
var tile_info_address;
// Given the number in the game-map, returns the address of the tile's image
function imageNumber(number) {
	switch (number) {
		case 0 :
			tile_info_address = "graphics/tile_info/tile_grass.png";
			tile_type = "Grass";
			return "graphics/tile/3d_tile/grass.png";
		case 1 :
			tile_info_address = "graphics/tile_info/tile_mud.png";
			tile_type = "Mud";
			return "graphics/tile/3d_tile/mud.png";
		case 1.1 :
			tile_info_address = "graphics/tile_info/tile_mud.png";
			tile_type = "Mud";
			return "graphics/tile/3d_tile/rock2.png";
		case 2 :
			tile_info_address = "graphics/tile_info/tile_stone_bridge.png";
			tile_type = "Stone Bridge";
			return "graphics/tile/stone_bridge.png";
		case 3 :
			tile_info_address = "graphics/tile_info/tile_stone_bridge.png";
			tile_type = "Stone Bridge";
			return "graphics/tile/3d_tile/stone_bridge.png";
		case 4 :
			tile_info_address = "graphics/tile_info/tile_stone_path.png";
			tile_type = "Stone Path";
			return "graphics/tile/3d_tile/stone_path.png";
		case 5 :
			tile_info_address = "graphics/tile_info/tile_water.png";
			tile_type = "Water";
			//return "graphics/tile/3d_tile/ss_water.png";
			return "graphics/tile/3d_tile/ss_water.png";
		case 5.1 :
			tile_info_address = "graphics/tile_info/tile_water.png";
			tile_type = "Water";
			//return "graphics/tile/3d_tile/ss_water.png";
			return "graphics/tile/3d_tile/waterTest.png";
		case 5.12 :
			tile_info_address = "graphics/tile_info/tile_water.png";
			tile_type = "Water";
			//return "graphics/tile/3d_tile/ss_water.png";
			return "graphics/tile/3d_tile/waterTest2.png";
		case 5.2 :
			tile_info_address = "graphics/tile_info/tile_water.png";
			tile_type = "Water";
			//return "graphics/tile/3d_tile/ss_water.png";
			return "graphics/tile/3d_tile/water_test2.png";
		case 5.22 :
			tile_info_address = "graphics/tile_info/tile_water.png";
			tile_type = "Water";
			//return "graphics/tile/3d_tile/ss_water.png";
			return "graphics/tile/3d_tile/water_test4.png";
		case 6 :
			tile_info_address = "graphics/tile_info/tile_wood_bridge.png";
			tile_type = "Wood Bridge";
			return "graphics/tile/3d_tile/wood_bridge.png";
		case 7 :
			tile_info_address = "graphics/tile_info/tile_wood_bridge.png";
			tile_type = "Wood Bridge";
			return "graphics/tile/wood_bridge2.png";
		case 8 :
			tile_info_address = "graphics/tile_info/sand.png";
			tile_type = "Sand";
			return "graphics/tile/3d_tile/sand.png";
		case 9:
			tile_info_address = "";
			tile_type = "";
			return "";
		default:
			return "error";
	}
}


function moveCharacter(unit) {
	var reachableTiles = findReachableTiles(unit.row, unit.column, unit.moveRange, true);
	highlightArea(reachableTiles, "graphics/tile/green_tile.png", ["click"], [function(event) {
		var fromX = selectedCharacter.row;
		var fromY = selectedCharacter.column;
		var tile = event.target;
		findPath(fromX, fromY, tile.row, tile.column);
		blockMaps[fromX][fromY] = 0;
		move();
		blockMaps[tile.row][tile.column] = 1;
		selectedCharacter.row = tile.row;
		selectedCharacter.column = tile.column;
		clearSelectionEffects();
	}]);

}

function performAttack() {
	isAttacking = true;
	var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, false);
	highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click"], [function(event) {
		var tile = event.target;
		$.each(units, function(i, unit) {
			if (unit.row == tile.row && unit.column == tile.column && selectedCharacter.team != unit.team){
				attack(selectedCharacter, unit);
				selectedCharacter.attack = selectedCharacter.base_attack;
				clearSelectionEffects();
				if (remainingAttackTimes > 0) {
					performAttack();
				}
			}
		});	
	}]); 
	
}

function highlightArea(tiles, imgSource, callBackEventNames, callBackFunctions) {
	destroyMenu();
	for (var i = 0; i < tiles.length; i++) {
		var bmp = new createjs.Bitmap(imgSource);
		bmp.x = (tiles[i][1]-tiles[i][0]) * 65 + 540;
		bmp.y = (tiles[i][1]+tiles[i][0]) * 32.5 + 220;
		bmp.regX = 65;
		bmp.regY = 32.5;
		bmp.row = tiles[i][0];
		bmp.column = tiles[i][1];
		for (var j = 0; j < callBackEventNames.length; j++) {
			bmp.addEventListener(callBackEventNames[j], callBackFunctions[j]);
		}
		upper.addChild(bmp);
		highlighted.push(bmp);
		$.each(units, function(i, value) {
			if (draggable.getChildIndex(value) < draggable.getChildIndex(bmp)) {
				draggable.swapChildren(bmp, value);
				draggable.swapChildren(bmp, value.hp_bar);
			}
		});
	}


	isInHighlight = true;
	drawGame();
}

