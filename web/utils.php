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

function select_user($user_id) {
  global $db;
  return $db->query("SELECT * FROM users WHERE id = '{$user_id}'")->fetch_object();
}

function select_part($user_id, $room_id, $is_spectator = -1) {
  global $db;
  $extra_sql = "";
  if ($is_spectator != -1) $extra_sql = " AND is_spectator = '{$is_spectator}'";
  $result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user_id}' AND room_id = '{$room_id}' AND event = ''{$extra_sql}");
  if (!$result) return false;
  return $result->fetch_object();
}
// Password encryption
/*$options = array(
    'salt' => "a93d92454321l3p09o6009"
);*/
function hashPass($pass) {
  if ($pass == "") return "";
  return password_hash($pass, PASSWORD_BCRYPT);
}

function passVerify($input, $encrypted_password) {
  return $input == "" && $encrypted_password == "" || password_verify($input, $encrypted_password);
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
function unixDate($date) {
  return date('d<\s\u\p>S</\s\u\p> F Y - g:i:sa', $date);
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


function myTime($from, $target){ //declare function, seconds is the default unit
  $return = "";
  $unitVal = array((1), (60), (60*60), (60*60*24), (60*60*24*7), (60*60*24*(365.25/12)), (60*60*24*365.25));
  $unit = array("second", "minute", "hour", "day", "week", "month", "year");
  $date = "";
  $start = "";
  $plural = "";
  
  $secondsLeft = $target - $from;
  if($secondsLeft < 0){$passed=1;}else{$passed=0;}
  $secondsLeft = abs($secondsLeft);
  if($secondsLeft == 0){$return = "NOW";} //the $target time is equal to the time now

  $i = 6; //start with year
  if($return == ""){
    while($i >= 0 && $secondsLeft > 0){ // going through each of the required units
      $timeLeft = floor($secondsLeft / $unitVal[$i]);

      if($timeLeft > 1){$plural = "s";}else{$plural="";} //add plurals if appropriate
      if($return != ""){$start = ", ";} //separate with commas if appropriate
      
      $secondsLeft = $secondsLeft - ($timeLeft * $unitVal[$i]);
      if($secondsLeft < 1 && $return != ""){$start = " and ";}
      
      //if value is > 0, then concatenate to $return otherwise it's not necessary to
      if($timeLeft > 0){$return .= $start.$timeLeft." ".$unit[$i].$plural;} 

      $i = $i - 1;
    } //end while loop bracket
  } //end if ($return == "")
  
  //comment out or remove the next line out if you don't want it to state "ago" if the timestamp ($target) is from the past
  //if($passed == 1){$return .= " ago";} //parameter $target is from the past
  //if($passed == 2){$return .= " to go";} //remove the comment if you want it to state 'to go'
  //$return .= "."; //add full stop at the end, remove this line if you don't want it to
  return $return;
}
?>