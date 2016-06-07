<?php
require_once 'includes/header_checks.php';
$other = secureStr($_GET['username']);
$result = $db->query("SELECT * FROM users WHERE username = '{$other}'");
$prof = $result->fetch_object();
if (!$prof) {
  header ("Location: ../{$LOGGEDIN_DIR}/");
  die();
}
$title = "{$prof->username} - Profile";



include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$ach_html = getAchievementsHTML($prof->id);
if ($ach_html == "") $ach_html = "This player has no achievements.";


$friend_result = $db->query("SELECT * FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$prof->id}') OR (other_id = '{$user->id}' AND user_id = '{$prof->id}')");
?>

<div class="small_container prof_user">

<?php 

if (isset($_GET['add'])) {
  if (!$fetch = $friend_result->fetch_object()) {
    $db->query("INSERT INTO friends (user_id, other_id) VALUES('{$user->id}', '{$prof->id}')");
    echo Message("Friend Request Sent", "You have successfully sent your friend request to ".linkUsername($prof).".");
  } else if ($fetch->accepted == 0 && $user->id == $fetch->user_id) {
    echo Message("Request Already Sent", "You already have a friend request sent to ".linkUsername($prof).".");
  } else if ($fetch->accepted == 0 && $user->id == $fetch->other_id) {
    $db->query("UPDATE friends SET accepted = 1 WHERE user_id = '{$prof->id}' AND other_id = '{$user->id}'");
    echo Message("Friend Request Accepted", "".linkUsername($prof)." had already sent you a friend request earlier. You accepted the friend request instead.");
  } else {
    echo Message("Already Friends", "You and ".linkUsername($prof)." already have each other added as friends.");
  }
}

echo genTitle("Profile Of {$prof->username}"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><td class="prof_avatar" colspan="2"><img src="<?php echo getAvatarURL($prof->id); ?>" />
<br />
<div class='btn lightbox_btn js_link' data-href='profile?username=<?php echo $prof->username; ?>&add=<?php echo $prof->id; ?>&close=<?php echo secureStr($close); ?>'>Add Friend</div>
</td>
</tr>
<tr><th>Username</th><td><?php echo $prof->username; ?> </td></tr>

<tr><th>Email</th><td><?php echo $prof->email; ?> </td></tr>
<tr><th>Games Won</th><td><?php echo number_format($prof->wins); ?> </td></tr>
<tr><th>Games Lost</th><td><?php echo number_format($prof->losses); ?> </td></tr>
<tr><th>Win/Loss Ratio</th><td><?php echo ratio($prof->wins, $prof->losses); ?> </td></tr>
<tr><th>Sign Up Date</th><td><?php echo formatSQLDate($prof->created); ?> </td></tr>
</table>
</div> <!-- play_profile box -->
<br />
<?php echo genTitle("Achievements Of {$prof->username}"); ?>
<div class="play_profile box center achievements">

<?php echo $ach_html; ?>
</div> <!-- play_profile box for achievements-->

</div> <!-- small_container -->

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>