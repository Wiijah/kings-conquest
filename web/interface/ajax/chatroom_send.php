<?php
/* Insert a message to the chatroom */
require_once 'ajax_common.php';

$message = secureStr($_POST['message']);
$room_id = secureInt($_POST['room']);
$colour = secureStr($_POST['colour']);

$query = "INSERT INTO chat (user, message, room_id, colour) VALUES
    ('{$user->id}', '{$message}', '{$room_id}', '{$colour}')";
$db->query($query);
echo $AJAX_SUCCESS;
?>