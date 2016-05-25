var stage = new createjs.Stage("demoCanvas");
var shouldMove = false;

var that = this;
var team = 1;

var path = [];
var highlighted = [];
var units = [];
var ICON_SCALE_FACTOR = 0.65;
var MOVEMENT_STEP = 6.5

var moveButton;
var attackButton;
var skillButton;
var cancelButton;
var menuBackground;

var statsDisplay = new createjs.Container();

var isDisplayingMenu = false;
var isInHighlight = false;
var changed = false;
var movingPlayer = false;
var isAttacking = false;
var turn = 0;

function resize() {
	stage.canvas.width = window.innerWidth;
	stage.canvas.height = window.innerHeight;
	drawGame();
	drawStatsDisplay();
}

function initGame() {
	stage.enableMouseOver(20);
	$.getJSON('game-map.json', function(data) {
		that.mapData = data['main'];
		mapHeight = parseInt(data.map_dimensions.height);
		mapWidth = parseInt(data.map_dimensions.width);
		// console.log(mapHeight + "blah" + mapWidth);
		
		that.drawMap(that.mapData);

		units = [];

		$.each(data.characters, function(i, value) {
			var unit = new createjs.Bitmap(value.address);
			unit.addEventListener("click", function(event) {
				if (!movingPlayer && !isAttacking) {
					clearSelectionEffects();
					selectedCharacter = unit;
					showActionMenuNextToPlayer(unit);
				}


				// In this case, we are selecting the unit to be attacked
				if (selectedCharacter != unit && isAttacking) {
					// console.log("attacker: " + selectedCharacter.column + " " + selectedCharacter.row);
					$.each(highlighted, function(i, coord) {
						if (unit.row === coord.column && unit.column === coord.row) {
							attack(selectedCharacter, unit);
							clearSelectionEffects();
						}
					});
				}

				displayStats(value);
				changed = true;
			});

			// Configure unit coordinates
			unit.hp = value.hp;
			unit.max_hp = value.max_hp;
			unit.attack = value.attack;
			unit.luck = value.luck;
			unit.row = parseInt(value.y);
			unit.column = parseInt(value.x);
			unit.x = originX +  (value.y - value.x) * 65;
			unit.y = value.y * 32.5 + originY + value.x * 32.5;
			unit.regX = 56.5;
			unit.regY = 130;
			unit.scaleX = 0.7;
			unit.scaleY = 0.7;
			unit.team = value.team;

			// Configure the hp bar of the unit
			hp_bar = new createjs.Shape();
			hp_bar.graphics.beginFill("#ff0000").drawRect(unit.x - 40, unit.y - 120, 80, 10);
			hp_bar.graphics.beginFill("#00ff00").drawRect(unit.x - 40, unit.y - 120, (parseInt(value.hp)/parseInt(value.max_hp)) * 80, 10);
			unit.hp_bar = hp_bar;


			// Configure move and attack range of the unit
			unit.moveRange = parseInt(value.moveRange);
			unit.attackRange = parseInt(value.attackRange);

			// Configure action control informations
			unit.canMove = parseInt(value.canMove);
			unit.canAttack = parseInt(value.canAttack);
			unit.skillCoolDown = parseInt(value.skillCoolDown);
			unit.outOfMoves = parseInt(value.outOfMoves);

			// Adding the unit to the list of units in the game
			units.push(unit);

			// Add the unit and its hp bar to the stage
			stage.addChild(unit);
			stage.addChild(hp_bar);
		});

	});


	var box = new createjs.Bitmap("graphics/stats_background.png");
	box.scaleX = 0.7;
	box.scaleY = 0.5;
	statsDisplay.addChild(box);

	stage.canvas.width = window.innerWidth;
	stage.canvas.height = window.innerHeight;
	
	drawStatsDisplay();
	changed = true;

	window.addEventListener('resize', resize, false);
}
function updateHP_bar(unit){
	stage.update();
	if (unit.hp <= 0){
		stage.removeChild(unit);
		stage.removeChild(unit.hp_bar);
	} else {
		unit.hp_bar.graphics.beginFill("#ff0000").drawRect(unit.x - 40, unit.y - 120, 80, 10);
		unit.hp_bar.graphics.beginFill("#00ff00").drawRect(unit.x - 40, unit.y - 120, (unit.hp / unit.max_hp) * 80, 10);
	}
}
function drawStatsDisplay() {
	statsDisplay.x = stage.canvas.width - 560
	statsDisplay.y = stage.canvas.height - 240;

	stage.addChild(statsDisplay);
}

