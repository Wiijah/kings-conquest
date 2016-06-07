<?php
require_once 'ajax_common.php';

/* Get room participant and room ID */
$result = $db->query("SELECT * FROM room_participants WHERE user_id != '{$user->id}' AND event = '' AND room_id = '{$room_id}'");
if (!$opp = $result->fetch_object()) {
 exit_error($ERROR_NOT_IG); //Error, not in room
}

/* End the game and set the victor to the opponent */
$db->query("UPDATE rooms SET state = 'ended', winner = '$opp->user_id' WHERE room_id = '{$room_id}'");

$out = "{";
$out .= $SUCCESS.",";
$out .= action("game_end",
        jsonPair("team", $team)
      );
$out .= "}";

oppInsert($out);
echo $out;
?>