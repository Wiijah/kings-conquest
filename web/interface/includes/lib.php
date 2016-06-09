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

function getRank($elo) {
  global $ELO_COLOURS;
  foreach ($ELO_COLOURS as $key => $value) {
    if ($elo >= $key) {
      return "<span style='color: #{$value[0]}'>{$value[1]}</span>";
    }
  }
  return "";
}
function genProf($prof) {
  global $user;
  $email = $user->id == $prof->id ? "<tr><th>Email</th><td>".$prof->email."</td></tr>" : "";

  return "<tr><th>Username</th><td>".$prof->username."</td></tr>
".$email."
<tr><th>King Points</th><td>".number_format($prof->kp)."</td></tr>
<tr><th>Games Won</th><td>".number_format($prof->wins)."</td></tr>
<tr><th>Games Lost</th><td>".number_format($prof->losses)."</td></tr>
<tr><th>ELO Rating</th><td>".number_format($prof->elo)." - ".getRank($prof->elo)."</td></tr>
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