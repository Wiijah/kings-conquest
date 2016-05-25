<?php
/* Output to the user all messages newer than the ID given */

require_once 'ajax_common.php';

// Delete old messages
$db->query("DELETE FROM chat WHERE created < (NOW() - INTERVAL 1 DAY)");

$id = secureInt($_POST['id']);
$room_id = secureInt($_POST['room']);

$out = "[";

$query = "SELECT * FROM chat INNER JOIN users ON chat.user = users.id WHERE chat_id > '{$id}' AND room_id = '{$room_id}' ORDER BY id ASC";
$result = $db->query($query);
while ($fetch = $result->fetch_object()) {
  $message = $fetch->message;

  if ($out != "[") $out .= ",";
  $out .= '{
   "id":"'.$fetch->chat_id.'",
   "username":"'.$fetch->username.'",
   "message":"'.$message.'",
   "chat_type":"'.$fetch->chat_type.'"
    }
  ';
}
$out .= "]";

echo $out;
?>