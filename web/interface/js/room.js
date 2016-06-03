var room_exists = true;

var ready_locked = true; //TODO

$(document).ready(function() {
  room_refresh_periodically();
  $('body').on('click', '#btn_leave', function() {
    room_leave();
  });
  btn_with_load("#btn_ready", room_ready);

  $('body').on('click', '#btn_start', function() {
    room_start();
  });
});

function room_start() {
  fs_load();
  quickPost("ajax/room_ready", {room_id: room_id, ready: 'ready'}, function(data, status) {
    if (data.kc_error !== undefined) {
      lightbox_alert("Error", data.kc_error);
      return;
    }
    window.location.href = '../game/';
  });
}

/* Makes the player ready or unready */
function room_ready() {
  var ready = $("#btn_ready").attr("data-ready");
  $("#btn_ready").html(LOADING_ANIM);

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
      room_exists = false;
      disablePage("index");
      lightbox_alert("Room Deleted", data.kc_error);
      return;
    }
    if (data.kc_success !== undefined && data.kc_success == "started") {
      window.location.href = '../game/';
    }
    var players = data.players;
    console.log(data);
    var players_html = '<tr><th>#</th><th>Player</th><th>Colour</th></tr>';

    for (var i = 0; i < players.length; i++) {
      var row_number = i + 1;
      var user_link = "<a href='profile.php?username="+players[i].player+"' target='_blank'>"+players[i].player+"</a>";

      players_html += "<tr><td>"+row_number+"</td><td style='position: relative'>"+user_link+state_html_array[players[i].state]+"</td><td>"+players[i].colour+"</td></tr>";
      if (players[i].user_id == user_id) {
        if (players[i].state == 'ready') {
          $("#btn_ready").html("Cancel Ready");
          $("#btn_ready").attr("data-ready", 'notready');
        } else if (players[i].state == 'notready') {
          $("#btn_ready").html("Ready");
          $("#btn_ready").attr("data-ready", 'ready');
        }
      }
    }
    $("#room_players").html(players_html);
    $("#info_num_players").html(players.length+"/"+max_players);
  });
}


/* Make the player leave the room */
function room_leave() {
  fs_load();
  quickPost("ajax/room_leave", {room_id: room_id}, function(data, status) {
    window.location.href = 'index';
  });
}