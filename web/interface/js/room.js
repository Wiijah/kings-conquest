var room_exists = true;

$(document).ready(function() {
  room_refresh_periodically();
  $('body').on('click', '#btn_leave', function() {
    room_leave();
  });
});

function room_refresh_periodically() {
  room_refresh();
  setTimeout("room_refresh_periodically()", 1000);
}

function room_refresh() {
  quickPost("ajax/room_get", {id: room_id}, function(data, status){
    if (session_expired || !room_exists) return;

    if (data.kc_error !== undefined) {
      if (data.kc_error == "deleted") {
        room_exists = false;
        disablePage("index");
        lightbox_alert("Room Deleted", "This room has been deleted.");
      }
      return;
    }
    var players = data.players;
    console.log(data);
    var players_html = '<tr><th>#</th><th>Player</th><th>Colour</th></tr>';
    for (var i = 0; i < players.length; i++) {
      var row_number = i + 1;
      players_html += "<tr><td>"+row_number+"</td><td>"+players[i].player+"</td><td>"+players[i].colour+"</td></tr>";
    }
    $("#room_players").html(players_html);
  });
}

function room_leave() {
  quickPost("ajax/room_leave", {room_id: room_id}, function(data, status) {
    window.location.href = 'index';
  });
}