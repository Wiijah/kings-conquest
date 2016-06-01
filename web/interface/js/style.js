$(function(){
  var x = 0;
  setInterval(function(){
    x -= 3;
    $('body').css('background-position', x + 'px 0');
  }, 130);
});