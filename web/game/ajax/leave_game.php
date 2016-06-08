<?php
require_once 'ajax_common.php';

$team = $TEAM_COLOURS[$player->colour];

/* Get room participant and room ID */
$result = $db->query("SELECT * FROM room_participants WHERE user_id != '{$user->id}' AND event = '' AND room_id = '{$room_id}'");
if (!$opp = $result->fetch_object()) {
 exit_error($ERROR_NOT_IG); //Error, not in room
}

$actions = array();

/* End game */
$opp_id = get_opponent_id();
$result = $db->query("SELECT * FROM users WHERE id = '{$opp_id}'");
$opp = $result->fetch_object();
$actions = array_merge($actions, gameEnd($opp, $user, "quit_game"));

$out = "{";
$out .= $SUCCESS.",";
$out .= jsonPair("actions", jsonArray($actions));
$out .= "}";
oppInsert($out);
echo $out;
?>