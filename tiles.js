
var ICON_SCALE_FACTOR = 0.65;
var MOVEMENT_STEP = 6.5


var stage = new createjs.Stage("demoCanvas");
var that = this;
var team = 0;



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
var unitCards = new Array(3);

var isDisplayingMenu = false;
var isInHighlight = false;
var changed = false;
var movingPlayer = false;
var isAttacking = false;
var currentGold;
var currentGoldDisplay;
var turn = 0;

function resize() {
	//stage.canvas.width = window.innerWidth;
	//stage.canvas.height = window.innerHeight;
	//drawGame();
	//drawStatsDisplay();
}


function initGame() {
	stage.enableMouseOver(20);
	$.getJSON('game-map.json', function(data) {
		that.mapData = data['main'];

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

		units = [];

		$.each(data.characters, function(i, value) {
			var spriteSheet = new createjs.SpriteSheet({
          	"images": [value.address],
          	"frames": {"regX": +10, "height": 142, "count": 2, "regY": -20, "width": 113 },
          	"animations": {
            	"stand":[0,1],
            	"info":[0]
          	},
          	framerate: 2
        	});


			var unit = new createjs.Sprite(spriteSheet, "stand");
			unit.addEventListener("click", function(event) {
				if (!movingPlayer && !isAttacking) {
					clearSelectionEffects();
					selectedCharacter = unit;
					showActionMenuNextToPlayer(unit);
					displayStats(value);
				}


				// In this case, we are selecting the unit to be attacked
				if (selectedCharacter != unit && isAttacking) {
					$.each(highlighted, function(i, coord) {
						if (unit.row === coord.row && unit.column === coord.column) {
							attack(selectedCharacter, unit);
							clearSelectionEffects();
						}
					});
				}

				changed = true;
			});
			createjs.Ticker.timingMode = createjs.Ticker.RAF;
   			createjs.Ticker.addEventListener("tick", stage);
			// Configure unit coordinates
			unit.hp = value.hp;
			unit.max_hp = value.max_hp;
			unit.attack = value.attack;
			unit.base_attack = unit.attack;
			unit.luck = value.luck;
			unit.row = value.y;
			unit.column = value.x;
			unit.x = originX +  (value.y - value.x) * 65;
			unit.y = value.y * 32.5 + originY + value.x * 32.5;
			unit.regX = 56.5;
			unit.regY = 130;
			unit.scaleX = 0.7;
			unit.scaleY = 0.7;
			unit.team = value.team;
			unit.skill = value.skill;
			unit.address = value.address;
			unit.skill_no = value.skill_no;
			unit.buffs = [];
			unit.buff_icons = [];

			// Configure the hp bar of the unit
			hp_bar = new createjs.Shape();
			hp_bar.x = unit.x - 40;
			hp_bar.y = unit.y - 90;
			hp_bar.graphics.beginFill("#ff0000").drawRect(0, 0, 80, 10);
			hp_bar.graphics.beginFill("#00ff00").drawRect(0, 0, (getHealth(value)/getMaxHealth(value)) * 80, 10);
			unit.hp_bar = hp_bar;


			// Configure move and attack range of the unit
			unit.moveRange = value.moveRange;
			unit.attackRange = value.attackRange;

			// Configure action control informations
			unit.canMove = value.canMove;
			unit.canAttack = value.canAttack;
			unit.skillCoolDown = value.skillCoolDown;
			unit.outOfMoves = value.outOfMoves;

			// Adding the unit to the list of units in the game
			units.push(unit);

			blockMaps[unit.column][unit.row] = 1;

			// Add the unit and its hp bar to the stage
			stage.addChild(unit);
			stage.addChild(hp_bar);
		});


	});

	var knight = new createjs.Bitmap();


	var box = new createjs.Bitmap("graphics/stats_background.png");
	box.scaleX = 0.9;
	box.scaleY = 0.47;
	statsDisplay.addChild(box);

	stage.canvas.width = window.innerWidth;
	stage.canvas.height = window.innerHeight;
	
	drawStatsDisplay();
	drawUnitCreationMenu();
	drawBottomInterface();


	changed = true;

	//window.addEventListener('resize', resize, false);
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
			base += value[1];
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
	stage.update();
	if (getHealth(unit) <= 0){
		stage.removeChild(unit);
		stage.removeChild(unit.hp_bar);
	} else {
		unit.hp_bar.graphics.clear();
		unit.hp_bar.graphics.beginFill("#ff0000").drawRect(0, 0, 80, 10);
		unit.hp_bar.graphics.beginFill("#00ff00").drawRect(0, 0, (getHealth(unit) / getMaxHealth(unit)) * 80, 10);
	}
}

