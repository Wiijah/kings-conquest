<?php
require_once 'ajax_common.php';

$x = 7;
$y = 7;
$name = "Wizard";
/*
$x = secureStr($_POST['x']);
$y = secureStr($_POST['y']);
$name = secureStr($_POST['name']);
*/
$team = $TEAM_COLOURS[$player->colour];

$unit_id = create_unit("King", 3, 2, $team);
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$unit_id}'");
$unit = $result->fetch_object();

$out = "{";
$out .= $SUCCESS.",";
$out .= action("create_unit", jsonPair("unit", "{".jsonUnit($unit)."}"));
$out .= "}";
echo $out;
?>