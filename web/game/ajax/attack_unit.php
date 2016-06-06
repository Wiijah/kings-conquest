<?php
require_once 'ajax_common.php';

$attacker_id = secureStr($_POST['attacker_id']);
$target_id = secureStr($_POST['target_id']);

// get player team
$team = $TEAM_COLOURS[$player->colour];

//get both units
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$attacker_id}' AND room_id = '{$room_id}'");
$attacker = $result->fetch_object();

$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$target_id}' AND room_id = '{$room_id}'");
$target = $result->fetch_object();

// add sanity checks
if ( !$attacker
  || !$target
  || $attacker->team != $team
  || $attacker->team == $target->team
  || $unit->canAttack == 0
  || outOfAttackRange($attacker, $target)
  ) {
	exit_error($ERROR_BAD_INPUT);
}

// get new health
$damage = $attacker->attack;
$new_health = $target->hp - $damage;
if ($new_health <= 0) 
	$db->query("DELETE FROM units WHERE unit_id = '{$target_id}'");
else 
	$db->query("UPDATE units SET health = '{$new_health}' WHERE unit_id = '{$target_id}'");

$db->query("UPDATE units SET canMove = 0, canAttack = 0, outOfMoves = 1 WHERE unit_id = '{$attacker_id}'"); 

// notify
$out = '{';
$out .= $SUCCESS.",";
$out .= action("attack_unit",
	   jsonPair("attacker_id", $attacker_id)
  .",".jsonPair("target_id", $target_id)
  .",".jsonPair("dmg", $damage)
  .",".jsonPair("is_critical", 0));
$out .= "}";

oppInsert($out);
echo $out;


function outOfAttackRange($unit1, $unit2) {
	return (abs($unit1->x - $unit2->x) + abs($unit1->y - $unit2->y) > $unit1->attackRange);
}
?>