var MENU_SLIDE_SPEED = 750;

$(document).ready(function() {

  /* Login AJAX */
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


  /* Register AJAX */
  $('body').on('click', '#btn_register', function() {
    fs_load();
    var username = $('#reg_user').val();
    var email1 = $('#reg_email1').val();
    var email2 = $('#reg_email2').val();
    var password1 = $('#reg_pass1').val();
    var password2 = $('#reg_pass2').val();

    if (email1 != email2) {
      lightbox_alert("Error", "Emails don't match. Please try again.");
      return;
    }
    if (password1 != password2) {
      lightbox_alert("Error", "Passwords don't match. Please try again.");
      return;
    }
    if (!isStrLenCorrect(username, 3, 16)) {
      lightbox_alert("Error", "Username should be between 3 to 16 characters.");
      return;
    }
    if (!isStrLenCorrect(password1, 3, 32)) {
      lightbox_alert("Error", "Your password must be between 3 to 32 characters.");
      return;
    }
    quickPost("ajax/register", {username: username, email: email1, password: password1}, function(data, status) {
      if (data.kc_error !== undefined) {
        lightbox_alert("Error", data.kc_error);
        return;
      }
      window.location.href = '../interface/';
    });
  });

  /* Open up register form if click on register button */
  $('body').on('click', '.goto_register', function() {
    $(".menu_container:visible").fadeOut(MENU_SLIDE_SPEED, function(){
        $("#register_container").fadeIn(MENU_SLIDE_SPEED);
    });
  });

  /* Open up login form if click on login button */
  $('body').on('click', '.goto_login', function() {
    $(".menu_container:visible").fadeOut(MENU_SLIDE_SPEED, function(){
        $("#login_container").fadeIn(MENU_SLIDE_SPEED);
    });
  });

  /* Open up home */
  $('body').on('click', '.goto_home', function() {
    $(".menu_container:visible").fadeOut(MENU_SLIDE_SPEED, function(){
        $("#home_container").fadeIn(MENU_SLIDE_SPEED);
    });
  });
});