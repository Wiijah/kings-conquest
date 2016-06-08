<?php
$title = "Leaderboards";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$close = 3;
?>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Leaderboard"));
?>

<?php echo genTitle("Leaderboards"); ?>
<div class="box standard_box center">
Here you can see the list of players with the highest ELO ratings.<br />
</div> 
<br />

<?php echo genTitle("ELO Rating List"); ?>
<div class="box center">
<table class="play_table lobby">
<tr><th>Rank</th><th>Player</th><th>ELO Rating</th></tr>
<?php
$i = 0;
$result = $db->query("SELECT * FROM users ORDER BY elo DESC");
while ($fetch = $result->fetch_object()) {
  $i++;
  echo "<tr><td>".$i."</td><td>".linkUsername($fetch)."</td><td>".number_format($fetch->elo)."</td></tr>";
}
?>
</table>
</div>

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>