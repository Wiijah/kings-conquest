<?php
/* Common include of each ajax file */

header('Access-Control-Allow-Origin: *');

require_once '../../dbcon.php';

if (!isset($_SESSION['id'])) {
  die('[{"Session": "Expired"}]');
}
?>