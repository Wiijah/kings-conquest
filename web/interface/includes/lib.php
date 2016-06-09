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

function giveAch($ach_name, $prof, $room_id = 0) {
  global $db;
  $result = $db->query("SELECT * FROM ach_instances WHERE user_id = '{$prof->id}' AND ach_name = '{$ach_name}'");
  if ($result->num_rows > 0) {
    return;
  } 
  $db->query("INSERT INTO ach_instances (ach_name, user_id, room_id) VALUES('{$ach_name}', '{$prof->id}', '{$room_id}')");
}

function getAchievementsHTML($prof, $room_id = 0) {
  global $db;

  $ach = array();
  $result = $db->query("SELECT * FROM achievements");
  while ($fetch = $result->fetch_object()) {
    $ach[$fetch->ach_name] = $fetch;
  }

  $user_ach = array();

  //if ($prof->wins >= 50) $user_ach['50_wins'] = $ach['50_wins'];
  //if ($prof->wins >= 100) $user_ach['100_wins'] = $ach['100_wins'];

  $sql_extra = "";
  if ($room_id != 0) $sql_extra = " AND room_id = {$room_id} AND alert != 0";
  $result = $db->query("SELECT * FROM ach_instances WHERE user_id = '{$prof->id}'{$sql_extra}");
  while ($fetch = $result->fetch_object()) {
    $user_ach[$fetch->ach_name] = $ach[$fetch->ach_name];
  }

  if ($room_id != 0) $db->query("UPDATE ach_instances SET alert = 0 WHERE user_id = '{$prof->id}'{$sql_extra}");


  $ach_html = "";
  foreach ($user_ach as $value) {
    $ach_html .= "<label title='{$value->label}'><img src='{$value->image}' class='achievement' /></label>";
  }
  return $ach_html;
}

function genProf($prof) {
  global $user;
  $email = $prof->member_type == "guest" ? "N/A" : $prof->email;
  $email = $user->id == $prof->id ? "<tr><th>Email</th><td>".$email."</td></tr>" : "";

  return "<tr><th>Username</th><td>".linkUsername($prof)."</td></tr>
".$email."
<tr><th>King Points</th><td>".number_format($prof->kp)."</td></tr>
<tr><th>Games Won</th><td>".number_format($prof->wins)."</td></tr>
<tr><th>Games Lost</th><td>".number_format($prof->losses)."</td></tr>
<tr><th>ELO Rating</th><td>".getRank($prof->elo)."<br /><small>".number_format($prof->elo)."</small></td></tr>
<tr><th>Win/Loss Ratio</th><td>".percent($prof->wins, $prof->losses)."%</td></tr>
<tr><th>Sign Up Date</th><td>".formatSQLDate($prof->created)."</td></tr>";
}
function linkUsername($prof, $newTab = false) {
  global $close, $ELO_COLOURS;
  $colour = "";
  foreach ($ELO_COLOURS as $key => $value) {
    if ($prof->elo >= $key) {
      $colour = $value[0];
      break;
    }
  }
  $nt = $newTab ? " target='_blank'" : "";
  return "<a href='profile?username={$prof->username}&close={$close}' style='color: #{$colour}' class='rank'{$nt}>{$prof->username}</a>";
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
  return "av.php?id={$user_id}";
}
?>