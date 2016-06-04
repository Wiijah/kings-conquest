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
  create_unit("king", 3, 2, $TEAM_COLOURS['red']);
  create_unit("red castle", 0, 0, $TEAM_COLOURS['red']);
  create_unit("wizard", 3, 3, $TEAM_COLOURS['red']);
  create_unit("knight", 0, 2, $TEAM_COLOURS['red']);
  create_unit("archer", 0, 3, $TEAM_COLOURS['red']);

  /* Blue Team */
  create_unit("king", 9, 11, $TEAM_COLOURS['blue']);
  create_unit("blue castle", 12, 13, $TEAM_COLOURS['blue']);
  create_unit("wizard", 9, 10, $TEAM_COLOURS['blue']);
  create_unit("knight", 12, 10, $TEAM_COLOURS['blue']);
  create_unit("archer", 12, 11, $TEAM_COLOURS['blue']);
}

function jsonUnit($unit) {
  return '"'.$unit->unit_id.'": {
      '.jsonStr("address", $unit->address).','.
        jsonStr("spritesheet", $unit->spritesheet).','.
        jsonPair("unit_id", $unit->unit_id).','.
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

function oppInsert($json) {
  global $db;
  global $room_id;
  global $user;
  global $player;
  $json = secureStr($json);

  $db->query("INSERT INTO opp (room_id, user_id, team, json) VALUES ('{$room_id}', '{$user->id}', '{$player->team}', '{$json}')");
}
?>
