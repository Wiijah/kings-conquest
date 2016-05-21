<?php
error_reporting  (E_ALL);
ini_set ("display_errors", true); 

session_start();

$db = mysqli_connect("localhost","root","","kconq");
if (!$db) die("Unable to connect to the MySQL server.");

$isLoggedIn = isset($_SESSION['id']);

if ($isLoggedIn) {
  $query = "SELECT * FROM users WHERE id = '".$_SESSION['id']."'";
  $res = $db->query($query);
  $user = $res->fetch_object();
}

if (!isset($_SESSION['token'])) {
  $_SESSION['token'] = md5(rand(1, 2147483647)."asd89u");
}
$TOKEN = $_SESSION['token'];

function verifyToken(&$token) {
  global $TOKEN;
  return isset($token) && $TOKEN == $token;
}

function secureStr(&$str) {
  global $db;
  if (!isset($str)) return "";
  $str = htmlentities($str);
  $str = $db->real_escape_string($str);
  return $str;
}
?>