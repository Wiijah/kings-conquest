var room_pw = "";
var room_pass_id = 0;

$(document).ready(function() {
  /* Initiate creating room */

  $("#goto_friends").click(function() {
    window.location.href = 'friends';
  });
  
  $('body').on('click', '#lightbox_btn_create_game', function() {
      create_room();
  });

  /* Attempt to join room (before entering pass - if any that is) */
  $('body').on('click', '.join_room', function() {
    var room_id = $(this).attr("data-room-id");
    var spectate = $(this).attr("data-spectate");
    room_pw = "";
    var pass_required = $(this).attr("data-password") == 1;
    if (pass_required) {
      room_pass_id = room_id;
      lightbox_open("enter_room");
      return;
    }
    join_room(room_id, spectate);
  });

  /* Join room after clicking password form button */
  $('body').on('click', '#lightbox_btn_enter_room', function() {
    room_pw = $("#join_pass").val();
    join_room(room_pass_id);
  });

  lobby_refresh_periodically();
});

function lobby_refresh_periodically() {
  lobby_refresh();
  setTimeout("lobby_refresh_periodically()", 1000);
}

function lobby_refresh() {
  $.quickPost("ajax/lobby_get", {id: room_id}, function(data, status){

    if (data.kc_error !== undefined && data.kc_error == "room") {
      window.location.href = 'room';
      return;
    }
    var rooms = data.rooms;
    var rooms_html = '<tr><th>Room Name</th><th>Room Owner</th><th>Number of Players</th><th>Password?</th><th>Join</th><th>Spectate</th></tr>';
    for (var i = 0; i < rooms.length; i++) {
      var user_link = rooms[i].userlink;
      var pass_yn = rooms[i].password == 1 ? "Yes" : "No";
      rooms_html += "<tr><td>"+rooms[i].room_name+"</td><td>"+user_link+"</td><td>"+rooms[i].num_of_players+"/"+rooms[i].max_players+"</td><td>"+pass_yn+"</td><td><div class='btn join_room' data-room-id='"+rooms[i].room_id+"' data-password='"+rooms[i].password+"' data-spectate='0'>Join</div></td><td><div class='btn join_room' data-room-id='"+rooms[i].room_id+"' data-password='"+rooms[i].password+"' data-spectate='1'>Spectate</div></td></tr>";
    }
    $("#rooms").html(rooms_html);
  });
}


/* Join a room */
function join_room(room_id, spectate) {
  fs_load();
  quickPost("ajax/room_join", {"room_id": room_id, "room_pass": room_pw, "spectate": spectate}, function(data, status){
    if (session_expired) return;
    
    // server side error checking
    if (data.kc_error !== undefined) {
      lightbox_alert("Error", data.kc_error);
      return;
    }

    // success, so redirect to room page
    window.location.href = 'room';
  });
}


/* Create room on submitting create game lightbox form */
function create_room() {
  var room_name = $("#room_name").val();
  var room_pass = $("#room_pass").val();

  /* Client slide input check */
  if (!isStrLenCorrect(room_name, 3, 20)) {
    lightbox_error("The room name must be between 3 to 20 characters.");
    return;
  }
  if (!isStrLenCorrect(room_name, 0, 20)) {
    lightbox_error("The room password should not be longer than 20 characters.");
    return;
  }
  quickPost("ajax/room_create", {room_name: room_name, room_pass: room_pass}, function(data, status){
    if (session_expired) return;

    // server side error checking
    if (data.kc_error !== undefined) {
      lightbox_error(data.kc_error);
      return;
    }

    // success, so redirect to room page
    window.location.href = 'room';
  });
}