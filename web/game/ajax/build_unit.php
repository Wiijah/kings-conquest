<?php
require_once 'ajax_common.php';

$x = secureStr($_POST['x']);
$y = secureStr($_POST['y']);
$name = secureStr($_POST['name']);

$team = $TEAM_COLOURS[$player->colour];

$unit_id = create_unit($name, $x, $y, $team);
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$unit_id}'");
$unit = $result->fetch_object();

if (!$unit) {
  die(game_error(1));
}

$out = "{";
$out .= $SUCCESS.",";
$out .= jsonPair("gold", $player->gold).",";
$out .= action("create_unit", jsonPair("unit", "{".jsonUnit($unit)."}"));
$out .= "}";
echo $out;
?>