var btnFunc;

function displayBox(action) {
	var box = document.getElementById("someBox");
	var button = document.getElementById("actionButton");

	box.style.display = "block";
	btnFunc = action;
	button.addEventListener("click", action);
}

function removeBox() {
	var box = document.getElementById("someBox");
	var button = document.getElementById("actionButton");

	box.style.display = "none";
	button.removeEventListener("click", btnFunc);
}

function addTextToBox(text) {
	var box = document.getElementById("box_body");
	box.innerHTML = text;	
}

function addTitleToBox(text) {
	var box = document.getElementById("box_header");
	box.innerHTML = text;	
}

