<?php
require_once 'ajax_common.php';

$x = secureStr($_POST['x']);
$y = secureStr($_POST['y']);
$name = secureStr($_POST['name']);
$team = $TEAM_COLOURS[$player->colour];

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
$player->gold -= $class->gold;
$db->query("UPDATE room_participants SET gold = '{$player->gold}' WHERE user_id = '{$user->id}' AND room_id = '{$room_id}'");

$out = "{";
$out .= $SUCCESS.",";
//$out .= jsonPair("gold", $player->gold).",";
$action = action("create_unit",
       jsonPair("unit", "{".jsonUnit($unit)."}")
  .",".jsonPair("gold", $player->gold));


$out .= jsonPair("actions", "[{$action}]"); 
$out .= "}";

oppInsert($out);
echo $out;
?>