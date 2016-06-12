<?php
/* Ready or start a new game from a room. */
require_once 'ajax_common.php';
require_once '../../game/includes/game_lib.php';

$room_id = secureInt($_POST['room_id']);
$room_countdown = secureInt($_POST['room_countdown']);

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

if (!in_array($room_countdown, $COUNTDOWNS)) {
  kc_error("You have selected an invalid time limit.");
}

$db->query("UPDATE rooms SET default_countdown = '{$room_countdown}' WHERE room_id = '{$room_id}'");

echo $AJAX_SUCCESS;
?>