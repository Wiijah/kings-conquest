<?php
require_once '../common.php';

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
  <link rel="icon" type="image/png" href="../images/favicon.png" />

  <!-- CSS -->
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/lightbox.css">
  <link rel="stylesheet" href="css/room.css">
  <link rel="stylesheet" href="../fonts/fonts.css">

  <!-- JS -->
  <script src="../utils/jquery.js"></script>
  <script src="js/common.js"></script>
  <script src="js/chatroom.js"></script>
  <script src="js/lightbox.js"></script>
</head>
<body>
<?php
require_once 'lightbox.php';
?>
