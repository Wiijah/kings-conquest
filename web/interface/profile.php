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

$close = secureInt($_GET['close']);
if ($close == 1) {
  $breadcrumbs = "";
} else if ($close == 2) { 
  $text = "Back To Friends";
  $link = "friends";
  $breadcrumbs = genBreadcrumbs(array("Lobby|index", "Friends|friends", "Profile Of {$prof->username}"))."<br />";
} else if ($close == 3) { 
  $text = "Back To Leaderboards";
  $link = "leaderboard";
  $breadcrumbs = genBreadcrumbs(array("Lobby|index", "Leaderboards|leaderboard", "Profile Of {$prof->username}"))."<br />";
} else if ($close == 4) {
  $text = "Back To Match History";
  $link = "match_history";
  $breadcrumbs = genBreadcrumbs(array("Lobby|index", "Match History|match_history", "Profile Of {$prof->username}"));
} else {
  $breadcrumbs = genBreadcrumbs(array("Lobby|index", "Profile Of {$prof->username}"))."<br />";
}

require_once 'includes/back_container.php';

$ach_html = getAchievementsHTML($prof);
if ($ach_html == "") $ach_html = "This player has no achievements.";


$friend_query = "SELECT * FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$prof->id}') OR (other_id = '{$user->id}' AND user_id = '{$prof->id}')";
$friend_result = $db->query($friend_query);
$friend = $friend_result->fetch_object();


?>

<div class="small_container prof_user">

<?php 

echo $breadcrumbs;

if (isset($_GET['add'])) {
  if ($prof->id == $user->id) {
      echo Message("Cannot Add Yourself", "You cannot add yourself into your own friends list.");
  } else if (!$friend) {
    $db->query("INSERT INTO friends (user_id, other_id) VALUES('{$user->id}', '{$prof->id}')");
    echo Message("Friend Request Sent", "You have successfully sent your friend request to ".linkUsername($prof).".");
  } else if ($friend->accepted == 0 && $user->id == $friend->user_id) {
    echo Message("Request Already Sent", "You already have a friend request sent to ".linkUsername($prof).".");
  } else if ($friend->accepted == 0 && $user->id == $friend->other_id) {
    $db->query("UPDATE friends SET accepted = 1 WHERE user_id = '{$prof->id}' AND other_id = '{$user->id}'");
    echo Message("Friend Request Accepted", "".linkUsername($prof)." had already sent you a friend request earlier. You accepted the friend request instead.");
  } else {
    echo Message("Already Friends", "You and ".linkUsername($prof)." already have each other added as friends.");
  }
} //end if ADD friend

/* Delete/Cancel Friend Request */
if (isset($_GET['delete'])) {
  if ($friend) {
    $db->query("DELETE FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$prof->id}') OR (other_id = '{$user->id}' AND user_id = '{$prof->id}')");
    if ($friend->accepted == 0 && $friend->user_id == $user->id) echo Message("Friend Request Removed", "You have successfully cancelled the friend request to ".linkUsername($prof).".");
    if ($friend->accepted == 0 && $friend->other_id == $user->id) echo Message("Friend Request Declined", "You have successfully declined the friend request from ".linkUsername($prof).".");
    if ($friend->accepted == 1) echo Message("Friend Removed", "You have successfully removed ".linkUsername($prof)." from your friends list.");
  }
} //end if isset cancel

echo genTitle("Profile Of ".linkUsername($prof).""); ?>
<div class="play_profile box">
<table class="play_table">
<tr><td class="prof_avatar" colspan="2"><img src="<?php echo getAvatarURL($prof->id); ?>" />
<br />
<?php
$friend_result = $db->query($friend_query);
$friend = $friend_result->fetch_object();
$friend_text = "Add Friend"; $friend_link = "add";
if ($friend) {
  if ($friend->accepted == 0 && $user->id == $friend->user_id) {$friend_text = "Cancel Friend Request"; $friend_link="delete";}
  if ($friend->accepted == 0 && $user->id == $friend->other_id) {$friend_text = "Accept Friend Request";}
  if ($friend->accepted == 1) { $friend_text = "Unfriend"; $friend_link="delete";}
}
?>
<?php
if ($prof->id != $user->id) {
?><div class='btn lightbox_btn js_link' data-href='profile?username=<?php echo $prof->username; ?>&<?php echo $friend_link; ?>=1&close=<?php echo secureStr($close); ?>'><?php echo $friend_text; ?></div>
<?php
}
?>
</td>
</tr>
<?php echo genProf($prof); ?>
</table>
</div> <!-- play_profile box -->
<br />
<?php echo genTitle("Achievements Of {$prof->username}"); ?>
<div class="play_profile box center achievements">

<?php echo $ach_html; ?>
</div> <!-- play_profile box for achievements-->

</div> <!-- small_container -->

<?php include 'includes/footer.php'; ?>