<?php
$title = "Tutorials";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';
?>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Tutorials"));
?>

<?php echo genTitle("Tutorials"); ?>
<div class="box standard_box center">
Welcome to the tutorials section.<br />
If you're feeling ready, you can try out one of four interactive tutorials below.<br /><br />

    <div class='btn lightbox_btn' id='tut1'>1. Movement</div>
    <div class='btn lightbox_btn' id='tut2'>2. Yo Momma</div>
    <div class='btn lightbox_btn' id='tut3'>3. Yo Dadda</div>
    <div class='btn lightbox_btn' id='tut4'>4. Yo Sista</div>
</div> <br />

<?php echo genTitle("Contents"); ?>
<div class="box standard_box center">
<ol>
<a href="#intro"><li>Introduction</li></a>
<li>Creating A Game</li>
<li>Joining A Game</li>
<li>Starting A Game</li>
<li>Playing The Game</li>
<li>In-game Items</li>
</ol>
</div><br />

<?php echo genTitle("Introduction"); ?><a name="intro"></a>
<div class="box standard_box">
Kings' Conquest is a turn-based fantasy multiplayer game.<br />
It is completely free to play and can be played from your browser without any installations.<br />
The game records how many games you won or lost, and we implement the ELO rating system. We will touch more on the ELO system at the end of the tutorial.
</div><br />

<?php echo genTitle("Creating A Game"); ?><a name="creating"></a>
<div class="box standard_box">
A game can be created in the <a href="index">Lobby page</a>. Simply click on the <span class='highlight'>Create Game</span> button, fill in a <span class='highlight'>room name</span> and if you like, a <span class='highlight'>room password</span> (where only people who know your room password may enter).<br /><br />

<img src="images/tut/create_game_button.png" class="tut_img" />
<img src="images/tut/arrow_right.png" class="arrow_right" />
<img src="images/tut/create_game_lb.png" class="tut_img" />
</div><br />

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>