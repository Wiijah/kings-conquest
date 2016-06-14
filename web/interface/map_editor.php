<?php
$title = "Map Editor";
require_once 'includes/header_checks.php';

$map_id = secureInt($_GET['map_id']);
$result = $db->query("SELECT * FROM maps WHERE map_id = '{$map_id}'");
if (!$result || !($map = $result->fetch_object()) || $map->user_id != $user->id) {
  header ("Location: index");
  die();
}

$points = json_decode($map->points, true);

include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';
?>
<script>
var TILES = <?php echo json_encode($TILES); ?>;
var map_id = <?php echo $map->map_id; ?>;
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
<input type="text" class="text" id="form_map_name" placeholder="Map Name" value="<?php echo $map->map_name; ?>"/><br /><br />

Select a tile below and then click on the grid below.

<br />
<div class='map_tile' id='tile_100' style='background-color: #FFF' data-tile='100'><span class='map_letter red'>K</span></div>
<div class='map_tile' id='tile_101' style='background-color: #FFF' data-tile='101'><span class='map_letter red'>C</span></div>
<div class='map_tile' id='tile_102' style='background-color: #FFF' data-tile='102'><span class='map_letter blue'>K</span></div>
<div class='map_tile' id='tile_103' style='background-color: #FFF' data-tile='103'><span class='map_letter blue'>C</span></div>
<?php
for ($i = 0; $i < count($TILES); $i++) {
  if (count($TILES[$i]) > 2) continue;
  echo "<div class='map_tile' id='tile_{$i}' style='background-color: #{$TILES[$i][1]}' data-tile='{$i}'></div>";
}
?>
<br />
<div class='map_holder'>
<?php
for ($y = 0; $y < $MAP_X_SIZE; $y++) {
  for ($x = 0; $x < $MAP_Y_SIZE; $x++) {
    $tile2 = 0; $innerHTML = ""; $class = "";
    if ("[{$x}, {$y}]" == $map->red_king) {$tile2 = 100;$innerHTML = "<span class='tile_letter red'>K</span>";}
    if ("[{$x}, {$y}]" == $map->red_castle) {$tile2 = 101;$innerHTML = "<span class='tile_letter red'>C</span>";}
    if ("[{$x}, {$y}]" == $map->blue_king) {$tile2 = 102;$innerHTML = "<span class='tile_letter blue'>K</span>";}
    if ("[{$x}, {$y}]" == $map->blue_castle) {$tile2 = 103;$innerHTML = "<span class='tile_letter blue'>C</span>";}
    if ($tile2 != 0) $class = " tile_".$tile2;

    echo "<div class='map_cell{$class}' id='tile_{$x}_{$y}' data-x='{$x}' data-y='{$y}' data-tile='{$points[$y][$x]}' data-tile2='{$tile2}' style='background-color: #{$TILES[$points[$y][$x]][1]}'>{$innerHTML}</div>";
  }
  echo "<div class='clear_float'></div>";
}
?>
</div>
<div class="btn lightbox_btn" id="save_map">Save Map</div>
</div>

<?php include 'includes/footer.php'; ?>