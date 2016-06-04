<?php
require_once 'ajax_common.php';

$username = secureStr($_POST['username']);
$email = secureStr($_POST['email']);
$password = secureStr($_POST['password']);

//START social sign up
$isSocialSignUp = setAndEquals($_SESSION['social_signup'], $_POST['social_signup']) &&
    setAndEquals($_SESSION['social_signup_id'], $_POST['social_signup_id']);
if ($isSocialSignUp) {
  $socialID = $_SESSION['social_signup_id'];
  $socialType = $_SESSION['social_signup'];
  $password = "";

  //social exists
  $social_exists = "SELECT * FROM login WHERE socialid = '{$socialID}' AND type = '{$socialType}'";
  $result = $db->query($social_exists);
  if ($result->num_rows > 0) kc_error("A user has already signed up with that {$socialType} account.");
} else {
  if (!isStrLenCorrect($password, 8, 32)) kc_error("Your password must be between 8 to 32 characters.");
}
//END social sign up

/* Check if email exists */
$email_exists = "SELECT * FROM users WHERE email = '{$email}'";
$result = $db->query($email_exists);
if ($result->num_rows > 0) kc_error("A user has already signed up with that email address. Please use another email.");

/* Check if username exists */
$username_exists = "SELECT * FROM users WHERE email = '{$email}'";
$result = $db->query($username_exists);
if ($result->num_rows > 0) kc_error("A user has already signed up with that username. Please pick another username.");

if (!isStrLenCorrect($username, 3, 16)) kc_error("Your username must be between 3 to 16 characters.");

if (!isValidEmail($email)) kc_error("You have entered an invalid email address.");

$db->autocommit(FALSE);

/* Insert and create account */
$password = hashPass($password);

$query = "INSERT INTO users (username, email, password) VALUES
('{$username}', '{$email}', '{$password}')";

if (!$db->query($query)) {
  kc_error("An error occurred with creating your account. Please try again.");
} else { //account successfully created
  $userID = $db->insert_id;
  if ($isSocialSignUp) {
    $query_social = "INSERT INTO login (socialid, userid, type) VALUES
      ('{$socialID}', '{$userID}', '{$socialType}')";
    if (!$db->query($query_social)) kc_error("An error occurred with creating your account. Please try again.");
  }
} //end successful query

//if all is good so far, then attempt to commit SQL results
if (!$db->commit()) {
  kc_error("An error occurred with the server. Please try again later.");
}
$db->autocommit(TRUE);

/*
if (isset($_SESSION['social_signup'])) unset($_SESSION['social_signup']);
if (isset($_SESSION['social_signup_id'])) unset($_SESSION['social_signup_id']);
*/

/* Automatically login the account the user just created */
$_SESSION['id'] = $userID;
echo $AJAX_SUCCESS;
?>