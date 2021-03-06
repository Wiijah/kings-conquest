<?php
if (isset($_POST['replay']) && $_POST['replay'] == '1') {
  header('Access-Control-Allow-Origin: *');
  header("Content-Type: application/json; charset=UTF-8");
  require_once '../../common.php';
  $room_id = secureInt($_POST['room_id']);
  $result = $db->query("SELECT * FROM opp WHERE room_id = '{$room_id}' AND init = '1'");
  $fetch = $result->fetch_object();
  die($fetch->json);
}
$spectate_page = true;
require_once 'ajax_common.php';

$out = "{";

$points = $room->map_json;

$out .= jsonPair("main", $points).", ";
$map_object = json_decode($points, true);

$width = count($map_object[0]);
$height = count($map_object);

/* Print map dimensions */
$out .= jsonPair("map_dimensions", "{".jsonPair("width", $width) . ", " . jsonPair("height", $height)."}") . ", ";

/* Print player gold */
$out .= jsonPair("gold", $player->gold).",";
// $result = $db->query("SELECT * FROM room_participants WHERE room_id = '{$room_id}' AND event = '' ORDER BY part_id ASC");
// $i = 0;
// while ($part = $result->fetch_object()) {
//   $i++;
//   $out .= jsonPair("P{$i}currentGold", $part->gold).",";
// }

$countdown = max(0, $room->countdown - time());
$out .= jsonPair("countdown", $countdown).",";

/* Player Info */
$out .= jsonPair("team", $TEAM_COLOURS[$player->colour]).",";
$out .= jsonPair("turn", $room->turn).",";

/* Buffs */
$out .= '"buffEffects": {';
$result = $db->query("SELECT * FROM buffs ORDER BY buff_id ASC");
$comma = "";
while ($buff = $result->fetch_object()) {
  $out .= $comma.jsonStr($buff->buff_name, $buff->graphics);
  $comma = ",";
}
$out .= '}, ';

/* Classes */
$result = $db->query("SELECT * FROM classes ORDER BY class_id ASC");
$out .= '"classStats": {';
$comma = "";
$i = 0;
while ($class = $result->fetch_object()) {
  $out .= $comma.'"'.$i++.'": {';

  $out .=  jsonStr("address", $class->address)
      .",".jsonStr("spritesheet", $class->spritesheet)
      .",".jsonStr("info", $class->info)
      .",".jsonPair("hp", $class->max_hp)
      .",".jsonPair("max_hp", $class->max_hp)
      .",".jsonPair("attack", $class->attack)
      .",".jsonStr("skill", $class->skill)
      .",".jsonPair("luck", $class->luck)
      .",".jsonPair("x", 0)
      .",".jsonPair("y", 0)
      .",".jsonPair("team", "0")
      .",".jsonPair("attackRange", $class->attackRange)
      .",".jsonPair("canMove", 1)
      .",".jsonPair("canAttack", 1)
      .",".jsonPair("outOfMoves", 0)
      .",".jsonPair("skillCoolDown", 0)
      .",".jsonStr("damageEffect", $class->damageEffect);

  $out .= "}";
  $comma = ",";
}
$out .= "}";
/* End classes */

/* Start units */
$out .= ', "characters": {';
$result = $db->query("SELECT * FROM units JOIN classes ON units.class_id = classes.class_id WHERE room_id = {$room_id}");
$comma = "";
while ($unit = $result->fetch_object()) {
  $out .= $comma.jsonUnit($unit);
  $comma = ",";
}
$out .= '}';
/* End units */
  
/* Close JSON with curly brace and print the whole JSON */
$out .= "}";

$result = $db->query("SELECT * FROM opp WHERE room_id = '{$room_id}' AND init = '1'");
if ($result->num_rows == 0) $db->query("INSERT INTO opp (room_id, init, json) VALUES ('{$room_id}', '1', '{$out}')");
echo $out;
?>