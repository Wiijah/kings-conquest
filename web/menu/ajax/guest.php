<?php
require_once 'ajax_common.php';

$username = secureStr($_POST['username']);
$email = "";
$password = "";

/* Check if username exists */
$username_exists = "SELECT * FROM users WHERE username = '{$username}'";
$result = $db->query($username_exists);
if ($result->num_rows > 0) kc_error("A user has already signed up with that display name. Please pick another name.");

if (!isStrLenCorrect($username, 3, 16)) kc_error("Your display name must be between 3 to 16 characters.");

if (!preg_match('~^[a-z0-9 ]+$~i', $username)) kc_error("Display names are not allowed to contain special characters.");

$db->autocommit(FALSE);
$email = rand(1,2147483647) + "@"+rand(1,2147483647) +".com";

$query = "INSERT INTO users (username, email, password, member_type, lastactive) VALUES
('{$username}', '{$email}', '{$password}', 'guest', '".time()."')";

if (!$db->query($query)) {
  kc_error("An error occurred with logging you in as a guest. Please try again.");
} else { //account successfully created
  $userID = $db->insert_id;
} //end successful query

//if all is good so far, then attempt to commit SQL results
if (!$db->commit()) {
  kc_error("An error occurred with the server. Please try again later.");
}
$db->autocommit(TRUE);

/* Automatically login the account the user just created */
$_SESSION['id'] = $userID;
echo $AJAX_SUCCESS;
?>