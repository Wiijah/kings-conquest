<?php
require_once '../common.php';
$SKIN_COLOURS = array("pink", "peach", "indian", "brown", "black");
$LAYERS = array("hat", "eyes", "mouth", "body");

function avatarIcon($img) {
  return str_replace("avatars/", "icons/", $img);
}

function iconImg($img) {
  return "<img src='".avatarIcon($img)."' class='avatarIcon' />";
}
?>