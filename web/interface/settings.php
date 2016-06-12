<?php
$title = "Account Settings";
require_once 'includes/header_checks.php';

if ($user->member_type == "guest") {
  header ("Location: index");
  die();
}

include 'includes/header.php';
include 'includes/avatar.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$message = "";

if (isset($_POST['email'])) {
  $email = secureStr($_POST['email']);
  $error = false;

  if (!isValidEmail($email)) {
    $message = Message("Invalid Email", "The email you entered was invalid.");
    $error = true;
  }
  if (strlen($email) >= 64) {
    $message = Message("Email Too Long", "Emails must be no more than 64 characters long.");
    $error = true;
  }
  if (!$error) {
    $db->query("UPDATE users SET email = '{$email}' WHERE id = '{$user->id}'");
    $message = Message("Email Changed", "You have successfully changed your email.");
  }
}


if (isset($_POST['old_pass'])) {
  $old_pass = $_POST['old_pass'];
  $new_pass = $_POST['pass1'];
  $new_pass2 = $_POST['pass2'];

  $error = false;

  if (!passVerify($old_pass, $user->password)) {
    $message = Message("Incorrect Password", "The password you entered was not correct.");
    $error = true;
  }

  if (strlen($new_pass) < 8) {
    $message = Message("Password Too Short", "Your new password must be at least 8 characters long.");
    $error = true;
  }

  if ($new_pass != $new_pass2) {
    $message = Message("Passwords Don't Match", "The passwords you entered did not match. Please try again.");
    $error = true;
  }

  if (!$error) {
    $new_pass = hashPass($new_pass);
    $db->query("UPDATE users SET password = '{$new_pass}' WHERE id = '{$user->id}'");
    $message = Message("Password Changed", "You have successfully changed your password.");
  }
}

if (!isset($email)) $email = $user->email;
?>

<div class="small_container friends_container">
<?php

echo genBreadcrumbs(array("Lobby|index", "Settings"));

echo $message;
?>

<?php echo genTitle("Account Settings"); ?>
<div class="box standard_box center">
<img src="images/settings.gif" class="avatar" /><br /><br />
Here you can modify your email address or password.
</div> 
<br />


<?php echo genTitle("Change Email"); ?>
<div class="box standard_box center">

<form action="settings" method="POST">

Email:<br />
<input type="text" class="text" name="email" value="<?php echo $email; ?>">
<br /><br />
<div class='btn lightbox_btn form_submit'>Update</div>
</form>
</div> 
<br />

<?php echo genTitle("Change Password"); ?>
<div class="box standard_box center">

<form action="settings" method="POST">
Old Password:<br />
<input type="password" class="text" name="old_pass" /><br /><br />
New Password:<br />
<input type="password" class="text" name="pass1" /><br /><br />
Type New Password Again:<br />
<input type="password" class="text" name="pass2" />
<br /><br />
<div class='btn lightbox_btn form_submit'>Update Password</div>
</form>

</div> 
<br />

<?php include 'includes/footer.php'; ?>