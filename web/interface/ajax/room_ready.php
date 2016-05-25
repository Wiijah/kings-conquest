<?php
/* Ready or start a new game from a room. */
require_once 'ajax_common.php';

$room_id = secureInt($_POST['room_id']);
$ready = secureStr($_POST['ready']);

if ($ready != "ready" && $ready != "notready") {
  kc_error("Please do not attempt to hack our website. Thank you.");
}

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0 || $room->state == 'deleted') {
  kc_error("This room has been deleted.");
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND room_id = '{$room_id}' AND event = ''");
if (!$part = $result->fetch_object()) {
  kc_error("You are not in this room.");
}

if ($part->state == 'owner') {
  $result = $db->query("SELECT * FROM room_participants WHERE room_id = '{$room_id}' AND event = ''");
  $num_of_players = $result->num_rows;
  if ($num_of_players < $room->max_players) {
    kc_error("There are not enough players in this room for you to start the game.");
  }

  $result = $db->query("SELECT * FROM room_participants WHERE room_id = '{$room_id}' AND event = '' AND state = 'ready'");
  $num_of_players_ready = $result->num_rows + 1; // +1 since the owner is always ready
  if ($num_of_players_ready < $num_of_players) {
    kc_error("All players need to be ready before you can start the game.");
  }
} else { //not owner, so just set ready
  $db->query("UPDATE room_participants SET state = '{$ready}' WHERE user_id = '{$user->id}'");
}
echo $AJAX_SUCCESS;
?>