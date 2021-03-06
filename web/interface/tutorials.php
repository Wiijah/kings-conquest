<?php
$title = "Tutorials";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$crown = '<img src="images/crown.png" style="position: absolute; width: 65px; top: -32px; right: -19px;" />';
$lock = '<img src="images/lock.png" style="position: absolute; width: 27px; top: 6px; right: 15px;" />';
?>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Tutorials"));
?>

<?php echo genTitle("Tutorials"); ?>
<div class="box standard_box center">
Welcome to the tutorials section.<br />
For tutorials concerning gameplay, you can try out the three interactive tutorials below.<br /><br />


    <div class='btn lightbox_btn goto_tut' data-href='../game/tutorial1' data-tut="1">1. Basics<?php if ($user->tutorial >= 2) echo $crown; ?></div>


    <div class='btn lightbox_btn goto_tut' data-href='../game/tutorial2' data-tut="2">2. Intermediate<?php if ($user->tutorial >= 3) echo $crown; ?><?php if ($user->tutorial <= 1) echo $lock; ?></div>
    <div class='btn lightbox_btn goto_tut' data-href='../game/tutorial3' data-tut="3">3. Advanced<?php if ($user->tutorial >= 4) echo $crown; ?><?php if ($user->tutorial <= 2) echo $lock; ?></div>
</div> <br />

<?php echo genTitle("Contents"); ?>
<div class="box standard_box center">
<ol>
<a href="#intro"><li>Introduction</li></a>
<a href="#creating"><li>Creating A Game</li></a>
<a href="#joining"><li>Joining A Game</li></a>
<a href="#starting"><li>Starting A Game</li></a>
<a href="#items"><li>Items & Avatars</li></a>
<a href="#elo"><li>ELO Rating</li></a>
</ol>
</div><br />

<a name="intro"></a><?php echo genTitle("Introduction"); ?>
<div class="box standard_box">
Kings' Conquest is a turn-based fantasy multiplayer game.<br /><br />
The game uses a <span class='highlight'>Lobby Room</span> system as we'll explain in the next three sections.
</div><br />

<a name="creating"></a><?php echo genTitle("Creating A Game"); ?>
<div class="box standard_box">
A game can be created in the <a href="index">Lobby page</a>. Simply click on the <span class='highlight'>Create Game</span> button, fill in a <span class='highlight'>room name</span> and if you like, a <span class='highlight'>room password</span> (where only people who know your room password may enter).<br /><br />

<img src="images/tut/create_game_button.png" class="tut_img" />
<img src="images/tut/arrow_right.png" class="arrow_right" />
<img src="images/tut/create_game_lb.png" class="tut_img" />
</div><br />

<a name="joining"></a><?php echo genTitle("Joining A Game"); ?>
<div class="box standard_box">
To join a game, click on the <span class='highlight'>Join</span> game button.<br /><br />
<img src="images/tut/join_game.png" class="tut_mc" />
</div><br />

<a name="starting"></a><?php echo genTitle("Starting A Game"); ?>
<div class="box standard_box">
Once in the game room, you can chat to other players in that room. Only the room owner can start the game once all other players are ready and that the room is full.
If you are not the room owner, then you must click <span class='highlight'>Ready</span> before the room owner can start the game.<br /><br />
<img src="images/tut/start_game_ready.png" class="tut_mc" /><br /><br />

Otherwise, if you are the room owner, you may start the game by clicking <span class='highlight'>Start</span>.
<img src="images/tut/start_game_start.png" class="tut_mc" /><br /><br />

The room owner may also kick other players by clicking on the <span class='highlight'>Kick</span> as shown below.
<img src="images/tut/start_game_kick.png" class="tut_mc" /><br /><br />

You can leave the game room by clicking on <span class='highlight'>Leave Room</span>.
<img src="images/tut/start_game_leave.png" class="tut_mc" /><br /><br />
</div><br />

<a name="items"></a><?php echo genTitle("Items & Avatars"); ?>
<div class="box standard_box">
You can buy items from the shop by spending <span class='highlight'>King Points</span> and use them to customise your avatar.<br /><br />
To buy items from the shop, click on the <span class='highlight'>Shop</span> button from the lobby and click on <span class='highlight'>Purchase</span>.
<img src="images/tut/avatar_shop.png" class="tut_img" />
<img src="images/tut/arrow_right.png" class="arrow_right" />
<img src="images/tut/avatar_purchase.png" class="tut_img" />
<br /><br />
You can <span class='highlight'>equip</span> items to personalise your avatar. To do so, click on the <span class='highlight'>Customise Avatar</span> button from the lobby and then click on <span class='highlight'>Equip</span> to equip an item.
<img src="images/tut/avatar_btn.png" class="tut_img" />
<img src="images/tut/arrow_right.png" class="arrow_right" />
<img src="images/tut/avatar_equip.png" class="tut_img" />
<br /><br />
You can also unequip items from your avatar by clicking on <span class='highlight'>Unequip</span>.<br />
<img src="images/tut/avatar_unequip.png" class="tut_mc" />
</div><br />

<a name="elo"></a><?php echo genTitle("ELO Rating"); ?>
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


<?php include 'includes/footer.php'; ?>