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

  <body onload="displayBox(showKingTutorial);">

  <?php include 'includes/lightbox.php'; ?>
      
  <canvas id="gameCanvas" width="5000px" height="5000px"></canvas>
  <script src="tutorial2.js"></script>

  <div id="someBox">
    <div id="box_header">
      <img src="./i_icon.png" style="line-height: 1px; vertical-align: bottom; margin-right: 5px" height="20" width="20" />Tutorial 2 : Intermediate
    </div>
    <div id="box_body">
      Now you know the basic actions move and attack in Kings Conquest. There are several units with different skills in King's Conquest. In this tutorial, you are going to learn the <b>skill of each unit</b>. Let's start with the king.<br /><br />
    </div>
    <div id="box_foot">
      <button type="button" id="actionButton" class="btn" ng-click="">Next</button>
      <button type="button" id="actionButton2" class="btn" ng-click="" style="display: none">OK</button>
    </div>
  </div>

  
  <div id="someBox2">
    <div id="box2_header">
      <img src="./warning.png" style="line-height: 1px; vertical-align: bottom; margin-right: 5px" height="20" width="20" /> System Message
    </div>
    <div id="box2_body">
      Are you sure to quit the game? <br /><br />
    </div>
    <div id="box_foot">
      <button type="button" id="yesButton" class="btn2" ng-click="">Yes</button>
       <button type="button" id="noButton" class="btn" ng-click="">No</button>
    </div>
  </div>



     <div id="someBox3">
    <div id="box3_header">
      <img src="./finishTutorial.png" style="line-height: 1px; vertical-align: bottom; margin-right: 5px" height="20" width="20" />Congratulations
    </div>
    <div id="box3_body">
    <b style="color:red;">Good job!</b><br><br>You finish Tutorial 2. In the next Chapter, you will learn how to build your own army to fight against the enemy. <br><br><b style="color:black;">Click 'Next' to Tutorial 3</b>
    </div>
    <div id="box_foot">
      <button type="button" id="quitButton" class="btn2" ng-click="">Quit</button>
      <button type="button" id="nextButton" class="btn" ng-click="">Next</button>
    </div>
  </div>
  
  </body>
</html>





