<?php

require_once '../../interface/includes/lib.php';

/* Team enumerations */
$TEAM_COLOURS = array("red" => 0, "blue" => 1, "spectator" => -1);
$TEAM_RED = 0;
$TEAM_BLUE = 1;

$SELECT_UNIT = "SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE";



function triggerBufferJson($buff_effect, $unit_id, $health_change) {
  return '{"action_type" : "trigger_buff",
    "buff_effect" : "'.$buff_effect.'",
    "unit_id" : '.$unit_id.',
    "health_change" : '.$health_change.'
  }';
}



function aoe($x, $y) {
  return "((x = '{$x}' AND y = '{$y}')
           OR (x = '".($x - 1)."' AND y = '{$y}')
           OR (x = '".($x + 1)."' AND y = '{$y}')
           OR (x = '{$x}' AND y = '".($y + 1)."')
           OR (x = '{$x}' AND y = '".($y - 1)."'))";
}

function totem($x, $y) {
  return "(x >= '".($x - 1)."' AND y >= '".($y - 1)."' AND x <= '".($x + 1)."' AND y <= '".($y + 1)."')";
}

function update_unit($unit, $canMove = -1, $canAttack = -1, $outOfMoves = -1, $skillCoolDown = -1) {
  global $db;

  if (!$unit) {
    return '{"action_type" : "nothing"}';
  }
  if ($canMove == -1) $canMove = $unit->canMove;
  if ($canAttack == -1) $canAttack = $unit->canAttack;
  if ($outOfMoves == -1) $outOfMoves = $unit->outOfMoves;
  if ($skillCoolDown == -1) $skillCoolDown = $unit->skillCoolDown;

  $db->query("UPDATE units SET canMove = {$canMove}, canAttack = {$canAttack}, outOfMoves = {$outOfMoves}, skillCoolDown = {$skillCoolDown} WHERE unit_id = '{$unit->unit_id}'");

  return '{ "action_type" : "update_unit",
    "unit_id" : '.$unit->unit_id.',
    "canMove" : '.$canMove.',
    "canAttack" : '.$canAttack.',
    "outOfMoves" : '.$outOfMoves.',
    "skillCoolDown" : '.$skillCoolDown.'}';
}

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
  global $room;

  if ($room->map_id == 1) {
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
  } else {

    /* Red Team */
    create_unit("king", 11, 2, $TEAM_COLOURS['red']);
    create_unit("red castle", 11, 1, $TEAM_COLOURS['red']);
    /* Blue Team */
    create_unit("king", 2, 11, $TEAM_COLOURS['blue']);
    create_unit("blue castle", 1, 11, $TEAM_COLOURS['blue']);
  }
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
        jsonStr("move", $unit->move).','.
        jsonPair("unit_id", $unit->unit_id).','.
        jsonStr("info", $unit->info).','.
        jsonPair("hp", $unit->hp).','.
        jsonPair("max_hp", $unit->max_hp).','.
        jsonPair("attack", $unit->attack).','.
        jsonStr("skill", $unit->skill).','.
        jsonPair("luck", $unit->luck).','.
        jsonPair("commandable", $unit->commandable).','.
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

function select_unit($unit_id) {
  global $db;
  global $room_id;
  global $TEAM_COLOURS;
  global $SELECT_UNIT;
  $result = $db->query("{$SELECT_UNIT} unit_id = '{$unit_id}' AND room_id = '{$room_id}'");
  return $result->fetch_object();
}

function give_gold($part, $gold) {
  global $db, $TEAM_COLOURS;
  $part->gold += $gold;
  $db->query("UPDATE room_participants SET gold = {$part->gold} WHERE part_id = {$part->part_id}");
  return '{"action_type" : "update_gold", "gold" : '.$part->gold.', "team" : '.$TEAM_COLOURS[$part->colour].'}';
}

function give_buff($unit, $buff_id, $turns_left) {
  global $db;
  global $room_id;
  $unit = select_unit($unit->unit_id);
  if (!$unit) return array();
  if ($unit->commandable == 0) return array();

  $actions = array();
  $result = $db->query("SELECT * FROM buff_instances WHERE buff_id = '{$buff_id}' AND unit_id = '{$unit->unit_id}'");
  if ($result->num_rows == 0) {
    $db->query("INSERT INTO buff_instances (buff_id, unit_id, turns_left, room_id) VALUES ('{$buff_id}', '{$unit->unit_id}', '{$turns_left}', '{$room_id}')");
  } else {
    $db->query("UPDATE buff_instances SET turns_left = '{$turns_left}' WHERE buff_id = '{$buff_id}' AND unit_id = '{$unit->unit_id}'");
  }
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
  global $player;

  /* Refresh target */
  $target = select_unit($target->unit_id);
  if (!$target) return array(); //already dead

  $result = $db->query("SELECT * FROM buff_instances WHERE unit_id = '{$target->unit_id}' AND buff_id = 4");
  $shield = $result->fetch_object();

  $actions = array();
  if ($shield) {
    // remove shield
    $db->query("DELETE FROM buff_instances WHERE unit_id = '{$target->unit_id}' AND buff_id = 4");

    $actions[] = action("remove_buff",
         jsonPair("unit_id", $target->unit_id)
      .",".jsonPair("buff_id", $shield->buff_id));
  } else { /* Normal attack */
    // get new health
    $damage = $attacker->attack;


    $result = $db->query("SELECT * FROM buff_instances WHERE unit_id = '{$attacker->unit_id}' AND buff_id = 2");
    $battle_cry = $result->fetch_object();
    if ($battle_cry) $damage = ceil($damage * 1.2);

    $result = $db->query("SELECT * FROM buff_instances WHERE unit_id = '{$attacker->unit_id}' AND buff_id = 3");
    $exhaust = $result->fetch_object();
    if ($exhaust) $damage = ceil($damage * 0.8);

    $crit = rand(1,100) <= ($attacker->luck * 100) ? '1' : '0';
    if ($crit == '1') $damage *= 2;
    
    $new_health = $target->hp - $damage;
    if ($new_health <= 0) { /* Target died */
      $db->query("DELETE FROM units WHERE unit_id = '{$target->unit_id}'");
      $db->query("UPDATE room_participants SET unit_kills = unit_kills + 1 WHERE part_id = '{$player->part_id}'");
    } else { /* Target hurt but survived */
      $db->query("UPDATE units SET hp = '{$new_health}' WHERE unit_id = '{$target->unit_id}'");
    }

    // notify
    $actions[] = action("attack_unit",
         jsonPair("attacker_id", $attacker->unit_id)
      .",".jsonPair("buffs", "[]")
      .",".jsonPair("target_id", $target->unit_id)
      .",".jsonPair("dmg", $damage)
      .",".jsonPair("is_critical", $crit));

    if ($new_health <= 0 && $target->name == "king") {
      $opp_id = get_opponent_id();
      $result = $db->query("SELECT * FROM users WHERE id = '{$opp_id}'");
      $opp = $result->fetch_object();
      $actions = array_merge($actions, gameEnd($user, $opp, "king_death"));
    }
  } 
  return $actions;
}

