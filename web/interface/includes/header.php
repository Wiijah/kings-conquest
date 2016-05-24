<?php
include '../common.php';

if (!isset($_SESSION['id'])) {
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}
function genTitle($title) {
  return "<div class='title'><h1>{$title}</h1></div>";
}

?>
<!DOCTYPE html>
<html>
<head>
    <title><?php echo (isset($title) ? $title . " - " : "") . "Kings' Conquest"; ?></title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/lightbox.css">
    <link rel="stylesheet" href="../fonts/fonts.css">
    <link rel="icon" type="image/png" href="../images/favicon.png" />


  <script src="../utils/jquery.js"></script>
  <script src="js/common.js"></script>
  <script src="js/chatroom.js"></script>
</head>

<div id="lightbox_behind"></div>

<div class="lightbox_container">
<?php echo genTitle("Create Game"); ?>
<div class="lightbox">
<table class="form_table">
<tr><th class="lightbox_left">Room Name:</th><td><input type="text" class="text" id="name" /></td></tr>
<tr><th>Room Password:</th><td><input type="password" class="text" id="password" /></td></tr>
</table>

<div class="btn lightbox_btn">Submit</div>
</div> <!-- lightbox -->
</div>