function displayStats(unit) {
	var bmp = new createjs.Bitmap(unit.address);
	bmp.scaleX = 1.6;
	bmp.scaleY = 1.6;

	bmp.y = 0;
	bmp.x = 15; // 226

	var text = unit.team == team ? new createjs.Text("HP : " + unit.hp + "/" + unit.max_hp + "\n" +
		"ATK : "  + unit.attack + "    " + "RNG : " + unit.attackRange + "\n" +
		"SKILL : " + unit.skill + "  ( CD " + unit.skillCoolDown + " )" + "\n" +
		"MOV. RANGE : " + unit.moveRange + "\n" +
		"LCK : " + unit.luck, "20px '04b_19'", "#000000")
	: new createjs.Text("HP : " + unit.hp + "/" + unit.max_hp + "\n" +
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
			drawRange(findReachableTiles(unit.column, unit.row, unit.moveRange, true), true);
		}
	});

	attackSource = unit.canAttack === 1 && unit.outOfMoves === 0 ? "graphics/ingame_menu/attack.png"
								   : "graphics/ingame_menu/attack_gray.png";
	attackButton = createClickableImage(attackSource, unit.x + 49, unit.y - 111, function() {
		if (unit.canAttack) {
			undoHighlights();
			isAttacking = true;
			drawRange(findReachableTiles(unit.column, unit.row, unit.attackRange, false), false);
		}
	});

	skillSource = unit.skillCoolDown === 0 && unit.outOfMoves === 0 ? "graphics/ingame_menu/skill.png"
								   : "graphics/ingame_menu/skill_gray.png";
	skillButton = createClickableImage(skillSource, unit.x + 48, unit.y - 77, function() {
		if (unit.skillCoolDown === 0) {
			console.log("Casting!");
		}
	});

	cancelSource = "graphics/ingame_menu/cancel.png";
	cancelButton = createClickableImage(cancelSource, unit.x + 45.5, unit.y - 47, function() {
		clearSelectionEffects();
	});

	var min = moveButton;
	min = stage.getChildIndex(attackButton) < stage.getChildIndex(min) ? attackButton : min;
	min = stage.getChildIndex(skillButton) < stage.getChildIndex(min) ? skillButton : min;
	min = stage.getChildIndex(cancelButton) < stage.getChildIndex(min) ? cancelButton : min;

	if (stage.getChildIndex(menuBackground) > stage.getChildIndex(min)) {
		stage.swapChildren(menuBackground, min);
	}

	stage.addChild(menuBackground);
    stage.addChild(moveButton);
    stage.addChild(attackButton);
    stage.addChild(skillButton);
    stage.addChild(cancelButton);
    isDisplayingMenu = true;
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

function drawRange(reachable, isMoving) {

	destroyMenu();

	$.each(reachable, function(i, value) {
		img = isMoving ? "graphics/green_tile.png" : "graphics/red_tile.png";
		bmp = new createjs.Bitmap(img);
		bmp.x = (value[1]-value[0]) * 65 + 540;
		bmp.y = (value[1]+value[0]) * 32.5 + 220;
		bmp.regX = 65;
		bmp.regY = 32.5;
		bmp.column = value[0];
		bmp.row = value[1];
		if (isMoving) {
			bmp.addEventListener("click", function(event) {
			var fromX = selectedCharacter.column;
			var fromY = selectedCharacter.row;
			findPath(fromX, fromY, value[0], value[1]);
			move();
			selectedCharacter.column = value[0];
			selectedCharacter.row = value[1];
			clearSelectionEffects();
			});
		} else {
			
			$.each(units, function(i, unit) {
				if (unit.column == value[0] && unit.row == value[1] &&
						selectedCharacter.team != unit.team){
					bmp.addEventListener("click", function(event) {
						attack(selectedCharacter, unit);
						clearSelectionEffects();
					});

				}
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



function attack(attacker, target){
	// console.log("target hp: " + target.hp);
	// console.log("attack target: " + target.column +","+ target.row);
	target.hp -= attacker.attack;
	// console.log("attack attacker: " + attacker.column +","+ attacker.row);
	// console.log("target hp: " + target.hp);
	updateHP_bar(target);
	attacker.outOfMoves = 1;
	attacker.canAttack = 0;
	isAttacking = false;
	changed = true;
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
	box.scaleX = 0.7;
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
				if (parseInt(that.mapData[nx][ny]) == 2) continue;

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
				if (parseInt(that.mapData[nx][ny]) == 2 && isMoving) continue;

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


var maps = new Array(4);


function drawMap(data) {
	for (var i = 0; i < 4; i++) {
		maps[i] = new Array(4);
	}

	originX = 540;
	originY = 220;
	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			img = imageNumber(parseInt(data[i][j]));
			maps[i][j] = new createjs.Bitmap(img);
			maps[i][j].name = i + "," + j;
			maps[i][j].x = (j-i) * 65 + 540;
			maps[i][j].y = (j+i) * 32.5 + 220;
			maps[i][j].regX = 65;
			maps[i][j].regY = 32.5;
			maps[i][j].addEventListener("mouseover",mouveOver);
			maps[i][j].addEventListener("mouseout", mouseOut);
			maps[i][j].addEventListener("click", function(event) {
				if (isDisplayingMenu && !isInHighlight) destroyMenu();
			});
			stage.addChild(maps[i][j]);
		}
	}
}
var tile;
	function mouseOut(evt){
		stage.removeChild(tile);
		stage.update();
	}
	
	function mouveOver(evt) {
		stage.removeChild(tile);
		var position = evt.target.name.split(",");
		var i = parseInt(position[0]);
		var j = parseInt(position[1]);
		tile = jQuery.extend({},maps[i][j]);
		tile.x = 100;
		tile.y = 100;
		stage.addChild(tile);
		stage.update();
		// console.log(i + "," + j);

	}

createjs.Ticker.addEventListener("tick", update);
createjs.Ticker.setFPS(30);

function update() {
	if (movingPlayer === true) {
		movePlayer();
	}
	if (changed) {
		stage.update();
		changed = false;
	}
}

// Given the number in the game-map, returns the address of the tile's image
function imageNumber(number) {
	switch (number) {
		case 0 :
			return "graphics/ground_texture/mud.png";
		case 1 :
			return "graphics/ground_texture/path.png";
		case 2 :
			return "graphics/ground_texture/water.png";
		default :
			return "error";
	}
}

// store 8 bits numbers in that.mapData :
// 5 bits for tile index
// 1 bit for unit
// 1 bit for other block