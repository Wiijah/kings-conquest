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

  create_unit("king", 3, 4, $TEAM_COLOURS['blue']);
  create_unit("knight", 0, 2, $TEAM_COLOURS['red']);
  create_unit("archer", 0, 3, $TEAM_COLOURS['red']);

  /* Blue Team */
  //create_unit("king", 9, 11, $TEAM_COLOURS['blue']);
  create_unit("blue castle", 12, 13, $TEAM_COLOURS['blue']);
  create_unit("wizard", 9, 10, $TEAM_COLOURS['blue']);
  create_unit("knight", 12, 10, $TEAM_COLOURS['blue']);
  create_unit("archer", 12, 11, $TEAM_COLOURS['blue']);
}

function select_unit($unit_id) {
  global $db;
  $result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE unit_id = '{$unit_id}'");
  if (!$result) return false;
  return $result->fetch_object();
}

function jsonUnit($unit) {
  global $db;

  $result = $db->query("SELECT * FROM buff_instances WHERE unit_id = '{$unit->unit_id}'");
  $buffs = "";
  $comma = "";
  while ($buff = $result->fetch_object()) {
    $buffs .= $comma."{$buff->buff_id}";
    $comma = ",";
  }

  return '"'.$unit->unit_id.'": {
      '.jsonStr("address", $unit->address).','.
        jsonStr("spritesheet", $unit->spritesheet).','.
        jsonPair("unit_id", $unit->unit_id).','.
        jsonStr("info", $unit->info).','.
        jsonPair("hp", $unit->hp).','.
        jsonPair("max_hp", $unit->max_hp).','.
        jsonPair("attack", $unit->attack).','.
        jsonStr("skill", $unit->skill).','.
        jsonPair("luck", $unit->luck).','.
        jsonPair("x", $unit->x).','.
        jsonPair("y", $unit->y).','.
        jsonPair("buffs", "[{$buffs}]").','.
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

function give_buff($unit, $buff_id, $turns_left) {
  global $db;
  $actions = array();
  $db->query("INSERT INTO buff_instances (buff_id, unit_id, turns_left) VALUES ('{$buff_id}', '{$unit->unit_id}', '{$turns_left}')");
  $actions[] = action("apply_buff",
       jsonPair("buff_id", $buff_id)
    .",".jsonPair("unit_id", $unit->unit_id));
  return $actions;
}

function attack_unit($attacker, $target) {
  global $db;
  global $user;
  global $team;
  global $room_id;

  $result = $db->query("SELECT * FROM buff_instances WHERE unit_id = '{$target->unit_id}' AND buff_id = 4");
  $shield = $result->fetch_object();

  $actions = array();
  if ($shield) {
    // remove shield
    $db->query("DELETE FROM buff_instances WHERE unit_id = '{$target->unit_id}' AND buff_id = 4");

    $actions[] = action("remove_buff",
         jsonPair("unit_id", $target->unit_id)
      .",".jsonPair("buff_id", $shield->buff_id));
    $out .= jsonPair("actions", jsonArray($actions));
  } else { /* Normal attack */
    // get new health
    $damage = $attacker->attack;

    $crit = rand(1,100) <= ($attacker->luck * 100) ? '1' : '0';
    if ($crit == '1') $damage *= 2;
    
    $new_health = $target->hp - $damage;
    if ($new_health <= 0) { /* Target died */
      $db->query("DELETE FROM units WHERE unit_id = '{$target->unit_id}'");
    } else { /* Target hurt but survived */
      $db->query("UPDATE units SET hp = '{$new_health}' WHERE unit_id = '{$target->unit_id}'");
    }

    $db->query("UPDATE units SET canMove = 0, canAttack = 0, outOfMoves = 1 WHERE unit_id = '{$attacker->unit_id}'"); 

    // notify
    $actions[] = action("attack_unit",
         jsonPair("attacker_id", $attacker->unit_id)
      .",".jsonPair("buffs", "[]")
      .",".jsonPair("target_id", $target->unit_id)
      .",".jsonPair("dmg", $damage)
      .",".jsonPair("is_critical", $crit));

    if ($new_health <= 0 && $target->name == "king") {
      $actions[] = action("game_end", jsonStr("reason", "king_death")
        .",".jsonPair("winner", $team));
      $db->query("UPDATE room_participants SET state = 'ended' WHERE room_id = '{$room_id}' AND event = ''");
      $db->query("UPDATE rooms SET state = 'ended', winner = '$user->id' WHERE room_id = '{$room_id}'");
    }
  } 
  return $actions;
}

function oppInsert($json) {
  global $db;
  global $room_id;
  global $user;
  global $player;
  $team = $player->colour == "red" ? 0 : 1;
  $json = secureStr($json);

  $db->query("INSERT INTO opp (room_id, user_id, team, json) VALUES ('{$room_id}', '{$user->id}', '{$team}', '{$json}')");
}
?>
