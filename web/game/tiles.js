var ICON_SCALE_FACTOR = 0.65;
var MOVEMENT_STEP = 6.5;
var HAS_JSON_LOADED = false;

var stage = new createjs.Stage("gameCanvas");


var that = this;
var team = 0;
var movingUnit;

var isDragging = false;
var offX;
var offY;
var isPlayerTurn;


var lastMove;
var path = [];
var highlighted = [];
var sub_highlighted = [];
var units = [];
var maps;
var blockMaps;
var tile_display;
var highLight_tile;
var tile_info_text;
var gameEnd = false;

var moveButton;
var attackButton;
var skillButton;
var cancelButton;
var menuBackground;
var turnInfoText; 

var bottomInterface  = new createjs.Container();
var statsDisplay = new createjs.Container();
var unitCreationMenu = new createjs.Container();
var unitCards = [];
var greyUnitCards = [];

var isDisplayingMenu = false;
var isInHighlight = false;
var changed = false;
var movingPlayer = false;
var isAttacking = false;
var remainingTargets;
var archerTargets = [];
var isCasting = false;
var currentGold;
var p1currentGold;
var p2currentGold;
var currentGoldDisplay;
var mapDrawn = false;
var resized = false;


var turn = 0;
var playableUnitCount = 0;


var	archerSkillDone = false;
var undoMove = [];
var undo = false;

var bgMusic = true;
var enableCountDown = true;
var turnTimer;
var remainingTurnTime;
var timerIntervalId;
var bg;
function startTimer() {
 var bgss = new createjs.SpriteSheet({
          "images": ["graphics/ss_cd.png"],
          "frames": {"regX": 50, "height": 159, "count": 2, "regY": 50, "width": 371 },
          "animations": {
            "tick":[0,1]
          },
          framerate: 2
        });  
var bgss2 = new createjs.SpriteSheet({
          "images": ["graphics/ss_cd2.png"],
          "frames": {"regX": 50, "height": 159, "count": 2, "regY": 50, "width": 371 },
          "animations": {
            "tick":[0,1]
          },
          framerate: 2
        });  


 if (turn == 1) {
 	bg = new createjs.Sprite(bgss, "tick");
 } else {
 	bg = new createjs.Sprite(bgss2, "tick");
 }
 
 bg.x = turnTimer.x - 100;
 bg.y = turnTimer.y ;
 stage.addChild(bg);
 stage.setChildIndex(bg, 2);


  if (typeof(timerIntervalId) != "undefined") window.clearInterval(timerIntervalId);
  timerIntervalId = setInterval(function() {
    refreshTimer(remainingTurnTime - 1);
  }, 1000);
}
var turnTimerbg;
function refreshTimer(remainingTime) {
  if (gameEnd) return; //stop timer if game ended.
  
  stage.removeChild(turnTimerbg);
  stage.removeChild(turnTimer);
  remainingTurnTime = remainingTime;
  if (remainingTurnTime === -1) {
    stage.removeChild(bg);
  	 
	setTimeout(function(){
  	 	 serverValidate("turn_change", null, [1]);
	        	clearSelectionEffects();
  	 },1);


  } //else {
  	var timeText;
  	if (remainingTurnTime < 10){
  		timeText = "0" + remainingTurnTime;
  	} else {
  		timeText = remainingTurnTime;
  	}
  	if (remainingTurnTime < 0) timeText = "00";

    var offset_timer = -30;
  	turnTimerbg = new createjs.Text("" + timeText, "70px '04b_19'", "#000000");
    turnTimerbg.x = stage.canvas.width - stage.canvas.width/2 + 2 + offset_timer;
    turnTimerbg.y = 48;
    turnTimer = new createjs.Text("" + timeText, "70px '04b_19'", "#ffffff");
    turnTimer.x = stage.canvas.width - stage.canvas.width/2 + offset_timer;
    turnTimer.y = 50;

    stage.addChild(turnTimerbg);
    stage.addChild(turnTimer);
 // }
}










function showTurnInfo(){
	stage.removeChild(playerLabel);
	stage.removeChild(playerLabelBg);
	if (turn) {
		var playerLabelBg = new createjs.Shape();
		playerLabelBg.graphics.beginFill("#000000").drawRect(-stage.canvas.width ,stage.canvas.height - stage.canvas.height/2 ,stage.canvas.width * 2,80);
		var playerLabel = new createjs.Text("Blue Player Turn", "30px Arial", "#00cdff");
	} else {
		var playerLabelBg = new createjs.Shape();
		playerLabelBg.graphics.beginFill("#000000").drawRect(-stage.canvas.width ,stage.canvas.height - stage.canvas.height/2 ,stage.canvas.width * 2,80);
		var playerLabel = new createjs.Text("Red Player Turn", "30px Arial", "#ff5555");
	}
	playerLabel.x = stage.canvas.width - stage.canvas.width / 2 - 100;
	playerLabel.y = stage.canvas.height -  stage.canvas.height / 2 + 20;
	playerLabelBg.alpha = 0.7;

	stage.addChild(playerLabelBg);
	stage.addChild(playerLabel);
	setTimeout(function() {
		stage.removeChild(playerLabel);
		stage.removeChild(playerLabelBg);
	}, 1000);
}


function handleBuffEffect(action) {
    var effectName = action.buff_effect;
    var unit = findUnitById(action.unit_id);
    var healthChange = action.health_change;
    console.log(healthChange);
    unit.hp += healthChange;
    updateHP_bar(unit);

    switch (effectName) {
        case "Burn":
            setTimeout(function() {
                var fire = new createjs.Sprite(unit.burnEffect, "burn");
                if (healthChange < 0) showDamage(unit, 1, healthChange);
                fire.x = unit.x;
                fire.y = unit.y;
                chars.addChild(fire);

                setTimeout(function() {
                    chars.removeChild(fire);
                }, 1000);
            }, 800);
            break;
        case "Heal":
            setTimeout(function() {
                var heal = new createjs.Sprite(unit.healEffect, "heal");
                heal.x = unit.x;
                heal.y = unit.y;
                chars.addChild(heal);

                setTimeout(function() {
                    chars.removeChild(heal);
                 }, 1000);
            }, 800);
            break;
        case "Freeze":
            console.log("freeze triggered");
            setTimeout(function() {
                var ice = new createjs.Sprite(unit.frozenEffect, "ice");
                ice.x = unit.x;
                ice.y = unit.y;
                chars.addChild(ice);
                setTimeout(function() {
                    chars.removeChild(ice);
                }, 1000);
            }, 800);
            break;
        case "IncAttack":
            console.log("trigger king buff");
            var incAttackEffect = new createjs.Sprite(unit.incAttack, "heal");
            incAttackEffect.x = unit.x;
            incAttackEffect.y = unit.y;
            chars.addChild(incAttackEffect);
            setTimeout(function() {
                chars.removeChild(incAttackEffect);
            }, 1000);
        break;
    }
}



function resize() {

  stage.canvas.height = $("body").prop("clientHeight");
  stage.canvas.width = window.innerWidth;
	// stage.canvas.width = window.innerWidth;
	//stage.canvas.height = window.innerHeight;
	//drawGame();
	//drawStatsDisplay();
	resized = true;
}

