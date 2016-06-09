<?php
require_once '../common.php';

if (!isset($_SESSION['id'])) { //user not logged in
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}
$result = $db->query("SELECT * FROM room_participants WHERE user_id = '{$user->id}' AND event = ''");
if (!$player = $result->fetch_object()) { //player is not in game
  header ("Location: ../{$LOGGEDIN_DIR}/");
  die();
}
$room_id = $player->room_id;

$result = $db->query("SELECT * FROM rooms WHERE room_id = {$room_id}");
$room = $result->fetch_object();
if ($result->num_rows == 0 || $room->state == 'deleted') { //user isn't in a room
  header ("Location: ../{$LOGGEDIN_DIR}/");
  die();
}
if ($room->state != 'ingame') { // game not started yet
  header ("Location: ../{$LOGGEDIN_DIR}/room");
  die();
}
?>
<html>
  <head>
    <style>
        body { 
          position: relative;
          background-image: url('graphics/background.jpg');
          background-position: repeat-x;
          padding: 0px;
          border: 0px;
          margin: 0px;
        }
       /* #sun {
          position: absolute;
          z-index: -100;
          left: 30px;
          top: 30px;
        }
        #gameCanvas {
          position: absolute;
          top: 0;
          left: 0;
          z-index: 0;
        }*/
        
      </style>
      <script>
<?php

  $result = $db->query("SELECT * FROM opp WHERE room_id = '{$room_id}' AND user_id != '{$user->id}' ORDER BY opp_id DESC LIMIT 1");
  $fetch = $result->fetch_object();
  $lastOppID = $fetch ? $fetch->opp_id : "0";
  echo "var lastOppID = {$lastOppID};";
  echo "var room_id = {$room_id};";
  echo "var DEFAULT_COUNTDOWN = {$DEFAULT_COUNTDOWN};";
  ?>
      </script>
  <script src="https://code.createjs.com/createjs-2015.11.26.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
  <script src="../interface/js/common.js"></script>
  <script src="js/opp.js"></script>
  </head>
  <body>
      
  <style type="text/css">
	  @font-face {
		  font-family: 04b_19;
		  src:url(./fonts/04B_19__.TTF);
	  }
  </style>
  <link rel="stylesheet" type="text/css" href="someCss.css">
  <script src = "./someJs.js" type="text/javascript"> </script>
    <div id="someBox2">
    <div id="box2_header">
      <img src="./warning.png" style="line-height: 1px; vertical-align: bottom; margin-right: 5px" height="20" width="20" /> System Message
    </div>
    <div id="box2_body">
      Are you sure to quite the game? <br /><br />
    </div>
    <div id="box_foot">
      <button type="button" id="yesButton" class="btn" ng-click="">Yes</button>
       <button type="button" id="noButton" class="btn" ng-click="">No</button>
    </div>
  </div>
  <canvas id="gameCanvas" width="5000px" height="5000px"></canvas>
  <script src="tiles.js"></script>
  </body>
</html>





