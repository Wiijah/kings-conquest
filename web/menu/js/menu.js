$(document).ready(function() {
  $('body').on('click', '#btn_login', function() {
    fs_load();
    var username = $('#username').val();
    var password = $('#password').val();

    quickPost("ajax/login", {username: username, password: password}, function(data, status) {
      if (data.kc_error !== undefined) {
        lightbox_alert("Error", data.kc_error);
        return;
      }
      window.location.href = '../interface/';
    });
  });
});