<?php
$ELO_COLOURS = array(
  2800 => array('FF0000', 'King'),
  2500 => array('FF0070', 'Legendary'),
  2200 => array('FF00CD', 'Grandmaster'),
  2000 => array('6C00FF', 'Master'),
  1800 => array('4131FF', 'Candidate Master'),
  1600 => array('3166FF', 'Expert'),
  1400 => array('1CFF91', 'Pro'),
  1200 => array('FFF0C0', 'Soldier'),
  1000 => array('FFFFFF', 'Recruit'),
  0 => array('C19393', 'Noob')
);
$close = "";
function linkUsername($prof) {
  global $close, $ELO_COLOURS;
  $colour = "";
  foreach ($ELO_COLOURS as $key => $value) {
    if ($prof->elo >= $key) {
      $colour = $value[0];
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