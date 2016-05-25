/* Globally defined constants */
var FADE_SP = 300;
var page_disabled = false;

/* Globally defined variables */
var session_expired = false; // boolean to indicate whether the session has expired

$(document).ready(function() {

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
        error: nothing,
        timeout: 10000
      });
    }
  });
});


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

        disablePage("../login");

        lightbox_alert("Session Expired", "You are not logged in. Please log yourself back in.");
      }
      callback(data, status);
   });
}

/* Function that does nothing, useful for passing callback functions that do nothing. */
function nothing() {}

/* Function that checks if a string's length is between two numbers. */
function isStrLenCorrect(str, min, max) {
  return str.length >= min && str.length <= max;
}