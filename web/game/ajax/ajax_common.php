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

require_once '../../common.php';
$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = ''");
if (!$player = $result->fetch_object()) {
 die(game_error($ERROR_NOT_IG)); //Error, not in game.
}
$room_id = $player->room_id;

require_once '../includes/game_lib.php';

if (!isset($_SESSION['id'])) {
  die('{"error_code": '.$ERROR_NOT_LOGGED_IN.'}');
}

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