<?php
require_once '../common.php';

if (!isset($_SESSION['id'])) {
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}
?>