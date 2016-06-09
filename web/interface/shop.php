<?php
$title = "Shop";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/avatar.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$message = "";

if (isset($_GET['purchase'])) {
  $purchase = secureStr($_GET['purchase']);
  $result = $db->query("SELECT * FROM items WHERE price > 0 AND item_id = '{$purchase}'");
  $error = false;
  if (!$item = $result->fetch_object()) {
    $message = Message("Invalid Item", "The item you tried to purchase was invalid.");
    $error = true;
  }
  if (!$error && $user->kp < $item->price) {
    $message = Message("Not Enough Points", "You do not have enough King Points to purchase this item.");
    $error = true;
  }
  if (!$error) {
    give_item($item->item_id, $user->id);
    $message = Message("Purchase Successful", "You have successfully purchased the item <span class='highlight'>{$item->name}</span> for <span class='highlight'>".number_format($item->price)."</span> King Points.");
    $user->kp -= $item->price;
    $db->query("UPDATE users SET kp = '.$user->kp.' WHERE id = {$user->id}");
  }
}
?>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Shop"));

echo $message;
?>

<?php echo genTitle("Shop"); ?>
<div class="box standard_box center">
<img src="<?php echo getAvatarURL($user->id); ?>" class="avatar" />
<br /><br />
Here you can use your hard-earned King Points to purchase merchandise.<br />
You currently have <span class='highlight'><?php echo number_format($user->kp); ?></span> King Points.
</div> 
<br />

<?php echo genTitle("Merchandise"); ?>
<div class="box center">
<table class="play_table lobby">
<tr><th> - </th><th>Item</th><th>Price (King Points)</th><th>Purchase</th></tr>
<?php
$result = $db->query("SELECT * FROM items WHERE price > 0 ORDER BY price ASC");
while ($item = $result->fetch_object()) {
  echo "<tr><td>".iconImg($item->image)."</td><td>{$item->name}</td><td>".number_format($item->price)."</td><td><a href='shop?purchase={$item->item_id}'>Purchase</a></td></tr>";
}
?>
</table>
</div>

<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>