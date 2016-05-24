<?php
/* Output lobby games */
require_once 'ajax_common.php';

$id = secureInt($_POST['id']);

$out = "{";

// output the array of players
$out .= '"rooms":[';

$result = $db->query("SELECT * FROM rooms INNER JOIN users ON rooms.user_id = users.id ORDER BY rooms.created DESC");

$comma = "";
while ($room = $result->fetch_object()) {
  $out .= $comma.'{"player": "'.$room->username.'", "room_id": "'.$room->room_id.'"}';
  $comma = ",";
}

$out .= "]"; //end of array of players


$out .= "}"; //end of whole JSON object
echo $out;
?>