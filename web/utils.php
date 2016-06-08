<?php
function isValidEmail($email) {
  return !filter_var($email, FILTER_VALIDATE_EMAIL) === false;
}

function isStrLenCorrect($string, $min, $max) {
  $len = mb_strlen($string);
  return $len >= $min && $len <= $max;
}

function genTitle($title) {
  return "<div class='title'><h1>{$title}</h1></div>";
}
// Password encryption
/*$options = array(
    'salt' => "a93d92454321l3p09o6009"
);*/
function hashPass($pass) {
  //password_hash uses a random salt, so no need to set one
  return password_hash($pass, PASSWORD_BCRYPT);
}

function passVerify($input, $encrypted_password) {
  return password_verify($input, $encrypted_password);
}
//ekko is an extension to echo, supporting undeclared variables
function ekko(&$str) {
  if (!isset($str)) echo "";
  echo $str;
}

function percent($a, $b) {
  if ($a + $b == 0) return 0;
  return round(100 * $a / ($a + $b), 2);
}

function ratio($a, $b) {
  if ($b == 0) return 0;
  return round($a / $b, 2);
}

function formatSQLDate($date) {
  return date('d<\s\u\p>S</\s\u\p> F Y', strtotime($date));
}
//check if a string contains a substring
function contains($haystack, $needle) {
  return $needle == "" || (strpos($haystack, $needle) !== false);
}

//check if both variables $a and $b are set and equal to each other
function setAndEquals(&$a, &$b) {
  return isset($a) && isset($b) && $a == $b;
}

//bootstrap functions
function errorMessage($msg) {
  return "<div class='alert alert-danger' role='alert'>{$msg}</div>";
}

function successMessage($msg) {
  return "<div class='alert alert-success' role='alert'>{$msg}</div>";
}

function digitalTime($time) {
  return date("g:i:sa", strtotime($time));
}
?>