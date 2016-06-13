<?php
/* Create a new room */
require_once 'ajax_common.php';

$room_id = secureInt($_POST['room_id']);
$room_pass = $_POST['room_pass'];

$spectate = secureInt($_POST['spectate']);
$colour = $spectate == 1 ? 'spectator' : 'blue';

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id} AND state = 'pregame'");
$room = $result->fetch_object();
if ($result->num_rows == 0) {
  die('{"kc_error":"The room you attempted to join is no longer available."}');
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = {$user->id} AND event = ''");
if ($result->num_rows > 0) {
  die('{"kc_error":"You cannot join a room if you already joined another room as a player."}');
}

$result = $db->query("SELECT * FROM room_participants WHERE room_id = {$room_id} AND event = '' AND colour != 'spectator'");
if ($result->num_rows >= $room->max_players && $spectate != 1) {
  die('{"kc_error":"Sorry. You cannot join this room because the room has reached its maximum capacity."}');
}

if ($room->password != "" && !passVerify($room_pass, $room->password)) {
  kc_error("You failed to join the room as you have entered an incorrect password.");
}

// join the room
$db->query("INSERT INTO room_participants (user_id, room_id, colour) VALUES
    ('{$user->id}', '{$room_id}', '{$colour}')");

// tell everyone in the room that you joined
$message = "{$user->username} joined the room.";
$db->query("INSERT INTO chat (user, message, room_id, chat_type) VALUES
    ('{$user->id}', '{$message}', '{$room_id}', 'event')");

echo $AJAX_SUCCESS;
?>