<?php
/* Create a new room */
require_once 'ajax_common.php';

$room_id = secureStr($_POST['room_id']);

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0) {
  die('{"kc_error":"The room you attempted to join no longer exists."}');
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = {$user->id}");
if ($result->num_rows > 0) {
  die('{"kc_error":"You cannot join a room if you are already in a room."}');
}

$result = $db->query("SELECT * FROM room_participants WHERE room_id = {$room_id}");
if ($result->num_rows >= $room->max_players) {
  die('{"kc_error":"Sorry. You cannot join this room because the room has reached its maximum capacity."}');
}

// join the room
$db->query("INSERT INTO room_participants (user_id, room_id, colour) VALUES
    ('{$user->id}', '{$room_id}', 'blue')");

echo $AJAX_SUCCESS;
?>