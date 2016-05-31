<?php
if (!isset($COMMON)) exit;

if (isset($_POST['register'])) {
  $errors = array();
  $successes = array();
  
  $username = secureStr($_POST['username']);
  
  $email = secureStr($_POST['email']);
  $email2 = secureStr($_POST['email2']);
  
  $password = secureStr($_POST['password']);
  $password2 = secureStr($_POST['password2']);
  
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
    if ($result->num_rows > 0) $errors[] = "A user has already signed up with that {$socialType} account.";
  } else {
    if (!isStrLenCorrect($password, 8, 32)) $errors[] = "Your password must be between 8 to 32 characters.";
    if ($password != $password2) $errors[] = "Passwords don't match.";
  }

  //END social sign up

  /*
  $day = secureStr($_POST['day']);
  $month = secureStr($_POST['month']);
  $year = secureStr($_POST['year']);
  
  $dob = $year."-".$month."-".$day;
  $gender = secureStr($_POST['gender']);
  */

  /* Check if email exists */
  $email_exists = "SELECT * FROM users WHERE email = '{$email}'";
  $result = $db->query($email_exists);
  if ($result->num_rows > 0) $errors[] = "A user has already signed up with that email address. Please use another email.";
  
  /* Check if username exists */
  $username_exists = "SELECT * FROM users WHERE email = '{$email}'";
  $result = $db->query($username_exists);
  if ($result->num_rows > 0) $errors[] = "A user has already signed up with that username. Please pick another username.";

  if (!isStrLenCorrect($username, 3, 16)) $errors[] = "Your username must be between 3 to 16 characters.";

  if (!isValidEmail($email)) $errors[] = "You have entered an invalid email address.";
  
  if ($email != $email2) $errors[] = "Emails don't match.";
  
  $db->autocommit(FALSE);

  if (empty($errors)) { //no error occurred so far, so attempt to create user account
    $password = hashPass($password);
    
    $query = "INSERT INTO users (username, email, password) VALUES
    ('{$username}', '{$email}', '{$password}')";

    if (!$db->query($query)) {
      $errors[] = "An error occurred with creating your account. Please try again.";
    } else { //account successfully created
      $userID = $db->insert_id;
      if ($isSocialSignUp) {
        $query_social = "INSERT INTO login (socialid, userid, type) VALUES
          ('{$socialID}', '{$userID}', '{$socialType}')";
        if (!$db->query($query_social)) $errors[] = "An error occurred with creating your account. Please try again.";
      }
    } //end successful query
    
  } // end no errors so far
  
  //if all is good so far, then attempt to commit SQL results
  if (empty($errors)) {
    if (!$db->commit()) $errors[] = "An error occurred with creating your account. Please try again.";
  } else { //otherwise rollback
    $db->rollback(); //rollback
  }
  $db->autocommit(TRUE);
  
  if (!empty($errors)) { //print all errors if any
    $errorList = "";
    foreach ($errors as $value) $errorList .= "<li>{$value}</li>";
    $su_errorHTML = errorMessage("
      <strong>Error.</strong> The following errors have occurred.
      <ul>{$errorList}</ul>");
  } else { // otherwise, print success message

    unset($_SESSION['social_signup']);
    unset($_SESSION['social_signup_id']);
    $su_successHTML = successMessage("
      <strong>Congratulations.</strong>
      You have successfully created your new account.");
  }
}

?>