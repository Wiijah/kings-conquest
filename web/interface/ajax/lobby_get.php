<?php
/* Output lobby games */
require_once 'ajax_common.php';
require_once '../includes/lib.php';

/* Check if user is already in a room */
$result = $db->query("SELECT * FROM room_participants WHERE user_id = {$user->id} AND event = ''");
if ($result->num_rows > 0) {
  die('{"kc_error":"room"}');
}


$id = secureInt($_POST['id']);

$out = "{";

// output the array of players
$out .= '"rooms":[';

$result = $db->query("SELECT * FROM users INNER JOIN rooms ON rooms.user_id = users.id WHERE state = 'pregame' ORDER BY rooms.created DESC");

$comma = "";
while ($room = $result->fetch_object()) {
  $result_part = $db->query("SELECT * FROM room_participants WHERE room_id = {$room->room_id} AND event = '' AND colour != 'spectator'");
  $num_of_players = $result_part->num_rows;
  $password = $room->password == "" ? 0 : 1;

  $out .= $comma.'{"room_name": "'.secureOutput($room->name).'",
                   "player": "'.$room->username.'",
                   "userlink":"'.linkUsername($room).'",
                   "room_id": "'.$room->room_id.'",
                   "num_of_players":"'.$num_of_players.'",
                   "max_players": '.$room->max_players.',
                   "password" : '.$password.'}';
  $comma = ",";
}

$out .= "]"; //end of array of players


$out .= "}"; //end of whole JSON object
echo $out;
?>