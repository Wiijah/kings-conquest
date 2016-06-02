/* Globally defined constants */
var FADE_SP = 300;
var LOADING_ANIM = '<img src="images/loading_white.png" class="loading_middle" />';

/* Globally defined variables */
var session_expired = false; // boolean to indicate whether the session has expired
var page_disabled = false;

$(document).ready(function() {
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

/* Function that does nothing, useful for passing callback functions that do nothing. */
function nothing() {}

function handle_ajax_error(jqXHR, textStatus, errorThrown) {
   //lightbox_alert("Server Error", "There was an error connecting to the server. Please try again later.");
}

/* Function that checks if a string's length is between two numbers. */
function isStrLenCorrect(str, min, max) {
  return str.length >= min && str.length <= max;
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