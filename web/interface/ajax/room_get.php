<?php
/* Output to the user all messages newer than the ID given */
require_once 'ajax_common.php';
require_once '../includes/lib.php';

$close = 1;

$room_id = secureInt($_POST['id']);

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0 || $room->state == 'deleted' || $room->state == 'ended') {
  die('{"kc_error":"This room no longer exists."}');
}
if ($room->state == 'ingame') {
  die('{"kc_success":"started"}');
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND room_id = '{$room_id}' ORDER BY part_id DESC LIMIT 1");

if (!$part = $result->fetch_object()) kc_error("You are not in this room."); //user not in room
if ($part->event == 'kicked') kc_error("You have been kicked from this room."); //user kicked
if ($part->event == 'left') kc_error("You are no longer in this room."); //user already left earlier

$out = "{";

// output the array of players
$out .= '"players":[';

$result = $db->query("SELECT * FROM room_participants JOIN users ON room_participants.user_id = users.id WHERE room_id = '{$room_id}'  AND event = '' ORDER BY part_id ASC");

$comma = "";
while ($player = $result->fetch_object()) {
  $spec = $player->colour == "spectator" ? 1 : 0;
  
  $out .= $comma.'{"user_id":"'.$player->user_id.'",
                   "player": "'.$player->username.'",
                   "spec": '.$spec.',
                   "userlink":"'.linkUsername($player, true).'",
                   "colour": "'.$player->colour.'",
                   "state": "'.$player->state.'"}';
  $comma = ",";
}

$out .= "]"; //end of array of players

$result = $db->query("SELECT * FROM maps WHERE map_id = '{$room->map_id}'");
$map = $result->fetch_object();

$out .= ', "map_name" : "'.$map->map_name.'", "map_id" : '.$map->map_id.', "map_modified" : '.$map->last_modified.', "default_countdown" : '.$room->default_countdown;

$out .= "}"; //end of whole JSON object
echo $out;
?>