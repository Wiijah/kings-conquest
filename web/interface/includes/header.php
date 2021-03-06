<!DOCTYPE html>
<html>
<head>
  <title><?php echo (isset($title) ? $title . " - " : "") . "Kings' Conquest"; ?></title>
  <link rel="icon" type="image/png" href="../images/favicon.png" />

  <!-- CSS -->
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/lightbox.css">
  <link rel="stylesheet" href="css/room.css">
  <link rel="stylesheet" href="css/profile.css">
  <link rel="stylesheet" href="css/friends.css">
  <link rel="stylesheet" href="css/tutorial.css">
  <link rel="stylesheet" href="css/avatar.css">
  <link rel="stylesheet" href="css/map.css">
  <link rel="stylesheet" href="../fonts/fonts.css">

  <!-- JS -->
  <script src="../utils/jquery.js"></script>
  <script src="js/map.js"></script>
  <script src="js/common.js"></script>
  <script src="js/style.js"></script>
  <script src="js/lightbox.js"></script>
  <script src="js/tutorial.js"></script>
  <script src="../utils/qtip.js"></script>
  <script>
  <!--
  var user_id = <?php echo $user->id; ?>;
  -->
  </script>
</head>
<body>
<input type="password" style="display:none;" /> <!-- prevent autocomplete -->
<?php
require_once 'lightbox.php';
?>