function drawBottomInterface()  {
	bottomInterface.x = 200;
	//bottomInterface.y = stage.canvas.height - 240;
	bottomInterface.y = 0;
	stage.addChild(bottomInterface);
}



function drawUnitCreationMenu() {
	var listOfSources = [];
	listOfSources.push("graphics/card/knight_card.png");
	listOfSources.push("graphics/card/archer_card.png");
	listOfSources.push("graphics/card/wizard_card.png");

	// var knightCard = new createjs.Bitmap("graphics/card/card_knight");
	// var knightArcher = new createjs.Bitmap("graphics/card/card_archer");
	// var knightWizard = new createjs.Bitmap("graphics/card/card_wizard");

	createFloatingCards(listOfSources, []);
	unitCreationMenu.x = 0;
	unitCreationMenu.y = 0;
	bottomInterface.addChild(unitCreationMenu);
}

function createFloatingCards(listOfSources, correspondingUnit) {

	var numOfCards = listOfSources.length;
	for (i = 0; i < listOfSources.length; i++) {
		unitCards[i] = new createjs.Bitmap(listOfSources[i]);
		var unit_card_text = new createjs.Text("$ 100", "12px 'Arial'", "#ffffff");
		unitCards[i].y = 0;
		unitCards[i].x = i * (300 / numOfCards);
		unitCards[i].scaleX = 0.60;
		unitCards[i].scaleY = 0.60;
		unitCards[i].index = i;
		unitCards[i].unitName = correspondingUnit[i];
		unitCards[i].text = unit_card_text;
		unitCards[i].text.y = unitCards[i].y+80;
		unitCards[i].text.x = unitCards[i].x+28;
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
		unitCreationMenu.addChild(unitCards[i]);

		unitCreationMenu.addChild(unitCards[i].text);

	}
}

function drawGoldDisplay() {
	console.log("displaying gold bar");
	var coin = new createjs.Bitmap("graphics/coin.png");
	coin.x = stage.canvas.width - 230;
	coin.y = 20;
	coin.scaleX = 0.5;
	coin.scaleY = 0.5;

	currentGoldDisplay = new createjs.Text("Gold: " + currentGold, "20px '04b_19'", "#000000");
	currentGoldDisplay.x = coin.x + 30;
	currentGoldDisplay.y = coin.y + 5;
	currentGoldDisplay.textBasline = "alphabetic";

	stage.addChild(coin);
	stage.addChild(currentGoldDisplay);
}

function drawStatsDisplay() {
	statsDisplay.x = 800;
	statsDisplay.y = 0;
	bottomInterface.addChild(statsDisplay);
	// stage.addChild(statsDisplay);
}

function displayStats(unit) {
	var spriteSheet = new createjs.SpriteSheet({
          	"images": [unit.address],
          	"frames": {"regX": +10, "height": 142, "count": 2, "regY": -20, "width": 113 },
          	"animations": {
            	"info":[0]
          	},
          	framerate: 2
        	});
	var bmp = new createjs.Sprite(spriteSheet, "info");
	bmp.scaleX = 1.2;
	bmp.scaleY = 1.2;

	bmp.y = -10;
	bmp.x = 40; // 226

	var text = unit.team == team ? new createjs.Text("HP : " + getHealth(unit) + "/" + getMaxHealth(unit) + "\n" +
		"ATK : "  + getAttack(unit) + "    " + "RNG : " + unit.attackRange + "\n" +
		"SKILL : " + unit.skill + "  ( CD " + unit.skillCoolDown + " )" + "\n" +
		"MOV. RANGE : " + unit.moveRange + "\n" +
		"LCK : " + getLuck(unit), "20px '04b_19'", "#000000")
	: new createjs.Text("HP : " + getHealth(unit) + "/" + getMaxHealth(unit) + "\n" +
		"ATK : "  + "???" + "    " + "RNG : " + "???" + "\n" +
		"SKILL : " + "???" + "  ( CD " + "???" + " )" + "\n" +
		"MOV. RANGE : " + "???" + "\n" +
		"LCK : " + "???", "20px '04b_19'", "#000000");
	text.y = 30;
	text.x = 226;
	text.textBasline = "alphabetic";

	statsDisplay.addChild(bmp);
	statsDisplay.addChild(text);
}

