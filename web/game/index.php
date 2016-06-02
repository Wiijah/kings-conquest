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
    <script src="https://code.createjs.com/createjs-2015.11.26.min.js"></script>
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
  <script src="https://code.createjs.com/createjs-2015.11.26.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
  <script src="../interface/js/common.js"></script>
  </head>
  <body>
      
  <style type="text/css">
	  @font-face {
		  font-family: 04b_19;
		  src:url(./fonts/04B_19__.TTF);
	  }
  </style>
  <canvas id="gameCanvas" width="5000px" height="5000px"></canvas>
  <script src="tiles.js"></script>
  </body>
</html>





