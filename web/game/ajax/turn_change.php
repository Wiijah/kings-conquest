<?php
require_once 'ajax_common.php';

$team = $TEAM_COLOURS[$player->colour];

$old_turn = $room->turn; //old player's turn
if ($old_turn != $team) {
  exit_error($ERROR_NOT_YOUR_TURN);
}

$new_turn = ($old_turn + 1) % 2;

/* Update the room to the new turn */
$db->query("UPDATE rooms SET turn = '{$new_turn}' WHERE room_id = '{$room_id}'");

/* Reset the moves */
$db->query("UPDATE units SET canMove = 1, canAttack = 1, outOfMoves = 0 WHERE room_id = '{$room_id}' AND team = '{$new_turn}'");

$out = "{";
$out .= $SUCCESS.",";
//$out .= jsonPair("gold", $player->gold).",";
$action = action("turn_change",
       jsonPair("new_turn", $new_turn)
  .",".jsonPair("effects_to_apply", "[]")
  .",".jsonPair("units_new_cd", "[]")
  .",".jsonPair("buffs_to_remove", "[]"));
  $out .= jsonPair("actions", "[{$action}]");
$out .= "}";

oppInsert($out);
echo $out;
?>