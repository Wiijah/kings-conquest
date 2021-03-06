<?php
$title = "Avatar";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/avatar.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';


/* Update achievements */
$result = $db->query("SELECT * FROM users");
while ($fetch = $result->fetch_object()) {
  $room_id = 0;
  if ($fetch->wins > 0) giveAch("first_win", $fetch, $room_id);
  if ($fetch->losses > 0) giveAch("first_lost", $fetch, $room_id);
  if ($fetch->wins > 49) giveAch("50_wins", $fetch, $room_id);
  if ($fetch->wins > 99) giveAch("100_wins", $fetch, $room_id);
  if ($fetch->wins > 0) giveAch("perfect_win", $fetch, $room_id);
}

/* End achievements */

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
  $type = secureStr($_GET['unequip']);
  if (in_array($type, $LAYERS) && $user->{$type} != 0) {
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
  $items_html .= "<tr><td>".avatarImg($fetch)."</td><td>".avatarTitle($fetch)."</td><td>{$fetch->quantity}<td><a href='avatar?equip={$fetch->item_id}'>Equip</a></td></tr>";
}

if ($items_html == "") {
  $items_html = "<div class='box standard_box center'>You do not have any items in your inventory.</div>";
} else {
  $items_html = "<div class='box center'><table class='play_table'><tr><th>-</th><th>Item</th><th>Quantity</th><th>Equip</th></tr>{$items_html}</table></div>";
}

/* Equipped HTML */
$equipped_list = array();

foreach ($LAYERS as $value) {
  if ($user->{$value} != 0) {
    $result = $db->query("SELECT * FROM items WHERE item_id = '{$user->{$value}}'");
    $fetch = $result->fetch_object();
    $equipped_list[] = $fetch;
  }
}

$equipped_html = "";

foreach ($equipped_list as $value) {
  $equipped_html .= "<tr><td>".avatarImg($value)."</td><td>".avatarTitle($value)."</td><td>".ucfirst($value->type)."</td><td><a href='avatar?unequip={$value->type}'>Unequip</a></td></tr>";
}

if ($equipped_html == "") {
  $equipped_html = "<div class='box standard_box center'>You do not have any items equipped.</div>";
} else {
  $equipped_html = "<div class='box center'><table class='play_table'><tr><th>-</th><th>Item</th><th>Type</th><th>Unequip</th></tr>{$equipped_html}</table></div>";
}

if (isset($_GET['skin'])) {
  $skin = secureInt($_GET['skin']);
  $error = false;
  if ($skin < 0 || $skin >= count($SKIN_CODES)) $error = true;
  if (!$error) {
    $db->query("UPDATE users SET skin_colour = {$skin} WHERE id = {$user->id}");
  }
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
<br />
<?php
for ($i = 0; $i < count($SKIN_CODES); $i++) {
  echo "<a href='avatar?skin={$i}'><div class='skin' style='background-color: #{$SKIN_CODES[$i]}' data-skin='{$i}'></div></a>";
}
?>
<br />
<div class='btn lightbox_btn js_link' data-href='shop'>Shop</div><br />
Here you can customise your avatar with items you have earned.
</div> 
<br />

<?php echo genTitle("Equipped Items").$equipped_html; ?>
<br />

<?php echo genTitle("Equippable Items Not Equipped").$items_html; ?>

<?php include 'includes/footer.php'; ?>