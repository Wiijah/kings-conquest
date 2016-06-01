<?php
$register = $_GET['social_register'];
$type = "";

switch ($register) {
  case "Facebook":
    $type = "Facebook";
    $profile = getAuth($type);
    break;
  case "Google":
    $type = "Google";
    $profile = getAuth($type);
    break;
  default:
    die("Invalid authentication type.");
}
// print_r($profile);

$socialID = secureStr($profile->identifier);

if (true) { //if user successfully authenticated
  $_SESSION['social_signup'] = $type;
  $_SESSION['social_signup_id'] = $socialID;
  $firstName = $profile->firstName;
  $lastName = $profile->lastName;
  $email = $profile->email;
} else {
  echo ("<script>alert('You failed to authenticate.')</script>");
}
?>