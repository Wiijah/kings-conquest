<?php
$title = "Profile";
require_once 'includes/header_checks.php';

$other = secureStr($_GET['username']);
$result = $db->query("SELECT * FROM users WHERE username = '{$other}'");
$prof = $result->fetch_object();

if (!$prof) {
  header ("Location: ../{$LOGGEDIN_DIR}/");
  die();
}

include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';
?>

<div class="small_container prof_user">

<?php echo genTitle("Profile Of {$prof->username}"); ?>
<div class="play_profile box">
<table class="play_table">
<tr><td class="prof_avatar" colspan="2"><img src="images/default_avatar.png" /></td></tr>
<tr><th>Username</th><td><?php echo $prof->username; ?> </td></tr>

<tr><th>Email</th><td><?php echo $prof->email; ?> </td></tr>
<tr><th>Games Won</th><td><?php echo number_format($prof->wins); ?> </td></tr>
<tr><th>Games Lost</th><td><?php echo number_format($prof->losses); ?> </td></tr>
<tr><th>Win/Loss Ratio</th><td><?php echo ratio($prof->wins, $prof->losses); ?> </td></tr>
<tr><th>Sign Up Date</th><td><?php echo formatSQLDate($prof->created); ?> </td></tr>
</table>
</div> <!-- play_profile box -->


</div> <!-- small_container -->

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>