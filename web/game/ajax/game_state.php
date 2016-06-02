<?php
require_once 'ajax_common.php';

$out = "{";

/* Print map */
$result = $db->query("SELECT * FROM maps WHERE map_id = 1");
$map = $result->fetch_object();

$out .= jsonPair("main", $map->points).", ";

$map_object = json_decode($map->points, true);
$width = count($map_object[0]);
$height = count($map_object);

/* Print map dimensions */
$out .= jsonPair("map_dimensions", jsonPair("width", $width) . ", " . jsonPair("height", $height)) . ", ";

/* Print player information */
$result = $db->query("SELECT * FROM room_participants WHERE room_id = '{$room_id}' AND event = '' ORDER BY part_id ASC");
$i = 0;
while ($part = $result->fetch_object()) {
  $i++;
  $out .= jsonPair("P{$i}currentGold", $part->gold).",";
}

/* Buffs */
$out .= '"buffs": [';
$result = $db->query("SELECT * FROM buffs ORDER BY buff_id ASC");
while ($buff = $result->fetch_object()) {
  $out .= jsonStr($buff->buff_name, $buff->graphics);
}
$out .= '], ';

/* Classes */
$result = $db->query("SELECT * FROM classes ORDER BY class_id ASC");
$out .= '"classStats": [';
while ($class = $result->fetch_object()) {
  $out .= "{";

  $out .=  jsonStr("address", $class->address)
          .jsonStr("spritesheet", $class->spritesheet)
          .jsonStr("info", $class->info)
          .jsonPair("hp", $class->max_hp)
          .jsonPair("max_hp", $class->max_hp)
          .jsonPair("attack", $class->attack)
          .jsonStr("skill", $class->skill)
          .jsonPair("luck", $class->luck)
          .jsonPair("x", 0)
          .jsonPair("y", 0)
          .jsonPair("team", "0")
          .jsonPair("attackRange", $class->attackRange)
          .jsonPair("canMove", 1)
          .jsonPair("canAttack", 1)
          .jsonPair("outOfMoves", 0)
          .jsonPair("skillCoolDown", 0)
          .jsonPair("damageEffect", $class->damageEffect);

  $out .= "}";
}
$out .= "]";
/* End classes */

/* Start units */
$out .= ', "characters": [';
$result = $db->query("SELECT * FROM units WHERE room_id = {$room_id}");

$out .= ']';
/* End units */
  
/* Close JSON with curly brace and print the whole JSON */
$out .= "}";
echo $out;
?>