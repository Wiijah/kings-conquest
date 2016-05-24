<?php
/* Output to the user all messages newer than the ID given */

require_once 'ajax_common.php';

$id = secureInt($_POST['id']);

$out = "{";

// output the array of players
$out .= '"players":[';

$result = $db->query("SELECT * FROM room_participants JOIN users ON room_participants.user_id = users.id WHERE room_id = '{$id}' ORDER BY part_id ASC");

$comma = "";
while ($player = $result->fetch_object()) {
  $out .= $comma.'{"player": "'.$player->username.'", "colour": "'.$player->colour.'"}';
  $comma = ",";
}

$out .= "]"; //end of array of players


$out .= "}"; //end of whole JSON object
echo $out;
?>