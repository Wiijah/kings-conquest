<html>
  <head>
    <script src="https://code.createjs.com/createjs-2015.11.26.min.js"></script>
    <script>
    lightbox_alert("Hi", "Hello world!");
    </script>
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
  
  </head>
  <body>
  <?php include 'includes/lightbox.php'; ?>
      
  <canvas id="gameCanvas" width="5000px" height="5000px"></canvas>
  <script src="tutorial1.js"></script>
  </body>
</html>





