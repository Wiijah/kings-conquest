<?php
$title = "Avatar";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

/* Get items */
$items_html = "";

$result = $db->query("SELECT * FROM inventory JOIN items ON inventory.item_id = items.item_id WHERE user_id = '{$user->id}'");
while ($fetch = $result->fetch_object()) {
  $items_html .= "<tr><td>{$fetch->name}</td><td>{$fetch->quantity}<td><a href='avatar?equip={$fetch->item_id}'>Equip</a></td></tr>";
}

if ($items_html == "") {
  $items_html = "<div class='box standard_box center'>You do not have any items in your inventory.</div>";
} else {
  $items_html = "<div class='box center'><table class='play_table'><tr><th>Item</th><th>Quantity</th><th>Equip</th></tr>{$items_html}</table></div>";
}

/* Equipped HTML */
$equipped_list = array();

if ($user->head != 0) {
  $result = $db->query("SELECT * FROM items WHERE item_id = '{$user->head}'");
  $fetch = $result->fetch_object();
  $equipped_list[] = $fetch;
}

$equipped_html = "";

foreach ($equipped_list as $value) {
  $equipped_html .= "<tr><td>".ucfirst($value->type)."</td><td>{$value->name}</td><td><a href='avatar?unequip={$fetch->item_id}'>Unequip</a></td></tr>";
}

if ($equipped_html == "") {
  $equipped_html = "<div class='box standard_box center'>You do not have any items equipped.</div>";
} else {
  $equipped_html = "<div class='box center'><table class='play_table'><tr><th>Equipped To</th><th>Item</th><th>Unequip</th></tr>{$equipped_html}</table></div>";
}

?>

<div class="small_container friends_container">
<?php
/* Equip Item */
if (isset($_GET['equip'])) {
  $equip = secureStr($_GET['equip']);
  
}

?>
<?php echo genBreadcrumbs(array("Lobby|index", "Avatar")); ?>

<?php echo genTitle("Customise Avatar"); ?>
<div class="box standard_box center">
<img src="<?php echo getAvatarURL($user->id); ?>" class="avatar" />
<br /><br />
Here you can customise your avatar with items you have earned.
</div> 
<br />

<?php echo genTitle("Equipped Items").$equipped_html; ?>
<br />

<?php echo genTitle("Equippable Items Not Equipped").$items_html; ?>


<div class="clear"></div>
<div class="footer">
<div class="white_line footer_line"></div>
&copy; 2016 Kings' Conquest
</div>
</body>
</html>