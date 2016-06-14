<?php
/* Create a new room */
require_once 'ajax_common.php';

$map_name = trim($_POST['map_name']);

if (!isStrLenCorrect($map_name, 3, 20)) {
  kc_error("Your map name must be 3 to 20 characters long and must not start or end with a space.");
}

$map_name = secureStr($map_name);

$result = $db->query("SELECT * FROM maps WHERE map_name = '{$map_name}'");

if ($result->num_rows > 0) {
  kc_error("The map name you entered was already taken. Please pick another map name.");
}

$points = '
{"0": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "1": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "2": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "3": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "4": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "5": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "6": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "7": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "8": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "9": [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "10":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "11":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 "12":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
}';

$db->query("INSERT INTO maps (map_name, points, user_id, last_modified) VALUES
    ('{$map_name}', '{$points}', '{$user->id}', '".time()."')");
echo '{"map_id": '.$db->insert_id.'}';
?>