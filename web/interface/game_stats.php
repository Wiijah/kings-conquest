<?php
$title = "Game Ended";
require_once 'includes/header_checks.php';

$room_id = secureStr($_GET['room_id']);
$result = $db->query("SELECT * FROM rooms WHERE room_id = '{$room_id}' AND state = 'ended'");
$room = $result->fetch_object();

if (!$room) {
  header ("Location: ../{$LOGGEDIN_DIR}/");
  die();
}

include 'includes/header.php';

$result = $db->query("SELECT * FROM users WHERE id = '{$room->winner}'");
$winner = $result->fetch_object();

$result = $db->query("SELECT * FROM room_participants WHERE user_id = {$winner->id} AND room_id = {$room_id} AND event = 'ended'");
$winner_part = $result->fetch_object();

$result = $db->query("SELECT * FROM room_participants WHERE user_id != {$winner->id} AND room_id = {$room_id} AND event = 'ended' AND colour != 'spectator'");
$loser_part = $result->fetch_object();

$result = $db->query("SELECT * FROM users WHERE id = '{$loser_part->user_id}'");
$loser = $result->fetch_object();

include 'includes/logout_container.php';
include 'includes/logo.php';

require_once 'includes/back_container.php';
?>

<div class="small_container friends_container">

<?php
echo genBreadcrumbs(array("Lobby|index", "End Game Stats"));
echo genTitle("End Game Stats");

$ach_html = getAchievementsHTML($user, $room->room_id);
if ($ach_html != "") {
  echo '<script>
lightbox_alert("Achievement Earned!", "From this game, you have earned the following achievements:<br /><br />'.$ach_html.'");</script>';
}
?>
<div class="box">
<table class="play_table">
<tr>
<td class="prof_avatar" colspan="2">
<img src="images/the_bridge.png" />
<br />
<div class='btn lightbox_btn js_link' data-href='../game/?replay=<?php echo $room->room_id; ?>'>Watch Replay</div>
</td>
</tr>

<tr><th style='width: 50%'>Room Name</th><td><?php echo secureOutput($room->name); ?></td></tr>
<tr><th>Map</th><td>The Bridge</td></tr>
<tr><th>Number of Players</th><td>2</td></tr>
</table>
</div><br />

<?php echo genTitle("Winner"); ?>
<div class="box">
<table class="play_table">
<tr><td class="prof_avatar" colspan="2"><img src="<?php echo getAvatarURL($winner->id); ?>" /></td></tr>
<tr><th style='width: 50%'>Username</th><td><?php echo linkUsername($winner); ?></td></tr>
<tr><th>ELO Gained</th><td><?php echo $room->elo_won; ?></td></tr>
<tr><th>King Points Gained</th><td>1,000</td></tr>
<tr><th>Unit Kills</th><td><?php echo $winner_part->unit_kills; ?></td></tr>
<tr><th>Unit Deaths</th><td><?php echo $loser_part->unit_kills; ?></td></tr>
</table>
</div> <br />

<?php echo genTitle("Loser"); ?>
<div class="box">
<table class="play_table">
<tr><td class="prof_avatar" colspan="2"><img src="<?php echo getAvatarURL($loser->id); ?>" /></td></tr>
<tr><th style='width: 50%'>Username</th><td><?php echo linkUsername($loser); ?></td></tr>
<tr><th>ELO Lost</th><td><?php echo $room->elo_lost; ?></td></tr>
<tr><th>King Points Gained</th><td>300</td></tr>
<tr><th>Unit Kills</th><td><?php echo $loser_part->unit_kills; ?></td></tr>
<tr><th>Unit Deaths</th><td><?php echo $winner_part->unit_kills; ?></td></tr>
</table>
</div> <!-- play_profile box -->

</div> <!-- small_container -->

<?php include 'includes/footer.php'; ?>