// typeName : king, red_castle, wizard, etc
// initial: true / false
function spawnUnit(data, isCreation, row, column){
	chars.removeChild(spawnAnimation);
		var spriteSheet = new createjs.SpriteSheet({
          	"images": [data.address],
          	"frames": {"regX": 0, "height": 142, "count": 2, "regY": -30, "width": 113 },
          	"animations": {
            	"stand":[0,1]
          	},
          	framerate: 2
    	});

		var unit = new createjs.Sprite(spriteSheet, "stand");

		
		createjs.Ticker.timingMode = createjs.Ticker.RAF;	
		createjs.Ticker.addEventListener("tick", stage);
		// Configure unit coordinates
        unit.unit_id = data.unit_id;
        unit.commandable = data.commandable;
		unit.hp = data.hp;
		unit.max_hp = data.max_hp;
		unit.attack = data.attack;
		unit.base_attack = unit.attack;
		unit.luck = data.luck;

		var spawnSpriteSheet = new createjs.SpriteSheet({
	      	"images": ["graphics/spritesheet/special_unit/ss_unit_creation.png"],
	      	"frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 65},
			"animations": {
				"damage":{
					frames: [0,1,2,3],
					next: false
				}
			},
			framerate: 4
		});

		unit.spawnSpriteSheet = spawnSpriteSheet;
		var spawnAnimation = new createjs.Sprite(spawnSpriteSheet, "spawn");

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

		var burnEffect = new createjs.SpriteSheet({
			"images": [that.buffEffects.burning],
			"frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 95},
			"animations": {
				"burn":{
					frames: [0,1,2,3],
					next: false
				}
			},
			framerate: 4
		});
		unit.burnEffect = burnEffect;

		var healEffect = new createjs.SpriteSheet({
			"images": [that.buffEffects.heal],
			"frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 95},
			"animations": {
				"heal":{
					frames: [0,1,2,3],
					next: false
				}
			},
			framerate: 4
		});
		unit.healEffect = healEffect;

        var frozenEffect = new createjs.SpriteSheet({
            "images": [that.buffEffects.freeze],
            "frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 95},
            "animations": {
                "ice":{
                    frames: [0,1,2,3],
                    next: false
                }
            },
            framerate: 4
        });
        unit.frozenEffect = frozenEffect;

        var incAttack = new createjs.SpriteSheet({
             "images": [that.buffEffects.battleCry],
             "frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 95},
             "animations": {
               "heal":{
                 frames: [0,1,2,3],
                 next: false
                }
            },
            framerate: 4
        });
        unit.incAttack = incAttack;


        unit.team = data.team;
	    unit.column = data.y;
	    unit.row = data.x;
		unit.x = originX +  (unit.column - unit.row) * 65;
		unit.y = unit.column * 32.5 + originY + unit.row * 32.5;
		//lalala	

		unit.regX = 56.5;
		unit.regY = 130;
		if (unit.team == 0 && data.skill_no != -1) unit.scaleX = -0.7;
        else unit.scaleX = 0.7
		unit.scaleY = 0.7;
		unit.skill = data.skill;
		unit.address = data.address;
		console.log(data.info);
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

		var moveSpriteSheet = new createjs.SpriteSheet({
            "images": [data.move],
            "frames": {"regX": 80, "height": 142, "count": 4, "regY": 100, "width": 142 },
            "animations": {
              "walk":[0,1,2,3]
            },
            framerate: 8
	    });
	    unit.moveAnimation = new createjs.Sprite(moveSpriteSheet, "walk");
	    unit.moveAnimation.x = unit.x;
	    unit.moveAnimation.y = unit.y;
	    unit.moveAnimation.scaleX = 0.7;
	    unit.moveAnimation.scaleY = 0.7;


		// Configure the hp bar of the unit
		hp_bar = new createjs.Shape();
		hp_bar.x = unit.x - 40;
		hp_bar.y = unit.y - 95;
		if (unit.team === 0){
			hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
			hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
			hp_bar.graphics.beginFill("#ff0000").drawRect(1, 1, (getHealth(data)/getMaxHealth(data)) * 80, 10);
		} else {
			hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
			hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
			hp_bar.graphics.beginFill("#3399ff").drawRect(1, 1, (getHealth(data)/getMaxHealth(data)) * 80, 10);
		}
		unit.hp_bar = hp_bar;

        unit.buffs = [];
        for (var i = 0; i < data.buffs.length; i++) {
            applyBuff(data.buffs[i], unit);
        }


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
	chars.addChild(unit);
	chars.addChild(hp_bar);

	unit.cache(0,0,150,150);
	hp_bar.cache(0,0,100,120);


	orderUnits();

	spawnAnimation.x = unit.x;
	spawnAnimation.y = unit.y;
	chars.addChild(spawnAnimation);
	setTimeout(function() {
		chars.removeChild(spawnAnimation);
	}, 1000);

	addEventListenersToUnit(unit);
}

var red_cas_x;
var red_cas_y;
var blue_cas_x;
var blue_cas_y;

function initGame() {

	createjs.Ticker.addEventListener("tick", keyEvent);
    this.document.onkeydown = keyEvent;
	stage.enableMouseOver(20);

	chars = new createjs.Container();
	stage.addChild(chars);

  var replay = isReplay ? '1' : '0';
	rawPost('ajax/game_state', {"room_id": room_id, "replay" : replay}, function(data) {
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

        team = data.team;
        turn = data.turn;

        showTurnInfo();


		that.buffEffects = data.buffEffects;
		// p1currentGold = data.P1currentGold;
		// p2currentGold = data.P2currentGold;
		currentGold = data.gold;


		for (var i = 0; i < unitCards.length; i++) {
			if (unitCards[i].price > currentGold) {
				greyOutCard(i);
			} else {
				colourCard(i);
			}
		}

		drawGoldDisplay();
		that.drawMap(that.mapData);


		//should only spawn 2 kings and castles
		$.each(data.characters, function(i, value) {
			// console.log(data.characters[i].x);
      if (data.characters[i].name == "red castle") {
        red_cas_x = data.characters[i].x;
        red_cas_y = data.characters[i].y;
      } else if (data.characters[i].name == "blue castle") {
        blue_cas_x = data.characters[i].x;
        blue_cas_y = data.characters[i].y;
      }
			spawnUnit(data.characters[i], false);
		});
        // turnStartPhase();
		if (enableCountDown) {
	   	  refreshTimer(data.countdown);
	   	  startTimer();
	 	}
    HAS_JSON_LOADED = true;
    start_replay();
	});

	stage.canvas.height = $("body").prop("clientHeight");//window.innerHeight; //$("body").prop("clientHeight");
  stage.canvas.width = window.innerWidth;

	draggable = new createjs.Container();
	drag_box = new createjs.Shape();
	drag_box.graphics.drawRect(-stage.canvas.width*50,-stage.canvas.height*50,stage.canvas.width * 100,stage.canvas.height * 100);
	drag_box.hitArea = new createjs.Shape();
	drag_box.hitArea.graphics.beginFill("#000").drawRect(-stage.canvas.width * 50,-stage.canvas.height * 50,stage.canvas.width * 100,stage.canvas.height * 100);
	draggable.addChild(drag_box);
	draggable.on("pressmove", function(event) {
		if (isDragging) {
			this.x = event.stageX - offX;
    		this.y = event.stageY - offY;
    	} else if (!isInHighlight) {
    		offX = stage.mouseX - draggable.x;
    		offY = stage.mouseY - draggable.y;
    		isDragging = true;
    		draggable.removeChild(highLight_tile);
    	}
	});
	draggable.on("pressup", function(event) {
		if (isDragging) {
			isDragging = false;
		}
	});
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

	drawMenuDisplay();

	// stage.update();
  setTimeout(function() {getOpp(); }, 1000);

  	




  
}


var muteIcon; 
var playIcon;

function destroyMenuDisplay(){
	stage.removeChild(quitIcon);
	stage.removeChild(muteIcon);
	stage.removeChild(playIcon);
}
function drawMenuDisplay(){
	// var audio = new Audio('Test.mp3');
	// audio.loop = true;
	// audio.play();

	muteIcon = new createjs.Bitmap("graphics/mute2.png");
	muteIcon.x = stage.canvas.width - 220;
	muteIcon.y = 5;
	muteIcon.scaleX = 0.7;
	muteIcon.scaleY = 0.7;
	
	playIcon = new createjs.Bitmap("graphics/mute.png");
	playIcon.x = stage.canvas.width - 220;
	playIcon.y = 5;
	playIcon.scaleX = 0.7;
	playIcon.scaleY = 0.7;

	quitIcon = new createjs.Bitmap("graphics/quit.png");
	quitIcon.x = stage.canvas.width - 260;
	quitIcon.y = 5;
	quitIcon.scaleX = 0.68;
	quitIcon.scaleY = 0.68;

	stage.addChild(quitIcon);
	  quitIcon.addEventListener("click", function(event){

    displayWarningBox(function(){
        quit_game();
    },function(){
      removeWarningBox();
    });
  });

	stage.addChild(muteIcon);
	muteIcon.addEventListener("click", function(event) {
		audio.pause();
		bgMusic = false;
		stage.removeChild(muteIcon);
		stage.addChild(playIcon);
	});
	playIcon.addEventListener("click", function(event) {
		audio.play();
		bgMusic = true;
		stage.removeChild(playIcon);
		stage.addChild(muteIcon);
	});
	// stage.update();

}

