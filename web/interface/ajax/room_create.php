<?php
/* Create a new room */
require_once 'ajax_common.php';

$room_name = trim($_POST['room_name']);
$room_pass = ($_POST['room_pass']);

/* Input is checked client-side before posting, however, if the client decides to modify client-side checking, then
   an arbitrary but valid values are substituted in */
if (!isStrLenCorrect($room_name, 3, 20)) {
  $room_name = "Join Me";
}
if (!isStrLenCorrect($room_pass, 0, 20)) {
  $room_pass = "";
}

/* secureStr only after checking the length due to htmlentities */
$room_name = secureStr($room_name);
if ($room_pass != "") $room_pass = hashPass($room_name);

$result = $db->query("SELECT * FROM room_participants WHERE user_id = {$user->id} AND event = '' AND colour != 'spectator'");
if ($result->num_rows > 0) {
  kc_error("You cannot join a room if you are already in a room.");
}


$result = $db->query("SELECT * FROM maps WHERE map_id = '1'");
if (!$map = $result->fetch_object()) {
  kc_error("A server error has occurred.");
}

// insert new room and get the room's ID
$result = $db->query("INSERT INTO rooms (name, password, user_id, map_id, map_json) VALUES
    ('{$room_name}', '{$room_pass}', '{$user->id}', '{$map->map_id}', '{$map->points}')");
$room_id = $db->insert_id;

$db->query("DELETE FROM units WHERE room_id = '{$room_id}'");
$db->query("DELETE FROM buff_instances WHERE room_id = '{$room_id}'");
$db->query("DELETE FROM opp WHERE room_id = '{$room_id}'");
$db->query("DELETE FROM chat WHERE room_id = '{$room_id}'");
$db->query("DELETE FROM room_participants WHERE room_id = '{$room_id}'");

// automatically have the user join the room it has made
$db->query("INSERT INTO room_participants (user_id, room_id, colour, state) VALUES
    ('{$user->id}', '{$room_id}', 'red', 'owner')");

// create the event that you joined the room
$message = "{$user->username} joined the room.";
$db->query("INSERT INTO chat (user, message, room_id, chat_type) VALUES
    ('{$user->id}', '{$message}', '{$room_id}', 'event')");

echo $AJAX_SUCCESS;
?>