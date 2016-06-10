<?php
require_once '../common.php';
$SKIN_COLOURS = array("pink", "peach", "indian", "brown", "black", "green");
$SKIN_CODES = array("ffdecb", "fac99e", "c59162", "77583b", "3c2c1d", "3aa979");
$LAYERS = array("hat", "eyes", "body", "mouth");

function avatarIcon($img) {
  return str_replace("avatars/", "icons/", $img);
}

function avatarImg($av) {

  return "<label title='".secureStr($av->description)."'><img src='".avatarIcon($av->image)."' class='avatarIcon' /></label>";
}
function avatarTitle($av) {
  return "<label title='".secureStr($av->description)."'>{$av->name}</label>";
}
function iconImg($img) {
  return "<img src='".avatarIcon($img)."' class='avatarIcon' />";
}
?>