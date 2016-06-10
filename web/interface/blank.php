<?php
$title = "Blank";
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

<?php echo genTitle("Customise Avatar"); ?>
<div class="box standard_box center">
<img src="<?php echo getAvatarURL($user->id); ?>" class="avatar" />
<br />
<div class='btn lightbox_btn js_link' data-href='shop'>Shop</div><br />
Here you can customise your avatar with items you have earned.
</div> 
<br />

<?php include 'includes/footer.php'; ?>