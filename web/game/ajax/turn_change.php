<?php
require_once 'ajax_common.php';

$team = $TEAM_COLOURS[$player->colour];
$is_countdown = secureStr($_POST['countdown']);
$time = time();

$old_turn = $room->turn; //old player's turn

if ($is_countdown == 1 && $time < $room->countdown - 1) {
  exit_error(1503);
}
if ($old_turn != $team && $is_countdown != 1) {
  exit_error(134);
}

$countdown = $time + $room->default_countdown;

$new_turn = ($old_turn + 1) % 2;

$actions = array();

/* Reset the moves */
$db->query("UPDATE units SET canMove = 1, canAttack = 1, outOfMoves = 0, prev_x = '-1', prev_y = '-1' WHERE room_id = '{$room_id}' AND team = '{$new_turn}'");

/* skillCoolDown */
$db->query("UPDATE units SET skillCoolDown = skillCoolDown - 1 WHERE room_id = '{$room_id}' AND skillCoolDown > 0");

/* Update the room to the new turn */
$db->query("UPDATE rooms SET turn = '{$new_turn}', countdown = '{$countdown}' WHERE room_id = '{$room_id}'");

/* Burn effect */
$result = $db->query("SELECT * FROM buff_instances JOIN buffs USING (buff_id) WHERE room_id = '{$room_id}' AND buff_id = 5");
$buff_list = array();
while ($buff = $result->fetch_object()) {
  $unit = select_unit($buff->unit_id);
  if (!$unit) continue;
  $damage = ceil($unit->max_hp * 0.02);
  $buff_list = array_merge($buff_list, damageByBuff($buff, $unit, $damage));
}

/* Freeze effect */
$result = $db->query("SELECT * FROM buff_instances JOIN buffs USING (buff_id) WHERE room_id = '{$room_id}' AND buff_id = 6");
while ($buff = $result->fetch_object()) {
  $unit = select_unit($buff->unit_id);
  if (!$unit) continue;
  $buff_list = array_merge($buff_list, damageByBuff($buff, $unit, 0));
  update_unit($unit, 0, 0, 1);
}

$result = $db->query("SELECT * FROM units WHERE room_id = '{$room_id}'");
while ($unit = $result->fetch_object()) {
  $actions[] = '{ "action_type" : "update_unit",
    "unit_id" : '.$unit->unit_id.',
    "canMove" : '.$unit->canMove.',
    "canAttack" : '.$unit->canAttack.',
    "outOfMoves" : '.$unit->outOfMoves.',
    "skillCoolDown" : '.$unit->skillCoolDown.'}';
}

/* Heal units via Totem */
$result = $db->query("SELECT * FROM units JOIN classes USING (class_id) WHERE room_id = '{$room_id}' AND name='totem' AND team = '{$new_turn}'");
while ($totem = $result->fetch_object()) {
  $result2 = $db->query("SELECT * FROM units WHERE room_id = '{$room_id}' AND team = '{$totem->team}' AND unit_id != {$totem->unit_id} AND ".totem($totem->x, $totem->y));
  while ($unit = $result2->fetch_object()) {
    $heal = ceil($unit->max_hp * 0.03);
    if ($heal + $unit->hp > $unit->max_hp) $heal = $unit->max_hp - $unit->hp;
    $buff_list[] = triggerBufferJson("Heal", $unit->unit_id, $heal);
    $unit->hp += $heal;
    $db->query("UPDATE units SET hp = {$unit->hp} WHERE unit_id = '{$unit->unit_id}'");
  }
}

/* Decrement buff turns left */
$db->query("UPDATE buff_instances SET turns_left = turns_left - 1 WHERE room_id = '{$room_id}' AND turns_left > 0");

/* Find all the buffs that should be removed */
$buffsToRemoveJSON = "";
$result = $db->query("SELECT * FROM buff_instances  WHERE room_id = '{$room_id}' AND turns_left = 0");
while ($fetch = $result->fetch_object()) {
  $actions[] = removeBuffJson($fetch->buff_id, $fetch->unit_id);
}

/* Remove buffs that are out of turns */
$db->query("DELETE FROM buff_instances WHERE room_id = '{$room_id}' AND turns_left = 0");


$out = "{";
$out .= $SUCCESS.",";
//$out .= jsonPair("gold", $player->gold).",";
$actions[] = action("turn_change",
       jsonPair("new_turn", $new_turn)
  .",".jsonPair("effects_to_apply", "[]")
  .",".jsonPair("units_new_cd", "[]")
  .",".jsonPair("buffs_to_remove", "[{$buffsToRemoveJSON}]"));
$actions = array_merge($actions, $buff_list);
$actions[] = give_gold($player, 10);
$actions[] = give_gold($opp_player, 10);
$out .= jsonPair("actions", jsonArray($actions));

$out .= "}";

oppInsert($out);
echo $out;

function removeBuffJson($buff_id, $unit_id) {
  return '{"action_type" : "remove_buff",
    "buff_id" : "'.$buff_id.'",
    "unit_id" : '.$unit_id.'
  }';
}
?>