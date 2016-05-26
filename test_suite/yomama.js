
// Test suite for path finding
describe("Path Finding", function() {
	beforeEach(function() {

		el = $('<canvas id="demoCanvas" width="5000px" height="5000px"></canvas>');
		$(document.body).append(el);
	});
	it("should find all possbile destinations that a unit can move to", function() {
		initGame();
		var allReachableTiles = findReachableTiles(0, 0, 2, true);
		expect(allReachableTiles.sort()).toEqual([[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [2, 0]]);
	});
});