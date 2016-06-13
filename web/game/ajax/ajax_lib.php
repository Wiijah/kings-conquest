<?php
/* Error codes */
$ERROR_SERVER_ERROR = 1; // error is to do with backend and not the client
$ERROR_NOT_IG = 2; // user is not currently in a game
$ERROR_NOT_LOGGED_IN = 3; // user is not logged in
$ERROR_NOT_ENOUGH_GOLD = 4; // not enough gold to build unit
$ERROR_BAD_INPUT = 5; // user tried malicious input
$ERROR_BLOCKED = 6; // user tried to build a unit in an obstacle
$ERROR_TIMEOUT = 7; // time out
$ERROR_NOT_YOUR_TURN = 8; //action when not user's turn
$ERROR_PLAYER_LEFT_GAME = 9; //other player left the game
$ERROR_UNKNOWN = 10; // something that shouldn't ever happen no matter what
$ERROR_GAME_ENDED = 11;
$ERROR_DO_NOTHING = 12; //do nothing

require_once '../../common.php';

if (!isset($_SESSION['id'])) {
  exit_error($ERROR_NOT_LOGGED_IN);
}
session_write_close();

/* Get room participant and room ID */
$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = '' ORDER BY part_id DESC LIMIT 1");
if (!$player = $result->fetch_object()) {
  exit_error($ERROR_NOT_IG); //Error, not in room
}
$room_id = $player->room_id;

/* Exit if spectator tries to do a player action */
if (!isset($spectate_page) && $player->colour == "spectator") {
  exit_error($ERROR_BAD_INPUT);
}

/* Get enemy room participant  */
$result = $db->query("SELECT * FROM room_participants WHERE user_id != '{$user->id}' AND colour != 'spectator' AND event = '' AND room_id = '{$room_id}' ORDER BY part_id DESC LIMIT 1");
if (!$opp_player = $result->fetch_object()) {
  exit_error($ERROR_NOT_IG); //Error, not in room
}

/* Get room */
$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0) {
  exit_error($ERROR_NOT_IG); //room state isn't "in game"
}

if ($room->state == 'ended') exit_error($ERROR_GAME_ENDED);
if ($room->state != 'ingame') exit_error($ERROR_NOT_IG);

require_once '../includes/game_lib.php';

function game_error($msg) {
  return '{"error_code":"'.$msg.'"}';
}

function exit_error($msg) {
  die('{"error_code":"'.$msg.'"}');
}

function jsonStr($key, $value, $braces = false) {
  $out = '"'.$key.'":"'.$value.'"';
  if ($braces) return "{".$out."}";
  
  return $out;
}

function jsonArray($array) {
  $out = "";
  $comma = "";
  foreach ($array as $value) {
    $out .= $comma.$value;
    $comma = ",";
  }
  return "[{$out}]";
}

function jsonPair($key, $value, $braces = false) {
  $out = '"'.$key.'": '.$value;
  if ($braces) return "{".$out."}";
  return $out;
}

function action($type, $other_fields) {
  return '{"action_type": "'.$type.'", '.$other_fields.'}';
}

$SUCCESS = '"error_code": 0';
?>