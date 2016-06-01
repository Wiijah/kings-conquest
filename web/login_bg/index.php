<?php
require_once '../common.php';
$HA_CONSTRUCTOR_PATH = "../hybridauth/hybridauth/config.php";
require_once '../inc_ha.php';

if (isset($_POST['register'])) {
  require_once 'inc_signup.php';
} else if (isset($_POST['login'])) {
  require_once 'inc_login.php';
}

if (verifyToken($_GET['token'])) {
  if (isset($_GET['social_login'])) {
    require_once 'inc_social_login.php';
  } else if (isset($_GET['social_register'])) {
    require_once 'inc_social_register.php';
  }
} else {
  //print_r($_GET);
}
?>
<html>
  <head>
    <title><?php echo $APP_NAME; ?></title>
    <link rel="icon" type="image/png" href="../images/favicon.png" />
    <link rel="stylesheet" href="../fonts/fonts.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.createjs.com/easeljs-0.8.2.min.js"></script>
    <script src="https://code.createjs.com/createjs-2015.11.26.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
  </head>
  <body>
  <canvas id="gameCanvas" width="1920px" height="1080px"></canvas>

  <img src="images/logo_login.png" id="top" />
  <div id="slogan">Turn-based Fantasy Multiplayer Game</div>

  <div id="right_container">
  <div class='title'><h1>Login</h1></div>

  <div class="login_box">
  Username or Email
  <br /><input type="text" class="login_text" id="username" />
  <br /><br />
  Password
  <br /><input type="password" class="login_text" id="password" />
  <br /><br />
  <input type="submit" value="Login" class="login_btn" />
  <br /><br />
  <div class="white_line"></div>
  <br />Don't have an account? Click <a>here</a> to register!
  <br />Forgot your password? Click <a>here</a>.
  </div>
<br /><br />
  <div class="white_line"></div><br />
  <div class="footer">&copy; 2016 Kings' Conquest</div>
  </div>

  <br /><br />

  <script src="tiles.js"></script>
  </body>
</html>





