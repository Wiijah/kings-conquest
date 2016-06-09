<?php
require_once 'ajax_common.php';

/* Get basic data */
$unit_id = secureInt($_POST['unit_id']);
$moves_json = secureStr($_POST['path']);
$moves = json_decode($moves_json);

// $unit_id = 151;
// $moves_json = "[[3,2], [3,3]]";
// $moves = json_decode($moves_json);
// $initial = array(1, 2);

$team = $TEAM_COLOURS[$player->colour];

/* Get the unit object */
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$unit_id}' AND room_id = '{$room_id}'");
$unit = $result->fetch_object();

//TODO: delete this
// if (!$unit) exit_error($unit_id);
// if ($unit->team != $team) exit_error(101);
// if ($moves[0][0] != $unit->x || $moves[0][1] != $unit->y) exit_error(102);
// if (count($moves) - 1 > $unit->moveRange) exit_error(103);

if (count($moves) == 0) {
  exit_error($ERROR_BAD_INPUT);
}

$dest_x = $moves[count($moves) - 1][0];
$dest_y = $moves[count($moves) - 1][1];

if ( !$unit //unit not exist
  || $unit->team != $team // player not supposed to control other team units) {
  || $moves[0][0] != $unit->x || $moves[0][1] != $unit->y //initial move path isn't where the unit initially was
  || count($moves) - 1 > $unit->moveRange //player trying to move more than the movement range
  || $unit->canMove == 0 && $unit->prev_x != $dest_x && $unit->prev_y != $dest_y //unit already moved this turn
  || $unit->canAttack == 0
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
$db->query("UPDATE units SET x = '{$new_x}', y = '{$new_y}', prev_x = '{$unit->x}', prev_y = '{$unit->y}' WHERE unit_id = '{$unit_id}'");

$out = "{";
$out .= $SUCCESS.",";
$actions[] = action("move_unit",
       jsonPair("unit_id", $unit_id)
  .",".jsonPair("path", $moves_json));

if ($unit->canMove == 0) {
  $actions[] = update_unit($unit, 1);
} else {
  $actions[] = update_unit($unit, 0);
}

$out .= jsonPair("actions", jsonArray($actions));
$out .= "}";

oppInsert($out);
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