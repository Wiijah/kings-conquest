<?php
require_once 'ajax_common.php';

/* Get basic data */
$unit_id = secureStr($_POST['unit_id']);
$moves_json = secureStr($_POST['moves']);
$moves = json_decode($moves_json);

$unit_id = 101;
$moves_json = "[[1,2], [1,3]]";
$moves = json_decode($moves_json);
$initial = array(1, 2);

$team = $TEAM_COLOURS[$player->colour];

/* Get the unit object */
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$unit_id}' AND room_id = '{$room_id}'");
$unit = $result->fetch_object();

if ( !$unit //unit not exist
  || $unit->team != $team // player not supposed to control other team units) {
  || $moves[0][0] != $unit->x || $moves[0][1] != $unit->y //initial move path isn't where the unit initially was
  || count($moves) > $unit->moveRange //player trying to move more than the movement range
  ) {
  exit_error($ERROR_BAD_INPUT);
}

for ($i = 0; $i < count($moves); $i++) {
  if (isPairMalicious($moves[$i])
    || $i != 0 && !arePairsAdj($moves[$i - 1], $moves[$i])) {
    exit_error($ERROR_BAD_INPUT);
  }
}

//update unit location
$new_x = $moves[count($moves) - 1][0];
$new_y = $moves[count($moves) - 1][1];
$db->query("UPDATE units SET x = '{$new_x}', y = '{$new_y}' WHERE unit_id = '{$unit_id}'");

$out = "{";
$out .= $SUCCESS.",";
$out .= action("move_unit",
       jsonPair("unit_id", $unit_id)
  .",".jsonPair("moves", $moves_json));
$out .= "}";
echo $out;

/* Moving unit functions */
function arePairsAdj($pair1, $pair2) {
  $diff = array($pair1[0] - $pair2[0], $pair1[1] - $pair2[1]);
  $abs_sum = abs($diff[0]) + abs($diff[1]);
  return $abs_sum == 1;
}

function isPairMalicious($pair) {
  return count($pair) != 2 || !is_int($pair[0]) || !is_int($pair[1]);
}
?>