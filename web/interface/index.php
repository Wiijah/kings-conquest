<?php
$title = "Lobby";
require_once 'includes/header_checks.php';

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = '' ORDER BY part_id DESC LIMIT 1");
if ($part = $result->fetch_object()) {
  $result = $db->query("SELECT * FROM rooms INNER JOIN users ON rooms.user_id = users.id WHERE room_id = '{$part->room_id}'");
  if ($room = $result->fetch_object()) {
    if ($room->state == 'ingame') {
      header ("Location: ../game/");
      die();
    } else if ($room->state == 'pregame') {
      header ("Location: room");
      die();
    }
  }
  /* Otherwise, invalid part id, so remove it. */
  $db->query("DELETE FROM room_participants WHERE part_id = '{$part->part_id}'");
}


include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';

if ($user->tutorial == 0) {
  $db->query("UPDATE users SET tutorial = 1 WHERE id = {$user->id}");
  echo '<script>lightbox_open("tutorial");</script>';
}
?>
<script>
<!--
var room_id = 0;
-->
</script>
<script src="js/chatroom.js"></script>
<script src="js/lobby.js"></script>

<div class="small_container">
<div class="play_left">

<?php echo genTitle("Lobby Chat"); ?>
<div class="play_chatroom box">
<div id="play_chatroom_messages">
</div> <!-- play_chatroom_messages -->
<div class="play_chatroom_footer">
<input type="text" id="play_chatroom_msg" placeholder="Type your message here and press enter to send." />
</div>
</div> <!-- play_chatroom -->



<?php echo genTitle("Join A Game"); ?>
<div class="play_lobby box">
<table class="play_table lobby" id="rooms">
<tr><th>Room Owner</th><th>Map</th><th>Mode</th><th>Join</th></tr>
</table>
</div> <!-- play_lobby box -->
</div> <!-- play_left -->

<div class="play_right">

<?php echo genTitle("Actions"); ?>
<div class="play_btn btn lightbox_open" data-lb="create_game">Create Game</div>
<div class="play_btn btn js_link" data-href="tutorials">Tutorials</div>
<div class="play_btn btn" id="goto_friends">Friends</div>
<!--<div class="play_btn btn lightbox_open" data-lb="achievements">Achievements</div>-->
<div class="play_btn btn js_link" data-href="shop">Shop</div>
<div class="play_btn btn js_link" data-href="leaderboard">Leaderboard</div>
<div class="play_btn btn js_link" data-href="custom_maps">Custom Maps</div>
<div class="play_btn btn js_link" data-href="match_history">Match History</div>


<?php echo genTitle("Your Profile"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><td class="play_avatar" colspan="2"><img src="<?php echo getAvatarURL($user->id); ?>" />
<br />

<div class='btn lightbox_btn js_link' data-href='avatar'>Customise Avatar</div>
<?php
if ($user->member_type != 'guest') {
  echo "<div class='btn lightbox_btn js_link' data-href='settings'>Account Settings</div>";
}
?>
</td></tr>
<?php echo genProf($user); ?>
</table>
</div> <!-- play_profile box -->


<br />
<?php
$ach_html = getAchievementsHTML($user);
if ($ach_html == "") $ach_html = "You have not yet earned any achievements.";
echo genTitle("Achievements");
?>
<div class="play_profile box center achievements">
<?php echo $ach_html; ?>

</div> <!-- play_right -->

</div> <!-- play_container -->

<?php include 'includes/footer.php'; ?>