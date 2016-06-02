<?php
/* Common include of each ajax file */
header('Access-Control-Allow-Origin: *');
header("Content-Type: application/json; charset=UTF-8");

require_once '../../common.php';
/* Error enums */
$ERROR_NOT_IG = 2;

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = ''");
if (!$player = $result->fetch_object()) {
 die(game_error($ERROR_NOT_IG)); //Error, not in game.
}
$room_id = $player->room_id;

if (!isset($_SESSION['id'])) {
  die('{"session_error":"session_expired"}');
}

function game_error($msg) {
  return '{"error_code":"'.$msg.'"}';
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
?>