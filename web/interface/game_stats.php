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

$result = $db->query("SELECT * FROM room_participants WHERE user_id != {$winner->id} AND room_id = {$room_id} AND event = ''");
$loser_part = $result->fetch_object();

$result = $db->query("SELECT * FROM users WHERE id = '{$loser_part->user_id}'");
$loser = $result->fetch_object();

include 'includes/logout_container.php';
include 'includes/logo.php';

require_once 'includes/back_container.php';
?>

<div class="small_container prof_user">

<?php echo genTitle("Game Ended"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><td class="prof_avatar" colspan="2"><img src="images/default_avatar.png" /></td></tr>
<tr><th>Room Name</th><td><?php echo $room->name; ?></td></tr>
</table>
</div><br />

<?php echo genTitle("Winner"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><th>Username</th><td><?php echo $winner->username; ?></td></tr>
<tr><th>ELO Gained</th><td><?php echo $room->elo_won; ?></td></tr>
<tr><th>King Points Gained</th><td>1,000</td></tr>
</table>
</div> <br />

<?php echo genTitle("Loser"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><th>Username</th><td><?php linkUsername($loser); ?></td></tr>
<tr><th>ELO Lost</th><td><?php echo $room->elo_lost; ?></td></tr>
<tr><th>King Points Gained</th><td>300</td></tr>
</table>
</div> <!-- play_profile box -->

</div> <!-- small_container -->

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>