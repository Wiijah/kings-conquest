var lastID = 0;
var debug;
var messageBox = $("#play_chatroom_messages");
var chatScrollSpeed = 600;
var chat_colour = '';

$(document).ready(function() {
  chatroom_refresh_messages_periodically();

  $('#play_chatroom_msg').on('keypress', function(event) {
    if (session_expired) return;
    if(event.which === 13 && $(this).val() != ""){
      var message = $(this).val();
      $(this).val("");
      quickPost("ajax/chatroom_send", {message: message, room: room_id}, function(data, status){
        chatroom_refresh_messages();
        console.log("YEA");
      });
    }
  });
});

function chatroom_refresh_messages_periodically() {
  chatroom_refresh_messages();
  setTimeout("chatroom_refresh_messages_periodically()", 1000);
}
function chatroom_refresh_messages() {
  quickPost("ajax/chatroom_get", {id: lastID, room: room_id}, function(data, status){
    if (session_expired) return;

    for (var i = 0; i < data.length; i++) {
        concatToChatroom(data[i]);
    }
      // if new data has arrived, then update lastID and automatically scroll to bottom of chat
    if (data.length != 0) {
      lastID = data[data.length - 1].id;
      $("#play_chatroom_messages").animate({ scrollTop: $("#play_chatroom_messages")[0].scrollHeight }, chatScrollSpeed);
    }
  });
}

function concatToChatroom(line) {
  if (line.chat_type == 'message') { //normal message
    $("#play_chatroom_messages").append("<span class='play_chatroom_user'>"+line.username+":</span> <span class='play_chatroom_text'>"+line.message+"</span><br />");
  } else { // event
    $("#play_chatroom_messages").append("<span class='play_chatroom_user chat_event'>"+line.message+"</span><br />");
  }
}