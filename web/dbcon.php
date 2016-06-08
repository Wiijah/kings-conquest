<?php
error_reporting  (E_ALL);
ini_set ("display_errors", true); 

session_start();
require_once 'dbacc.php';

$db = mysqli_connect("localhost",$DB_USER,$DB_PASS,$DB_NAME);
if (!$db) die("Unable to connect to the MySQL server.");

$isLoggedIn = isset($_SESSION['id']);

if ($isLoggedIn) {
  $query = "SELECT * FROM users WHERE id = '".$_SESSION['id']."'";
  $res = $db->query($query);
  $user = $res->fetch_object();
  updateLastActive();
}

if (!isset($_SESSION['token'])) {
  $_SESSION['token'] = md5(rand(1, 2147483647)."asd89u");
}
$TOKEN = $_SESSION['token'];

/* Security utility functions */
function verifyToken(&$token) {
  global $TOKEN;
  return isset($token) && $TOKEN == $token;
}

function secureStr(&$str) {
  global $db;
  if (!isset($str)) return "";
  $str = $db->real_escape_string($str);
  return $str;
}

function refreshUser() {
  global $db, $user;
  return $db->query("SELECT * FROM users WHERE id = {$user->id}")->fetch_object();
}
function secureInt(&$input) {
  return preg_replace("/[^0-9]/", "", $input);
}

function secureOutput(&$str) {
  if (!isset($str)) return "";
  return htmlentities(stripslashes($str)); 
}

function updateLastActive() {
  global $db;
  global $user;
  $db->query("UPDATE users SET lastactive = '".time()."' WHERE id = '{$user->id}'");
}
?>