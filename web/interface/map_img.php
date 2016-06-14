<?php
require_once '../common.php';
require_once 'includes/map.php';

$FONT = '../fonts/BebasNeue Regular.ttf';

$map_id = secureInt($_GET['map_id']);

$DIM = 182;

$WIDTH = $DIM / 20;
$MARGIN = (($DIM - $WIDTH * 13) / 14);

$im = imagecreatetruecolor($DIM, $DIM);

$result = $db->query("SELECT * FROM maps WHERE map_id = '{$map_id}'");
if (!$fetch = $result->fetch_object()) die("Invalid map.");

$points = json_decode($fetch->points, true);
$r = 255;
$g = 255;
$b = 255;

for ($y = 0; $y < 13; $y++) {
  for ($x = 0; $x < 13; $x++) {
    $x1 = $x * ($WIDTH + $MARGIN) + $MARGIN;
    $y1 = $y * ($WIDTH + $MARGIN) + $MARGIN;
    $c = $TILES[$points[$y][$x]][1];
    $colour = imagecolorallocate($im, hexdec(substr($c, 0, 2)), hexdec(substr($c, 2, 2)), hexdec(substr($c, 4, 2)));
    imagefilledrectangle($im, $x1 , $y1, $x1 + $WIDTH, $y1 + $WIDTH, $colour);
  }
}

header ('Content-type: image/png');
imagepng($im, NULL, 0);
imagedestroy($im);
?>