
$(document).ready(function() {
  room_refresh_periodically();
});

function room_refresh_periodically() {
  room_refresh();
  setTimeout("room_refresh_periodically()", 1000);
}

function room_refresh() {
  $.quickPost("ajax/room_get", {id: room_id}, function(data, status){
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
