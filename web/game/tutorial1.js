var ICON_SCALE_FACTOR = 0.65;
var MOVEMENT_STEP = 6.5

var stage = new createjs.Stage("gameCanvas");

var that = this;
var team = 0;

var isDragging = false;
var offX;
var offY;

var selectedCharacter;
var path = [];
var highlighted = [];
var sub_highlighted = [];
var units = [];
var maps;
var blockMap;
var tile_display;
var highLight_tile;
var tile_info_text;
var endGame = false;

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
var p1currentGold;
var p2currentGold;
var currentGoldDisplay;
var mapDrawn = false;
var resized = false;

var turn = 1;
var playableUnitCount = 0;


var archerSkillDone = false;
var undoMove = [];
var undo = false;

var bgMusic = true;

//Tutorial 1
var currentUnit;
var enemyUnit;

var lock = true;

function showTurnInfo(){
  if (!startTutorial) return;
  stage.removeChild(playerLabel);
  stage.removeChild(playerLabelBg);
  if (turn) {
    var playerLabelBg = new createjs.Shape();
    playerLabelBg.graphics.beginFill("#000000").drawRect(-stage.canvas.width ,stage.canvas.height - stage.canvas.height/2 ,stage.canvas.width * 2,80);
    var playerLabel = new createjs.Text("Your Turn", "30px Arial", "#0000ff");
  } else {
    var playerLabelBg = new createjs.Shape();
    playerLabelBg.graphics.beginFill("#000000").drawRect(-stage.canvas.width ,stage.canvas.height - stage.canvas.height/2 ,stage.canvas.width * 2,80);
    var playerLabel = new createjs.Text("Enemy Turn", "30px Arial", "#ff0000");
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


function turnStartPhase() {

  turnCount ++;

  console.log(turnCount);
  // if (turnCount == 3 && currentUnit.skill_no == 0){
  //   k_instruction4();
  // }
  if (turnCount == 2 && currentUnit.skill_no == 3){
    if(!endCurrentUnitTutorial) kt_instruction4();
  }

  undoMove = [];
 // destroyGoldDisplay();
 //   drawGoldDisplay();
  showTurnInfo();
    playableUnitCount = 0;
    console.log("Starting turn");
    $.each(units, function(i, value) {
      // Increment the number of playable unit for the current player
        if (value.team === turn) {
            playableUnitCount += 1;
            value.canMove = 1;
            value.canAttack = 1;
            value.outOfMoves = 0;
        }

        // Reduce the skill cooldown of each unit (if it hasn't cooled down yet)
        if (value.skillCoolDown != 0) {
            value.skillCoolDown--;
        }

        var buffsToBeRemoved = [];
        // Decrement the buff duration for each unit
        for (var j = 0; j < value.buffs.length; j++) {
            value.buffs[j][2]--;
            if (value.buffs[j][2] === 0) buffsToBeRemoved.push(value.buffs[j][0]);
            if (value.buffs[j][0] === 5) {

                var damage = value.max_hp * 0.02;
                chars.removeChild(fire);
                var fire = new createjs.Sprite(value.burnEffect, "burn");
                showDamage(value, 1, damage);
                fire.x = value.x;
                fire.y = value.y;
                chars.addChild(fire);

                value.hp -= damage;
                updateHP_bar(value);
                setTimeout(function() {
                  chars.removeChild(fire);
                }, 1000);
            }
            if (value.buffs[j][0] === 6) {
                chars.removeChild(ice);
                value.outOfMoves = 1;
                var ice = new createjs.Sprite(value.forzenEffect, "ice");
                ice.x = value.x;
                ice.y = value.y;
                chars.addChild(ice);
                setTimeout(function() {
          chars.removeChild(ice);
        }, 1000);
            }
        }

        // Remove all the buffs with duration 0
        for (var j = 0; j < buffsToBeRemoved.length; j++) {
            removeBuff(buffsToBeRemoved[j], value);
        }

    });
       
    var kingX;
    var kingY;

    $.each(units, function(i, value) {
      if (value.team == turn && value.address == "graphics/spritesheet/stand/ss_king_stand.png") {

        kingX = value.x;
        kingY = value.y;
      }
    });

    if (turn) {
      draggable.x = 975 - currentUnit.x;
      draggable.y = 382.5 - currentUnit.y;
    }



 //    setTimeout(function() {
  //  clearSelectionEffects();
 //     turn = 1 - turn;
 //     turnEndPhase();
 //     turnStartPhase();
  // }, 6000);

  if (!turn && !enemyUnit.outOfMoves){


    setTimeout(function(){
      showActionMenuNextToPlayer(enemyUnit);
    },1000);

    setTimeout(function() {
       var reachableTiles = findReachableTiles(enemyUnit.row, enemyUnit.column, enemyUnit.moveRange, true);
       highlightArea(reachableTiles, "graphics/tile/green_tile.png", ["click"], []);
    }, 2000);
    
    var row = currentUnit.row;
    var column = currentUnit.column - 2;
    var fromX = enemyUnit.row;
    var fromY = enemyUnit.column;

    setTimeout(function(){
      findPath(fromX, fromY, row, column);
      blockMaps[fromX][fromY] = 0;
      move();
      clearSelectionEffects();
      enemyUnit.row = row;
      enemyUnit.column = column;
      blockMaps[row][column] = 1;
    },3000);
    

    // if (enemyUnit.skillCoolDown == 0) {
    //   setTimeout(function() {

    //     clearSelectionEffects();
    //     var heal = new createjs.Sprite(enemyUnit.healEffect, "heal");
    //     heal.x = enemyUnit.x;
    //     heal.y = enemyUnit.y;
    //     chars.addChild(heal);
    //     applyBuff(2, enemyUnit);
    //     enemyUnit.skillCoolDown = 3;
    //     setTimeout(function() {
    //       chars.removeChild(heal);
    //     }, 1000);
    //   },4000);
    // } else {
        var reachableTiles = findReachableTiles(row, column, enemyUnit.attackRange, false);
       setTimeout(function() {
       clearSelectionEffects();

       highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click"], []);
       }, 4000);

      setTimeout(function(){
        $.each(reachableTiles, function(i, tile) {

          if (tile[0] == currentUnit.row && tile[1] == currentUnit.column){
            attack(enemyUnit, currentUnit);
            clearSelectionEffects();
          } 
        });
        clearSelectionEffects();
      },5000);
    //}
    
    

    setTimeout(function(){
      turn = 1 - turn;
      turnEndPhase();
      turnStartPhase();
    },6000);

  }

  if (!turn && enemyUnit.outOfMoves){
    setTimeout(function() {
       clearSelectionEffects();
       endTurn();
       }, 2000);
  }


}

function turnEndPhase() {
    // Post-turn processing
}




function resize() {
  // stage.canvas.width = window.innerWidth;
  //stage.canvas.height = window.innerHeight;
  //drawGame();
  //drawStatsDisplay();
  resized = true;
}

// typeName : king, red_castle, wizard, etc
// initial: true / false
function spawnUnit(data, isCreation, row, column, team){
  chars.removeChild(spawnAnimation);
  //|| data.address == "graphics/spritesheet/stand/ss_scarecrow_stand.png"

   // if (data.address == "graphics/spritesheet/stand/ss_rogue_stand.png") return;

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


    var forzenEffect = new createjs.SpriteSheet({
      "images": [that.buffEffects.frozen],
      "frames": {"width": 142, "height": 142, "count": 4, "regY": 110, "regX": 95},
      "animations": {
        "ice":{
          frames: [0,1,2,3],
          next: false
        }
      },
      framerate: 4
    });
    unit.forzenEffect = forzenEffect;

    if (isCreation) {
        unit.team = team;
        unit.row = row;
        unit.column = column;
    } else {
      unit.team = data.team;
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
      chars.addChild(spawnAnimation);
    

    sortIndices(unit);

    unit.cache(0,0,150,150);
    hp_bar.cache(0,0,100,120);
    spawnAnimation.x = unit.x;
    spawnAnimation.y = unit.y;
    
    setTimeout(function() {
      chars.removeChild(spawnAnimation);
    }, 1000);


    addEventListenersToUnit(unit);

    if (unit.team == 1) {

      currentUnit = unit;
    } else {
      enemyUnit = unit;
    }
  // });    
}

function findFreeSpace(){
  if (turn == 0){
    //red castle postion[0,0]
    var empty = findReachableTiles(1, 0, 10, false);
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

  $.getJSON('tutorial1.json', function(data) {
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


    that.buffEffects = data.buffEffects;
    p1currentGold = data.P1currentGold;
    p2currentGold = data.P2currentGold;
   // drawGoldDisplay();
    that.drawMap(that.mapData);

    //should only spawn 2 kings and castles
    $.each(data.characters, function(i, value) {
      spawnUnit(data.characters[i], false);
    });
        turnStartPhase();
  });

  stage.canvas.width = window.innerWidth;
  stage.canvas.height = window.innerHeight; //$("body").prop("clientHeight");


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


    // setInterval(function(){ 
    //     if (!movingPlayer && !isAttacking && !isCasting && !isInHighlight) {
    //         if (playableUnitCount === 0) {
    //             clearSelectionEffects();
    //             //console.log("turn ended for current player");
    //             turnEndPhase();
    //             turn = 1 - turn;
    //             turnStartPhase();
    //         }
    //     }
    // }, 5000);

  changed = true;

  window.addEventListener('resize', resize, false);

  drawMenuDisplay();
  stage.update();
  draggable.mouseChildren = false;

}
var muteIcon;
var playIcon;
var quitIcon;
function destroyMenuDisplay(){
  stage.removeChild(muteIcon);
  stage.removeChild(playIcon);
  stage.removeChild(quitIcon);
}
function drawMenuDisplay(){
  var audio = new Audio('Test.mp3');
  audio.loop = true;
  audio.play();

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
  quitIcon.x = stage.canvas.width - 270;
  quitIcon.y = 5;
  quitIcon.scaleX = 0.68;
  quitIcon.scaleY = 0.68;

  stage.addChild(quitIcon);
  quitIcon.addEventListener("click", function(event){

    displayWarningBox(function(){
      alert("quit the tutorial, location to game lobby");
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
  stage.update();

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
            var buffIcon = new createjs.Bitmap("graphics/buff/buff_dec_attack.png");
            unit.buffs.push([3, 0.8, 3, buffIcon]);
            break;
    case 4: // shield Buff
      var buffIcon = new createjs.Bitmap("graphics/buff/buff_shield.png");
      unit.buffs.push([4, 0, -1, buffIcon]);
      break;
    case 5: // burn Buff
        var buffIcon = new createjs.Bitmap("graphics/buff/buff_burning.png");
        unit.buffs.push([5, 0.02, 5, buffIcon]);
        break;
   case 6: // forzen Buff
    var buffIcon = new createjs.Bitmap("graphics/buff/buff_frozen.png");
    unit.buffs.push([6, 0, 4, buffIcon]);
    console.log("frozen");
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
    if (unit.address == "graphics/spritesheet/stand/ss_king_stand.png" && unit.team == 0){
       if (!tutorialStart) reSpawn();
    }
   
  } else {
    // unit.hp_bar.graphics.clear();
    // unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 80, 10);
    // unit.hp_bar.graphics.beginFill("#ff0000").drawRect(0, 0, (getHealth(unit) / getMaxHealth(unit)) * 80, 10);
    if (unit.team == 0){
      unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
      unit.hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
      unit.hp_bar.graphics.beginFill("#ff0000").drawRect(1, 1, (getHealth(unit)/getMaxHealth(unit)) * 80, 10);
    } else {
      unit.hp_bar.graphics.beginFill("#000000").drawRect(0, 0, 82, 12);
      unit.hp_bar.graphics.beginFill("#000000").drawRect(1, 1, 80, 10);
      unit.hp_bar.graphics.beginFill("#3399ff").drawRect(1, 1, (getHealth(unit)/getMaxHealth(unit)) * 80, 10);
    }
  }
  unit.hp_bar.updateCache();
}
function reSpawn(){
  spawnUnit(that.classStats.kingClass, true, 2, 1, 0);

  console.log("respawn");
}

function drawBottomInterface()  {
  bottomInterface.x = 0;
  bottomInterface.y = stage.canvas.height - 240;
  // bottomInterface.y = 0;
  draggable.addChild(bottomInterface);
}




function drawUnitCreationMenu() {
  var listOfSources = [];
  listOfSources.push("graphics/card/king_card.png");
  listOfSources.push("graphics/card/knight_card.png");
  listOfSources.push("graphics/card/archer_card.png");
  listOfSources.push("graphics/card/wizard_card.png");
  listOfSources.push("graphics/card/dragon_card.png");
  //listOfSources.push("graphics/card/rogue_card.png");
  //createFloatingCards(listOfSources, ["king","knight","archer","wizard","dragon"]);
  //unitCreationMenu.x = 50;
  //unitCreationMenu.y = window.innerHeight - 130;
  //bottomInterface.addChild(unitCreationMenu);
}

function findAvailableAndNonAvailableSpawnTiles() {
    var availableSpawnTiles = [];
    var nonAvailableSpawnTiles = [];
    for (var i = 0; i < 4; i++) {
        for (var j = 0; j < 4; j++) {
            if (blockMaps[i][j] === 0) {
                availableSpawnTiles.push([i, j]);
            } else {
                nonAvailableSpawnTiles.push([i, j]);
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
    var unit_card_text = new createjs.Text("click", "12px 'Arial'", "#ffffff");
    unitCards[i].y = 0;
    unitCards[i].x = i * (110);
    unitCards[i].scaleX = 0.60;
    unitCards[i].scaleY = 0.60;
    unitCards[i].index = i;
    unitCards[i].unitName = correspondingUnit[i];
    unitCards[i].text = unit_card_text;
    unitCards[i].text.y = unitCards[i].y+80;
    unitCards[i].text.x = unitCards[i].x+33;
    switch(unitCards[i].unitName ){
      case "king":
        unitCards[i].addEventListener("click", function(event) {
                    showKingTutorial();
        });
        break;
      case "knight": 
        unitCards[i].addEventListener("click", function(event) {
                    showKnightTutorial();
        });
        break;
      case "archer": 
        unitCards[i].addEventListener("click", function(event) {
                    showArcherTutorial();
        });
        break;
      case "wizard": 
        unitCards[i].addEventListener("click", function(event) {
                    showWizardTutorial();
        });
        break;
      case "dragon":
        unitCards[i].addEventListener("click", function(event) {
                    showDragonTutorial();
        });
        break;
      // case "rogue": 
      //  unitCards[i].addEventListener("click", function(event) {
      //    if (currentGold >= 100) {
      //      spawnUnit("rogue",false, 5,2,turn);
      //      currentGold -= 100;
      //      currentGoldDisplay.text = ("Gold: " + currentGold);
      //    }
      //    changed = true;
      //  });
      //  break;
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

    unitCreationMenu.addChild(unitCards[i]);
    unitCreationMenu.addChild(unitCards[i].text);

  }
}

//really bad
function createNewUnit(unitType, row, column) {
  if (turn){
    switch (unitType) {
        case "knight":
            if (p2currentGold >= 100) {
                spawnUnit(that.classStats.knightClass, true, row, column);
                p2currentGold -= 100;
                playableUnitCount++;
            }
            break;
        case "wizard":
            if (p2currentGold >= 100) {
                spawnUnit(that.classStats.wizardClass, true, row, column);
                p2currentGold -= 100;
                playableUnitCount++;
            }
            break;
        case "archer":
            if (p2currentGold >= 100) {
                spawnUnit(that.classStats.archerClass, true, row, column);
                p2currentGold -= 100;
                playableUnitCount++;
            }
            break;
        }
  } else {
    switch (unitType) {
        case "knight":
            if (p1currentGold >= 100) {
                spawnUnit(that.classStats.knightClass, true, row, column);
                p1currentGold -= 100;
                playableUnitCount++;
            }
            break;
        case "wizard":
            if (p1currentGold >= 100) {
                spawnUnit(that.classStats.wizardClass, true, row, column);
                p1currentGold -= 100;
                playableUnitCount++;
            }
            break;
        case "archer":
            if (p1currentGold >= 100) {
                spawnUnit(that.classStats.archerClass, true, row, column);
                p1currentGold -= 100;
                playableUnitCount++;
            }
            break;
        }
    }
   // destroyGoldDisplay();
  //  drawGoldDisplay();
}
var num = 0;
function addEventListenersToUnit(unit) {
    unit.addEventListener("click", function(event) {
            if (unit.team == 0 && isDisplayingMenu && !endCurrentUnitTutorial) {
              return;
            }
            if (num == 0 && unit.team == 0) return;
            if (unit.team == 1 && unit.address == "graphics/spritesheet/stand/ss_king_stand.png" && firstClickUnit) {
              firstClickUnit = false;
              chars.removeChild(pointerVertical);
              hideButton();
              stats_instruction();
            }

            if (isInHighlight && !isAttacking && !isCasting){
                return;
            }
            if (!movingPlayer && !isAttacking && !isCasting) {
                clearSelectionEffects();
                selectedCharacter = unit;
                if (unit.team == turn) showActionMenuNextToPlayer(unit);
                displayStats(unit);
            }


            // In this case, we are selecting the unit to be attacked
            if (selectedCharacter != unit && isAttacking && selectedCharacter.team != unit.team) {
                $.each(highlighted, function(i, coord) {
                  if (!attackTutorialDone){
                      removeAllPointer();
                      attack_instruction3();
                    }
                    if (unit.row === coord.row && unit.column === coord.column) {
                        attack(selectedCharacter, unit);
                        clearSelectionEffects();
                        if (remainingAttackTimes > 0) {

                            archerSkillDone = true;

                            remainingAttackTimes - 1;
                            performAttack();
                        } else {
                            selectedCharacter.canAttack = 0;
                            selectedCharacter.outOfMoves = 1;
                            playableUnitCount--;


                            if (archerSkillDone) showButton();
                            removeAllPointer();

                            //console.log(playableUnitCount);
                        }
                    }
                });
            }

            // In this case, we are selecting the unit to be attacked by the wizard spell
            if (selectedCharacter != unit && isCasting && selectedCharacter.team != unit.team && selectedCharacter.skill_no == 5) {
                for (var i = 0; i < highlighted.length; i++) {
                    if (highlighted[i].row === unit.row && highlighted[i].column === unit.column) {
                        break;
                    }
                    if (i == highlighted.length - 1) return;
                }
                $.each(units, function(i, otherUnit) {

                    if (otherUnit.column == unit.column && otherUnit.row == unit.row && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                        applyBuff(5, otherUnit);
                    }
                    if (otherUnit.column == unit.column
                        && (otherUnit.row == unit.row-1 || otherUnit.row == unit.row+1) && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                        applyBuff(5, otherUnit);
                    }
                    if (otherUnit.row == unit.row
                        && (otherUnit.column == unit.column-1 || otherUnit.column == unit.column+1) && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                        applyBuff(5, otherUnit);
                    }
                    clearSelectionEffects();
                    selectedCharacter.outOfMoves = 1;
                    selectedCharacter.skillCoolDown = 3;
                    playableUnitCount--;
                    isCasting = false;

                });
            }


             if (selectedCharacter != unit && isCasting && selectedCharacter.team != unit.team && selectedCharacter.skill_no == 6) {
                for (var i = 0; i < highlighted.length; i++) {
                    if (highlighted[i].row === unit.row && highlighted[i].column === unit.column) {
                        break;
                    }
                    console.log(i);
                    if (i == highlighted.length - 1) return;
                }
                $.each(units, function(i, otherUnit) {

                    if (otherUnit.column == unit.column && otherUnit.row == unit.row && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                        applyBuff(6, otherUnit);
                    }
                    if (otherUnit.column == unit.column
                        && (otherUnit.row == unit.row-1 || otherUnit.row == unit.row+1) && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                        applyBuff(6, otherUnit);
                    }
                    if (otherUnit.row == unit.row
                        && (otherUnit.column == unit.column-1 || otherUnit.column == unit.column+1) && otherUnit.team != selectedCharacter.team) {
                        attack(selectedCharacter, otherUnit);
                        applyBuff(6, otherUnit);
                    }
                    clearSelectionEffects();
                    selectedCharacter.outOfMoves = 1;
                    selectedCharacter.skillCoolDown = 3;
                    playableUnitCount--;
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
  if (turn){
    currentGoldDisplay = new createjs.Text("Gold: " + p2currentGold, "20px '04b_19'", "#ffffff");
  } else {
    currentGoldDisplay = new createjs.Text("Gold: " + p1currentGold, "20px '04b_19'", "#ffffff");
  }
  
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
  var text = unit.team == turn ? new createjs.Text("HP : " + getHealth(unit) + "/" + getMaxHealth(unit) + "\n" +
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
  $.getJSON('tutorial1.json', function(data) {
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
    if(!interfaceIntroDone) return;
    if (unit.canMove) {
      undoHighlights();
      removeAllPointer();
      // drawRange(findReachableTiles(unit.column, unit.row, unit.moveRange, true), 0);
      moveCharacter(unit);
      move_instruction1();
      firstClickMove = false;
    }
  });

  attackSource = unit.canAttack === 1 && unit.outOfMoves === 0 ? "graphics/ingame_menu/new_attack.png"
                   : "graphics/ingame_menu/new_attack_gray.png";
  attackButton = createClickableImage(attackSource, unit.x + 48, unit.y - 119, function() {

    if (!moveTutorialDone) return;
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
    return;

    if (unit.skillCoolDown === 0) {
      undoHighlights();
      isCasting = true;
      cast(unit.skill_no, unit);
    }
  });

  cancelSource = "graphics/ingame_menu/new_cancel.png";
  cancelButton = createClickableImage(cancelSource, unit.x + 48, unit.y - 63, function() {

    return;
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
          var heal = new createjs.Sprite(units[i].healEffect, "heal");
          heal.x = value.x;
          heal.y = value.y;
          chars.addChild(heal);
          updateHP_bar(value);
          //value.buffs.push([0,add,3]);
          //value.buffs.push([1,add,3]);
          //buff dmg
          applyBuff(2, value);
          // value.buffs.push([2,5,3]);
          setTimeout(function() {
            chars.removeChild(heal);
          }, 1000);
        }
      });
      isCasting = false;
            selectedCharacter.outOfMoves = 1;
            unit.skillCoolDown = 3;
            playableUnitCount--;
            changed = true;
            undoMove.pop();
      // notify server

      // display updated json
      break;
    case 1: // Archer's skill
      archerSkillDone = false;
      var reachableTiles = findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false);
      isCasting = true;
      undoHighlights();
      performAttack();
      remainingAttackTimes = 2;
        unit.skillCoolDown = 3;
      break;
      case 3: // Warrior's skill
        undoHighlights();
            applyBuff(4, selectedCharacter);
        selectedCharacter.outOfMoves = 1;
        unit.skillCoolDown = 3;
            playableUnitCount--;
        isCasting = false;
      changed = true;
      undoMove.pop();
        break;
      case 4: // Wizard's skill
        isCasting = true;
        isAttacking = false;
        // drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 2);
        var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, false);
        highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click", "mouseover", "mouseout"], [castWizardSpellOnClick, highlightWizardSpellCross, clearWizardSpellCross]);
        if(!endCurrentUnitTutorial) addPointerToTile(2,2);
      break;
    case 5:
      remainingAttackTimes = 1;
      break;

    case 6: // dragon skill
    console.log("dragon skill");
    isCasting = true;
      isAttacking = false;
      // drawRange(findReachableTiles(selectedCharacter.column, selectedCharacter.row, selectedCharacter.attackRange, false), 2);
      var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, false);
      highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click", "mouseover", "mouseout"], [castDragonSpellOnClick, highlightWizardSpellCross, clearWizardSpellCross]);
       if(!endCurrentUnitTutorial) addPointerToTile(2,2);
    break;
  }
  destroyMenu();
  destroyStats();
}


function castDragonSpellOnClick(event){
  console.log("casting dragon skill");
  var kongda = true;
  $.each(units, function(i, unit) {
    if (unit.column == event.target.column && unit.row == event.target.row && unit.team != selectedCharacter.team) {
      attack(selectedCharacter, unit);
            applyBuff(6, unit);
            kongda = false;
    }
    if (unit.column == event.target.column
      && (unit.row == event.target.row-1 || unit.row == event.target.row + 1) && unit.team != selectedCharacter.team) {
      attack(selectedCharacter, unit);
            applyBuff(6, unit);
            kongda = false;
    }
    if (unit.row == event.target.row
      && (unit.column == event.target.column-1 || unit.column == event.target.column + 1) && unit.team != selectedCharacter.team) {
      attack(selectedCharacter, unit);
            applyBuff(6, unit);
            kongda = false;
    }
  });
  
    if (!kongda) {
      clearSelectionEffects();
      selectedCharacter.outOfMoves = 1;
      playableUnitCount--;
      selectedCharacter.skillCoolDown = 3;
      undoMove.pop();
      isCasting = false;
      changed = true;
      removeAllPointer();
      if(!endCurrentUnitTutorial) d_instruction4();
    }
}
function castWizardSpellOnClick(event) {
  var kongda = true;
  $.each(units, function(i, unit) {
    if (unit.column == event.target.column && unit.row == event.target.row && unit.team != selectedCharacter.team) {
      attack(selectedCharacter, unit);
      applyBuff(5, unit);
      kongda = false;
    }
    if (unit.column == event.target.column
      && (unit.row == event.target.row-1 || unit.row == event.target.row + 1) && unit.team != selectedCharacter.team) {
      attack(selectedCharacter, unit);
      applyBuff(5, unit);
      kongda = false;
    }
    if (unit.row == event.target.row
      && (unit.column == event.target.column-1 || unit.column == event.target.column + 1) && unit.team != selectedCharacter.team) {
      attack(selectedCharacter, unit);
      applyBuff(5, unit);
      kongda = false;
    }
  });

    if (!kongda) {
      clearSelectionEffects();
      selectedCharacter.outOfMoves = 1;
      playableUnitCount--;
      selectedCharacter.skillCoolDown = 3;
      undoMove.pop();
      isCasting = false;
      changed = true;
      removeAllPointer();
      if(!endCurrentUnitTutorial) w_instruction4();
    }
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
    return 2;
    } else {
      return 1; 
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
  //    stage.update(damageText,damageBackground);
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


  // if (critical == 2) {
  //  unit.damageBackground = new createjs.Text(damage, "bold 25px Arial", "#000000");
  //  unit.damageText = new createjs.Text(damage, "bold 20px Arial", "#ffeb00");
  // } else {
  //  unit.damageBackground = new createjs.Text(damage, "bold 25px Arial", "#000000");
  //  unit.damageText = new createjs.Text(damage, "bold 20px Arial", "#ff0000");
  // }


  // unit.damageBackground.x = unit.x - 2;
  // unit.damageBackground.y = unit.y - 55;
  // unit.damageBackground.textBasline = "alphabetic";

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



function attack(attacker, target){
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
    if (isCasting && isAttacking) {
      applyBuff(3, target);
    }
    chars.addChild(damageAnimation);
    
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
  isDisplayingMenu = false;
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
  if (turn) {
    var playerX = selectedCharacter.x;
      playerY = selectedCharacter.y;
  } else {
    var playerX = enemyUnit.x;
    playerY = enemyUnit.y;
    selectedCharacter = enemyUnit;
  }
  
      destX = path[0][0],
      destY = path[0][1];


  var coefficientX = 0;
  var coefficientY = 0;


  if (playerX < destX && playerY < destY) {
    coefficientX = 1.0;
    coefficientY = 1.0;
  } else if (playerX > destX && playerY > destY) {
    coefficientX = -1.0;
    coefficientY = -1.0;
  } else if (playerX < destX && playerY > destY) {
    coefficientX = 1.0;
    coefficientY = -1.0;
  } else if (playerX > destX && playerY < destY) {
    coefficientX = -1.0;
    coefficientY = 1.0;
  } 



  var stepX = coefficientX * MOVEMENT_STEP;
  var stepY = coefficientY * MOVEMENT_STEP / 2;


  selectedCharacter.x += stepX;
  selectedCharacter.y += stepY;
  selectedCharacter.hp_bar.x += stepX;
  selectedCharacter.hp_bar.y += stepY;

  draggable.x = draggable.x - stepX;
  draggable.y = draggable.y - stepY;
  for (var i = 0; i < selectedCharacter.buffs.length; i++) {
    selectedCharacter.buffs[i][3].x += stepX;
    selectedCharacter.buffs[i][3].y += stepY;
  }


  if ((playerX === destX) && (playerY === destY)) {
      path.splice(0,1);
      if (path.length == 0) {

        sortIndices(selectedCharacter);
        movingPlayer = false;
        if (undo){
          selectedCharacter.canMove = 1;
          undo = false;
        } else {
          selectedCharacter.canMove = 0;
        }
       

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
        if (selectedCharacter.skill_no != 6  && blockMaps[nx][ny] != 0) continue;


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
        if (selectedCharacter.skill_no != 6 && blockMaps[nx][ny] != 0 && isMoving) continue;

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
            if (terrain == 5) blockMaps[i][j] = 1;
      // if (terrain == 5) {
      //  img = imageNumber(terrain);
      //  var spriteSheet = new createjs.SpriteSheet({
    //            "images": [img],
    //            "frames": {"regX": 0, "height": 130, "count": 2, "regY": 0, "width": 130 },
    //            "animations": {
    //            "water":[0,1]
    //            },
    //            framerate: 1
   //         });
      //  maps[i][j] = new createjs.Sprite(spriteSheet, "water");
      //  maps[i][j].name = i + "," + j + "," + tile_type + "," + tile_info_address;
      //  maps[i][j].x = (j-i) * 65 + 540;
      //  maps[i][j].y = (j+i) * 32.5 + 220;
      //  maps[i][j].regX = 65;
      //  maps[i][j].regY = 32.5;
      //  maps[i][j].addEventListener("mouseover",mouveOver);
      //  maps[i][j].addEventListener("mouseout", mouseOut);
      //  maps[i][j].addEventListener("click", function(event) {
      //    showUnitInfo = false;
      //    clearSelectionEffects();
      //  });
      //} else {
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
          if (isCasting && !endCurrentUnitTutorial){
              return;
          } else if(isDisplayingMenu && !endCurrentUnitTutorial) {
              return;
          } else {
             if (endCurrentUnitTutorial) clearSelectionEffects();
          }

        });
      //}
      draggable.addChild(maps[i][j]);
    }
  }
  mapDrawn = true;

}

  function mouseOut(evt){
    if (!isDragging) {
      upper.removeChild(highLight_tile);
      //stage.removeChild(tile_display);
      //stage.removeChild(tile_info_text);
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
      
      // tile_info_text = new createjs.Text(tile_info, "20px Arial", "#ffffff");
      // tile_info_text.x = 90;
      // tile_info_text.y = 100;
      // tile_info_text.textBaseline = "alphabetic";
      // tile_info_text.textAlign = "center";
      // stage.addChild(tile_display);
      // stage.addChild(tile_info_text);


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
        case 27:  //esc
            if (isDisplayingMenu) {
              clearSelectionEffects();
            }
            break;
        case 77: //m

          if (isDisplayingMenu) {
            if(!interfaceIntroDone) return;
            if (selectedCharacter.canMove) {
              undoHighlights();
              removeAllPointer();
              // drawRange(findReachableTiles(unit.column, unit.row, unit.moveRange, true), 0);
              moveCharacter(selectedCharacter);
              move_instruction1();
              firstClickMove = false;
            }
          }
          break;
        case 65: //a
          if (!moveTutorialDone) return;
          if (isDisplayingMenu) {
            if (selectedCharacter.canAttack) {
          undoHighlights();
          // isAttacking = true;
          // drawRange(findReachableTiles(unit.column, unit.row, unit.attackRange, false), 1);
          remainingAttackTimes = 1;
          performAttack();
        }
      }
      break;
    case 83: //s
      return;
      if (isDisplayingMenu) {
        removeAllPointer();
        if (currentUnit.address == "graphics/spritesheet/stand/ss_king_stand.png" && firstClickSkill) {
          k_instruction3();
          firstClickSkill = false;
          chars.removeChild(pointerHorizontal);
        }
        if (currentUnit.address == "graphics/spritesheet/stand/ss_knight_stand.png" && firstClickSkill) {
          kt_instruction3();
          firstClickSkill = false;
          chars.removeChild(pointerHorizontal);
        }
        if (currentUnit.address == "graphics/spritesheet/stand/ss_archer_stand.png" && firstClickSkill) {
          a_instruction3();
          firstClickSkill = false;
          chars.removeChild(pointerHorizontal);
        }
        if (currentUnit.address == "graphics/spritesheet/stand/ss_wizard_stand.png" && firstClickSkill) {
          w_instruction3();
          firstClickSkill = false;
          chars.removeChild(pointerHorizontal);
        }
        if (currentUnit.address == "graphics/spritesheet/stand/ss_dragon_stand.png" && firstClickSkill) {
          d_instruction3();
          firstClickSkill = false;
          chars.removeChild(pointerHorizontal);
        }
        if (selectedCharacter.skillCoolDown === 0) {
          undoHighlights();
          isCasting = true;
          cast(selectedCharacter.skill_no, selectedCharacter);
        }
      }
      break;
    case 32: //space
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
        console.log("current row:" + fromX + ", current column:" + fromY);
        console.log("prev row:" + toX + ", prev column:" + toY);
        findPath(fromX, fromY, toX, toY);
        blockMaps[fromX][fromY] = 0;
        move();
        blockMaps[toX][toY] = 1;
        selectedCharacter.row = toX;
        selectedCharacter.column = toY;
        clearSelectionEffects();
      }
    case 70:
//      goFullScreen();
      break;
    }
}
function endTurn(){
  clearSelectionEffects();
  turn = 1 - turn;
  turnEndPhase();
  turnStartPhase();
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
  // if(!turn){
  //   clearSelectionEffects();
  //   turn = 1 - turn;
  //   turnEndPhase();
  //   turnStartPhase();
  // }
  if (movingPlayer === true) {
    movePlayer();
  }
  if (resized) {  
    stage.canvas.width = window.innerWidth;
    stage.canvas.height = window.innerHeight;
    drawGame();
    destroyMenuDisplay();
    drawMenuDisplay();
    drawStatsDisplay();
   // destroyGoldDisplay();
   // drawGoldDisplay();

    drag_box = new createjs.Shape();
    drag_box.graphics.drawRect(-stage.canvas.width * 50,-stage.canvas.height ,stage.canvas.width * 100,stage.canvas.height * 100);
    drag_box.hitArea = new createjs.Shape();
    drag_box.hitArea.graphics.beginFill("#000").drawRect(-stage.canvas.width * 50,-stage.canvas.height ,stage.canvas.width * 100,stage.canvas.height * 100);
    draggable.addChild(drag_box);

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


    drag_box.x = draggable.x;
    drag_box.y = draggable.y; 

  stage.addChild(statsDisplay);
  stage.setChildIndex( statsDisplay, 2);
  //stage.addChild(unitCreationMenu);
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
    // case 5 :
    //  tile_info_address = "graphics/tile_info/tile_water.png";
    //  tile_type = "Water";
    //  return "graphics/tile/3d_tile/ss_water.png";
    case 5 :
      tile_info_address = "graphics/tile_info/tile_water.png";
      tile_type = "Water";
      return "graphics/tile/3d_tile/water_half.png";
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
  var reachableTiles = findReachableTiles(unit.row, unit.column, unit.moveRange, true);
  highlightArea(reachableTiles, "graphics/tile/green_tile.png", ["click"], [function(event) {

    var fromX = selectedCharacter.row;
    var fromY = selectedCharacter.column;
    var tile = event.target;
    findPath(fromX, fromY, tile.row, tile.column);
    if (moveTutorialDone || tile.row != 2 || tile.column != 2){
      return;
    }
    if (!moveTutorialDone) {
      removeAllPointer();
      move_instruction2();
    }
    blockMaps[fromX][fromY] = 0;
    move();
    blockMaps[tile.row][tile.column] = 1;
    selectedCharacter.row = tile.row;
    selectedCharacter.column = tile.column;
    clearSelectionEffects();
    undoMove.pop();
    undoMove.push(selectedCharacter);
  }]);
}

function performAttack() {
  num = 1;
  if (!attackTutorialDone){
    removeAllPointer();
    attack_instruction2();
  }
  isAttacking = true;
  var reachableTiles = findReachableTiles(selectedCharacter.row, selectedCharacter.column, selectedCharacter.attackRange, false);
  highlightArea(reachableTiles, "graphics/tile/red_tile.png", ["click"], [function(event) {
    var tile = event.target;
    $.each(units, function(i, unit) {
      if (unit.row == tile.row && unit.column == tile.column && selectedCharacter.team != unit.team){
        attack(selectedCharacter, unit);
        selectedCharacter.attack = selectedCharacter.base_attack;
        clearSelectionEffects();
        if (!attackTutorialDone){
          removeAllPointer();
          attack_instruction3();
        }
        if (remainingAttackTimes > 0) {
          setTimeout(function() {
            performAttack();
          }, 1000);
        } else {

          if (archerSkillDone) showButton();
          selectedCharacter.canAttack = 0;
          selectedCharacter.outOfMoves = 1;
          playableUnitCount--;
          removeAllPointer();
          //console.log(playableUnitCount);
        }


      }
    }); 
  if (currentUnit.address == "graphics/spritesheet/stand/ss_archer_stand.png"){
    archerSkillDone = true;
  }
  undoMove.pop()
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
function enemyMove(){
  showActionMenuNextToPlayer(enemyUnit);
}

function resetTheGame(){
  draggable.removeChild(enemyUnit.hp_bar);
  draggable.removeChild(enemyUnit);
  enemyUnit.hp -= 1000;
  updateHP_bar(enemyUnit);
  draggable.removeChild(currentUnit.hp_bar);
  draggable.removeChild(currentUnit);
  currentUnit.hp -= 1000;
  updateHP_bar(currentUnit);
}

function resetCarmera(){
  draggable.x = 975 - currentUnit.x;
  draggable.y = 382.5 - currentUnit.y;
}


//Tutorial Support Function ===========
var startTutorial = false;
var interfaceIntroDone = false;
var endCurrentUnitTutorial = false;
var firstClickUnit;
var firstClickSkill;
var firstClickMove;
var pv_spritesheet;
var ph_spritesheet;
var pointerVertical;
var pointerHorizontal;
var turnCount = 0;
var kingDone = 0;
var knightDone = 0;
var archerDone = 0;
var wizardDone = 0;
var dragonDone = 0;

function addPointerToPlayerUnit(){
  pv_spritesheet = new createjs.SpriteSheet({
            "images": ["graphics/tutorial/pointerV.png"],
            "frames": {"regX": 0, "height": 142, "count": 2, "regY": -10, "width": 142 },
            "animations": {
              "pointer":[0,1]
            },
            framerate: 2
      });
  pointerVertical = new createjs.Sprite(pv_spritesheet, "pointer");
  pointerVertical.scaleX = 0.7;
  pointerVertical.scaleY = 0.6;
  pointerVertical.x = currentUnit.x - 50;
  pointerVertical.y = currentUnit.y - 180;
  chars.addChild(pointerVertical);
}

function addPointerToEnemyUnit(){
  pv_spritesheet = new createjs.SpriteSheet({
            "images": ["graphics/tutorial/pointerV.png"],
            "frames": {"regX": 0, "height": 142, "count": 2, "regY": -10, "width": 142 },
            "animations": {
              "pointer":[0,1]
            },
            framerate: 2
      });
  pointerVertical = new createjs.Sprite(pv_spritesheet, "pointer");
  pointerVertical.scaleX = 0.7;
  pointerVertical.scaleY = 0.6;
  pointerVertical.x = enemyUnit.x - 50;
  pointerVertical.y = enemyUnit.y - 180;
  chars.addChild(pointerVertical);
}

function addPointerToTile(column, row){
  pv_spritesheet = new createjs.SpriteSheet({
            "images": ["graphics/tutorial/pointerV.png"],
            "frames": {"regX": 0, "height": 142, "count": 2, "regY": -10, "width": 142 },
            "animations": {
              "pointer":[0,1]
            },
            framerate: 2
      });
  pointerVertical = new createjs.Sprite(pv_spritesheet, "pointer");
  pointerVertical.scaleX = 0.7;
  pointerVertical.scaleY = 0.6;
  pointerVertical.x = (column-row) * 65 + 490;
  pointerVertical.y = (row+column) * 32.5 + 140;
  chars.addChild(pointerVertical);
}


function addPointerNearPlayerMove(){
  ph_spritesheet = new createjs.SpriteSheet({
            "images": ["graphics/tutorial/pointerH.png"],
            "frames": {"regX": 0, "height": 142, "count": 2, "regY": -10, "width": 142 },
            "animations": {
              "pointer":[0,1]
            },
            framerate: 2
      });
  pointerHorizontal = new createjs.Sprite(ph_spritesheet, "pointer");
  pointerHorizontal.scaleX = 0.7;
  pointerHorizontal.scaleY = 0.6;
  pointerHorizontal.x = currentUnit.x + 130;
  pointerHorizontal.y = currentUnit.y - 180;
  chars.addChild(pointerHorizontal);
}

function addPointerNearPlayerAttack(){
  ph_spritesheet = new createjs.SpriteSheet({
            "images": ["graphics/tutorial/pointerH.png"],
            "frames": {"regX": 0, "height": 142, "count": 2, "regY": -10, "width": 142 },
            "animations": {
              "pointer":[0,1]
            },
            framerate: 2
      });
  pointerHorizontal = new createjs.Sprite(ph_spritesheet, "pointer");
  pointerHorizontal.scaleX = 0.7;
  pointerHorizontal.scaleY = 0.6;
  pointerHorizontal.x = currentUnit.x + 130;
  pointerHorizontal.y = currentUnit.y - 160;
  chars.addChild(pointerHorizontal);
}

function removeAllPointer(){
  chars.removeChild(pointerVertical);
  chars.removeChild(pointerHorizontal);
}

function resetInsturctions(){
  startTutorial = true;
  draggable.mouseChildren = true;
  showButton();
  removeAllPointer();
  firstClickUnit = true;
  firstClickMove = true;
  firstClickSkill = true;
  iscasting = false;
  isAttacking = false;
  endCurrentUnitTutorial = false;
  removeBox();
}


function showMaskBox(){
  var box1 = document.getElementById("maskBox1");
  var box2 = document.getElementById("maskBox2");
  box1.style.display = "inline-block";
  box2.style.display = "inline-block";
}
function hideMaskBox(){
  var box1 = document.getElementById("maskBox1");
  var box2 = document.getElementById("maskBox2");
  box1.style.display = "none";
  box2.style.display = "none";
}



// Interface Intro ==========================
var tutorialStart = false;
function backgroundInfo(){
  stage.mouseChildren = false;
  draggable.mouseChildren = true;
  turnCount = 0;
  resetInsturctions();
  displayBox(function() {
    unit_instruction();
  });
  addTitleToBox("Introduction");
  addTextToBox("<p>The colour of HP bar indicates the team of units. In this tutorial you will be the blue team.</p>");
  resetTheGame();
  spawnUnit(that.classStats.kingClass, true, 2, 5, 1);
  clearSelectionEffects();
  resetCarmera();
  tutorialStart = true;
}

function unit_instruction(){
  removeBox();
  displayBox(function() {
    removeBox();
  });
  hideButton();
  addPointerToPlayerUnit();
  stage.mouseChildren = true;
  addTitleToBox("Unit");
  addTextToBox("<p> Here is your king, Now let's try click the king to see more information.</p>");
}

function stats_instruction(){
  removeBox();
  displayBox(function() {
    hp_instruction();
  });
  showButton();
  addTextToButton("Next");
  addPointerToPlayerUnit();
  addTitleToBox("Stats Board");
  addTextToBox("<p> Well done. Now you can see the detail information of the current unit on the right buttom cornor. Once you click on your unit you can see all details information of this unit. However if you click the opponent's unit you can only see it's HP.</p>");
  removeAllPointer();
  showMaskBox();
}
function hp_instruction(){
  ph_spritesheet = new createjs.SpriteSheet({
            "images": ["graphics/tutorial/pointerH.png"],
            "frames": {"regX": 0, "height": 142, "count": 2, "regY": -10, "width": 142 },
            "animations": {
              "pointer":[0,1]
            },
            framerate: 2
      });
  pointerHorizontal = new createjs.Sprite(ph_spritesheet, "pointer");
  pointerHorizontal.scaleX = 0.7;
  pointerHorizontal.scaleY = 0.6;
  pointerHorizontal.x = statsDisplay.x + 35;
  pointerHorizontal.y = statsDisplay.y + 50;
  chars.addChild(pointerHorizontal);
  stage.setChildIndex( pointerHorizontal, stage.getNumChildren()-1);
  removeBox();
  displayBox(function() {
    attack_instruction();
  });
  addTextToButton("Next");
  addTitleToBox("Hit Point (HP)");
  addTextToBox("<p> HP indicates the hit points of the unit, the unit will die if its HP is less or equal to 0.</p><p>If you kill the enemy's king (attack him and let his HP reduce to 0, you win the game, and vise versa)</p>");
}
function attack_instruction(){
  pointerHorizontal.y += 15;
  removeBox();
  displayBox(function() {
    //luck_instruction();
    range_instruction();
  });
  addTextToButton("Next");
  addTitleToBox("Attack Damage (ATK)");
  addTextToBox("<p> ATK is the damage you could give to the enemy target when attack.</p> <p>(Some skill might increase or decrease units' base attack damage. Will be explain in detail in Tutorial 2)</p>");
}
function range_instruction(){
  pointerHorizontal.y  += 15;
  removeBox();
  displayBox(function() {
    skill_instruction();
  });
  addTextToButton("Next");
  addTitleToBox("Attack Range (RNG)");
  addTextToBox("<p> RNG indicates the range of current unit can reach when the unit attacks. The range differs between units. </p> <p>(The attack range will be shown as red tiles after you click on attack button)</p>");
}
function skill_instruction(){
  pointerHorizontal.y  += 15;
  removeBox();
  displayBox(function() {
    cd_instruction();
  });
  addTextToButton("Next");
  addTitleToBox("Skill");
  addTextToBox("<p> Each unit has a unique skill. A unit can use its skill if the cool down for the skill is 0. </p><p> (Will be explain in detail in Tutorial 2)</p>");
}
function cd_instruction(){
  pointerHorizontal.y  += 15;
  removeBox();
  displayBox(function() {
    moveRange_instruction();
  });
  addTextToButton("Next");
  addTitleToBox("Cool Down (CD)");
  addTextToBox("<p> CD indicates how many turns left until the unit can use its skill again. CD will reduce by 1 each turn.</p> <p>The CD differs between units. Some skills have longer CD.</p>");
}
function moveRange_instruction(){
  pointerHorizontal.y  += 15;
  removeBox();
  displayBox(function() {
    luck_instruction();
  });
  addTextToButton("Next");
  addTitleToBox("Move Range");
  addTextToBox("<p> Move Range is similar to the Attack Range, it indicates the positions that the unit can move to in one turn. Move range differs between units.</p><p>(The move range will be shown as green tiles after you click on move button)</p>");
}
function luck_instruction(){
  pointerHorizontal.y  += 15;
  removeBox();
  displayBox(function() {
    ingameMenu_instruction();
  });
  addTextToButton("Next");
  addTitleToBox("Luck");
  addTextToBox("<p> Luck is a fixed for each unit, it indicates the chance to get a critical hit when dealing demage to enemy units. (E.g. Luck = 0.2 means 20% chance to critical Hit)</p><p>(Critical Hit deals twice the damage as the normal attack)</p>");
}
function ingameMenu_instruction(){
  removeBox();
  hideMaskBox();
  removeAllPointer();
  displayBox(function() {
    ingameMenu_instruction();
  });
  hideButton();
  addPointerNearPlayerMove();
  addTitleToBox("In Game Menu");
  addTextToBox("<p>This is the in game menu. It will be shown once you click on your units.</p><p>Now let's try to move our king first. Click on the Move in the menu, or press 'M' on your keyboard.</p>");
  interfaceIntroDone = true;
}

// Move Tutorial
var moveTutorialDone = false;
function move_instruction1(){
  removeBox();
  displayBox(function() {
    move_instruction2();
  });
  addTitleToBox("Move");
  addTextToBox("<p>Good! Now you can see the gree tiles are the moving range of your king. Let's try to move your king closer to the enemy! Click on the tile to move.</p>");
  addPointerToTile(2, 2);
}

function move_instruction2(){
  removeBox();
  displayBox(function() {
    attack_instruction1();
    moveTutorialDone = true;
  });
  showButton();
  addTitleToBox("Move");
  addTextToBox("<p> Well Done! And you can see the move button becomes gray now, each unit only can move once each turn. </p><p>(If you are now satified with the current position before you do any attack or using any skill, you can press 'space' on your keyboard to undo the previous move.)</p></p>The enemy king doesn't have much HP left, let's give him a fatal attack.</p>");
}

// Attack Tutorial
var attackTutorialDone = false;
function attack_instruction1(){
  removeBox();
  displayBox(function() {
    removeBox();
  });
  hideButton();
  addPointerNearPlayerAttack();
  addTitleToBox("Attack");
  addTextToBox("<p> Click on the Attack Button or press 'A' on your keyboard to attack.</p>");
}

function attack_instruction2(){
  removeBox();
  displayBox(function() {
    removeBox();
  });
  addPointerToEnemyUnit();
  addTitleToBox("Attack");
  addTextToBox("<p> Nice! You can see the enemy king is in our attack range, try to click on the king to perform attack.</p>");
}

function attack_instruction3(){
  attackTutorialDone = true;
  removeBox();
  displayBox(function() {
    //To Tutorial 2
    window.location.replace("http://localhost/WebAppGroup22/web/game/tutorial2.php");
  });
  showButton();
  addPointerToEnemyUnit();
  addTitleToBox("!!!Congratulations!!!");
  addTextToBox("<p> Well Done! Now you know how the move and attack works in King's Conquest. In the next Chapter, you will learn how to build your own army to fight against the enemy. </p><p>Click 'Next' to Tutorial2</p>");
  stage.mouseChildren = false;
}

// End Tutorial
