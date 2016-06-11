<?php
$title = "Account Settings";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/avatar.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$message = "";
?>

<div class="small_container friends_container">
<?php

echo genBreadcrumbs(array("Lobby|index", "Avatar"));

echo $message;
?>

<?php echo genTitle("Account Settings"); ?>
<div class="box standard_box center">
Here you can modify your email address or password.
</div> 
<br />


<?php echo genTitle("Change Email"); ?>
<div class="box standard_box center">

<form action="settings" method="POST">

Email:<br />
<input type="text" class="text" name="email" value="<?php echo $user->email; ?>">
<br /><br />
<div class='btn lightbox_btn form_submit'>Update</div>
</form>
</div> 
<br />

<?php echo genTitle("Change Password"); ?>
<div class="box standard_box center">

<form action="settings" method="POST">

Email:<br />
<input type="text" class="text" name="email" value="<?php echo $user->email; ?>">
<br /><br />
<div class='btn lightbox_btn form_submit'>Update</div>
</form>
</div> 
<br />

<?php include 'includes/footer.php'; ?>