var lastID = 0;
var debug;
$(document).ready(function() {
    setTimeout("chatroom_refresh_messages()", 1000);
});

function chatroom_refresh_messages() {
  $.quickPost("ajax/ajax_chatroom", {id: lastID}, function(data, status){
    for (var i = 0; i < data.length; i++) {
        concatToChatroom(data[i]);
    }
    console.log(data + "Last ID: "+lastID);
    if (data.length != 0) lastID = data[data.length - 1].id;
    setTimeout("chatroom_refresh_messages()", 1000);
  });
}

function concatToChatroom(line) {
  $("#play_chatroom_messages").append("<span class='play_chatroom_user'>"+line.username+":</span> <span class='play_chatroom_text'>"+line.message+"</span><br />");
}