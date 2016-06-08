<?php
require_once '../common.php';
require_once 'items.php';

if (!isset($_SESSION['id'])) {
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}

function getAchievementsHTML($user_id) {
  global $db, $user;

  $ach = array();
  $result = $db->query("SELECT * FROM achievements");
  while ($fetch = $result->fetch_object()) {
    $ach[$fetch->ach_name] = $fetch;
  }

  $user_ach = array();

  if ($user->wins >= 50) $user_ach['50_wins'] = $ach['50_wins'];
  if ($user->wins >= 100) $user_ach['100_wins'] = $ach['100_wins'];

  $result = $db->query("SELECT * FROM ach_instances WHERE user_id = '{$user_id}'");
  while ($fetch = $result->fetch_object()) {
    $user_ach[$fetch->ach_name] = $ach[$fetch->ach_name];
  }


  $ach_html = "";
  foreach ($user_ach as $value) {
    $ach_html .= "<label title='{$value->label}'><img src='{$value->image}' class='achievement' /></label>";
  }
  return $ach_html;
}
?>