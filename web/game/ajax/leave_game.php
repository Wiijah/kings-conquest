<?php
require_once 'ajax_common.php';

$team = $TEAM_COLOURS[$player->colour];

/* Get room participant and room ID */
$result = $db->query("SELECT * FROM room_participants WHERE user_id != '{$user->id}' AND event = '' AND room_id = '{$room_id}'");
if (!$opp = $result->fetch_object()) {
 exit_error($ERROR_NOT_IG); //Error, not in room
}

/* End the game and set the victor to the opponent */
$db->query("UPDATE rooms SET state = 'ended', winner = '$opp->user_id' WHERE room_id = '{$room_id}'");
$db->query("UPDATE room_participants SET state = 'ended' WHERE room_id = '{$room_id}' AND event = ''");

$out = "{";
$out .= $SUCCESS.",";
$out .= action("game_end",
        jsonPair("winner", 1 - $team)
   .",".jsonStr("reason", "player_left")
      );

$out .= jsonPair("actions", "[{$action}]");
$out .= "}";

oppInsert($out);
echo $out;
?>