<?php
require_once 'ajax_common.php';

$unit_id = secureStr($_POST['unit_id']);
$moves_json = secureStr($_POST['moves']);
$moves = json_decode($moves_json);

$unit_id = 1337;
$moves_json = "[[1,2], [1,3]]";
$moves = json_decode($moves_json);
$initial = array(1, 2);

$team = $TEAM_COLOURS[$player->colour];

for ($i = 0; $i < count($moves); $i++) {
  if (isPairMalicious($moves[$i])
    || $i != 0 && !arePairsAdj($moves[$i - 1], $moves[$i])) {
    exit_error($ERROR_BAD_INPUT);
  }
}

function arePairsAdj($pair1, $pair2) {
  $diff = array($pair1[0] - $pair2[0], $pair1[1] - $pair2[1]);
  $abs_sum = abs($diff[0]) + abs($diff[1]);
  return $abs_sum == 1;
}

function isPairMalicious($pair) {
  return count($pair) != 2 || !is_int($pair[0]) || !is_int($pair[1]);
}


$out = "{";
$out .= $SUCCESS.",";
$out .= action("move_unit",
       jsonPair("unit_id", $unit_id)
  .",".jsonPair("moves", $moves_json));
$out .= "}";
echo $out;

?>