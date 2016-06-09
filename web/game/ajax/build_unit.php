<?php
require_once 'ajax_common.php';

$x = secureInt($_POST['x']);
$y = secureInt($_POST['y']);
$name = secureStr($_POST['name']);
$team = $TEAM_COLOURS[$player->colour];
if ($team != $room->turn) exit_error($ERROR_NOT_YOUR_TURN);

$actions = array();
// $x = 3;
// $y = 2;
// $name = "wizard";
// $team = 0;

$result = $db->query("SELECT * FROM classes WHERE name = '{$name}'");
$class = $result->fetch_object();

if (!$class) {
  exit_error($ERROR_BAD_INPUT); //class not exist
}

if ($player->gold < $class->gold) {
  exit_error($ERROR_NOT_ENOUGH_GOLD); // player can't afford unit
}


/* Create the unit */
$unit_id = create_unit($name, $x, $y, $team);
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$unit_id}'");
$unit = $result->fetch_object();

if (!$unit) {
  exit_error($ERROR_SERVER_ERROR); //for some reason it was unable to create the unit
}

/* Remove the gold from the player */

$out = "{";
$out .= $SUCCESS.",";
//$out .= jsonPair("gold", $player->gold).",";
$actions[] = action("create_unit",
       jsonPair("unit", "{".jsonUnit($unit)."}"));
$actions[] = give_gold($player, 0 - $class->gold);


$out .= jsonPair("actions", jsonArray($actions));
$out .= "}";

$db->query("UPDATE room_participants SET unit_spawns = unit_spawns + 1 WHERE part_id = '{$player->part_id}'");

oppInsert($out);
echo $out;
?>