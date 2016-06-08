<?php
$title = "Avatar";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$message = "";
/* Equip Item */
if (isset($_GET['equip'])) {
  $equip = secureInt($_GET['equip']);
  $result = $db->query("SELECT * FROM inventory JOIN items USING (item_id) WHERE user_id = '{$user->id}' AND item_id = '{$equip}'");
  $error = false;
  if (!$item = $result->fetch_object()) {
    $message = Message("Not In Inventory", "You don't currently have the item you tried to equip in your inventory.");
    $error = true;
  }
  if (!$error) {
    if ($user->{$item->type} != 0) give_item($user->{$item->type}, $user->id);
    take_item($item->item_id, $user->id);
    $db->query("UPDATE users SET {$item->type} = '{$item->item_id}' WHERE id = '{$user->id}'");
    $message = Message("Item Equipped", "You have successfully equipped the {$item->name}.");
  }
}
/* Unequip Item */
if (isset($_GET['unequip'])) {
  $type = secureInt($_GET['unequip']);
  if ($user->{$type} != 0) {
     give_item($user->{$type}, $user->id);
    $result = $db->query("SELECT * FROM inventory JOIN items USING (item_id) WHERE item_id = '{$user->{$type}}' AND user_id = '{$user->id}'");
    $item = $result->fetch_object();
    $db->query("UPDATE users SET {$item->type} = 0 WHERE id = '{$user->id}'");
    $message = Message("Item Unequipped", "You have successfully unequipped the {$item->name}.");
  }
}


$user = refreshUser();

/* Get items */
$items_html = "";

$result = $db->query("SELECT * FROM inventory JOIN items USING (item_id) WHERE user_id = '{$user->id}'");
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

if ($user->hat != 0) {
  $result = $db->query("SELECT * FROM items WHERE item_id = '{$user->hat}'");
  $fetch = $result->fetch_object();
  $equipped_list[] = $fetch;
}

$equipped_html = "";

foreach ($equipped_list as $value) {
  $equipped_html .= "<tr><td>".ucfirst($value->type)."</td><td>{$value->name}</td><td><a href='avatar?unequip={$fetch->type}'>Unequip</a></td></tr>";
}

if ($equipped_html == "") {
  $equipped_html = "<div class='box standard_box center'>You do not have any items equipped.</div>";
} else {
  $equipped_html = "<div class='box center'><table class='play_table'><tr><th>Equipped To</th><th>Item</th><th>Unequip</th></tr>{$equipped_html}</table></div>";
}

?>

<div class="small_container friends_container">
<?php

echo genBreadcrumbs(array("Lobby|index", "Avatar"));

echo $message;
?>

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