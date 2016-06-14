<?php
$title = "Match History";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$close = 3;
?>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Match History"));
?>

<?php echo genTitle("Match History"); ?>
<div class="box standard_box center">
Here you can view your match history.<br />
</div> 
<br />

<?php echo genTitle("ELO Rating List"); ?>
<div class="box center">
<table class="play_table lobby">
<tr><th>Game Name</th><th>Game Started</th><th>Winner</th><th>Loser</th><th>View Full Match Details</th></tr>
<?php
$i = 0;
$result = $db->query("SELECT * FROM room_participants JOIN rooms USING (room_id) WHERE room_participants.user_id = {$user->id} AND colour != 'spectator' AND event = 'ended' ORDER BY part_id DESC");
while ($room = $result->fetch_object()) {
  $winner = select_user($room->winner);

  $result_loser_part = $db->query("SELECT * FROM room_participants WHERE user_id != {$winner->id} AND room_id = {$room->room_id} AND event = 'ended' AND colour != 'spectator'");
  $loser_part = $result_loser_part->fetch_object();
  if (!$loser_part) continue;

  $loser = select_user($loser_part->user_id);
  echo "<tr><td>".secureOutput($room->name)."</td><td>".unixDate($room->game_start)."</td><td>".linkUsername($winner)."</td><td>".linkUsername($loser)."</td><td><a href='game_stats?room_id={$room->room_id}'>View Details</a></tr>";
}
?>
</table>
</div>

<?php include 'includes/footer.php'; ?>