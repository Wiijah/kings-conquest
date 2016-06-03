<?php
require_once '../includes/lightbox.php';

echo genLightbox("Create Game", "create_game", "<table class='form_table'>
    <tr><th class='lightbox_left'>Room Name: <span class='required'>*</span><span class='form_subtext'><br />3 - 20 characters.</span></th><td><input type='text' class='text auto_off' id='room_name' placeholder='Room Name' autocomplete='off' /></td></tr>
    <tr><th>Room Password:<span class='form_subtext'><br />Optional. Up to 20 characters.</span></th><td><input type='password' class='text auto_off' id='room_pass' placeholder='Leave blank if no password.' autocomplete='off' /></td></tr>
    </table>
    <div class='btn lightbox_btn' id='lightbox_btn_create_game'>Submit</div>");

$ach = array(
  '50_wins' => array("images/achievements/50_wins.png", "Won 50 games."),
  '100_wins' => array("images/achievements/100_wins.png", "Won 100 games."),
  'perfect_win' => array("images/achievements/perfect_win.png", "Won a game without losing any units.")
  );
$user_ach = array();

if ($user->wins >= 50) $user_ach[] = $ach['50_wins'];
if ($user->wins >= 100) $user_ach[] = $ach['100_wins'];
$user_ach[] = $ach['perfect_win'];

$ach_html = "";
foreach ($user_ach as $value) {
  $ach_html .= "<label title='{$value[1]}'><img src='{$value[0]}' class='achievement' /></label>";
}
echo genLightBox("Achievements", "achievements", "<div style='text-align: center'>{$ach_html}</a></div>");
?>