var room_exists = true;

$(document).ready(function() {
  room_refresh_periodically();
  $('body').on('click', '#btn_leave', function() {
    room_leave();
  });

  $('body').on('click', '#btn_ready', function() {
    room_ready();
  });
});

/* Makes the player ready or unready */
function room_ready() {
  var ready = $("#btn_ready").attr("data-ready");
  quickPost("ajax/room_ready", {room_id: room_id, ready: ready}, function(data, status) {
    if (data.kc_error !== undefined) {
      lightbox_alert("Error", data.kc_error);
      return;
    }
    if (ready == 'notready') {
      ready = 'ready';
      $("#btn_ready").html("Ready");
    } else {
      ready = 'notready';
      $("#btn_ready").html("Cancel Ready");
    }
    $("#btn_ready").attr("data-ready", ready);
  });
}
function room_refresh_periodically() {
  room_refresh();
  setTimeout("room_refresh_periodically()", 1000);
}

var state_html_array = {"owner":"<span class='player_state owner'> Owner </span>",
                        "ready":"<span class='player_state ready'> Ready </span>",
                        "notready": ""};//"<span class='player_state not_ready'> Not Ready </span>"};

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
      players_html += "<tr><td>"+row_number+"</td><td style='position: relative'>"+players[i].player+state_html_array[players[i].state]+"</td><td>"+players[i].colour+"</td></tr>";
    }
    $("#room_players").html(players_html);
  });
}


/* Make the player leave the room */
function room_leave() {
  quickPost("ajax/room_leave", {room_id: room_id}, function(data, status) {
    window.location.href = 'index';
  });
}