function drawGame() {
	$.getJSON('game-map.json', function(data) {
		that.mapData = data['main'];
		that.drawMap(that.mapData);

		$.each(units, function(i, value) {
			stage.addChild(value);
			stage.addChild(value.hp_bar);
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


	menuBackground = new createjs.Bitmap("graphics/ingame_menu/ingame_menu_background.png");
	menuBackground.x = unit.x + 43;
	menuBackground.y = unit.y - 150;
	menuBackground.scaleX = 0.6;
    menuBackground.scaleY = 0.6;

	moveSource = unit.canMove === 1 && unit.outOfMoves === 0 ? "graphics/ingame_menu/move.png"
								    : "graphics/ingame_menu/move_gray.png";
	moveButton = createClickableImage(moveSource, unit.x + 45, unit.y - 140, function() {
		if (unit.canMove) {
			undoHighlights();
			drawRange(findReachableTiles(unit.column, unit.row, unit.moveRange, true), 0);
		}
	});

	attackSource = unit.canAttack === 1 && unit.outOfMoves === 0 ? "graphics/ingame_menu/attack.png"
								   : "graphics/ingame_menu/attack_gray.png";
	attackButton = createClickableImage(attackSource, unit.x + 49, unit.y - 111, function() {
		if (unit.canAttack) {
			undoHighlights();
			isAttacking = true;
			drawRange(findReachableTiles(unit.column, unit.row, unit.attackRange, false), 1);
		}
	});

	skillSource = unit.skillCoolDown === 0 && unit.outOfMoves === 0 ? "graphics/ingame_menu/skill.png"
								   : "graphics/ingame_menu/skill_gray.png";
	skillButton = createClickableImage(skillSource, unit.x + 48, unit.y - 77, function() {
		if (unit.skillCoolDown === 0) {
			undoHighlights();
			unit.skillCoolDown = "3";
			unit.outOfMoves = 1;
			cast(unit.skill_no, unit);
		}
	});

	cancelSource = "graphics/ingame_menu/cancel.png";
	cancelButton = createClickableImage(cancelSource, unit.x + 45.5, unit.y - 47, function() {
		clearSelectionEffects();
	});

	stage.addChild(menuBackground);
    stage.addChild(moveButton);
    stage.addChild(attackButton);
    stage.addChild(skillButton);
    stage.addChild(cancelButton);

	var min = moveButton;
	min = stage.getChildIndex(attackButton) < stage.getChildIndex(min) ? attackButton : min;
	min = stage.getChildIndex(skillButton) < stage.getChildIndex(min) ? skillButton : min;
	min = stage.getChildIndex(cancelButton) < stage.getChildIndex(min) ? cancelButton : min;

	if (stage.getChildIndex(menuBackground) > stage.getChildIndex(min)) {
		stage.swapChildren(menuBackground, min);
	}


    isDisplayingMenu = true;
    changed = true;
}	
var secondAttack;
var firstAttackDone;
function cast(skillNo, unit) {
	switch (skillNo) {
		case 0: // King's skill
			// display effect
			$.each(units, function(i, value) {
				if (value.team === selectedCharacter.team) {
					//buff health
					var add = Math.ceil(0.1 * value.max_hp);
					value.buffs.push([0,add,3]);
					value.buffs.push([1,add,3]);
					//buff dmg
					value.buffs.push([2,5,3]);

					destroyStats();
					displayStats(value);

					destroyMenu();
					showActionMenuNextToPlayer(value);

					changed = true;
				}
			});
			// notify server

			// display updated json
			break;
		case 1: // Archer's skill
		 //    var atk = selectedCharacter.attack;
		 //    selectedCharacter.attack = 2 * atk;

			// isAttacking = true;
			// undoHighlights();
			// drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 1);
		
			undoHighlights();
			isAttacking = true;
			secondAttack = true;
			secondAttackDone = false;
			drawRange(findReachableTiles(unit.column, unit.row, unit.attackRange, false), 1);
			
			break;
	    case 3: // Warrior's skill
	    	undoHighlights();

	    	var found = false;

	    	$.each(selectedCharacter.buffs, function(i, value) {
	    		if (value[0] == 5) {
	    			found = true;
	    		}
	    	});
	    	
	    	if (!found) {
	    		selectedCharacter.buffs.push([5, 0, -1]);
    			buff_icon = new createjs.Bitmap("graphics/buff_shield.png");
				buff_icon.x = unit.x + 5;
				buff_icon.y = unit.y - 70;
				stage.addChild(buff_icon);
	    	}


			destroyMenu();
			showActionMenuNextToPlayer(selectedCharacter);

			changed = true;

	    	break;
	    case 4: // Wizard's skill
	    	drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 2);
			
	}
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

function drawRange(reachable, typeOfRange) {

	destroyMenu();

	$.each(reachable, function(i, value) {
		img = (typeOfRange == 0) ? "graphics/green_tile.png" : "graphics/red_tile.png";
		var bmp = new createjs.Bitmap(img);
		bmp.x = (value[1]-value[0]) * 65 + 540;
		bmp.y = (value[1]+value[0]) * 32.5 + 220;
		bmp.regX = 65;
		bmp.regY = 32.5;
		bmp.column = value[0];
		bmp.row = value[1];
		if (typeOfRange == 0) {
			bmp.addEventListener("click", function(event) {
				var fromX = selectedCharacter.column;
				var fromY = selectedCharacter.row;
				findPath(fromX, fromY, value[0], value[1]);
				move();
				selectedCharacter.column = value[0];
				selectedCharacter.row = value[1];
				clearSelectionEffects();
			});
		} else if (typeOfRange == 1) {
			$.each(units, function(i, unit) {
				if (unit.column == value[0] && unit.row == value[1] &&
						selectedCharacter.team != unit.team){
					bmp.addEventListener("click", function(event) {
						attack(selectedCharacter, unit);
						selectedCharacter.attack = selectedCharacter.base_attack;
						clearSelectionEffects();
					});
				}
			});
		} else if (typeOfRange == 2) {
			bmp.addEventListener("click", function(event) {
				$.each(units, function(i, unit) {
					if (unit.column == bmp.column && unit.row == bmp.row) {
						attack(selectedCharacter, unit);
					}
					if (unit.column == bmp.column
						&& (unit.row == bmp.row-1 || unit.row == bmp.row+1)) {
						attack(selectedCharacter, unit);
					}
					if (unit.row == bmp.row
						&& (unit.column == bmp.column-1 || unit.column == bmp.column+1)) {
						attack(selectedCharacter, unit);
					}
					clearSelectionEffects();
				});
			});
			bmp.addEventListener("mouseover", function(event) {
				var tiles = getSurroundingTiles(bmp.column, bmp.row);
				$.each(tiles, function(i, tile) {
					var sub_bmp = new createjs.Bitmap("graphics/green_tile.png");
					sub_bmp.x = (tile[1]-tile[0]) * 65 + 540;
					sub_bmp.y = (tile[1]+tile[0]) * 32.5 + 220;
					sub_bmp.regX = 65;
					sub_bmp.regY = 32.5;
					stage.addChild(sub_bmp);
					sub_highlighted.push(sub_bmp);
				});
				stage.update();
			});
			bmp.addEventListener("mouseout", function(event) {
				$.each(sub_highlighted, function(i, tile) {
					stage.removeChild(tile);
				});
				stage.update();
			});
		}
		stage.addChild(bmp);
		highlighted.push(bmp);
		$.each(units, function(i, value) {
			if (stage.getChildIndex(value) < stage.getChildIndex(bmp)) {
				stage.swapChildren(bmp, value);
				stage.swapChildren(bmp, value.hp_bar);
			}
		});
	});
	isInHighlight = true;
	changed = true;
}

function getSurroundingTiles(col, row) {
	var result = [];
	result.push([col,row]);
	if (col > 0) {
		result.push([col-1,row]);
	}
	if (col < mapWidth-1) {
		result.push([col+1,row]);
	}
	if (row > 0) {
		result.push([col,row-1]);
	}
	if (row < mapHeight-1) {
		result.push([col,row+1]);
	}
	return result
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
	damageText.y -= 0.2;
	damageBackground.y -= 0.2;
	stage.update(damageText,damageBackground);
	for (var i = 0; i < 100; i++) {
		setTimeout(function (){
			damageText.y -= 0.2;
			damageBackground.y -= 0.2;
			stage.update(damageText,damageBackground);
		}, 100);
		
	}
	
}
function showDamage(unit, critical, damage){
	unit.damageBackground = new createjs.Shape();
	if (critical == 2) {
		unit.damageBackground.graphics.beginFill("#ffeb00").drawRect(unit.x - 10, unit.y - 50, 40, 20);
		unit.damageText = new createjs.Text(damage, "20px '04b_19'", "#000000");
	} else {
		unit.damageBackground.graphics.beginFill("#ff0000").drawRect(unit.x - 10, unit.y - 50, 40, 20);
		unit.damageText = new createjs.Text(damage, "20px '04b_19'", "#000000");
	}
	unit.damageText.x = unit.x;
	unit.damageText.y = unit.y - 50;
	unit.damageText.textBasline = "alphabetic";

	stage.addChild(unit.damageBackground);
	stage.addChild(unit.damageText);
	stage.update();
	unit.showingDamage = true;
	demageEffect(unit.damageText, unit.damageBackground);	

	setTimeout(function (){
		stage.removeChild(unit.damageBackground);
		stage.removeChild(unit.damageText);
		unit.showingDamage = false;
		stage.update();
	}, 750);
}

var buff_icon;
function attack(attacker, target){
	if (attacker.team != target.team){
		console.log("target team: " + target.team);
		console.log("attacker team: " + attacker.team);
		var criticalHit = getRandom(getLuck(attacker));
		var damage = getAttack(attacker) * criticalHit
		
		var shield = false;
		$.each(target.buffs, function(i, value) {
			if (value[0] == 5) {
				shield = true;
				stage.removeChild(buff_icon);
				var index = target.buffs.indexOf(value);
				target.buffs.splice(index, 1);
			}
		});
		
		if (!shield) {
			showDamage(target, criticalHit, damage);
			target.hp -= damage;
		}
		// console.log("attack attacker: " + attacker.column +","+ attacker.row);
		// console.log("target hp: " + target.hp);
		updateHP_bar(target);
		attacker.outOfMoves = 1;
		attacker.canAttack = 0;
		isAttacking = false;

		// check for archer skill
		if (firstAttackDone){
			secondAttack = false;
		}
		if (secondAttack) {
			firstAttackDone = true;
		}
		changed = true;
	} 
}

function clearSelectionEffects() {
	destroyMenu();
    undoHighlights();
    destroyStats();
    isAttacking = false;
}

function destroyStats() {
	statsDisplay.removeChildAt(2,3);

	var box = new createjs.Bitmap("graphics/stats_background.png");
	box.scaleX = 0.9;
	box.scaleY = 0.5;
	statsDisplay.addChild(box);
	changed = true;
}

function destroyMenu() {
	if (!isDisplayingMenu) return;
	stage.removeChild(menuBackground);
	stage.removeChild(moveButton);
	stage.removeChild(attackButton);
	stage.removeChild(skillButton);
	stage.removeChild(cancelButton);
	changed = true;
}

function undoHighlights() {
	// console.log(isInHighlight);
	if (!isInHighlight) return;
	$.each(highlighted, function(i, tile) {
		stage.removeChild(tile);
	});
	$.each(sub_highlighted, function(i, tile) {
		stage.removeChild(tile);
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
			if (stage.getChildIndex(unit) < stage.getChildIndex(value)) {
				stage.swapChildren(unit, value);
			}
		} else if (unit.y < value.y) {
			if (stage.getChildIndex(unit) > stage.getChildIndex(value)) {
				stage.swapChildren(unit, value);
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
				if (blockMaps[nx][ny] === 1) continue;

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

	blockMaps = new Array(mapHeight);
	for (var i = 0; i < mapHeight; i++) {
		blockMaps[i] = new Array(mapWidth);
	}

	originX = 540;
	originY = 220;
	for (i = 0; i < mapHeight; i++) {
		for (j = 0; j < mapWidth; j++) {
			var terrain = data[i][j];
			blockMaps[i][j] = (terrain == 5 || terrain == 10) ? 1 : 0;
			img = imageNumber(terrain);
			maps[i][j] = new createjs.Bitmap(img);
			maps[i][j].name = i + "," + j + "," + tile_type + "," + tile_info_address;
			maps[i][j].x = (j-i) * 65 + 540;
			maps[i][j].y = (j+i) * 32.5 + 220;
			maps[i][j].regX = 65;
			maps[i][j].regY = 32.5;
			maps[i][j].addEventListener("mouseover",mouveOver);
			maps[i][j].addEventListener("mouseout", mouseOut);
			maps[i][j].addEventListener("click", function(event) {
				clearSelectionEffects();
			});
			stage.addChild(maps[i][j]);
		}
	}

}

	function mouseOut(evt){
		stage.removeChild(highLight_tile);
		stage.removeChild(tile_display);
		stage.removeChild(tile_info_text);
		stage.update();
	}

	function mouveOver(evt) {
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
		
		tile_info_text = new createjs.Text(tile_info, "20px Arial", "#000000");
		tile_info_text.x = 90;
		tile_info_text.y = 100;
		tile_info_text.textBaseline = "alphabetic";
		tile_info_text.textAlign = "center";
		stage.addChild(tile_display);
		stage.addChild(tile_info_text);


		highLight_tile = new createjs.Bitmap("graphics/highlight_tile.png");
		highLight_tile.x = (j-i) * 65 + 540;
		highLight_tile.y = (j+i) * 32.5 + 220;
		highLight_tile.regX = 65;
		highLight_tile.regY = 32.5;
		stage.addChild(highLight_tile);
		stage.update();
	}

createjs.Ticker.addEventListener("tick", update);
createjs.Ticker.setFPS(30);

function update() {
	//really bad!
	if (secondAttack && firstAttackDone) {
		undoHighlights();
		isAttacking = true;
		drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 1);
	}
	// if (unit.showingDamage === true){
	// 	demageEffect();
	// }
	if (movingPlayer === true) {
		movePlayer();
	}
	if (changed) {
		stage.update();
		changed = false;
	}
}
var tile_type;
var tile_info_address;
// Given the number in the game-map, returns the address of the tile's image
function imageNumber(number) {
	switch (number) {
		case 0 :
			tile_info_address = "graphics/tile_info/tile_grass.png";
			tile_type = "Grass";
			return "graphics/tile/grass.png";
		case 1 :
			tile_info_address = "graphics/tile_info/tile_mud.png";
			tile_type = "Mud";
			return "graphics/tile/mud.png";
		case 2 :
			tile_info_address = "graphics/tile_info/tile_stone_bridge.png";
			tile_type = "Stone Bridge";
			return "graphics/tile/stone_bridge.png";
		case 3 :
			tile_info_address = "graphics/tile_info/tile_stone_bridge.png";
			tile_type = "Stone Bridge";
			return "graphics/tile/stone_bridge2.png";
		case 4 :
			tile_info_address = "graphics/tile_info/tile_stone_path.png";
			tile_type = "Stone Path";
			return "graphics/tile/stone_ground.png";
		case 5 :
			tile_info_address = "graphics/tile_info/tile_water.png";
			tile_type = "Water";
			return "graphics/tile/water.png";
		case 6 :
			tile_info_address = "graphics/tile_info/tile_wood_bridge.png";
			tile_type = "Wood Bridge";
			return "graphics/tile/wood_bridge.png";
		case 7 :
			tile_info_address = "graphics/tile_info/tile_wood_bridge.png";
			tile_type = "Wood Bridge";
			return "graphics/tile/wood_bridge2.png";
		case 10:
			tile_info_address = "";
			tile_type = "";
			return "";
		default:
			return "error";
	}
}