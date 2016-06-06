<?php
require_once 'ajax_common.php';

$old_turn = $room->turn; //old player's turn
if ($old_turn != $player->team) {
  exit_error($ERROR_NOT_YOUR_TURN);
}

$new_turn = ($old_turn + 1) % 2;

/* Update the room to the new turn */
$db->query("UPDATE rooms SET turn = '{$new_turn}' WHERE room_id = '{$room_id}'");

$out = "{";
$out .= $SUCCESS.",";
//$out .= jsonPair("gold", $player->gold).",";
$out .= action("turn_change",
       jsonPair("new_turn", $new_turn)
  .",".jsonPair("effects_to_apply", "[]")
  .",".jsonPair("units_new_cd", "[]")
  .",".jsonPair("buffs_to_remove", "[]"));
$out .= "}";

oppInsert($out);
echo $out;
?>