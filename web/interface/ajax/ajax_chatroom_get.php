<?php
/* Output to the user all messages newer than the ID given */

require_once 'ajax_common.php';
header("Content-Type: application/json; charset=UTF-8");

$id = secureInt($_POST['id']);

$out = "[";

$query = "SELECT * FROM chat INNER JOIN users ON chat.user = users.id WHERE chat_id > '{$id}' ORDER BY id ASC";
$result = $db->query($query);
while ($fetch = $result->fetch_object()) {
  $message = $fetch->message;

  if ($out != "[") $out .= ",";
  $out .= '{
   "id":"'.$fetch->chat_id.'",
   "username":"'.$fetch->username.'",
   "message":"'.$message.'"}
  ';
}
$out .= "]";

echo $out;
?>