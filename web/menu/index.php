<?php
require_once '../common.php';
if (isset($_SESSION['id'])) {
  header ("Location: ../{$LOGGEDIN_DIR}/");
  die();
}
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
<div class="home_left goto_login home_hover">
<img src="images/big_blue_king.png" class="home_king" /><br />
<img src="images/btn_brush.png" class="home_btn" />
<div class="home_btn_text">Login</div>
</div>


<div class="home_middle home_hover lightbox_open" data-lb="guest">
<img src="images/big_green_king.png" class="home_king" /><br />
<img src="images/btn_brush.png" class="home_btn" />
<div class="home_btn_text">Guest</div>
</div>

<div class="home_right goto_register home_hover">
<img src="images/big_red_king.png" class="home_king" /><br />
<img src="images/btn_brush.png" class="home_btn" />
<div class="home_btn_text">Register</div>
</div>

<div id="credits">
<div class="home_box">
In no particular order, the game was developed by Alan Du, Pierre-Louis Rivierre, Hanou Chen and Rendy Li.<br /><br />
We used the following resources on our game:
<ol>
  <li>Facebook SDK<br />https://github.com/facebook/facebook-php-sdk-v4/</li>
  <li>Cloud image<br />http://pngimg.com/upload/cloud_PNG4.png</li>
  <li>jQuery<br />https://jquery.com/</li>
  <li>CreateJS and EaselJS<br />http://www.createjs.com/</li>
  <li>Loading Animation<br />http://loading.io/</li>
  <li>Epic Fantasy Music<br />http://opengameart.org/content/epic- fantasy-music</li>
</ol>
</div>
<div class="goto_home_btn goto_home">Home</div>
</div>

<div id="intro">
<div class="home_box">
Kings' Conquest is a <span class='home_highlight'>turned-based multiplayer
game</span> aimed at fans of the <span class='home_highlight'>fantasy</span> or
<span class='home_highlight'>strategy</span> genre.<br /><br />
Best viewed with both eyes open and on Chrome.
</div>
<div class="goto_home_btn goto_credits">Credits</div>
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

  <input type="submit" value="Login with Facebook" class="login_btn fb_btn" id="btn_fb" />
  <br /><br />
  <div class="white_line"></div>
  <br />Don't have an account? Click <a class="goto_register">here</a> to register!
  <br />Forgot your password? Click <a>here</a>.
  </div>
  <div class="goto_home_btn goto_home">Home</div>
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

<span id="reg_passwords">
  Password
  <br /><input type="password" class="login_text" id="reg_pass1" /><br /><br />

  Password
  <br /><input type="password" class="login_text" id="reg_pass2" /><br /><br />
</span>
<span id="register_social">
The account you are registering will be authenticated by your Facebook account.<br /><br />
</span>

  <input type="submit" value="Register" class="login_btn" id="btn_register" />
  
  <input type="submit" value="Register using Facebook" style="width: 185px" class="login_btn fb_btn" id="btn_fb_reg" />
<br /><br />
  <div class="white_line"></div>
  <br />Already have an account? Click <a class="goto_login">here</a> to login!
  </div>
  <div class="goto_home_btn goto_home">Home</div>
</div> 
<!-- end register -->

  <div class="white_line"></div><br />
  <div class="footer">&copy; 2016 Kings' Conquest</div>
  </div>

  <br /><br />

  <script src="tiles.js"></script>
  </body>
</html>





