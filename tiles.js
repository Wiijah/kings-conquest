var stage = new createjs.Stage("demoCanvas");
var shouldMove = false;

var that = this;
var movingPlayer = false;
var path = [];
var highlighted = [];
var units = [];

var changed = false;

$.getJSON('game-map.json', function(data) {
	that.mapData = data['main'];
	mapHeight = parseInt(data.map_dimensions.height);
	mapWidth = parseInt(data.map_dimensions.width);
	// console.log(mapHeight + "blah" + mapWidth);
	
	that.drawMap(that.mapData);

	units = [];

	$.each(data.characters, function(i, value) {
		player = new createjs.Bitmap(value.address);
		player.addEventListener("click", function(event) {
			selectedCharacter = player;
			drawRange(findReachableTiles(parseInt(value.x), parseInt(value.y), parseInt(value.moveRange), true));
		});
		player.row = parseInt(value.y);
		player.column = parseInt(value.x);
		player.x = originX +  (value.y - value.x) * 65;
		player.y = value.y * 32.5 + originY + value.x * 32.5;
		player.regX = 56.5;
		player.regY = 130;
		player.scaleX = 0.7;
		player.scaleY = 0.7;

		hp_bar = new createjs.Shape();
		hp_bar.graphics.beginFill("#ff0000").drawRect(player.x - 40, player.y - 120, 80, 10);
		hp_bar.graphics.beginFill("#00ff00").drawRect(player.x - 40, player.y - 120, (parseInt(value.hp)/parseInt(value.max_hp)) * 80, 10);

		player.hp_bar = hp_bar;

		units.push(player);

		stage.addChild(player);
		stage.addChild(hp_bar);
	});

	changed = true;
});

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

function drawRange(reachable) {
	$.each(reachable, function(i, value) {
		img = "graphics/green_tile.png";
		bmp = new createjs.Bitmap(img);
		bmp.x = (value[1]-value[0]) * 65 + 540;
		bmp.y = (value[1]+value[0]) * 32.5 + 220;
		bmp.regX = 65;
		bmp.regY = 32.5;
		bmp.addEventListener("click", function(event) {
			var fromX = selectedCharacter.column;
			var fromY = selectedCharacter.row;
			findPath(fromX, fromY, value[0], value[1]);
			move();
			selectedCharacter.column = value[0];
			selectedCharacter.row = value[1];
		});
		stage.addChild(bmp);
	});
	changed = true;
}

// Move the player by a fixed amount
function movePlayer() {
  var playerX = selectedCharacter.x,
      playerY = selectedCharacter.y,
      destX = path[0][0],
      destY = path[0][1];

  if (playerX < destX && playerY < destY) {
    selectedCharacter.x += 6.5;
    selectedCharacter.y += 3.25;

    selectedCharacter.hp_bar.x += 6.5;
    selectedCharacter.hp_bar.y += 3.25;
  } else if (playerX > destX && playerY > destY) {
    selectedCharacter.x -= 6.5;
    selectedCharacter.y -= 3.25;


    selectedCharacter.hp_bar.x -= 6.5;
    selectedCharacter.hp_bar.y -= 3.25;
  } else if (playerX < destX && playerY > destY) {
    selectedCharacter.x += 6.5;
    selectedCharacter.y -= 3.25;


    selectedCharacter.hp_bar.x += 6.5;
    selectedCharacter.hp_bar.y -= 3.25;
  } else if (playerX > destX && playerY < destY){
  	selectedCharacter.x -= 6.5;
  	selectedCharacter.y += 3.25;


    selectedCharacter.hp_bar.x -= 6.5;
    selectedCharacter.hp_bar.y += 3.25;
  }

  if ((playerX === destX) && (playerY === destY)) {
      path.splice(0,1);
      if (path.length == 0) {

      	sortIndices(selectedCharacter);

        movingPlayer = false;
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

function drawMap(data) {
	originX = 540;
	originY = 220;
	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			img = imageNumber(parseInt(data[i][j]));
			bmp = new createjs.Bitmap(img);
			bmp.x = (j-i) * 65 + 540;
			bmp.y = (j+i) * 32.5 + 220;
			bmp.regX = 65;
			bmp.regY = 32.5;
			stage.addChild(bmp);
		}
	}
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