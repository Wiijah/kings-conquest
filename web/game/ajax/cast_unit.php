<?php
require_once 'ajax_common.php';

$caster_id = secureStr($_POST['caster_id']);
$target_id = secureStr($_POST['target_id']);

// get player team
$team = $TEAM_COLOURS[$player->colour];

//get both units
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$caster_id}' AND room_id = '{$room_id}'");
$caster = $result->fetch_object();

if ($target_id > 0) {
  $result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$target_id}' AND room_id = '{$room_id}'");
  $target = $result->fetch_object();
  if (!$target) exit_error(101);
}


if ($caster->skill == "Shield") {
  $db->query("INSERT INTO buff_instances (buff_id, unit_id, turns_left) VALUES ('4', '{$caster->unit_id}', '-1')");

  $out = '{';
  $out .= $SUCCESS.",";
  $actions[] = action("apply_buff",
       jsonPair("buff_id", 4)
    .",".jsonPair("unit_id", $caster->unit_id));
  $out .= jsonPair("actions", jsonArray($actions));
  $out .= "}";
}

$db->query("UPDATE units SET canMove = 0, canAttack = 0, outOfMoves = 1 WHERE unit_id = '{$caster_id}'"); 

oppInsert($out);
echo $out;
?>