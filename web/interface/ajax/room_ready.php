<?php
/* Ready or start a new game from a room. */
require_once 'ajax_common.php';
require_once '../../game/includes/game_lib.php';

$room_id = secureInt($_POST['room_id']);
$ready = secureStr($_POST['ready']);

if ($ready != "ready" && $ready != "notready") {
  kc_error("Please do not attempt to hack our website. Thank you.");
}

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0) {
  kc_error("This room is already deleted.");
}

if ($room->state != 'pregame') {
  kc_error("This room is not in the pregame state.");
}

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND room_id = '{$room_id}' AND event = '' AND colour != 'spectator'");
if (!$part = $result->fetch_object()) {
  kc_error("You are not a player in this room.");
}

if ($part->state == 'owner') {
  $result = $db->query("SELECT * FROM room_participants WHERE room_id = '{$room_id}' AND event = '' AND colour != 'spectator'");
  $num_of_players = $result->num_rows;
  if ($num_of_players < $room->max_players) {
    kc_error("There are not enough players in this room for you to start the game.");
  }

  $result = $db->query("SELECT * FROM room_participants WHERE room_id = '{$room_id}' AND event = '' AND state = 'ready' AND colour != 'spectator'");
  $num_of_players_ready = $result->num_rows + 1; // +1 since the owner is always ready
  if ($num_of_players_ready < $num_of_players) {
    kc_error("All players need to be ready before you can start the game.");
  }

  init_units(); //create the units
  $countdown = time() + $DEFAULT_COUNTDOWN;
  $db->query("UPDATE rooms SET state = 'ingame', countdown = '{$countdown}' WHERE room_id = {$room_id}");
} else { //not owner, so just set ready
  $db->query("UPDATE room_participants SET state = '{$ready}' WHERE user_id = '{$user->id}'");
}
echo $AJAX_SUCCESS;
?>