<?php
/* Output to the user all messages newer than the ID given */

require_once 'ajax_common.php';

$room_id = secureInt($_POST['id']);

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0 || $room->state == 'deleted') {
  die('{"kc_error":"This room no longer exists."}');
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND room_id = '{$room_id}' AND event = ''");
if (!$participant = $result->fetch_object()) { //user not in room
  die('{"kc_error":"You are not in this room."}');
}

$out = "{";

// output the array of players
$out .= '"players":[';

$result = $db->query("SELECT * FROM room_participants JOIN users ON room_participants.user_id = users.id WHERE room_id = '{$room_id}'  AND event = '' ORDER BY part_id ASC");

$comma = "";
while ($player = $result->fetch_object()) {
  $out .= $comma.'{"user_id":"'.$player->user_id.'", "player": "'.$player->username.'", "colour": "'.$player->colour.'", "state": "'.$player->state.'"}';
  $comma = ",";
}

$out .= "]"; //end of array of players


$out .= "}"; //end of whole JSON object
echo $out;
?>