function damageByBuff($buff, $target, $damage) {
  global $db, $room_id, $part_id;
  $result = $db->query("SELECT * FROM buff_instances WHERE unit_id = '{$target->unit_id}' AND buff_id = 4");
  $shield = $result->fetch_object();

  $actions = array();
  if ($shield) {
    $damage = 0;
    // remove shield
    $db->query("DELETE FROM buff_instances WHERE unit_id = '{$target->unit_id}' AND buff_id = 4");

    $actions[] = action("remove_buff",
         jsonPair("unit_id", $target->unit_id)
      .",".jsonPair("buff_id", $shield->buff_id));
  } else { /* no shield */
    $new_health = $target->hp - $damage;

    if ($new_health <= 0) { /* Target died */
      $db->query("DELETE FROM units WHERE unit_id = '{$target->unit_id}'");
      $db->query("UPDATE room_participants SET unit_kills = unit_kills + 1 WHERE part_id = '{$player->part_id}'");
    } else { /* Target hurt but survived */
      $db->query("UPDATE units SET hp = '{$new_health}' WHERE unit_id = '{$target->unit_id}'");
    }

    if ($new_health <= 0 && $target->name == "king") {
      $opp_id = get_opponent_id();
      $result = $db->query("SELECT * FROM users WHERE id = '{$opp_id}'");
      $opp = $result->fetch_object();
      $actions = array_merge($actions, gameEnd($user, $opp, "king_death"));
    }
  } 
  $actions[] = triggerBufferJson(ucfirst($buff->buff_name), $target->unit_id, 0 - $damage);
  return $actions;
}

function get_opponent_id() {
  global $db, $user, $room_id;
  $result = $db->query("SELECT * FROM room_participants WHERE user_id != '{$user->id}' AND room_id = '{$room_id}'");
  $opp = $result->fetch_object();
  return $opp->user_id;
}

function gameEnd($winner, $loser, $reason) {
  global $db;
  global $room_id;
  global $TEAM_COLOURS;

  $actions = array();

  /* Get winner info */
  $result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$winner->id}' AND room_id = '{$room_id}'");
  $winner_part = $result->fetch_object();

  $result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$loser->id}' AND room_id = '{$room_id}'");
  $loser_part = $result->fetch_object();

  $winner_team = $TEAM_COLOURS[$winner_part->colour];

  $actions[] = action("game_end", jsonStr("reason", $reason)
        .",".jsonPair("winner", $winner_team));

  /* ELO */
  $chance_win = abs((1 / (1 + pow(10, (($loser->elo - $winner->elo) / 400)))) * 100);
  $chance_lose = abs(100 - $chance_win);

  $elo_won = round(32 * ($chance_lose / 100));
  $elo_lost = $elo_won;
  

  /* Update room and room participants */
  $db->query("UPDATE room_participants SET event = 'ended' WHERE room_id = '{$room_id}' AND event = ''");
  $db->query("UPDATE rooms SET state = 'ended', winner = '$winner->id', elo_won = {$elo_won}, elo_lost = {$elo_lost} WHERE room_id = '{$room_id}'");

  /* Update user profiles */
  $db->query("UPDATE users SET wins = wins + 1, kp = kp + 1000, elo = elo + {$elo_won} WHERE id = '{$winner->id}'");
  $db->query("UPDATE users SET losses = losses + 1, kp = kp + 300, elo = elo - {$elo_lost} WHERE id = '{$loser->id}'");

  /* Give achievements if appropriate */
  if ($winner->wins == 0) giveAch("first_win", $winner, $room_id);
  if ($loser->losses == 0) giveAch("first_lost", $loser, $room_id);
  if ($winner->wins == 49) giveAch("50_wins", $winner, $room_id);
  if ($winner->wins == 99) giveAch("100_wins", $winner, $room_id);
  if ($loser_part->unit_kills == 0) giveAch("perfect_win", $winner, $room_id);

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
