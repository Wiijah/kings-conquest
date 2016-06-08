<?php
$title = "Friends";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$close = 2;

/* Delete/Cancel Friend Request */
if (isset($_GET['delete'])) {
  $other_id = secureStr($_GET['delete']);
  $other = $db->query("SELECT * FROM users WHERE id = '{$other_id}'")->fetch_object();
  if ($other) {
    $result = $db->query("SELECT * FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$other_id}') OR (other_id = '{$user->id}' AND user_id = '{$other_id}')");

    if ($fetch = $result->fetch_object()) {
      $db->query("DELETE FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$other_id}') OR (other_id = '{$user->id}' AND user_id = '{$other_id}')");
      if ($fetch->accepted == 0 && $friend->user_id == $user->id) echo lightbox_alert("Friend Request Cancelled", "You have successfully cancelled the friend request to ".linkUsername($other).".");
      if ($fetch->accepted == 0 && $friend->other_id == $user->id) echo lightbox_alert("Friend Request Declined", "You have successfully declined the friend request from ".linkUsername($other).".");
      if ($fetch->accepted == 1) echo lightbox_alert("Friend Removed", "You have successfully removed ".linkUsername($other)." from your friends list.");
    }
  }
} //end if isset cancel

/* Accept Friend Request */
if (isset($_GET['accept'])) {
  $other_id = secureStr($_GET['accept']);
  $other = $db->query("SELECT * FROM users WHERE id = '{$other_id}'")->fetch_object();
  if ($other) {
    $result = $db->query("SELECT * FROM friends WHERE user_id = '{$other_id}' AND other_id = '{$user->id}'");

    if ($fetch = $result->fetch_object()) {
      $db->query("UPDATE friends SET accepted = 1 WHERE user_id = '{$other_id}' AND other_id = '{$user->id}'");
      if ($fetch->accepted == 0) echo lightbox_alert("Friend Accepted", "You have successfully accepted the friend request from ".linkUsername($other).".");
    }
  }
} //end if isset cancel

/* Get friends */
$friends_html = "";

$result = $db->query("SELECT * FROM friends WHERE accepted = '1' AND (user_id = '{$user->id}' OR other_id = '{$user->id}')");
while ($fetch = $result->fetch_object()) {
  $other_id = $fetch->user_id == $user->id ? $fetch->other_id : $fetch->user_id;
  $other = $db->query("SELECT * FROM users WHERE id = '{$other_id}'")->fetch_object();

  $friends_html .= "<tr><td>".linkUsername($other)."</td><td><a href='friends?delete={$other->id}'>Remove</a></td></tr>";
}

if ($friends_html == "") {
  $friends_html = "<div class='box standard_box center'>Your friends list is currently empty.</div>";
} else {
  $friends_html = "<div class='box center'><table class='play_table'><tr><th>Friend</th><th>Remove</th></tr>{$friends_html}</table></div>";
}


/* Get pending requests from */
$pending_from_html = "";

$result = $db->query("SELECT * FROM friends WHERE accepted = '0' AND user_id = '{$user->id}'");
while ($fetch = $result->fetch_object()) {
  $other = $db->query("SELECT * FROM users WHERE id = '{$fetch->other_id}'")->fetch_object();

  $pending_from_html .= "<tr><td>".linkUsername($other)."</td><td><a href='friends?delete={$other->id}'>Cancel</a></td></tr>";
}

if ($pending_from_html != "") {
  $pending_from_html = genTitle("Friend Requests From You")."<div class='box center'><table class='play_table'><tr><th>Friend</th><th>Cancel</th></tr>{$pending_from_html}</table></div><br />";
}

/* Get pending requests to you */
$pending_to_html = "";

$result = $db->query("SELECT * FROM friends WHERE accepted = '0' AND other_id = '{$user->id}'");
while ($fetch = $result->fetch_object()) {
  $other = $db->query("SELECT * FROM users WHERE id = '{$fetch->user_id}'")->fetch_object();

  $pending_to_html .= "<tr><td>".linkUsername($other)."</td><td><a href='friends?accept={$other->id}'>Accept</a></td></tr>";
}

if ($pending_to_html != "") {
  $pending_to_html = genTitle("Friend Requests To You")."<div class='box center'><table class='play_table'><tr><th>Friend</th><th>Accept</th></tr>{$pending_to_html}</table></div><br />";
}
?>

<div class="small_container friends_container">
<?php echo genBreadcrumbs(array("Lobby|index", "Friends")); ?>

<?php echo genTitle("Friends"); ?>
<div class="box standard_box center">
To add a friend, click here to search for a new friend and click on 'add friend'.
</div> <!-- friends_profile box -->
<br />
<?php echo $pending_to_html.$pending_from_html; ?>
<?php echo genTitle("Your Friends"); ?>
<?php echo $friends_html; ?>
 <!-- friends_profile box -->
</div> <!-- small_container -->

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>