<?php

/* Team enumerations */
$TEAM_RED = 0;
$TEAM_BLUE = 1;

function create_unit($name, $x, $y, $team) {
  global $room_id;
  $result = $db->query("SELECT * FROM classes WHERE name = '{$name}'");
  $class = $result->fetch_object();

  $result = $db->query("INSERT INTO units (class_id, hp, max_hp, attack, x, y, team, room_id) VALUES
    ('{$class->class_id}', '{$class->max_hp}', '{$class->max_hp}', '{$class->attack}', '{$x}', '{$y}', '{$team}', '{$room_id}')");
}

function init_units() {
  /* Red Team */
  create_unit("King", 3, 2, $TEAM_RED);
  create_unit("Red Castle", 1, 0, $TEAM_RED);
  create_unit("Wizard", 3, 3, $TEAM_RED);
  create_unit("Knight", 0, 2, $TEAM_RED);
  create_unit("Archer", 0, 3, $TEAM_RED);

  /* Blue Team */
  create_unit("King", 9, 11, $TEAM_BLUE);
  create_unit("Blue Castle", 12, 13, $TEAM_BLUE);
  create_unit("Wizard", 9, 10, $TEAM_BLUE);
  create_unit("Knight", 12, 10, $TEAM_BLUE);
  create_unit("Archer", 12, 11, $TEAM_BLUE);
}
?>