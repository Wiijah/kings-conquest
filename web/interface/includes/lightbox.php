<?php
require_once '../includes/lightbox.php';

echo genLightbox("Create Game", "create_game", "<table class='form_table'>
    <tr><th class='lightbox_left'>Room Name: <span class='required'>*</span><span class='form_subtext'><br />3 - 20 characters.</span></th><td><input type='text' class='text auto_off' id='room_name' placeholder='Room Name' autocomplete='off' /></td></tr>
    <tr><th>Room Password:<span class='form_subtext'><br />Optional. Up to 20 characters.</span></th><td><input type='password' class='text auto_off' id='room_pass' placeholder='Leave blank if no password.' autocomplete='off' /></td></tr>
    </table>
    <div class='btn lightbox_btn' id='lightbox_btn_create_game'>Submit</div>");
?>