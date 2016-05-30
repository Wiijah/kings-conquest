$("document").ready(function() {

  $('#l_home').click(function(){
      scrollTo(0);
  });
  
  $('#l_about').click(function(){
      scrollTo($("#about").offset().top - 60);
  });
  
  $('#l_learnmore').click(function(){
      scrollTo($("#about").offset().top - 60);
  });
  
  $('#l_contact').click(function(){
      scrollTo($("#contact").offset().top);
  });
  
  $('#l_pricing').click(function(){
      scrollTo($("#pricing").offset().top);
  });
});

function scrollTo(offset) {
    $('html, body').animate({
      scrollTop: offset
    }, 1000);
}