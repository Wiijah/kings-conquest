var stage = new createjs.Stage("demoCanvas");

var that = this;
$.getJSON('game-map.json', function(data) {
	that.mapData = data['main'];
	that.drawMap(that.mapData);

	$.each(data.characters, function(i, value) {
		player = new createjs.Bitmap(value.address);
		player.x = originX +  (value.y - value.x) * 65;
		player.y = value.y * 32.5 + originY + value.x * 32.5;
		player.regX = 56.5;
		player.regY = 130;
		player.scaleX = 0.7;
		player.scaleY = 0.7;
		stage.addChild(player);
	})
});

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
function update() {
	stage.update();
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