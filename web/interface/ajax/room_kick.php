<?php
/* Leave room and output JSON result */
require_once 'ajax_common.php';

/* Get Room ID from POST data */
$room_id = secureStr($_POST['room_id']);
$target_id = secureStr($_POST['target_id']);

/* Check if the client already left the room or cannot leave the room */

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();

if (!$room) kc_error("This room no longer exists.");
if ($room->state != 'pregame') kc_error("Game already started.");

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND room_id = '{$room_id}' AND event = ''");
$part = $result->fetch_object();
if (!$part) kc_error("You are not in this room.");
if ($part->state != 'owner') kc_error("You can only kick players if you are the owner.");

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$target_id}' AND room_id = '{$room_id}' AND event = ''");
if (!$other_part = $result->fetch_object()) kc_error("The user you tried to kick is no longer in this room.");

$result = $db->query("SELECT * FROM users WHERE id = '{$target_id}'");
$other = $result->fetch_object();

if (!$other) kc_error("An error occurred with the server. Please try again later.");

/* Tell everyone you kicked someone */
$message = $user->username." kicked {$other->username}.";
$db->query("INSERT INTO chat (user, message, room_id, chat_type) VALUES
    ('{$user->id}', '{$message}', '{$room_id}', 'event')");

$db->query("UPDATE room_participants SET event = 'kicked' WHERE user_id = '{$target_id}'");

/* Success */
echo $AJAX_SUCCESS;
?>