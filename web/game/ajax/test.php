<?php
require_once '../../common.php';
require_once '../includes/game_lib.php';

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = ''");
if (!$player = $result->fetch_object()) {
 die(game_error($ERROR_NOT_IG)); //Error, not in game.
}
$room_id = $player->room_id;

//Delete all units
$db->query("DELETE FROM buff_instances");
$db->query("DELETE FROM units WHERE room_id = {$room_id}");
$db->query("UPDATE room_participants SET gold = '1000'");
$db->query("UPDATE rooms SET turn = '0' WHERE room_id = '{$room_id}'");
init_units();
header ("Location: ../");
?>