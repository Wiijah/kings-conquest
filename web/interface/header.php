<?php
include '../common.php';

if (!isset($_SESSION['id'])) {
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}
?>
<!DOCTYPE html>
<html>
<head>
    <title><?php echo (isset($title) ? $title . " - " : "") . "Kings' Conquest"; ?></title>
    <link rel="stylesheet" href="menu.css">
    <link rel="stylesheet" href="../fonts/fonts.css">
    <link rel="icon" type="image/png" href="../images/favicon.png" />
</head>