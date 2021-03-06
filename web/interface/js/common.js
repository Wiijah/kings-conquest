/* Globally defined constants */
var FADE_SP = 300;
var LOADING_ANIM = '<img src="images/loading_white.png" class="loading_middle" />';

/* Globally defined variables */
var session_expired = false; // boolean to indicate whether the session has expired
var page_disabled = false;
var logged_out = false;

$(document).ready(function() {

  $('body').on('click', '.js_link', function() {
    var link = $(this).attr("data-href");
    window.location.href = link;
  });

  $('body').on('click', '.logout_btn', function() {
    logged_out = true;
    window.location.href = "logout";
  });


  $('body').on('click', '.form_submit', function() {
    $(this).closest("form").submit();
  });

  $('body').on('click', '.open_profile', function() {
    var username = $(this).attr("data-username");
    if (room_id == 0) {
      window.location.href = "profile?username="+username;
      return;
    }
    window.open("profile?close=1&username="+username);
  });

  /* Turn off autocomplete for input */
  $('input, :input').attr('autocomplete', 'off');
  $('.auto_off').val("");

  /* Custom jQuery Post functions */
  jQuery.extend({
    myPostCallbacks: function(url, data, callback_succ, callback_fail, timeout) {
      return jQuery.ajax({
        type: "POST",
        url: url,
        data: data,
        success: callback_succ,
        error: callback_fail,
        timeout: timeout
      });
    }, myPost: function(url, data, callback, timeout) {
      return jQuery.ajax({
        type: "POST",
        url: url,
        data: data,
        success: callback,
        error: callback,
        timeout: timeout
      });
    }, quickPost: function(url, data, callback) { //default timeout of 10s
      return jQuery.ajax({
        type: "POST",
        url: url,
        data: data,
        success: callback,
        error: handle_ajax_error,
        timeout: 10000
      });
    }, comPost: function(url, data, timeout_cb, callback) { //default timeout of 10s
      return jQuery.ajax({
        type: "POST",
        url: url,
        data: data,
        success: callback,
        error: handleComError,
        timeout: 36000000
      });
    }
  });
});

/* Button that only works if not loading */
function btn_with_load(btn, func) {
  $('body').on('click', btn, function() {
    if ($(btn).find(".loading_middle").length) {
      return;
    }
    func();
  });
}

/* Disable the current page the user is visiting */
function disablePage(url) {
  page_disabled = true;

  //remove closing lightbox features
  $(".lightbox_cross").remove();

  $('body').on('click', '#alert_btn', function() {
    window.location.href = url;
  });
}

/* Utilises the jQuery quickPost implemented above, but also checks if session has expired. */
function quickPost(url, data, callback) {
   return $.quickPost(url, data, function(data, status){
      if (logged_out) return;
      if (data.session_error !== undefined && !session_expired){
        session_expired = true;

        disablePage("../menu");

        lightbox_alert("Session Expired", "You are not logged in. Please log yourself back in.");
      }
      callback(data, status);
   });
}

/* Minimal features of an AJAX post request. */
function rawPost(url, data, callback) {
   return $.quickPost(url, data, function(data, status){
      callback(data, status);
   });
}

/* AJAX with larger timeout. */
function comPost(url, data, timeout_cb, callback) {
   return $.comPost(url, data, timeout_cb, function(data, status){
      callback(data, status);
   });
}

function updateTut() {
  rawPost("../interface/ajax/tutorial", {"tut": tut_num, "tut2": tut_num}, function (data) {
    console.log(data.kc_error);
  });
}

/* Function that does nothing, useful for passing callback functions that do nothing. */
function nothing() {}

function handle_ajax_error(jqXHR, textStatus, errorThrown) {
console.log("ajax er" + JSON.stringify(jqXHR));
console.log("ajax er" + JSON.stringify(textStatus));
console.log("ajax er" + JSON.stringify(errorThrown));
   //lightbox_alert("Server Error", "There was an error connecting to the server. Please try again later.");
}

function handleComError(jqXHR, textStatus, errorThrown) {
  getOpp();
   //lightbox_alert("Server Error", "There was an error connecting to the server. Please try again later.");
}
/* Function that checks if a string's length is between two numbers. */
function isStrLenCorrect(str, min, max) {
  return str.length >= min && str.length <= max;
}

function goto_tutorials() {
  window.location.href = '../interface/tutorials';
}
/* Synchronous AJAX. */
function syncPost(url, data, callback) {
  return $.ajax({
    url: url,
    dataType: 'json',
    async: false,
    data: data,
    success: callback
  });
}