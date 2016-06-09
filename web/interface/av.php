<?php
require_once 'includes/avatar.php';

$FONT = '../fonts/BebasNeue Regular.ttf';

$user_id = secureInt($_GET['id']);

$result = $db->query("SELECT * FROM users WHERE id = '{$user_id}'");
if (!$prof = $result->fetch_object()) die("Invalid user.");

$im = imagecreatefrompng("avatars/{$SKIN_COLOURS[$prof->skin_colour]}_man.png");
$w = 600;
$h = 600;

addImage("avatars/vest.png");

foreach ($LAYERS as $type) {
  if ($prof->{$type} != 0) {
    $result = $db->query("SELECT * FROM items WHERE item_id = '{$prof->{$type}}'");
    $fetch = $result->fetch_object();
    addImage($fetch->image);
  }
}

function addImage($image) {
  global $im;
  $item_image = imagecreatefrompng($image);
  imagecopy($im, $item_image, 0, 0, 0, 0, 600, 600);
}

$colour = 255;
$colour2 = imagecolorallocate($im, $colour, $colour, $colour);
$size = 6;

header ('Content-type: image/png');
imagepng($im, NULL, 0);
imagedestroy($im);
?>