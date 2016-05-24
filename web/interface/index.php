<?php
$title = "Lobby";
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
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
<div class="play_btn btn">How To Play</div>
<div class="play_btn btn">Options</div>
<div class="play_btn btn">Highscores</div>


<?php echo genTitle("Your Profile"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><td class="play_avatar" colspan="2"><img src="images/default_avatar.png" /></td></tr>
<tr><th>Username</th><td><?php echo $user->username; ?> </td></tr>

<tr><th>Email</th><td><?php echo $user->email; ?> </td></tr>
<tr><th>Games Won</th><td><?php echo number_format($user->wins); ?> </td></tr>
<tr><th>Games Lost</th><td><?php echo number_format($user->losses); ?> </td></tr>
<tr><th>Win/Loss Ratio</th><td><?php echo ratio($user->wins, $user->losses); ?> </td></tr>
<tr><th>Sign Up Date</th><td><?php echo formatSQLDate($user->created); ?> </td></tr>
</table>
</div> <!-- play_profile box -->

</div> <!-- play_right -->

</div> <!-- play_container -->

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>