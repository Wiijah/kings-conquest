<?php
$title = "Custom Maps";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';
?>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Custom Maps"));
?>

<?php echo genTitle("Custom Maps"); ?>
<div class="box standard_box center">
Here you can see the custom maps you've made.<br />

<div class="btn lightbox_btn lightbox_open" data-lb="new_map">New Map</div>
</div> 
<br />

<?php echo genTitle("Your Maps"); ?>
<div class="box center">
<table class="play_table lobby">
<tr><th>Map</th><th>Edit Map</th></tr>
<?php
$i = 0;
$result = $db->query("SELECT * FROM maps WHERE user_id = '{$user->id}' ORDER BY last_modified DESC");
while ($fetch = $result->fetch_object()) {
  echo "<tr><td><br />".$fetch->map_name."<br /><br /><img src='map_img?map_id=".$fetch->map_id."&modified=".$fetch->last_modified."' style='width: 150px' /><br /><br /></td><td><a href='map_editor?map_id={$fetch->map_id}'>Edit Map</a></td></tr>";
}
?>
</table>
</div>

<?php include 'includes/footer.php'; ?>