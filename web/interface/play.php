<?php
$title = "Game Lobby";
include 'header.php';
?>
<body>
<?php
include 'logout_container.php';
?>
<img src="images/small_top.png" class="small_top" />
<div class="small_top_subtitle">Turn-based Fantasy Multiplayer Game</div>



<div class="small_top_margin"></div>

<div class="play_container">

<div class="play_left">
<div class="play_lobby box">
<table class="play_table">
<tr><th>Room Owner</th><th>Map</th><th>Mode</th><th>Join</th></tr>
<?php
$result = $db->query("SELECT * FROM games INNER JOIN users ON games.user = users.id ORDER BY created DESC");
while ($fetch = $result->fetch_object()) {
  for ($i = 0; $i < 10; $i++) echo "<tr><td>{$fetch->username}</td><td>Dark Forest</td><td>Regicide</td><td>Join</td></tr>";
}
?>
</table>
</div> <!-- play_lobby box -->
</div> <!-- play_left -->

<div class="play_right">
<div class="play_profile box">
<table class="play_table">
<tr><th colspan="2">Your Profile</th></tr>
<tr><td class="play_avatar" colspan="2"><img src="images/default_avatar.png" /></td></tr>
<tr><th>Username</th><td><?php echo $user->username; ?> </td></tr>

<tr><th>Email</th><td><?php echo $user->email; ?> </td></tr>
<tr><th>Games Won</th><td><?php echo number_format($user->wins); ?> </td></tr>
<tr><th>Games Lost</th><td><?php echo number_format($user->losses); ?> </td></tr>
</table>
</div>
</div> <!-- play_right -->

</div> <!-- play_container -->

</body>
</html>