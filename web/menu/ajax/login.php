<?php
require_once 'ajax_common.php';

$email = secureStr($_POST['username']);
$password = secureStr($_POST['password']);
$id_type = contains($email, '@') ? "email" : "username";

$query = "SELECT * FROM users WHERE {$id_type} = '{$email}'";

if (!$result = $db->query($query)) {
  kc_error("An error occurred with the server. Please try again.");
} else if (!($fetch = $result->fetch_object()) || !password_verify($password, $fetch->password) || $password == "") {
  kc_error("Invalid login credentials. Please try again.");
}

$_SESSION['id'] = $fetch->id;
echo $AJAX_SUCCESS;
?>