<?php
$ELO_COLOURS = array(
  2000 => '5582FF',
  1500 => 'FD55FF',
  1400 => 'FF5557',
  1300 => 'FF9848',
  1200 => 'FFFC87',
  1000 => 'FFFFFF',
  0 => '00FF91'
);
$close = "";
function linkUsername($prof) {
  global $close, $ELO_COLOURS;
  $colour = "";
  foreach ($ELO_COLOURS as $key => $value) {
    if ($prof->elo >= $key) {
      $colour = $value;
      break;
    }
  }
  return "<a href='profile?username={$prof->username}&close={$close}' style='color: #{$colour}'>{$prof->username}</a>";
}
function Message($title, $text) {
  return genTitle($title)."<div class='box center standard_box'>{$text}</div><br />";
}

/* Breadcrumbs */
function genBreadcrumbs($arr) {
  $out = "";
  foreach ($arr as $value) {
    if ($out != "") $out .= " >> ";
    if (!contains($value, "|")) {
      $out .= $value;
      continue;
    }
    $array = explode("|", $value);
    $out .= "<a href='{$array[1]}'>{$array[0]}</a>";
  }
  return "<div class='breadcrumbs'>{$out}</div>";
}

function getAvatarURL($user_id) {
  return "images/default_avatar.png";
}
?>