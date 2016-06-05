<?php
require_once 'ajax_common.php';
/* Get basic data */
$opp_id = secureStr($_POST['opp_id']);

for ($i = 0; $i < 360; $i++) {
  $result = $db->query("SELECT * FROM opp WHERE opp_id >= '{$opp_id}' AND room_id = '{$room_id}' AND user_id != '{$user->id}' ORDER BY opp_id ASC LIMIT 0,1");
  if ($result->num_rows == 0) {
    usleep(500000);
    continue;
  }
  $fetch = $result->fetch_object();
  $out = "{" .
         jsonPair("error_code", 0).",".
         jsonPair("opp_id", $fetch->opp_id).",".
         jsonPair("user_id", $fetch->user_id).",".
         jsonPair("json", stripslashes($fetch->json)).
        "}";
  $db->query("DELETE FROM opp WHERE opp_id = '{$fetch->opp_id}'");
  die($out);
}
exit_error($ERROR_TIMEOUT);
?>