<?php
/* Create a new room */
require_once 'ajax_common.php';

$room_name = secureStr($_POST['room_name']);
$password = secureStr($_POST['password']);

$query = "INSERT INTO rooms (name, password, user_id) VALUES
    ('{$room_name}', '{$password}', '{$user->id}')";
$db->query($query);
?>