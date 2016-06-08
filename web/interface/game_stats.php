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


$result = $db->query("SELECT * FROM users WHERE user_id = '{$room->winner}' AND state = 'ended'");
$opp = $result->fetch_object();

include 'includes/logout_container.php';
include 'includes/logo.php';

require_once 'includes/back_container.php';
?>

<div class="small_container prof_user">

<?php echo genTitle("Game Ended"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><td class="prof_avatar" colspan="2"><img src="images/default_avatar.png" /></td></tr>
<tr><th>Room Name</th><td><?php echo $room->name; ?> </td></tr>
<tr><th>Winner</th><td><?php echo $opp->username; ?> </td></tr>
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