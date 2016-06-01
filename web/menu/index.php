<?php
require_once '../common.php';
?>
<html>
  <head>
    <title><?php echo $APP_NAME; ?></title>
    <link rel="icon" type="image/png" href="../images/favicon.png" />
    <link rel="stylesheet" href="../fonts/fonts.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="../interface/css/lightbox.css">
    <script src="https://code.createjs.com/easeljs-0.8.2.min.js"></script>
    <script src="https://code.createjs.com/createjs-2015.11.26.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
    <script src="../interface/js/common.js"></script>
    <script src="../interface/js/lightbox.js"></script>
    <script src="js/menu.js"></script>
  </head>
  <body>
  <?php include 'includes/lightbox.php'; ?>
  <canvas id="gameCanvas" width="1920px" height="1180px"></canvas>
  <img src="graphics/sun.png" id="sun" />
  <div class="clouds"></div>
  <img src="images/logo_login.png" id="top" />
  <div id="slogan">Turn-based Fantasy Multiplayer Game</div>

  <div id="right_container">


<!-- start home -->

<div id="home_container" class="menu_container">
<div class="home_left goto_login">
<img src="images/big_blue_king.png" class="home_king" /><br />
<img src="images/btn_brush.png" class="home_btn" />
<div class="home_btn_text">Login</div>
</div>

<div class="home_right goto_register">
<img src="images/big_red_king.png" class="home_king" /><br />
<img src="images/btn_brush.png" class="home_btn" />
<div class="home_btn_text">Register</div>
</div>

<div class="home_box">
Kings' Conquest is a <span class='home_highlight'>turned-based multiplayer
game</span> aimed at fans of the <span class='home_highlight'>fantasy</span> or
<span class='home_highlight'>strategy</span> genre.
</div>

</div>
<!-- end home -->

<!-- start login -->

<div id="login_container" class="menu_container">
  <?php echo genTitle("Login"); ?>

  <div class="login_box">
  Username or Email
  <br /><input type="text" class="login_text" id="username" />
  <br /><br />
  Password
  <br /><input type="password" class="login_text" id="password" />
  <br /><br />
  <input type="submit" value="Login" class="login_btn" id="btn_login" />
  <br /><br />
  <div class="white_line"></div>
  <br />Don't have an account? Click <a class="goto_register">here</a> to register!
  <br />Forgot your password? Click <a>here</a>.
  </div>
</div>
<!-- end login -->

<!-- start register -->
<div id="register_container" class="menu_container">
  <?php echo genTitle("Register"); ?>
  <div class="login_box">
  Username
  <br /><input type="text" class="login_text" id="reg_user" /><br /><br />

  Email
  <br /><input type="text" class="login_text" id="reg_email1" /><br /><br />

  Re-enter Email
  <br /><input type="text" class="login_text" id="reg_email2" /><br /><br />

  Password
  <br /><input type="password" class="login_text" id="reg_pass1" /><br /><br />

  Password
  <br /><input type="password" class="login_text" id="reg_pass2" /><br /><br />

  <input type="submit" value="Register" class="login_btn" id="btn_register" />
  <br /><br />
  <div class="white_line"></div>
  <br />Already have an account? Click <a class="goto_login">here</a> to login!
  </div>
</div> 
<!-- end register -->


<br /><br />
  <div class="white_line"></div><br />
  <div class="footer">&copy; 2016 Kings' Conquest</div>
  </div>

  <br /><br />

  <script src="tiles.js"></script>
  </body>
</html>





