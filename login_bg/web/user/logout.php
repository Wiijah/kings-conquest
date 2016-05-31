<?php
include '../dbcon.php';
include '../common.php';

if (!isset($_SESSION['id'])) {
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}

session_destroy();
echo "You have successfully logged out.<meta http-equiv='refresh' content='1;url=../{$LOGIN_FORM_DIR}'>";
?>