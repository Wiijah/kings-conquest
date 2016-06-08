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
  $other_id = secureInt($_GET['delete']);
  $other = $db->query("SELECT * FROM users WHERE id = '{$other_id}'")->fetch_object();
  if ($other) {
    $result = $db->query("SELECT * FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$other_id}') OR (other_id = '{$user->id}' AND user_id = '{$other_id}')");

    if ($fetch = $result->fetch_object()) {
      $db->query("DELETE FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$other_id}') OR (other_id = '{$user->id}' AND user_id = '{$other_id}')");
      if ($fetch->accepted == 0 && $fetch->user_id == $user->id) echo lightbox_alert("Friend Request Cancelled", "You have successfully cancelled the friend request to ".linkUsername($other).".");
      if ($fetch->accepted == 0 && $fetch->other_id == $user->id) echo lightbox_alert("Friend Request Declined", "You have successfully declined the friend request from ".linkUsername($other).".");
      if ($fetch->accepted == 1) echo lightbox_alert("Friend Removed", "You have successfully removed ".linkUsername($other)." from your friends list.");
    }
  }
} //end if isset cancel

/* Accept Friend Request */
if (isset($_GET['accept'])) {
  $other_id = secureInt($_GET['accept']);
  $other = $db->query("SELECT * FROM users WHERE id = '{$other_id}'")->fetch_object();
  if ($other) {
    $result = $db->query("SELECT * FROM friends WHERE user_id = '{$other_id}' AND other_id = '{$user->id}'");

    if ($fetch = $result->fetch_object()) {
      $db->query("UPDATE friends SET accepted = 1 WHERE user_id = '{$other_id}' AND other_id = '{$user->id}'");
      if ($fetch->accepted == 0) echo lightbox_alert("Friend Accepted", "You have successfully accepted the friend request from ".linkUsername($other).".");
    }
  }
} //end if isset cancel


/* Add New Friend */
if (isset($_GET['add'])) {
  $other_id = secureInt($_GET['add']);
  $other = $db->query("SELECT * FROM users WHERE id = '{$other_id}'")->fetch_object();
  if ($other) {
    $friend_query = "SELECT * FROM friends WHERE (user_id = '{$user->id}' AND other_id = '{$other_id}') OR (other_id = '{$user->id}' AND user_id = '{$other_id}')";
    $friend_result = $db->query($friend_query);
    $friend = $friend_result->fetch_object();

    if ($other_id == $user->id) {
      echo lightbox_alert("Cannot Add Yourself", "You cannot add yourself into your own friends list.");
    } else if (!$friend) {
      $db->query("INSERT INTO friends (user_id, other_id) VALUES('{$user->id}', '{$other_id}')");
      echo lightbox_alert("Friend Request Sent", "You have successfully sent your friend request to ".linkUsername($other).".");
    } else if ($friend->accepted == 0 && $user->id == $friend->user_id) {
      echo lightbox_alert("Request Already Sent", "You already have a friend request sent to ".linkUsername($other).".");
    } else if ($friend->accepted == 0 && $user->id == $friend->other_id) {
      $db->query("UPDATE friends SET accepted = 1 WHERE user_id = '{$other_id}' AND other_id = '{$user->id}'");
      echo lightbox_alert("Friend Request Accepted", "".linkUsername($other)." had already sent you a friend request earlier. You accepted the friend request instead.");
    } else {
      echo lightbox_alert("Already Friends", "You and ".linkUsername($other)." already have each other added as friends.");
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



/* Search Feature */
$search_html = "";
if (isset($_GET['search'])) {
  $search = secureStr($_GET['search']);
  $result = $db->query("SELECT * FROM users WHERE username LIKE '%{$search}%'");
  while ($fetch = $result->fetch_object()) {
    $search_html .= "<tr><td>".linkUsername($fetch)."</td><td><a href='friends?add={$fetch->id}&search={$search}'>Add Friend</a></td></tr>";
  }
  if ($search_html != "") {
    $search_html = genTitle("Search Results")."<div class='box center'><table class='play_table'><tr><th>Username</th><th>Add Friend</th></tr>{$search_html}</table></div><br />";
  } else {
    $search_html = genTitle("Search Results")."<div class='box standard_box center'>No users found with your search query.</div><br />";
  }
}
?>

<div class="small_container friends_container">

<?php echo genBreadcrumbs(array("Lobby|index", "Friends")); ?>

<?php
  echo $search_html;
?>
<?php echo genTitle("Find Friends"); ?>
<div class="box standard_box center">
Use the form below to search for particular users to add.
<br /><br />
<form action="friends" method="GET">
<input class="text" type="text" name="search" placeholder="Username" />

<div class='btn lightbox_btn form_submit'>Search</div>
</form>
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