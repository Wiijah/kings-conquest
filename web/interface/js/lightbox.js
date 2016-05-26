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

  /* Tell user it's under development */
  $('body').on('click', '.dev', function() {
    in_dev();
  });

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
  lightbox_quick_close(); // prevent more than one lightbox showing
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
  if (page_disabled) return; //if session expired, force alert box open
  $("#lightbox_behind").fadeOut(LB_FS);
  $(".lightbox_error").fadeOut(LB_FS);
  $(".lightbox_container").fadeOut(LB_FS);
}

/* Close all FS loading and old lightboxes */
function lightbox_quick_close() {
  $("#lightbox_behind").hide();
  $(".lightbox_error").hide();
  $(".lightbox_container").hide();
}

function fs_load() {
  $("#fs_load").fadeIn(LB_FS);
}

function in_dev() {
  lightbox_alert("In Development", "This feature is in development. Please check back in a few days.");
}
