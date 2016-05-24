<?php
$title = "Room";
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';

$result = $db->query("SELECT * FROM game_participants WHERE user = '{$user->id}'");
if (!$participant = $result->fetch_object()) {
  header ("Location: index");
  die();
}

$result = $db->query("SELECT * FROM games INNER JOIN users ON games.user = users.id WHERE game_id = '{$participant->game_id}'");
if (!$room = $result->fetch_object()) {
  header ("Location: index");
  die();
}

$max_players = 2;

$isOwner = $room->user = $user->id;
?>

<div class="small_container">

<div class="play_left">

<?php echo genTitle("Room Chat"); ?>
<div class="play_chatroom box">
<div id="play_chatroom_messages">
<?php
for ($i = 0; $i < 50; $i++) {
  //echo "<span class='play_chatroom_user'>xXDragonSlayer52:</span> <span class='play_chatroom_text'>Hello everyone! I am a new player!</span><br />";
}
?>
</div> <!-- play_chatroom_messages -->
<div class="play_chatroom_footer">
<input type="text" id="play_chatroom_msg" placeholder="Type your message here and press enter to send." />
</div>
</div> <!-- play_chatroom -->



<?php echo genTitle("Players In Room"); ?>
<div class="box room_players_box">
<table class="play_table">
<tr><th>#</th><th>Player</th><th>Colour</th></tr>
<?php
$result = $db->query("SELECT * FROM game_participants JOIN users ON game_participants.user = users.id WHERE game_id = '{$room->game_id}' ORDER BY id ASC");
$i = 0;
while ($player = $result->fetch_object()) {
  $i++;
  echo "<tr><td>{$i}</td><td>{$player->username}</td><td>{$player->colour}</td></tr>";
}
?>
</table>
</div> <!-- play_lobby box -->
</div> <!-- play_left -->

<div class="play_right">
<?php echo genTitle("Game Info"); ?>
<div class="room_data box small_box">
<table class="play_table">
<tr><td class="play_avatar" colspan="2"><img src="images/default_avatar.png" /></td></tr>
<tr><th>Game Name</th><td><?php echo $room->name; ?></td></tr>
<tr><th>Room Owner</th><td><?php echo $room->username; ?></td></tr>
<tr><th>Map</th><td>Dark Forest</td></tr>
<tr><th>Mode</th><td>Regicide</td></tr>
<tr><th>Players</th><td>1/2</td></tr>
</table>
</div> <!-- play_profile box -->


<?php echo genTitle("Actions"); ?>

<?php
if ($isOwner) {
  echo "<div class='play_btn btn'>Start</div>";
} else {
  echo "<div class='play_btn btn'>Ready</div>";
}
?>
<div class="play_btn btn">Leave Room</div>


</div> <!-- play_right -->

</div> <!-- play_container -->

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>