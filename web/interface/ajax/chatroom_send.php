<?php
/* Insert a message to the chatroom */
require_once 'ajax_common.php';
header("Content-Type: application/json; charset=UTF-8");

$message = secureStr($_POST['message']);

$query = "INSERT INTO chat (user, message) VALUES
    ('{$user->id}', '{$message}')";
$db->query($query);
?>