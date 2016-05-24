var lastID = 0;
var debug;
var messageBox = $("#play_chatroom_messages");
var chatScrollSpeed = 600;

$(document).ready(function() {
  chatroom_refresh_messages_periodically();

  $('#play_chatroom_msg').on('keypress', function(event) {
    if(event.which === 13 && $(this).val() != ""){
      var message = $(this).val();
      $(this).val("");
      console.log("Message: "+ message);
      $.quickPost("ajax/ajax_chatroom_send", {message: message}, function(data, status){

      });
    }
  });
});

function chatroom_refresh_messages_periodically() {
  chatroom_refresh_messages();
  setTimeout("chatroom_refresh_messages_periodically()", 1000);
}
function chatroom_refresh_messages() {
  $.quickPost("ajax/ajax_chatroom_get", {id: lastID}, function(data, status){
    for (var i = 0; i < data.length; i++) {
        concatToChatroom(data[i]);
    }
    // if new data has arrived, then update lastID and automatically scroll to bottom of chat
    if (data.length != 0) {
      lastID = data[data.length - 1].id;
      $("#play_chatroom_messages").animate({ scrollTop: $("#play_chatroom_messages")[0].scrollHeight }, chatScrollSpeed);
    }
    console.log(data + "Last ID: "+lastID);

  });
}

function concatToChatroom(line) {
  $("#play_chatroom_messages").append("<span class='play_chatroom_user'>"+line.username+":</span> <span class='play_chatroom_text'>"+line.message+"</span><br />");
}