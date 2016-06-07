var btnFunc;

function displayBox(action) {
	var box = $("#someBox");
	var button = $("#actionButton");
	var button2 = $("#actionButton2");
	button2.hide();
    box.show();
	button.click(action);
}


function displayBox2(action, action2) {
	var box = $("#someBox");
	var button = $("#actionButton");
	var button2 = $("#actionButton2");
	button2.show();
    box.show();
	button.click(action);
	button2.click(action2);
} 
function removeBox() {
    $("#someBox").hide();
	$("#actionButton").unbind();
	$("#actionButton2").unbind();
}

function addTextToBox(text) {
	$("#box_body").html(text);	
}

function addTitleToBox(text) {
	$("#box_header").html(text);	
}

function hideButton() {
	$(".btn").hide();
}

function showButton() {
	$("#actionButton").show();
}

function showButton2() {
	$("#actionButton").show();
	$("#actionButton2").show();
}

function addTextToButton(text){
	$("#actionButton").html(text);
}


function addTextToButton2(text){
	$("#actionButton2").html(text);
}

