<?php
/* Create a new room */
require_once 'ajax_common.php';

$map_id = secureInt($_POST['map_id']);
$map_points = secureStr($_POST['points']);
$map_name = trim($_POST['map_name']);


$red_king = secureStr($_POST['red_king']);
$red_castle = secureStr($_POST['red_castle']);

$blue_king = secureStr($_POST['blue_king']);
$blue_castle = secureStr($_POST['blue_castle']);

$points = json_decode($_POST['points'], true);

$result = $db->query("SELECT * FROM maps WHERE user_id = '{$user->id}' AND map_id = '{$map_id}'");
if ($result->num_rows == 0) {
  kc_error("Invalid map.");
}

if (!isStrLenCorrect($map_name, 3, 20)) {
  kc_error("Your map name must be 3 to 20 characters long and must not start or end with a space.");
}

$map_name = secureStr($map_name);

$result = $db->query("SELECT * FROM maps WHERE map_name = '{$map_name}'");
$fetch = $result->fetch_object();
if ($fetch && $fetch->map_id != $map_id) {
  kc_error("The map name you entered was already taken. Please pick another map name.");
}

$db->query("UPDATE maps SET map_name = '{$map_name}', points = '{$map_points}', last_modified = '".time()."', red_king = '{$red_king}', red_castle = '{$red_castle}', blue_king = '{$blue_king}', blue_castle = '{$blue_castle}' WHERE map_id = '{$map_id}'");
echo $AJAX_SUCCESS;
?>