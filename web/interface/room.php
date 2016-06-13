<?php
$title = "Room";
$hide_footer_links = true;
require_once 'includes/header_checks.php';

$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = '' ORDER BY room_id DESC LIMIT 1");
if (!$part = $result->fetch_object()) {
  header ("Location: index");
  die();
}

$result = $db->query("SELECT * FROM rooms INNER JOIN users ON rooms.user_id = users.id JOIN maps USING (map_id) WHERE room_id = '{$part->room_id}'");
if (!$room = $result->fetch_object()) {
  header ("Location: index");
  die();
}

if ($room->state == 'ingame') {
  header ("Location: ../game/");
  die();
}
if ($room->state != 'pregame') {
  header ("Location: index");
  die();
}


include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';

$max_players = 2;

$isOwner = $room->user_id == $user->id;

$maps = "";
$result = $db->query("SELECT * FROM maps ORDER BY map_id ASC");
while ($fetch = $result->fetch_object()) {
  $selected = $fetch->map_id == $room->map_id ? " selected" : "";
  $maps .= "<option value='{$fetch->map_id}'{$selected}>{$fetch->map_name}</option>";
}

$countdowns = "";
foreach ($COUNTDOWNS as $value) {
  $selected = $room->default_countdown == $value ? " selected" : "";
  $countdowns .= "<option value='{$value}'{$selected}>{$value} seconds</option>";  
}

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
<br />
<?php echo genTitle("Spectators In Room"); ?>
<div class="box room_players_box">
<table class="play_table" id="room_spectators">
<tr><th>#</th><th>Player</th></tr>
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

<?php
if ($isOwner) {
?>
<tr><th>Map</th><td><select id="select_map" class="text"><?php echo $maps; ?></select></td></tr>
<tr><th>Time Limit Per Turn</th><td><select id="select_countdown" class="text"><?php echo $countdowns; ?></select></td></tr>
<?php
} else {
?>
<tr><th>Map</th><td id="map"><?php echo $room->map_name; ?></td></tr>
<tr><th>Time Limit Per Turn</th><td id="countdown"><?php echo $room->default_countdown; ?> seconds</td></tr>
<?php
}
?>
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

<?php include 'includes/footer.php'; ?>