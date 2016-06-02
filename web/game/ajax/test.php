<?php
require_once '../../common.php';
require_once '../includes/game_lib.php';

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = ''");
if (!$player = $result->fetch_object()) {
 die(game_error($ERROR_NOT_IG)); //Error, not in game.
}
$room_id = $player->room_id;
init_units();
?>Okay!