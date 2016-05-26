<?php
$login = $_GET['social_login'];

switch ($login) {
  case "Facebook":
    $type = "Facebook";
    $profile = getAuth($type);
    break;
  default:
    die("Invalid authentication type.");
}
// print_r($profile);

$socialID = secureStr($profile->identifier);
$result = $db->query("SELECT * FROM login WHERE socialid = '{$socialID}'");

if ($fetch = $result->fetch_object()) { //if user successfully logged in
  $_SESSION['id'] = $fetch->userid;
  header ("Location: ../{$LOGGEDIN_DIR}/");
  exit;
} else {
  echo ("<script>alert('not logged in!')</script>");
}
?>