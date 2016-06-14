<?php
/* Ready or start a new game from a room. */
require_once 'ajax_common.php';
require_once '../../game/includes/game_lib.php';

$room_id = secureInt($_POST['room_id']);
$map_id = secureInt($_POST['map_id']);

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0) {
  kc_error("This room is already deleted.");
}

if ($room->state != 'pregame') {
  kc_error("This room is not in the pregame state.");
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND room_id = '{$room_id}' AND event = ''");
if (!$part = $result->fetch_object()) {
  kc_error("You are not in this room.");
}

$result = $db->query("SELECT * FROM maps WHERE map_id = '{$map_id}'");
if (!$map = $result->fetch_object()) {
  kc_error("You have selected an invalid map.");
}
$db->query("UPDATE rooms SET map_id = '{$map_id}', map_json = '{$map->points}' WHERE room_id = '{$room_id}'");


$db->query("UPDATE room_participants SET state = 'notready' WHERE room_id = '{$room_id}' AND state = 'ready'");

echo $AJAX_SUCCESS;
?>