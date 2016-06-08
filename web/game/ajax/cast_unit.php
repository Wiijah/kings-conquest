<?php
require_once 'ajax_common.php';

$caster_id = secureStr($_POST['caster_id']);
$target_id = secureStr($_POST['target_id']);
$target_id2 = secureStr($_POST['target_id2']);

$x = secureStr($_POST['x']) * 1;
$y = secureStr($_POST['y']) * 1;

// get player team
$team = $TEAM_COLOURS[$player->colour];

$AOE = "((x = '{$x}' AND y = '{$y}')
           OR (x = '".($x - 1)."' AND y = '{$y}')
           OR (x = '".($x + 1)."' AND y = '{$y}')
           OR (x = '{$x}' AND y = '".($y + 1)."')
           OR (x = '{$x}' AND y = '".($y - 1)."'))";

//get both units
$result = $db->query("{$SELECT_UNIT} unit_id = '{$caster_id}' AND room_id = '{$room_id}'");
$caster = $result->fetch_object();

if ($target_id > 0) {
  $result = $db->query("{$SELECT_UNIT} unit_id = '{$target_id}' AND room_id = '{$room_id}'");
  $target = $result->fetch_object();
  if (!$target) exit_error(101);
}

$actions = array();
$out = $SUCCESS.",";

if ($caster->skill == "Shield") {
  $actions = array_merge($actions, give_buff($caster, 4, 6));
} else if ($caster->skill == "Battle Cry") {
  $result = $db->query("{$SELECT_UNIT} room_id = '{$room_id}' AND team = '{$team}'");
  while ($fetch = $result->fetch_object()) {
    $db->query("INSERT INTO buff_instances (buff_id, unit_id, turns_left) VALUES ('2', '{$fetch->unit_id}', '6')");
    $actions[] = action("apply_buff",
         jsonPair("buff_id", 2) 
    .",".jsonPair("unit_id", $fetch->unit_id));
  }
} else if ($caster->skill == "Magic Damage") {
  $result = $db->query("{$SELECT_UNIT} room_id = '{$room_id}' AND team != '{$team}' AND {$AOE}");
  while ($fetch = $result->fetch_object()) {
    $actions = array_merge($actions, give_buff($fetch, 5, 6));
    $actions = array_merge($actions, attack_unit($caster, $fetch));
  }
} else if ($caster->skill == "Double Shoot") {
  $result = $db->query("{$SELECT_UNIT} room_id = '{$room_id}' AND team != '{$team}' AND (unit_id = '{$target_id}' OR unit_id = '{$target_id2}')");
  $howMany = $target_id == $target_id2 ? 2 : 1;
  while ($fetch = $result->fetch_object()) {
    for ($i = 0; $i < $howMany; $i++) {
      $actions = array_merge($actions, give_buff($fetch, 3, 6));
      $actions = array_merge($actions, attack_unit($caster, $fetch));
    }
  }
}

$actions[] = update_unit($attacker, 0, 0, 1);


$out .= jsonPair("actions", jsonArray($actions));

$out = "{".$out.", \"debug\": \"{$caster->skill}\"}";
oppInsert($out);
echo $out;
?>