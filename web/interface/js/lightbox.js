var LB_FS = 300;
/* Lightbox utility methods */

/* Show error message */
function lightbox_error(id, text) {
  $("#lightbox_"+id).find(".lightbox_error_text").html(text);
  $("#lightbox_"+id).find(".lightbox_error").fadeIn(600);
}


$(document).ready(function() {
  /* General function for opening a lightbox */
  $('body').on('click', '.lightbox_open', function() {
    var id = $(this).attr("data-lb");

    // Show the black background surrounding the lightbox
    $("#lightbox_behind").fadeIn(LB_FS);

    //Fade the lightbox in
    $("#lightbox_"+id).fadeIn(LB_FS);
  });


  /* Close lightbox if click surrounding black bg */
  $('body').on('click', '#lightbox_behind', function() {
    closeLightbox();
  });
});

function closeLightbox() {
  $("#lightbox_behind").fadeOut(LB_FS);
  $(".lightbox_error").fadeOut(LB_FS);
  $(".lightbox_container").fadeOut(LB_FS);
}

/* Individual Lightbox Methods */