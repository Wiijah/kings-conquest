<?php

/* Team enumerations */
$TEAM_COLOURS = array("red" => 0, "blue" => 1);
$TEAM_RED = 0;
$TEAM_BLUE = 1;

function create_unit($name, $x, $y, $team) {
  global $db;
  global $room_id;
  $result = $db->query("SELECT * FROM classes WHERE name = '{$name}'");
  $class = $result->fetch_object();

  $result = $db->query("INSERT INTO units (class_id, hp, max_hp, attack, x, y, team, room_id) VALUES
    ('{$class->class_id}', '{$class->max_hp}', '{$class->max_hp}', '{$class->attack}', '{$x}', '{$y}', '{$team}', '{$room_id}')");
  return $db->insert_id;
}

function init_units() {
  global $TEAM_COLOURS;
  /* Red Team */
  create_unit("King", 3, 2, $TEAM_COLOURS['red']);
  create_unit("Red Castle", 0, 0, $TEAM_COLOURS['red']);
  create_unit("Wizard", 3, 3, $TEAM_COLOURS['red']);
  create_unit("Knight", 0, 2, $TEAM_COLOURS['red']);
  create_unit("Archer", 0, 3, $TEAM_COLOURS['red']);

  /* Blue Team */
  create_unit("King", 9, 11, $TEAM_COLOURS['blue']);
  create_unit("Blue Castle", 12, 13, $TEAM_COLOURS['blue']);
  create_unit("Wizard", 9, 10, $TEAM_COLOURS['blue']);
  create_unit("Knight", 12, 10, $TEAM_COLOURS['blue']);
  create_unit("Archer", 12, 11, $TEAM_COLOURS['blue']);
}

function jsonUnit($unit) {
  return '"'.$unit->unit_id.'": {
      '.jsonStr("address", $unit->address).','.
        jsonStr("spritesheet", $unit->spritesheet).','.
        jsonPair("hp", $unit->hp).','.
        jsonPair("max_hp", $unit->max_hp).','.
        jsonPair("attack", $unit->attack).','.
        jsonStr("skill", $unit->skill).','.
        jsonPair("luck", $unit->luck).','.
        jsonPair("x", $unit->x).','.
        jsonPair("y", $unit->y).','.
        jsonPair("moveRange", $unit->moveRange).','.
        jsonPair("team", $unit->team).','.
        jsonPair("attackRange", $unit->attackRange).','.
        jsonPair("canMove", $unit->canMove).','.
        jsonPair("canAttack", $unit->canAttack).','.
        jsonPair("skillCoolDown", $unit->skillCoolDown).','.
        jsonPair("outOfMoves", $unit->outOfMoves).','.
        jsonStr("damageEffect", $unit->damageEffect).'
    }';
}
?>
