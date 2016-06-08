<?php
require_once 'ajax_common.php';

$attacker_id = secureInt($_POST['attacker_id']);
$target_id = secureInt($_POST['target_id']);

// get player team
$team = $TEAM_COLOURS[$player->colour];

//get both units
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$attacker_id}' AND room_id = '{$room_id}'");
$attacker = $result->fetch_object();

$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$target_id}' AND room_id = '{$room_id}'");
$target = $result->fetch_object();

// add sanity checks
if ( !$attacker ) exit_error(100);
if ( !$target ) exit_error(101);
if ( $attacker->team != $team ) exit_error(102);
if ( $attacker->team == $target->team ) exit_error(103);
if ( $attacker->canAttack == 0 ) exit_error(104);
if ( outOfAttackRange($attacker, $target)) exit_error(105);

$out = '{';
$out .= $SUCCESS.",";


$actions = array();
$actions = array_merge($actions, attack_unit($attacker, $target));
$actions[] = update_unit($attacker, 0, 0, 1);

$out .= jsonPair("actions", jsonArray($actions));
$out .= "}";
oppInsert($out);
echo $out;

function outOfAttackRange($unit1, $unit2) {
	return (abs($unit1->x - $unit2->x) + abs($unit1->y - $unit2->y) > $unit1->attackRange);
}
?>