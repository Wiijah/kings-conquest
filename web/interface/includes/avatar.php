<?php
require_once '../common.php';
$SKIN_COLOURS = array("pink", "peach", "indian", "brown", "black");
$LAYERS = array("hat", "eyes", "mouth", "body");

function avatarIcon($img) {
  return str_replace("avatars/", "icons/", $img);
}

function avatarImg($av) {

  return "<label title='".secureStr($av->description)."'><img src='".avatarIcon($av->image)."' class='avatarIcon' /></label>";
}
function iconImg($img) {
  return "<img src='".avatarIcon($img)."' class='avatarIcon' />";
}
?>