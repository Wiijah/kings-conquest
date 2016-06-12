<?php
$title = "Upgrade To Member";
require_once 'includes/header_checks.php';

if ($user->member_type != "guest") {
  header ("Location: settings");
  die();
}

include 'includes/header.php';
include 'includes/avatar.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$message = "";


if (isset($_POST['old_pass'])) {
  $new_pass = $_POST['pass1'];
  $new_pass2 = $_POST['pass2'];
  $email = secureStr($_POST['email']);

  $error = false;

  if (!isValidEmail($email)) {
    $message = Message("Invalid Email", "The email you entered was invalid.");
    $error = true;
  } else if (strlen($email) >= 64) {
    $message = Message("Email Too Long", "Emails must be no more than 64 characters long.");
    $error = true;
  } else if (strlen($new_pass) < 8) {
    $message = Message("Password Too Short", "Your new password must be at least 8 characters long.");
    $error = true;
  } else if ($new_pass != $new_pass2) {
    $message = Message("Passwords Don't Match", "The passwords you entered did not match. Please try again.");
    $error = true;
  }

  if (!$error) {
    $new_pass = hashPass($new_pass);
    $db->query("UPDATE users SET password = '{$new_pass}', email = '{$email}', member_type = 'normal' WHERE id = '{$user->id}'");
    $message = Message("Account Upgraded", "You have successfully upgraded your account from a guest to a regular member.");
  }
}

if (!isset($email)) $email = $user->email;
?>

<div class="small_container friends_container">
<?php

echo genBreadcrumbs(array("Lobby|index", "Upgrade Account"));

echo $message;
?>

<?php echo genTitle("Upgrade To Member"); ?>
<div class="box standard_box center">
Here you can upgrade your guest account to a regular account.<br />
To do so, enter an email address and password.
</div> 
<br />


<?php echo genTitle("Upgrade Form"); ?>
<div class="box standard_box center">

<form action="settings" method="POST">

Email:<br />
<input type="text" class="text" name="email" /><br /><br />
New Password:<br />
<input type="password" class="text" name="pass1" /><br /><br />
Type New Password Again:<br />
<input type="password" class="text" name="pass2" />
<br /><br />
<div class='btn lightbox_btn form_submit'>Upgrade Account</div>
</div> 
<br />


<?php include 'includes/footer.php'; ?>