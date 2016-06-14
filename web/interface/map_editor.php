<?php
$title = "Map Editor";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$close = 3;
?>
<script>
var TILES = <?php echo json_encode($TILES); ?>;
</script>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Map Editor"));
?>

<?php echo genTitle("Your Map"); ?>
<div class="box standard_box center">
Here you can create your own map for multiplayer.
</div> 
<br />

<?php echo genTitle("Map Editor"); ?>
<div class="box standard_box center">
Map Name:<br />
<input type="text" class="text" name="map_name" placeholder="Map Name" /><br /><br />

Select a tile below and then click on the grid below.

<br />
<div class='map_tile' id='tile_100' style='background-color: #FFF' data-tile='100'><span class='map_letter red'>K</span></div>
<div class='map_tile' id='tile_101' style='background-color: #FFF' data-tile='101'><span class='map_letter red'>C</span></div>
<div class='map_tile' id='tile_102' style='background-color: #FFF' data-tile='102'><span class='map_letter blue'>K</span></div>
<div class='map_tile' id='tile_103' style='background-color: #FFF' data-tile='103'><span class='map_letter blue'>C</span></div>
<?php
for ($i = 0; $i < count($TILES); $i++) {
  if ($TILES[$i][1] == "") continue;
  echo "<div class='map_tile' id='tile_{$i}' style='background-color: #{$TILES[$i][1]}' data-tile='{$i}'></div>";
}
?>
<br />
<div class='map_holder'>
<?php
for ($y = 0; $y < $MAP_X_SIZE; $y++) {
  for ($x = 0; $x < $MAP_Y_SIZE; $x++) {

    echo "<div class='map_cell' id='tile_{$x}_{$y}' data-x='{$x}' data-y='{$y}' data-tile='0' data-tile2='0' style='background-color: #{$TILES[0][1]}'></div>";
  }
  echo "<div class='clear_float'></div>";
}
?>
</div>
<div class="btn lightbox_btn">Save Map</div>
</div>

<?php include 'includes/footer.php'; ?>