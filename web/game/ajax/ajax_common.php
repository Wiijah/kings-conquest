<?php
/* Common include of each ajax file */
header('Access-Control-Allow-Origin: *');
header("Content-Type: application/json; charset=UTF-8");

/* Error codes */
$ERROR_SERVER_ERROR = 1; // error is to do with backend and not the client
$ERROR_NOT_IG = 2; // user is not currently in a game
$ERROR_NOT_LOGGED_IN = 3; // user is not logged in
$ERROR_NOT_ENOUGH_GOLD = 4; // not enough gold to build unit
$ERROR_BAD_INPUT = 5; // user tried malicious input
$ERROR_BLOCKED = 6; // user tried to build a unit in an obstacle

require_once '../../common.php';

if (!isset($_SESSION['id'])) {
  exit_error($ERROR_NOT_LOGGED_IN);
}

/* Get room participant and room ID */
$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = ''");
if (!$player = $result->fetch_object()) {
 exit_error($ERROR_NOT_IG); //Error, not in room
}
$room_id = $player->room_id;


/* Get room */
$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0 || $room->state != 'ingame') {
  exit_error($ERROR_NOT_IG); //room state isn't "in game"
}

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

function jsonPair($key, $value, $braces = false) {
  $out = '"'.$key.'": '.$value;
  if ($braces) return "{".$out."}";
  return $out;
}

function action($type, $other_fields) {
  return '"action" : {"action_type": "'.$type.'", '.$other_fields.'}';
}

$SUCCESS = '"error_code": 0';

?>