function removeBuff(buffType, unit) {
    var success = false;
    for (var i = 0; i < unit.buffs.length; i++) {
        console.log(unit.buffs[i][0] == buffType);
        if (unit.buffs[i][0] == buffType) {
            chars.removeChild(unit.buffs[i][2]);
            unit.buffs.splice(i, 1);
            success = true;
            break;
        } 
    }

    for (var i = 0; i < unit.buffs.length; i++) {
        unit.buffs[i][2].x = unit.hp_bar.x + i * 25;
        stage.update();
    }

    return success;
}


function applyBuff(buffType, unit) {

    if (unit == null) return; /* Don't apply buff to a dead unit */
    var buffAlreadyExists = false;
    for (var i = 0; i < unit.buffs.length; i++) {
        if (unit.buffs[i][0] === buffType) {
            buffAlreadyExists = true;
            break;
        }
    }

    if (buffAlreadyExists) removeBuff(buffType, unit);

    var buffIcon;
	switch (buffType) {
		case 0: // hp Buff 
            break;
		case 1: // max hp Buff
            break;
		case 2: // inc attack Buff
			buffIcon = new createjs.Bitmap("graphics/buff/buff_inc_attack.png");
			unit.buffs.push([2, 1.2, buffIcon]);
			break;
		case 3: // dec attack Buff
            buffIcon = new createjs.Bitmap("graphics/buff/buff_dec_attack.png");
            unit.buffs.push([3, 0.8, buffIcon]);
            break;
		case 4:	// shield Buff
			buffIcon = new createjs.Bitmap("graphics/buff/buff_shield.png");
			unit.buffs.push([4, -1, buffIcon]);
			break;
        case 5: // burn Buff
            buffIcon = new createjs.Bitmap("graphics/buff/buff_burning.png");
            unit.buffs.push([5, 0.02, buffIcon]);
            break;
        case 6: // freeze Buff
            buffIcon = new createjs.Bitmap("graphics/buff/buff_frozen.png");
            unit.buffs.push([6, -1, buffIcon]);
            break;
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
			base *= value[1];
		} // if type == health, add to base
	});

	return base;
}


function getMaxHealth(unit) {
	var base = unit.max_hp;
	$.each(unit.buffs, function(i, value) {
		if (value[0] == 1) {
			base *= value[1];
		} // if type == max_health, add to base
	});
	return base;
}


