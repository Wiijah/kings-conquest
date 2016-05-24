var LB_FS = 300; //lightbox fade speed

/* Lightbox utility methods */

/* Get ID of the currently opened lightbox */
function getLightboxID() {
  var id = "";
  $(".lightbox_container:visible").each(function() {
    id = $(this).attr("id");
  });
  return "#"+id;
}

/* Show error message */
function lightbox_error(text) {
  var id = getLightboxID();
  console.log(id);
  $(id).find(".lightbox_error_text").html(text);
  $(id).find(".lightbox_error").fadeIn(600);
}


$(document).ready(function() {
  /* General function for opening a lightbox */
  $('body').on('click', '.lightbox_open', function() {
    var id = $(this).attr("data-lb");

    lightbox_open(id);
  });

  /* Close lightbox if click surrounding black bg */
  $('body').on('click', '.lightbox_close', function() {
    lightbox_close();
  });
});

/* Open lightbox */
// Show the black background surrounding the lightbox
function lightbox_open(id) {
  $("#lightbox_behind").fadeIn(LB_FS);
  //Fade the lightbox in
  $("#lightbox_"+id).fadeIn(LB_FS);
}
/* Generic lightbox alert */
function lightbox_alert(title, message) {
  $("#lightbox_alert").find(".title").html("<h1>"+title+"</h1>");
  $("#lightbox_alert").find("#lb_alert_txt").html(message);
  lightbox_open("alert");
}

/* Function that fades out all lightbox related objects */
function lightbox_close() {
  if (session_expired) return; //if session expired, force alert box open
  $("#lightbox_behind").fadeOut(LB_FS);
  $(".lightbox_error").fadeOut(LB_FS);
  $(".lightbox_container").fadeOut(LB_FS);
}

/* Individual Lightbox Methods */

$(document).ready(function() {
  /* Create Game */

  $('body').on('click', '#lightbox_btn_create_game', function() {
    console.log("Hello World");
      var room_name = $("#room_name").val();
      var room_pass = $("#room_pass").val();
      if (!isStrLenCorrect(room_name, 3, 20)) {
        lightbox_error("The room name must be between 3 to 20 characters.");
        return;
      }
      if (!isStrLenCorrect(room_name, 0, 20)) {
        lightbox_error("The room password should not be longer than 20 characters.");
        return;
      }
  });
});