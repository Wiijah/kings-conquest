<?php
$ELO_COLOURS = array(
  2800 => array('FFD100', 'King'),
  2500 => array('FF2626', 'Legendary'),
  2200 => array('FF00CD', 'Grandmaster'),
  2000 => array('CA5EFF', 'Master'),
  1800 => array('5E81FF', 'Candidate Master'),
  1600 => array('00B7FF', 'Expert'),
  1400 => array('00FFF7', 'Pro'),
  1200 => array('5DFF6D', 'Soldier'),
  1000 => array('FFFFFF', 'Recruit'),
  0 => array('C19393', 'Noob')
);
$close = "";

function getRank($elo) {
  global $ELO_COLOURS;
  foreach ($ELO_COLOURS as $key => $value) {
    if ($elo >= $key) {
      return "<span style='color: #{$value[0]}' class='rank'>{$value[1]}</span>";
    }
  }
  return "";
}
function genProf($prof) {
  global $user;
  $email = $user->id == $prof->id ? "<tr><th>Email</th><td>".$prof->email."</td></tr>" : "";

  return "<tr><th>Username</th><td>".linkUsername($prof)."</td></tr>
".$email."
<tr><th>King Points</th><td>".number_format($prof->kp)."</td></tr>
<tr><th>Games Won</th><td>".number_format($prof->wins)."</td></tr>
<tr><th>Games Lost</th><td>".number_format($prof->losses)."</td></tr>
<tr><th>ELO Rating</th><td>".getRank($prof->elo)."<br /><small>".number_format($prof->elo)."</small></td></tr>
<tr><th>Win/Loss Ratio</th><td>".ratio($prof->wins, $prof->losses)."</td></tr>
<tr><th>Sign Up Date</th><td>".formatSQLDate($prof->created)."</td></tr>";
}
function linkUsername($prof) {
  global $close, $ELO_COLOURS;
  $colour = "";
  foreach ($ELO_COLOURS as $key => $value) {
    if ($prof->elo >= $key) {
      $colour = $value[0];
      break;
    }
  }
  return "<a href='profile?username={$prof->username}&close={$close}' style='color: #{$colour}' class='rank'>{$prof->username}</a>";
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