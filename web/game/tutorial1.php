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
  <script src="../interface/js/lightbox.js"></script>
  <script src="../interface/js/common.js"></script>
  <link rel="stylesheet" href="css/lightbox.css">
  <style type="text/css">
    @font-face {
      font-family: 04b_19;
      src:url(./fonts/04B_19__.TTF);
    }
  </style>
  
  <link rel="stylesheet" type="text/css" href="someCss.css">
  <script src = "./someJs.js" type="text/javascript"> </script>

  </head>

  <body onload="displayBox(backgroundInfo);">

  <?php include 'includes/lightbox.php'; ?>
      
  <canvas id="gameCanvas" width="5000px" height="5000px"></canvas>
  <script src="tutorial1.js"></script>

  <div id="someBox">
    <div id="box_header">
      <img src="./i_icon.png" style="line-height: 1px; vertical-align: bottom; margin-right: 5px" height="20" width="20" />Tutorial 1 : Basics
    </div>
    <div id="box_body">
      Welcome to King's Conquest. Your top priority is to kill the enemy's king to win the game. In this tutorial, you will learn how to move a unit and attack an enemy<br /><br />
    </div>
    <div id="box_foot">
      <button type="button" id="actionButton" class="btn" ng-click="">OK</button>
      <button type="button" id="actionButton2" class="btn" ng-click="" style="display: none">OK</button>
    </div>
  </div>

  
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

   <div id="someBox3">
    <div id="box3_header">
      <img src="./finishTutorial.png" style="line-height: 1px; vertical-align: bottom; margin-right: 5px" height="20" width="20" />Congratulations
    </div>
    <div id="box3_body">
      <p>Well Done! Now you know how the move and attack works in King's Conquest. In the next Chapter, you will learn how to build your own army to fight against the enemy. </p><p>Click 'Next' to Tutorial2</p>
    </div>
    <div id="box_foot">
      <button type="button" id="quitButton" class="btn2" ng-click="">Quit</button>
      <button type="button" id="nextButton" class="btn" ng-click="">Next</button>
    </div>
  </div>



    <div id = "maskBox1"> <style>
      #maskBox1 {
        position:fixed;
        z-index:30;
        right:400px;
        top:0;
        background: rgba(0,0,0,.7);
        width:100%;
        height:100%;
        display: none;
       }
       </style></div>
    <div id = "maskBox2"> <style>
      #maskBox2 {
        position:fixed;
        z-index: 30;
        margin-left: 100%;
        left: -400px;
        bottom: 200px;
        background: rgba(0,0,0,.7);
        width:100%;
        height:100%;
        display: none;
       }
       </style></div>
</body>
</html>