function getAttack(unit) {
	var base = unit.attack;
	$.each(unit.buffs, function(i, value) {
		if (value[0] == 2 || value[0] == 3) {
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
		for (var i = 0; i <= 6; i++) {
			removeBuff(i, unit);
		}
		// if (unit.address == "graphics/spritesheet/stand/ss_king_stand.png") {
		//     var endLabelBg = new createjs.Shape();
		// 	endLabelBg.graphics.beginFill("#000000").drawRect(-stage.canvas.width ,stage.canvas.height - stage.canvas.height/2 ,stage.canvas.width * 2,80);
		// 	if (turn){
		// 		var endLabel = new createjs.Text("Player2 Win", "30px Arial", "#0000ff");
		// 	} else {
		// 		var endLabel = new createjs.Text("Player1 Win", "30px Arial", "#ff0000");
		// 	}
		// 	var restartLabel = new createjs.Text("Press \" r \" to restart", "15px Arial", "#ffffff");
			
		// 	endLabel.x = stage.canvas.width - stage.canvas.width / 2 - 100;
		// 	endLabel.y = stage.canvas.height -  stage.canvas.height / 2 + 20;
		// 	restartLabel.x = endLabel.x + 20;
		// 	restartLabel.y = endLabel.y + 35;
		// 	endLabelBg.alpha = 0.7;

		// 	stage.addChild(endLabelBg);
		// 	stage.addChild(restartLabel);
		// 	stage.addChild(endLabel);
		// 	endGame = true;
		// 	stage.mouseChildren = false;
		//  }
	// } else {
		// unit.hp_bar.graphics.clear();
		// unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 80, 10);
		// unit.hp_bar.graphics.beginFill("#ff0000").drawRect(0, 0, (getHealth(unit) / getMaxHealth(unit)) * 80, 10);
    }
	if (unit.team == 0){
		unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
		unit.hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
		unit.hp_bar.graphics.beginFill("#ff0000").drawRect(1, 1, (getHealth(unit)/getMaxHealth(unit)) * 80, 10);
	} else {
		unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
		unit.hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
		unit.hp_bar.graphics.beginFill("#3399ff").drawRect(1, 1, (getHealth(unit)/getMaxHealth(unit)) * 80, 10);
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
    if (isSpectating) return;
	var listOfSources = [];
	listOfSources.push("graphics/card/knight_card.png");
	listOfSources.push("graphics/card/archer_card.png");
    listOfSources.push("graphics/card/wizard_card.png");
    listOfSources.push("graphics/card/totem_card.png");
	listOfSources.push("graphics/card/dragon_card.png");
	//listOfSources.push("graphics/card/rogue_card.png");

	createFloatingCards(listOfSources, ["knight","archer","wizard","totem", "dragon"]);
	unitCreationMenu.x = 50;
	unitCreationMenu.y = window.innerHeight - 130;
	bottomInterface.addChild(unitCreationMenu);
}


function findAvailableAndNonAvailableSpawnTiles(range) {
   if (typeof(range) == "undefined") range = 2;
   var availableSpawnTiles = [];
   var nonAvailableSpawnTiles = [];
   var originX = team == 0 ? red_cas_x : blue_cas_x;
   var originY = team == 0 ? red_cas_y : blue_cas_y;
   var di = team == 0 ? 1 : -1;
   var dj = team == 0 ? 1 : -1;

   for (var i = 0 - range; i <= range; i++) {
       if (originX + i * di >= mapHeight || originX + i * di < 0) continue;
       for (var j = 0 - range; j <= range; j++) {
           if (originY + j * dj >= mapWidth || originY + j * dj < 0) continue;
           if (blockMaps[originX + i * di][originY + j * dj] === 0) {
               availableSpawnTiles.push([originX + i * di, originY + j * dj]);
           } else {
               nonAvailableSpawnTiles.push([originX + i * di, originY + j * dj]);
           }
       }
   }

   return [availableSpawnTiles, nonAvailableSpawnTiles];
}


function createFloatingCards(listOfSources, correspondingUnit) {
	var numOfCards = listOfSources.length;
    var newUnitSpawnTiles = [];
	for (i = 0; i < listOfSources.length; i++) {
		unitCards[i] = new createjs.Bitmap(listOfSources[i]);
		// var unit_card_text = new createjs.Text("$ 100", "12px 'Arial'", "#ffffff");
		unitCards[i].y = 0;
		unitCards[i].x = i * (110);
		unitCards[i].scaleX = 0.60;
		unitCards[i].scaleY = 0.60;
		unitCards[i].index = i;
		unitCards[i].unitName = correspondingUnit[i];

		greyUnitCards[i] = new createjs.Bitmap(listOfSources[i].slice(0,-4) + "_gray.png");
		greyUnitCards[i].y = unitCards[i].y;
		greyUnitCards[i].x = unitCards[i].x;
		greyUnitCards[i].scaleX = unitCards[i].scaleX;
		greyUnitCards[i].scaleY = unitCards[i].scaleY;
		greyUnitCards[i].index = unitCards[i].index;
		greyUnitCards[i].unitName = correspondingUnit[i];

		switch(unitCards[i].unitName ){
			case "knight": 
                unitCards[i].price = 120;
                unitCards[i].text = new createjs.Text("$ 120", "12px 'Arial'", "#ffffff");
				unitCards[i].addEventListener("click", function(event) {
                    if (team != turn || isInHighlight || isSpectating) return;
                    if (currentGold < 120) {

                        return;
                    } 

                    var spawnTiles = findAvailableAndNonAvailableSpawnTiles();
                    highlightArea(spawnTiles[0], "graphics/tile/green_tile.png", ["click"], [function(event) {
                        var tile = event.target;
                        createNewUnit("knight", tile.row, tile.column);
                        clearSelectionEffects();
                    }]);
                    highlightArea(spawnTiles[1], "graphics/tile/red_tile.png", [], []);

					// createNewUnit("knight");
				});
				break;
			case "archer": 
                unitCards[i].price = 120;
                unitCards[i].text = new createjs.Text("$ 120", "12px 'Arial'", "#ffffff");
				unitCards[i].addEventListener("click", function(event) {
                    if (team != turn || isInHighlight || isSpectating) return;
                    var spawnTiles = findAvailableAndNonAvailableSpawnTiles();
                    highlightArea(spawnTiles[0], "graphics/tile/green_tile.png", ["click"], [function(event) {
                        var tile = event.target;
                        createNewUnit("archer", tile.row, tile.column);
                        clearSelectionEffects();
                    }]);
                    highlightArea(spawnTiles[1], "graphics/tile/red_tile.png", [], []);
                    // createNewUnit("knight");
                });
				break;
			case "wizard": 
                unitCards[i].price = 150;
                unitCards[i].text = new createjs.Text("$ 150", "12px 'Arial'", "#ffffff");
				unitCards[i].addEventListener("click", function(event) {
                    if (team != turn || isInHighlight || isSpectating) return;
                    var spawnTiles = findAvailableAndNonAvailableSpawnTiles();
                    highlightArea(spawnTiles[0], "graphics/tile/green_tile.png", ["click"], [function(event) {
                        var tile = event.target;
                        createNewUnit("wizard", tile.row, tile.column);
                        clearSelectionEffects();
                    }]);
                    highlightArea(spawnTiles[1], "graphics/tile/red_tile.png", [], []);
                    // createNewUnit("knight");
                });
				break;
			case "totem":
                unitCards[i].price = 200;
                unitCards[i].text = new createjs.Text("$ 200", "12px 'Arial'", "#ffffff");
                unitCards[i].addEventListener("click", function(event) {
                    if (team != turn || isInHighlight || isSpectating) return;
                    var spawnTiles = findAvailableAndNonAvailableSpawnTiles(15);
                    highlightArea(spawnTiles[0], "graphics/tile/green_tile.png", ["click"], [function(event) {
                        var tile = event.target;
                        createNewUnit("totem", tile.row, tile.column);
                        clearSelectionEffects();
                    }]);
                    highlightArea(spawnTiles[1], "graphics/tile/red_tile.png", [], []);
                    // createNewUnit("knight");
                });
                break;
            case "dragon":
                unitCards[i].price = 300;
                unitCards[i].text = new createjs.Text("$ 300", "12px 'Arial'", "#ffffff");
                unitCards[i].addEventListener("click", function(event) {
                    if (team != turn || isInHighlight || isSpectating) return;
                    var spawnTiles = findAvailableAndNonAvailableSpawnTiles();
                    highlightArea(spawnTiles[0], "graphics/tile/green_tile.png", ["click"], [function(event) {
                        var tile = event.target;
                        createNewUnit("dragon", tile.row, tile.column);
                        clearSelectionEffects();
                    }]);
                    highlightArea(spawnTiles[1], "graphics/tile/red_tile.png", [], []);
                    // createNewUnit("knight");
                });
                break;
		}

        unitCards[i].text.y = unitCards[i].y+80;
        unitCards[i].text.x = unitCards[i].x+28;
		

		greyUnitCards[i].text = unitCards[i].text;
		greyUnitCards[i].text.y = unitCards[i].y+80;
		greyUnitCards[i].text.x = unitCards[i].x+28;

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

function createNewUnit(unitType, row, column) {
    serverValidate("create", null, [unitType, row, column]);
    destroyGoldDisplay();
    drawGoldDisplay();
}


function addEventListenersToUnit(unit) {
    unit.addEventListener("click", function(event) {

            if (isSpectating) {
                clearSelectionEffects();
                displayStats(unit);
                return;
            }

            if (isInHighlight && !isAttacking && !isCasting){
                // console.log("yomama2");
                return;
            }
            if (!movingPlayer && !isAttacking && !isCasting) {
                clearSelectionEffects();
                // console.log(unit.row + " " + unit.column + " " + unit.commandable + " " + turn);
                selectedCharacter = unit;
                if (unit.team == turn && unit.team == team && unit.commandable == 1) showActionMenuNextToPlayer(unit);
                displayStats(unit);
                return;
            }


            // In this case, we are selecting the unit to be attacked
            if (selectedCharacter != unit && !isCasting && isAttacking && selectedCharacter.team != unit.team) {
                $.each(highlighted, function(i, coord) {
                    if (unit.row === coord.row && unit.column === coord.column) {
                    	serverValidate("attack", selectedCharacter, [unit]);
                    }
                });
            }

            // In this case, we are marking archer skill targets
            if (selectedCharacter != unit && isCasting && selectedCharacter.skill == "Double Shoot" && selectedCharacter.team != unit.team) {
                for (var i = 0; i < highlighted.length; i++) {
                    if (highlighted[i].row === unit.row && highlighted[i].column === unit.column) {
                        break;
                    }
                    if (i == highlighted.length - 1) return;
                }
                archerTargets.push(unit.unit_id);
                // console.log("adding units with coordinates: (" + unit.row + " " + unit.column + ") to archer targets");
                remainingTargets--;
                // applyBuff(7, unit);
                if (remainingTargets == 0) {
                    undoHighlights();
                    serverValidate("skill", selectedCharacter, archerTargets);
                }
            }




            // In this case, we are selecting the unit to be attacked by the wizard or dragon spell
            if (selectedCharacter != unit && isCasting && (selectedCharacter.skill == "Magic Damage" || selectedCharacter.skill == "Icy Wind") && selectedCharacter.team != unit.team) {
                for (var i = 0; i < highlighted.length; i++) {
                    if (highlighted[i].row === unit.row && highlighted[i].column === unit.column) {
                        break;
                    }
                    if (i == highlighted.length - 1) return;
                }
                serverValidate("skill", selectedCharacter, [unit.row, unit.column]);
            }

            changed = true;
        });

        unit.addEventListener("mouseover", function(event) {
            if (isCasting && selectedCharacter.skill == "Magic Damage") {
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

function markArcherTargets(event) {
    var unit = findUnitByCoordinates(event.target.row, event.target.column);
    if (unit == null) return;
    archerTargets.push(unit.unit_id);
    // console.log("adding units with coordinates: (" + unit.row + " " + unit.column + ") to archer targets");
    remainingTargets--;
    // applyBuff(7, unit);
    if (remainingTargets == 0) {
        undoHighlights();
        serverValidate("skill", selectedCharacter, archerTargets);
    }
}

var isGoldDisplayed = false;
function destroyGoldDisplay() {
  if (!isGoldDisplayed) return;
	stage.removeChild(coin_pic);
	stage.removeChild(currentGoldDisplay);
  isGoldDisplayed = false;
}

function drawGoldDisplay() {
  destroyGoldDisplay();
  isGoldDisplayed = true;
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
	stage.addChild(coin_pic);
	stage.addChild(currentGoldDisplay);
}

function drawStatsDisplay() {
	statsDisplay.x = window.innerWidth - 350;
	statsDisplay.y = window.innerHeight - 180;
	// stage.addChild(statsDisplay);
}

function displayStats(unit) {
	if(unit.team === 1){
		var drag_box = new createjs.Bitmap("graphics/stats_background_self.png");
	} else {
		var drag_box = new createjs.Bitmap("graphics/stats_background_opponent.png");
	}
	
	drag_box.scaleX = 0.8;
	drag_box.scaleY = 0.8;
	statsDisplay.addChild(drag_box);

	var bmp = new createjs.Bitmap(unit.info);
	bmp.scaleX = 0.75;
	bmp.scaleY = 0.75;

	bmp.y = 10;
	bmp.x = 20; // 226
	//stage.update();
	var text = (unit.team == team || isSpectating) ? new createjs.Text("HP : " + getHealth(unit) + "/" + getMaxHealth(unit) + "\n" +
		"ATTACK : "  + getAttack(unit) + "\n" + "ATTACK RANGE : " + unit.attackRange + "\n" +
		"SKILL : " + unit.skill +  "\n" + "CD: " + unit.skillCoolDown  + "\n" +
		"MOVE RANGE : " + unit.moveRange + "\n" +
		"LUCK : " + getLuck(unit), "15px Arial", "#000000")
	: new createjs.Text("HP : " + getHealth(unit) + "/" + getMaxHealth(unit) + "\n" +
		"ATTACK : "  + "???"  + "\n" + "ATTACK RANGE : " + "???" + "\n" +
		"SKILL : " + "???"  + "\n" +"CD: " + "???" + "\n" +
		"MOVE RANGE : " + "???" + "\n" +
		"LUCK : " + "???", "15px Arial", "#000000");
	text.y = 25;
	text.x = 156;
	text.textBasline = "alphabetic";

	statsDisplay.addChild(bmp);
	statsDisplay.addChild(text);
}

function drawGame() {
  var replay = isReplay ? '1' : '0';
  rawPost('ajax/game_state', {"room_id": room_id, "replay" : replay}, function(data) {
		that.mapData = data['main'];
		that.drawMap(that.mapData);

		$.each(units, function(i, value) {
			chars.addChild(value);
			chars.addChild(value.hp_bar);
		});

		orderUnits();

		changed = true;
    HAS_JSON_LOADED = true;
	});	
}


$(document).ready(function() {
    initGame()
});

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
  if (isSpectating) return;

	menuBackground = new createjs.Bitmap("graphics/ingame_menu/new_ingame_bg2.png");
	menuBackground.x = unit.x + 43;
	menuBackground.y = unit.y - 150;
	menuBackground.scaleX = 0.7;
    menuBackground.scaleY = 0.7;

    // console.log(unit.unit_id);
    // console.log(unit.outOfMoves);

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
			performAttack(unit);
		}
	});


	skillSource = unit.skillCoolDown === 0 && unit.outOfMoves === 0 ? "graphics/ingame_menu/new_skill.png"
								   : "graphics/ingame_menu/new_skill_gray.png";
	skillButton = createClickableImage(skillSource, unit.x + 48, unit.y - 91, function() {
		if (unit.skillCoolDown === 0) {
			undoHighlights();
			isCasting = true;
			cast(unit.skill, unit);
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



function cast(skillName, unit) {
    // console.log(skillName);
	switch (skillName) {
		case "Battle Cry": // King's skill
            serverValidate("skill", unit, []);
            isCasting = false;
            undoMove.pop();
			break;
		case "Double Shoot": // Archer's skill
			archerSkillDone = false;
			var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, true);
			isCasting = true;
			undoHighlights();
			remainingTargets = 2;
            archerTargets = [];
            highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click"], [markArcherTargets]);
			// performAttack(unit);
	    	// unit.skillCoolDown = 3;
			break;
	    case "Shield": // Warrior's skill
	    	undoHighlights();
            serverValidate("skill", unit, []);
            // applyBuff(4, selectedCharacter);
	    	selectedCharacter.outOfMoves = 1;
	    	unit.skillCoolDown = 3;
	    	isCasting = false;
			changed = true;
			undoMove.pop();
	    	break;
	    case "Magic Damage": // Wizard's skill
	    	isCasting = true;
	    	isAttacking = false;
	    	// drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 2);
	    	var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, true);
	    	highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click", "mouseover", "mouseout"], [function(event) {
                serverValidate("skill", selectedCharacter, [event.target.row, event.target.column]);
            }, highlightSpellCross, clearSpellCross]);
			break;
        case "Icy Wind":
            isCasting = true;
            isAttacking = false;
            var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, true);
            highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click", "mouseover", "mouseout"], [function(event) {
                serverValidate("skill", selectedCharacter, [event.target.row, event.target.column]);
            }, highlightSpellCross, clearSpellCross]);
            break;

	}
	destroyMenu();
	destroyStats();
}



