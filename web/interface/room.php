<?php
$title = "Room";
require_once 'includes/header_checks.php';

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = ''");
if (!$part = $result->fetch_object()) {
  header ("Location: index");
  die();
}

$result = $db->query("SELECT * FROM rooms INNER JOIN users ON rooms.user_id = users.id WHERE room_id = '{$part->room_id}'");
if (!$room = $result->fetch_object()) {
  header ("Location: index");
  die();
}

if ($room->state == 'ingame') {
  header ("Location: ../game/");
  die();
}


include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';

$max_players = 2;

$isOwner = $room->user_id == $user->id;
?>
<script>
var room_id = <?php echo $room->room_id; ?>;
var max_players = <?php echo $max_players; ?>;
var isOwner = <?php var_export($isOwner); ?>;
</script>
<script src="js/chatroom.js"></script>
<script src="js/room.js"></script>
<div class="small_container">

<div class="play_left">

<?php echo genTitle("Room Chat"); ?>
<div class="play_chatroom box">
<div id="play_chatroom_messages">

</div> <!-- play_chatroom_messages -->
<div class="play_chatroom_footer">
<input type="text" id="play_chatroom_msg" placeholder="Type your message here and press enter to send." />
</div>
</div> <!-- play_chatroom -->



<?php echo genTitle("Players In Room"); ?>
<div class="box room_players_box">
<table class="play_table" id="room_players">
<tr><th>#</th><th>Player</th><th>Colour</th></tr>
</table>
</div> <!-- play_lobby box -->
</div> <!-- play_left -->

<div class="play_right">
<?php echo genTitle("Game Info"); ?>
<div class="room_data box small_box">
<table class="play_table">
<tr><td class="play_avatar" colspan="2"><img src="images/the_bridge.png" /></td></tr>
<tr><th>Game Name</th><td><?php echo secureOutput($room->name); ?></td></tr>
<tr><th>Room Owner</th><td><?php echo $room->username; ?></td></tr>
<tr><th>Map</th><td>The Bridge</td></tr>
<tr><th>Mode</th><td>Regicide</td></tr>
<tr><th>Players</th><td id="info_num_players">1/2</td></tr>
</table>
</div> <!-- play_profile box -->


<?php echo genTitle("Actions"); ?>

<?php
if ($isOwner) {
  echo "<div class='play_btn btn' id='btn_start'>Start</div>";
} else {
  if ($part->state == 'ready') {
    echo "<div class='play_btn btn' id='btn_ready' data-ready='ready'>Ready</div>";
  } else {
    echo "<div class='play_btn btn' id='btn_ready' data-ready='notready'>Cancel Ready</div>";
  }
}
?>
<div class="play_btn btn" id="btn_leave">Leave Room</div>


</div> <!-- play_right -->

</div> <!-- play_container -->

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>