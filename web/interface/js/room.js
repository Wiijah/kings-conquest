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

  $('#select_map').change(room_map);
  $('#select_countdown').change(room_limit);

  /* Attempt to join room (before entering pass - if any that is) */
  $('body').on('click', '.kick_player', function() {
    var target_id = $(this).attr("data-user-id");
    room_kick(target_id);
  });
});

function room_map() {
  fs_load();
  var map_id = $("#select_map").val();
  quickPost("ajax/room_map", {room_id: room_id, map_id: map_id}, function(data, status) {
    if (data.kc_error !== undefined) {
      lightbox_alert("Error", data.kc_error);
      return;
    }
    fs_unload();
  });
}

function room_limit() {
  fs_load();
  var room_countdown = $("#select_countdown").val();
  quickPost("ajax/room_countdown", {room_id: room_id, room_countdown: room_countdown}, function(data, status) {
    if (data.kc_error !== undefined) {
      lightbox_alert("Error", data.kc_error);
      return;
    }
    fs_unload();
  });
}

function room_kick(target_id) {
  console.log(target_id);
  fs_load();
  quickPost("ajax/room_kick", {room_id: room_id, target_id: target_id}, function(data, status) {
    if (data.kc_error !== undefined) {
      lightbox_alert("Error", data.kc_error);
      return;
    }
    fs_unload();
  });
}
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
  setTimeout("room_refresh_periodically()", 800);
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
    var extraCols = isOwner ? '<th style="width: 130px">Kick</th>': '';
    var players_html = '<tr><th>#</th><th>Player</th><th>Colour</th>'+extraCols+'</tr>';
    var spectators_html = '<tr><th>#</th><th>Player</th>'+extraCols+'</tr>';

    var num_of_players = 0;
    var num_of_spectators = 0;

    for (var i = 0; i < players.length; i++) {
      var row_number = i + 1;
      var user_link = players[i].userlink;

      var extraData = "";
      if (isOwner) extraData += players[i].user_id != user_id ? "<td><a class='kick_player' data-user-id='"+players[i].user_id+"'>Kick</a></td>": '<td>-</td>';
      
      if (players[i].spec == 0) {
        num_of_players++;
        players_html += "<tr><td>"+num_of_players+"</td><td style='position: relative'>"+user_link+state_html_array[players[i].state]+"</td><td>"+players[i].colour+"</td>"+extraData+"</tr>";
      } else {
        num_of_spectators++;
        spectators_html += "<tr><td>"+num_of_spectators+"</td><td>"+user_link+"</td>"+extraData+"</tr>";
      }
      


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
    $("#room_spectators").html(spectators_html);

    $("#info_num_players").html(num_of_players+"/"+max_players);
    $("#map").html(data.map_name);
    $("#countdown").html(data.default_countdown + " seconds");
  });
}


/* Make the player leave the room */
function room_leave() {
  fs_load();
  quickPost("ajax/room_leave", {room_id: room_id}, function(data, status) {
    window.location.href = 'index';
  });
}