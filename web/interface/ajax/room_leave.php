<?php
/* Leave room and output JSON result */
require_once 'ajax_common.php';

/* Get Room ID from POST data */
$room_id = secureStr($_POST['room_id']);

/* Check if the client already left the room or cannot leave the room */

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0) { //room no longer exists
  die('{"kc_success":""}');
}

if ($room->state != 'pregame') {
  die('{"kc_error":"Game already started."}'); //can't leave room if game started, must leave through the game interface
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND room_id = '{$room_id}' AND event = ''");
if (!$participant = $result->fetch_object()) { //user already left
  die('{"kc_success":""}');
}


/* Tell everyone you left */
$message = $user->username." left the game.";
$db->query("INSERT INTO chat (user, message, room_id, chat_type) VALUES
    ('{$user->id}', '{$message}', '{$room_id}', 'event')");

/* Delete room and room participant records if owner */
if ($participant->state == 'owner') {
  $db->query("UPDATE rooms SET state = 'deleted' WHERE room_id = '{$room_id}'");
  $db->query("DELETE FROM room_participants WHERE room_id = '{$room_id}'");
} else { /* Otherwise, leave the game without deleting the room */
  $db->query("UPDATE room_participants SET event = 'left' WHERE user_id = '{$user->id}'");
}

/* Success */
echo $AJAX_SUCCESS;
?>