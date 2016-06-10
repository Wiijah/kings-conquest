var room_exists = true;

var ready_locked = true; //TODO

$(document).ready(function() {
  $('body').on('click', '.goto_tut', function() {
    var tut = $(this).attr("data-tut");
    rawPost("ajax/tutorial", {"tut": tut}, function (data) {
      if (data.kc_error !== undefined) {
        lightbox_alert("Tutorial Locked", data.kc_error);
      } else {
        window.location.href = '../game/tutorial'+tut;
      }
    });
  });
});