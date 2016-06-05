var MENU_ANIM_TIME = 0;
var social_signup = "none";
var social_signup_id = 0;

/* Facebook Login */
$(document).ready(function() {
  /* FB's code */
  $.ajaxSetup({ cache: true });
  $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
    FB.init({
      appId: '190990184598813',
      version: 'v2.5' // or v2.0, v2.1, v2.2, v2.3
    });     
    $('#loginbutton,#feedbutton').removeAttr('disabled');
  });
  /* End FB's code */

  $('body').on('click', '#btn_fb', function() {
    fb_login();
  });

  $('body').on('click', '#btn_fb_reg', function() {
    fb_register();
  });
});

function fb_login() {
  fs_load();
  FB.login(function(response) {
    if (response.status === 'connected') {
      console.log("Access token:" + response.authResponse.accessToken);
      rawPost('ajax/login_fb', {access_token : response.authResponse.accessToken}, function(data) {
        if (data.kc_error !== undefined) {
          lightbox_alert("Error", data.kc_error);
          return;
        }
        window.location.href = '../interface/';
      });
    } else {
      lightbox_alert("Error", "Failed to login with your Facebook account.");
    }
  });
}

function fb_register() {
  fs_load();
  FB.login(function(response) {
    if (response.status === 'connected') {
      console.log("Access token:" + response.authResponse.accessToken);
      rawPost('ajax/register_fb', {access_token : response.authResponse.accessToken}, function(data) {
        if (data.kc_error !== undefined) {
          lightbox_alert("Error", data.kc_error);
          return;
        }
        social_signup = data.social_signup;
        social_signup_id = data.social_signup_id;

        $("#register_social").show();
        $("#reg_passwords").hide();
        fs_unload();
      });
    } else {
      lightbox_alert("Error", "Failed to login with your Facebook account.");
    }
  });
}

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
    if (social_signup == "none" && !isStrLenCorrect(password1, 8, 32)) {
      lightbox_alert("Error", "Your password must be between 8 to 32 characters.");
      return;
    }
    quickPost("ajax/register", {username: username, email: email1, password: password1, social_signup: social_signup, social_signup_id: social_signup_id}, function(data, status) {
      if (data.kc_error !== undefined) {
        lightbox_alert("Error", data.kc_error);
        return;
      }
      window.location.href = '../interface/';
    });
  });

  /* Open up register form if click on register button */
  $('body').on('click', '.goto_register', function() {
    show_menu_container("#register_container");
  });

  /* Open up login form if click on login button */
  $('body').on('click', '.goto_login', function() {
    show_menu_container("#login_container");
  });

  /* Open up home */
  $('body').on('click', '.goto_home', function() {
    show_menu_container("#home_container");
  });
});

function show_menu_container(id) {
  var visible = $(".menu_container:visible");
  visible.slideUp(MENU_ANIM_TIME, function(){
      $(id).fadeIn(MENU_ANIM_TIME);
  });
}