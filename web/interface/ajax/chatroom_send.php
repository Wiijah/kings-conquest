<?php
/* Insert a message to the chatroom */
require_once 'ajax_common.php';
header("Content-Type: application/json; charset=UTF-8");

$message = secureStr($_POST['message']);
$room_id = secureStr($_POST['room']);

$query = "INSERT INTO chat (user, message, room_id) VALUES
    ('{$user->id}', '{$message}', '{$room_id}')";
$db->query($query);
?>