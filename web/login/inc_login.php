<?php
if(!isset($COMMON)) exit;

if (isset($_POST['login'])) {
  $login_errorHTML = "";
  
  $email = secureStr($_POST['email']);
  $password = secureStr($_POST['password']);
  $id_type = contains($email, '@') ? "email" : "username";

  $query = "SELECT * FROM users WHERE {$id_type} = '{$email}'";
  
  if (!$result = $db->query($query)) {
    $login_errorHTML = errorMessage("An error occurred. Please try again.");
  } else if (!($fetch = $result->fetch_object()) || !password_verify($password, $fetch->password)) {
    $login_errorHTML = errorMessage("Invalid login credentials. Please try again.");
  }
  
  if ($login_errorHTML == "") {
    $_SESSION['id'] = $fetch->id;
    header ("Location: ../{$LOGGEDIN_DIR}/");
    die();
  }
} //if post submit

?>