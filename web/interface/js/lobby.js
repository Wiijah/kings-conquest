$(document).ready(function() {
  /* Initiate creating room */
  $('body').on('click', '#lightbox_btn_create_game', function() {
      create_room();
  });

  $('body').on('click', '.join_room', function() {
    var room_id = $(this).attr("data-room-id");
    join_room(room_id);
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
    var rooms_html = '<tr><th>Room Owner</th><th>Number of Players</th><th>Join</th></tr>';
    for (var i = 0; i < rooms.length; i++) {
      rooms_html += "<tr><td>"+rooms[i].player+"</td><td>"+rooms[i].num_of_players+"/"+rooms[i].max_players+"</td><td><div class='btn join_room' data-room-id='"+rooms[i].room_id+"'>Join</div></td></tr>";
    }
    $("#rooms").html(rooms_html);
  });
}


/* Join a room */
function join_room(room_id) {
  quickPost("ajax/room_join", {room_id: room_id}, function(data, status){
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