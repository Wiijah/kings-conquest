<?php
function give_item($item_id, $user_id, $quantity = 1) {
  global $db;
  $result = $db->query("SELECT * FROM inventory WHERE user_id = '{$user_id}' AND item_id = '{$item_id}'");
  if ($result->num_rows > 0) {
    $db->query("UPDATE inventory SET quantity = quantity + {$quantity} WHERE user_id = '{$user_id}' AND item_id = '{$item_id}'");
    return;
  } 
  $db->query("INSERT INTO inventory (user_id, item_id, quantity) VALUES('{$user_id}', '{$item_id}', '{$quantity}')");
}

function take_item($item_id, $user_id, $quantity = 1) {
  global $db;
  $result = $db->query("SELECT * FROM inventory WHERE user_id = '{$user_id}' AND item_id = '{$item_id}'");
  if (!$fetch = $result->fetch_object()) return;

  if ($fetch->quantity <= $quantity) {
    $db->query("DELETE FROM inventory WHERE inv_id = '{$fetch->inv_id}'");
  } else {
    $db->query("UPDATE inventory SET quantity = quantity - {$quantity} WHERE inv_id = '{$fetch->inv_id}'");
  }
}
?>