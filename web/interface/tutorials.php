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
If you're feeling ready, you can try out one of four interactive gameplay tutorials below.<br /><br />

    <div class='btn lightbox_btn js_link' data-href='../game/tutorial1'>1. Basics</div>
    <div class='btn lightbox_btn js_link' data-href='../game/tutorial2'>2. Intermediate</div>
    <div class='btn lightbox_btn js_link' data-href='../game/tutorial3'>3. Advanced</div>
    <div class='btn lightbox_btn js_link' data-href='../game/tutorial4'>4. Expert</div>
</div> <br />

<?php echo genTitle("Contents"); ?>
<div class="box standard_box center">
<ol>
<a href="#intro"><li>Introduction</li></a>
<a href="#creating"><li>Creating A Game</li></a>
<a href="#creating"><li>Joining A Game</li></a>
<a href="#creating"><li>Starting A Game</li></a>
<a href="#creating"><li>Playing The Game</li></a>
<a href="#creating"><li>In-game Items</li></a>
<a href="#elo"><li>ELO Rating</li></a>
</ol>
</div><br />

<?php echo genTitle("Introduction"); ?><a name="intro"></a>
<div class="box standard_box">
Kings' Conquest is a turn-based fantasy multiplayer game.<br />
It is completely free to play and can be played from your browser without any installations.<br />
Playing a game requires you to use the standard <span class='highlight'>Lobby Room</span> system as we'll explain in the next few sections.
</div><br />

<?php echo genTitle("Creating A Game"); ?><a name="creating"></a>
<div class="box standard_box">
A game can be created in the <a href="index">Lobby page</a>. Simply click on the <span class='highlight'>Create Game</span> button, fill in a <span class='highlight'>room name</span> and if you like, a <span class='highlight'>room password</span> (where only people who know your room password may enter).<br /><br />

<img src="images/tut/create_game_button.png" class="tut_img" />
<img src="images/tut/arrow_right.png" class="arrow_right" />
<img src="images/tut/create_game_lb.png" class="tut_img" />
</div><br />

<?php echo genTitle("ELO Rating"); ?><a name="elo"></a>
<div class="box standard_box">
If you win a game, you win ELO, and losing a game causes you to lose ELO. ELOs are shown in the profile pages (or at the lobby page). The amount of ELO you can earn or lose depends on how high your opponent's ELO is.<br /><br />
The default starting ELO is <span class='highlight'>1,000</span>.
<br /><br />
A player's username is coloured according to his/her ELO, as indicated in the table below.<br /><br />
<table class='play_table elo_table lobby'>
<tr><th>ELO Rank/Colour</th><th>ELO Required</th></tr>
<?php
foreach ($ELO_COLOURS as $key => $value) {
  echo "<tr><td><span style='color: #{$value[0]}'>{$value[1]}</span></td><td>".number_format($key)."+</td></tr>";
}
?>
</table>
</div><br />


<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>