<?php
/* Common include of each ajax file */
header('Access-Control-Allow-Origin: *');
header("Content-Type: application/json; charset=UTF-8");

require_once '../../dbcon.php';

if (!isset($_SESSION['id'])) {
  die('{"session_error":"session_expired"}');
}
?>