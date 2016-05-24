/* Globally defined js variables */
var FADE_SP = 300;

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

/* Function that does nothing, useful for passing callback functions that do nothing. */
function nothing() {}

/* Function that checks if a string's length is between two numbers. */
function isStrLenCorrect(str, min, max) {
  return str.length >= min && str.length <= max;
}