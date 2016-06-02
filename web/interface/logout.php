<?php
include '../dbcon.php';
include '../common.php';

if (isset($_SESSION['id'])) {
  session_destroy();
}

header ("Location: ../{$LOGIN_FORM_DIR}");
?>