function highlightSpellCross(event) {
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

function clearSpellCross(event) {
	$.each(sub_highlighted, function(i, tile) {
		upper.removeChild(tile);
	});
	sub_highlighted = [];
	changed = true;
}

// Start moving a given unit
function move(unit) {
    movingUnit = unit;
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
	chars.removeChild(unit.damageBackground);
	chars.removeChild(unit.damageText);
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



function attack(attacker, target, dmg, isCritical) {
	// if (attacker.team != target.team) {
		var sprite = new createjs.Sprite(attacker.spritesheet, "attack");
		sprite.x = attacker.x;
		sprite.y = attacker.y;
		if (attacker.x > target.x) {
 			sprite.scaleX = 0.7;
		} else {
			sprite.scaleX = -0.7;
		}
		sprite.scaleY = 0.7;
		chars.removeChild(attacker);	
		chars.addChild(sprite);
		orderUnits();
			
		showDamage(target, isCritical == 1 ? 2 : 1, dmg);
		target.hp -= dmg;
        // console.log("new hp: " + target.hp);
		updateHP_bar(target);
		
		var damageAnimation = new createjs.Sprite(attacker.damageEffect, "damage");
		damageAnimation.x = target.x;
		damageAnimation.y = target.y;
		chars.addChild(damageAnimation);

		isAttacking = false;


		setTimeout(function() {
			chars.removeChild(sprite);
			chars.addChild(attacker);
			chars.removeChild(damageAnimation);
			orderUnits();
		}, 1000);

		changed = true;

}

function clearSelectionEffects() {
	destroyMenu();
    undoHighlights();
    destroyStats();
    isAttacking = false;
    isCasting = false;
    // for (var i = 0; i < units.length; i++) {
    //     removeBuff(7, units[i]);
    // }
}

function destroyStats() {
	statsDisplay.removeAllChildren();
	stage.removeChild(statsDisplay);
	// statsDisplay.removeChild(2, 3);

	// var drag_box = new createjs.Bitmap("graphics/stats_background.png");
	// drag_box.scaleX = 0.8;
	// drag_box.scaleY = 0.8;
	// statsDisplay.addChild(drag_box);
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
function moveUnit() {
  var playerX = movingUnit.moveAnimation.x,
      playerY = movingUnit.moveAnimation.y,
      destX = path[0][0],
      destY = path[0][1];

  var coefficientX = 0;
  var coefficientY = 0;


  if (playerX < destX && playerY < destY) {
  	movingUnit.moveAnimation.scaleX = -0.7;
    coefficientX = 1.0;
    coefficientY = 1.0;
  } else if (playerX > destX && playerY > destY) {
  	movingUnit.moveAnimation.scaleX = 0.7;
    coefficientX = -1.0;
    coefficientY = -1.0;
  } else if (playerX < destX && playerY > destY) {
  	movingUnit.moveAnimation.scaleX = -0.7;
    coefficientX = 1.0;
    coefficientY = -1.0;
  } else if (playerX > destX && playerY < destY) {
  	movingUnit.moveAnimation.scaleX = 0.7;
    coefficientX = -1.0;
    coefficientY = 1.0;
  } 



  var stepX = coefficientX * MOVEMENT_STEP;
  var stepY = coefficientY * MOVEMENT_STEP / 2;


  movingUnit.moveAnimation.x += stepX;
  movingUnit.moveAnimation.y += stepY;
  movingUnit.hp_bar.x += stepX;
  movingUnit.hp_bar.y += stepY;

  if (team == turn) {
    draggable.x = draggable.x - stepX;
    draggable.y = draggable.y - stepY;
  }
  for (var i = 0; i < movingUnit.buffs.length; i++) {
    movingUnit.buffs[i][2].x += stepX;
    movingUnit.buffs[i][2].y += stepY;
  }


  if ((playerX === destX) && (playerY === destY)) {
      path.splice(0,1);
      if (path.length == 0) {
      	movingUnit.x = movingUnit.moveAnimation.x;
      	movingUnit.y = movingUnit.moveAnimation.y;

      	// console.log(chars.getChildIndex(movingUnit.moveAnimation));
      	chars.removeChild(movingUnit.moveAnimation);
      	chars.addChild(movingUnit);

      	orderUnits();
        movingPlayer = false;
        if (undo){
        	movingUnit.canMove = 1;
        	undo = false;
        } else {
            undoMove.pop();
            if (movingUnit.team == team) {
                undoMove.push(movingUnit);
            }
        	movingUnit.canMove = 0;
        }

		if (movingUnit.team === turn && turn === team) showActionMenuNextToPlayer(movingUnit);
      }
  }

  sortIndices(movingUnit);
  //stage.update();
  changed = true;
}


function sortIndices(unit) {
	$.each(units, function(i, value) {
		if (unit.moveAnimation.y > value.y) {
			if (chars.getChildIndex(unit.moveAnimation) < chars.getChildIndex(value)) {
				chars.swapChildren(unit.moveAnimation, value);
			}
			if (chars.getChildIndex(unit.hp_bar) < chars.getChildIndex(value.hp_bar)) {
				chars.swapChildren(unit.hp_bar, value.hp_bar);
			}
			if (chars.getChildIndex(unit.hp_bar) < chars.getChildIndex(value)) {
				chars.swapChildren(unit.hp_bar, value);
			}
		} else if (unit.moveAnimation.y < value.y) {
			if (chars.getChildIndex(unit.moveAnimation) > chars.getChildIndex(value)) {
				chars.swapChildren(unit.moveAnimation, value);
			}
			if (chars.getChildIndex(unit.hp_bar) > chars.getChildIndex(value.hp_bar)) {
				chars.swapChildren(unit.hp_bar, value.hp_bar);
			}
			if (chars.getChildIndex(unit.moveAnimation) > chars.getChildIndex(value.hp_bar)) {
				chars.swapChildren(unit.moveAnimation, value.hp_bar);
			}
		}
	});
}

function orderUnits() {
	units.sort(function(a,b){return a.y - b.y;});

	$.each(units, function(i, value) {
		chars.setChildIndex(value, chars.getNumChildren()-1);
		value.updateCache();
	});


	$.each(units, function(i, value) {
		chars.setChildIndex(value.hp_bar, chars.getNumChildren()-1);
		value.hp_bar.updateCache();
	});

    $.each(units, function(i, value) {
        for (var i = 0; i < value.buffs.length; i++) {
            chars.setChildIndex(value.buffs[i][2], chars.getNumChildren()-1);
            // value.hp_bar.updateCache();
        }
    });
}



function findPath(fromX, fromY, toX, toY, ignoreObstacle) {
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
				if (!ignoreObstacle && blockMaps[nx][ny] != 0) continue;

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

}


// A call back function that highlights all the possible definitions 
// when a character is clicked.
function findReachableTiles(x, y, range, ignoreObstacle, isDragon) {
    if (typeof(ignoreObstacle) == "undefined") ignoreObstacle = false;
    if (typeof(isDragon) == "undefined") isDragon = false;


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
				if ( blockMaps[nx][ny] != 0 && !ignoreObstacle) continue;



				// bounds and obstacle check here
				if ($.inArray(nx * mapWidth + ny, marked) === -1) {
                    if (isDragon) {
                        if (findUnitByCoordinates(nx, ny) == null) {
                            marked.push(nx * mapWidth + ny);
                        }
                    } else {
                        marked.push(nx * mapWidth + ny);
                    }
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


	if (mapDrawn) {
		for (var i = 0; i < maps.length; i++) {
			for (var j = 0; j < maps[i].length; j++) {
				draggable.removeChild(maps[i][j]);
			}
		}
	}

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
	mapDrawn = true;

}

	function mouseOut(evt){
		if (!isDragging) {
			upper.removeChild(highLight_tile);
			stage.removeChild(tile_display);
			stage.removeChild(tile_info_text);
			// stage.update();
		}
	}

	function mouseOver(evt) {
		if (!isDragging) {
			if (upper.removeChild(highLight_tile)){
				stage.removeChild(tile_display);
				stage.removeChild(tile_info_text);
				// stage.update();
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
		// stage.update();
	}

createjs.Ticker.addEventListener("tick", update);
createjs.Ticker.on("tick", function() {

	$.each(units, function(i, value) {
		value.updateCache();
	});
}, this);	

// createjs.Ticker.setFPS(30);
function keyEvent(event) {
    // console.log(team + " " + selectedCharacter.team  + " " + selectedCharacter.unit_id);
    switch(event.keyCode) {
        case 27:  //esc
    if (turn != team || selectedCharacter.team != turn || selectedCharacter.team != team || isSpectating) return;
            if (isDisplayingMenu) {
            	clearSelectionEffects();
            }
            break;
        case 67: 
            // console.log(gameEnd);
            if (gameEnd) {
                window.location.href = '../interface/game_stats?room_id='+room_id;
            } else {
        	   draggable.x = 0;
        	   draggable.y = 0;
            }
        	break; 
        case 77: //m
    if (turn != team || selectedCharacter.team != turn || selectedCharacter.team != team || isSpectating) return;
        	if (isDisplayingMenu) {
        		if (selectedCharacter.canMove) {
					undoHighlights();
					// drawRange(findReachableTiles(unit.column, unit.row, unit.moveRange, true), 0);
					moveCharacter(selectedCharacter);
				}
        	}
        	break;
        case 65: //a
    if (turn != team || selectedCharacter.team != turn || selectedCharacter.team != team || isSpectating) return;
        	if (isDisplayingMenu) {
		        if (selectedCharacter.canAttack) {
					undoHighlights();
					// isAttacking = true;
					// drawRange(findReachableTiles(unit.column, unit.row, unit.attackRange, false), 1);
					performAttack(selectedCharacter);
				}
			}
			break;
		case 82: // keyboard r
			if (gameEnd){
				location.reload();
			}
            break;
		case 83: //s
    if (turn != team || selectedCharacter.team != turn || selectedCharacter.team != team || isSpectating) return;
			if (isDisplayingMenu) {
				if (selectedCharacter.skillCoolDown === 0) {
					undoHighlights();
					isCasting = true;
					cast(selectedCharacter.skill, selectedCharacter);
				}
			}
			break;
		case 32: //space
             if (isSpectating) return;
            // console.log(undoMove.length);
			if(undoMove.length != 0){
				if(!archerSkillDone){
					selectedCharacter.skillCoolDown = 0;
					selectedCharacter.outOfMoves = 0;
				}
				selectedCharacter = undoMove.pop();
				undo = true;
				var fromX = selectedCharacter.row;
				var fromY = selectedCharacter.column;
				var toX = selectedCharacter.prevRow;
				var toY = selectedCharacter.prevColumn;
				// console.log("current row:" + fromX + ", current column:" + fromY);
				// console.log("prev row:" + toX + ", prev column:" + toY);
				findPath(fromX, fromY, toX, toY);
                serverValidate("move", selectedCharacter, [path]);
				// blockMaps[fromX][fromY] = 0;
				// move();
				// blockMaps[toX][toY] = 1;
				// selectedCharacter.row = toX;
				// selectedCharacter.column = toY;
				clearSelectionEffects();
			}
            break;
		case 70:
//			goFullScreen();
			break;
        case 13: //enter
        if (isSpectating) return;
        	if (!gameEnd) {
                serverValidate("turn_change", null, [0]);
	        	clearSelectionEffects();
	        	// turn = 1 - turn;
	        	// turnEndPhase();
	        	// turnStartPhase();
	        }
            break;
    }
}

function goFullScreen(){
    var canvas = document.getElementById("demoCanvas");
    if(canvas.requestFullScreen)
        canvas.requestFullScreen();
    else if(canvas.webkitRequestFullScreen)
        canvas.webkitRequestFullScreen();
    else if(canvas.mozRequestFullScreen)
        canvas.mozRequestFullScreen();
}

function update() {
  if (!HAS_JSON_LOADED) return;
	if (movingPlayer === true) {
		moveUnit();
	}
	if (resized) {	
		drawGame();
		destroyMenuDisplay();
		drawMenuDisplay();
		drawStatsDisplay();
		destroyGoldDisplay();
		drawGoldDisplay();

		drag_box = new createjs.Shape();
		drag_box.graphics.drawRect(-stage.canvas.width * 50,-stage.canvas.height ,stage.canvas.width * 100,stage.canvas.height * 100);
		drag_box.hitArea = new createjs.Shape();
		drag_box.hitArea.graphics.beginFill("#000").drawRect(-stage.canvas.width * 50,-stage.canvas.height ,stage.canvas.width * 100,stage.canvas.height * 100);
		draggable.addChild(drag_box);

		$.each(unitCards, function(i, value) {
			unitCreationMenu.removeChild(value.text);
			if (unitCreationMenu.getChildIndex(value) != -1) unitCreationMenu.removeChild(value);
		});

		$.each(greyUnitCards, function(i, value) {
			if (unitCreationMenu.getChildIndex(value) != -1) unitCreationMenu.removeChild(value);
		});

		unitCards = [];
		drawUnitCreationMenu();
		resized = false;
	}
	if (changed) {
		// stage.update();
		changed = false;
	}
	upper.x = draggable.x;
	upper.y = draggable.y;

	chars.x = draggable.x;
	chars.y = draggable.y;


    drag_box.x = draggable.x;
    drag_box.y = draggable.y; 

	stage.addChild(statsDisplay);
	stage.addChild(unitCreationMenu);

    bg.x = turnTimer.x - 100; //reposition counter bg
}
var tile_type;
var tile_info_address;
// Given the number in the game-map, returns the address of the tile's image
function imageNumber(number) {
	switch (number) {
		case 0 :
			tile_info_address = "graphics/tile_info/tile_grass.png";
			tile_type = "Grass";
			return "graphics/tile/3d_tile/grass2.png";
		case 1 :
			tile_info_address = "graphics/tile_info/tile_mud.png";
			tile_type = "Mud";
			return "graphics/tile/3d_tile/mud2.png";
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
			//return "graphics/tile/3d_tile/stone_path.png";
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
		// case 5 :
		// 	tile_info_address = "graphics/tile_info/tile_water.png";
		// 	tile_type = "Water";
		// 	return "graphics/tile/3d_tile/water_half.png";
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

$(function(){
    var x = 0;
    setInterval(function(){
        x-=0.5;
        $('body').css('background-position', x + 'px 0');
    }, 10);
})


function moveCharacter(unit) {
  	unit.prevRow = unit.row;
 	unit.prevColumn = unit.column;
    var ignoreObstacle = unit.skill == "Icy Wind" ? true : false;
	var reachableTiles = findReachableTiles(unit.row, unit.column, unit.moveRange, ignoreObstacle, ignoreObstacle);
	highlightArea(reachableTiles, "graphics/tile/green_tile.png", ["click"], [function(event) {
		// server request
		var fromX = selectedCharacter.row;
		var fromY = selectedCharacter.column;
		var tile = event.target;
		findPath(fromX, fromY, tile.row, tile.column, ignoreObstacle);

		var index = chars.getChildIndex(unit);
	    chars.removeChild(unit);
	    chars.addChildAt(unit.moveAnimation, index);

		serverValidate("move", selectedCharacter, [path]);
	}]);
}

function handleRemoveBuff(action) {
    removeBuff(action.buff_id, findUnitById(action.unit_id));
}

function handleApplyBuff(action) {
    applyBuff(action.buff_id, findUnitById(action.unit_id));
}

function handleServerReply(data) {
    console.log(data);
    if (data.error_code != 0) {
        // console.log("ERROR");
        return;
    }

    // Fuck all this shit
    var fuckingAttackCounter = 0;
    var fuckingAttackActionList = [];
    for (var i = 0; i < data.actions.length; i++) {
        if (data.actions[i].action_type == "attack_unit") {
            var attacker = findUnitById(data.actions[i].attacker_id);
            if (attacker.skill == "Double Shoot") {
                fuckingAttackCounter++;
                fuckingAttackActionList.push(data.actions[i]);
            }
        }
    }

    if (fuckingAttackCounter == 2) {
        handleAttack2(fuckingAttackActionList);
    }

    for (var i = 0; i < data.actions.length; i++) {

        var action = data.actions[i];
        switch (action.action_type) {
            case "update_unit":
                handleUnitUpdate(action);
                break;
            case "move_unit":
                handleMove(action);
                break;
            case "create_unit":
                handleCreate(action);
                break;
            case "attack_unit":
                if (fuckingAttackCounter == 2) break;
                handleAttack(action);
                break;
            case "remove_buff":
                handleRemoveBuff(action);
                break;
            case "apply_buff":
                handleApplyBuff(action);
                break;
            case "trigger_buff":
                handleBuffEffect(action);
                break;
            case "turn_change":
                changeTurn(action);
                break;
            case "update_gold":
                handleGoldUdpate(action);
                break;
            case "game_end":
                handleGameEnd(action);
                break;
            default:
                return;
        }
    }
}


function serverValidate(type, unit, additionalArgs) {
    if (type === "move") {
        rawPost("ajax/move_unit", {"unit_id" : String(unit.unit_id), "path" : JSON.stringify(path)}, handleServerReply);
    }
    if (type === "create") {
        rawPost("ajax/build_unit", {"name" : additionalArgs[0], "x": additionalArgs[1], "y": additionalArgs[2]}, handleServerReply);
    }
    if (type === "attack") {
    console.log("ATTACKER"+unit.unit_id+", TARGET"+additionalArgs[0].unit_id);
        rawPost("ajax/attack_unit", {"attacker_id" : String(unit.unit_id), "target_id" : String(additionalArgs[0].unit_id)}, handleServerReply);
    }

    if (type === "turn_change") {
        rawPost("ajax/turn_change", {"countdown" : additionalArgs[0]}, handleServerReply);
    }

    if (type === "skill") {
        if (unit.skill === "Battle Cry" || unit.skill === "Shield") { // King and knight spell
            rawPost("ajax/cast_unit", {"caster_id": unit.unit_id}, handleServerReply);
        }

        if (unit.skill === "Magic Damage" || unit.skill === "Icy Wind") { // Wizard or Dragon spell
            rawPost("ajax/cast_unit", {"caster_id": unit.unit_id, "x": additionalArgs[0], "y": additionalArgs[1]}, handleServerReply);
        }

        if (unit.skill === "Double Shoot") { // Arher spell
            rawPost("ajax/cast_unit", {"caster_id": unit.unit_id, "target_id": archerTargets[0], "target_id2":archerTargets[1]}, handleServerReply);
        }


    }
}



function performAttack(attacker) {
	isAttacking = true;
	var reachableTiles = findReachableTiles(attacker.row, attacker.column, attacker.attackRange, true);
	highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click"], [function(event) {
		var tile = event.target;
		$.each(units, function(i, target) {
			if (target.row == tile.row && target.column == tile.column && attacker.team != target.team){
				serverValidate("attack", attacker, [target]);
			}
		});	
	archerSkillDone = true;
	undoMove.pop()
	}]); 
}

function findUnitById(id) {
    for (var i = 0; i < units.length; i++) {
        if (units[i].unit_id == id) {
            return units[i];
        }
    }
    // console.log("Cannot find unit with id: " + id);
    return null;
}

function findUnitByCoordinates(row, column) {
    for (var i = 0; i < units.length; i++) {
        if (units[i].row === row && units[i].column === column) {
            return units[i];
        }
    }
    // console.log("Cannot find unit with coordinates: " + row + " " + column);
    return null;
}

function handleGoldUdpate(action) {

  if (!HAS_JSON_LOADED) return;
    if (action.team == team && !isSpectating || action.team == turn && isSpectating) {
      currentGold = action.gold;     

  		for (var i = 0; i < unitCards.length; i++) {
  			if (unitCards[i].price > currentGold) {
  				greyOutCard(i);
  			} else {
  				colourCard(i);
  			}
  		}

      destroyGoldDisplay();
      drawGoldDisplay();   
    }

    //  var matrix = new createjs.ColorMatrix().adjustSaturation(100);
    // for (var i = 0; i < unitCards.length; i++) {
    //     if (unitCards[i].price > currentGold) {
    //         console.log("Cards " + i + ": not enough gold");
    //         unitCards[i].filters = [new createjs.ColorMatrixFilter(matrix)];
    //     } else {
    //         unitCards[i].filters = [];
    //     }
    //     unitCards[i].cache(unitCards[i].x, unitCards[i].y, unitCards[i].width, unitCards[i].height);
    //     // stage.update();
    //     // stage.addChild(unitCards[i]);
    // }  
    // // myDisplayObject.cache();
}

function changeTurn(action) {

	stage.removeChild(bg);
  stage.removeChild(turnTimerbg);
  stage.removeChild(turnTimer);


    clearSelectionEffects();
    turn = action.new_turn;
    showTurnInfo();
    var effectsToApply = action.effects_to_apply;
    var unitsNewCD = action.units_new_cd;


      if (enableCountDown) {
	    refreshTimer(DEFAULT_COUNTDOWN);
	    startTimer();
   }


    // Refresh the cd of the skills.
    for (var i = 0; i < unitsNewCD.length; i++) {
        var unit = findUnitById(unitsNewCD[i][0]);
        unit.skillCoolDown = unitsNewCD[i][1];
    }


    // Apply buff effects to units.
    for (var i = 0; i < effectsToApply.length; i++) {
        var unit = findUnitById(effectsToApply[i][1]);
        switch (effectsToApply[i][0]) {
            case "burn":
                var damage = unit.max_hp * effectsToApply[i][2];
                chars.removeChild(fire);
                var fire = new createjs.Sprite(value.burnEffect, "burn");
                showDamage(value, 1, damage);
                fire.x = value.x;
                fire.y = value.y;
                chars.addChild(fire);

                unit.hp -= damage;
                updateHP_bar(unit);
                setTimeout(function() {
                    chars.removeChild(fire);
                }, 1000);
                break;
            case "heal":
                break;
        }
    }
}

function handleUnitUpdate(action) {
    var unit = findUnitById(action.unit_id);
    unit.canMove = action.canMove;
    unit.canAttack = action.canAttack;
    unit.skillCoolDown = action.skillCoolDown;
    unit.outOfMoves = action.outOfMoves;
}

function handleOpponent(data) {
    console.log(data);
    if (data.error_code != 0) {
        console.log("ERROR");
        return;
    }

    var fuckingAttackCounter = 0;
    var fuckingAttackActionList = [];
    for (var i = 0; i < data.actions.length; i++) {
        if (data.actions[i].action_type == "attack_unit") {
            var attacker = findUnitById(data.actions[i].attacker_id);
            if (attacker.skill == "Double Shoot") {
                fuckingAttackCounter++;
                fuckingAttackActionList.push(data.actions[i]);
            }
        }
    }

    if (fuckingAttackCounter == 2) {
        handleAttack2(fuckingAttackActionList);
    }
    for (var i = 0; i < data.actions.length; i++) {
        var action = data.actions[i];
        switch (action.action_type) {
            case "update_unit":
                handleUnitUpdate(action);
                break;
            case "move_unit":
                handleMove(action);
                break;
            case "create_unit":
                handleCreate(action);
                break;
            case "attack_unit":
                if (fuckingAttackCounter == 2) break;
                handleAttack(action);
                break;
            case "remove_buff":
                handleRemoveBuff(action);
                break;
            case "apply_buff":
                handleApplyBuff(action);
                break;
            case "trigger_buff":
                handleBuffEffect(action);
                break;
            case "turn_change":
                changeTurn(action);
                break;
            case "update_gold":
                handleGoldUdpate(action);
                break;
            case "game_end":
                handleGameEnd(action);
                break;
        }
    }
}

function changeGold(gold) {
    currentGold = gold;
    destroyGoldDisplay();
    drawGoldDisplay();

    for (var i = 0; i < unitCards.length; i++) {
        if (unitCards[i].price > currentGold) {
            greyOutCard(i);
        } else {
            colourCard(i);
        }
    }
}




function handleGameEnd(action) {
    console.log("handle end game");
    //window.location.href = '../interface/game_stats?room_id='+room_id;
    gameEnd = true;
    var reason = "";
    if (action.reason == "king_death") reason = "By death of king.";
    if (action.reason == "quit_game" && team == action.winner) reason = "Victory by loser rage quitting.";
    if (action.reason == "quit_game" && team != action.winner) reason = "Victory by loser rage quitting.";

    var text = action.winner == 0 ? "Red player victory" : "Blue player victory";
    var color = action.winner == 0 ? "#ff5555" : "#00cdff";
    var endLabelBg = new createjs.Shape();
    endLabelBg.graphics.beginFill("#000000").drawRect(-stage.canvas.width ,stage.canvas.height - stage.canvas.height/2, stage.canvas.width * 2, 130);
    var endLabel = new createjs.Text(text, "30px Arial", color);
    var reasonLabel = new createjs.Text(reason, "15px Arial", color);

    var restartLabel = new createjs.Text("Press \" c \" to continue", "15px Arial", color);
    
    endLabel.x = stage.canvas.width - stage.canvas.width / 2 - 100;
    endLabel.y = stage.canvas.height -  stage.canvas.height / 2 + 20;
    reasonLabel.x = endLabel.x + 20;
    reasonLabel.y = endLabel.y + 45;
    restartLabel.x = endLabel.x + 20;
    restartLabel.y = endLabel.y + 65;
    endLabelBg.alpha = 0.7;

    stage.addChild(endLabelBg);
    stage.addChild(restartLabel);
    stage.addChild(reasonLabel);
    stage.addChild(endLabel);
    stage.mouseChildren = false;

}

function handleMove(action) {
    path = action.path;

    var fromRow = path[0][0];
    var fromCol = path[0][1];
    var toRow = path[path.length - 1][0];
    var toCol = path[path.length - 1][1];

    for (i = 0; i < path.length; i++) {
        path[i] = rcToCoord(path[i][0], path[i][1]);
    }
    console.log("handleMove");
	blockMaps[fromRow][fromCol] = 0;
    var unit = findUnitById(action.unit_id);
    var index = chars.getChildIndex(unit);
    chars.removeChild(unit);
    chars.addChildAt(unit.moveAnimation, index);
	move(unit);
	blockMaps[toRow][toCol] = 1;
    unit.canMove = 0;
	unit.row = toRow;
	unit.column = toCol;
	clearSelectionEffects();
}





function handleAttack(action) {
    console.log("handle attack");
    undoMove.pop();
	var attacker = findUnitById(action.attacker_id);
	var target = findUnitById(action.target_id);
	attack(attacker, target, action.dmg, action.is_critical);
    attacker.canAttack = 0;
    attacker.outOfMoves = 1;
    // Apply buffs to the target
    for (var i = 0; i < action.buffs.length; i++) {
        applyBuff(action.buffs[i], target);
    }
	clearSelectionEffects();
}



function handleAttack2(attacks) {
    undoMove.pop();
    handleAttack(attacks[0]);
    if (findUnitById(attacks[1].target_id) == null) return;
    setTimeout(function() {
        handleAttack(attacks[1]);
    }, 1300);
}

function handleCreate(action) {
  	// console.log("action: " + getFirstProp(action.unit));
    var unit = getFirstProp(action.unit);
	spawnUnit(unit, false);
}

function greyOutCard(index) {
	if (unitCreationMenu.getChildIndex(greyUnitCards[index]) == -1) {
		unitCreationMenu.removeChild(unitCards[index]);
		unitCreationMenu.addChild(greyUnitCards[index]);
		unitCreationMenu.addChild(greyUnitCards[index].text);
	}
}

function colourCard(index) {
	if (unitCreationMenu.getChildIndex(unitCards[index]) == -1) {
		unitCreationMenu.removeChild(greyUnitCards[index]);
		unitCreationMenu.addChild(unitCards[index]);
		unitCreationMenu.addChild(unitCards[index].text);
	}
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

/* S. Helper Functions */
function getFirstProp(obj) {
  for(var key in obj) {
    if(obj.hasOwnProperty(key)) return obj[key];
  }
  return 0;
}






