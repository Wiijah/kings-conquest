<?php
require_once '../common.php';
require_once 'items.php';

if (!isset($_SESSION['id'])) {
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}
?>