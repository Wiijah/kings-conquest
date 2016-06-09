<?php
require_once 'lib.php';
require_once '../includes/lightbox.php';

echo genLightbox("Create Game", "create_game", "<table class='form_table'>
    <tr><th class='lightbox_left'>Room Name: <span class='required'>*</span><span class='form_subtext'><br />3 - 20 characters.</span></th><td><input type='text' class='text auto_off' id='room_name' placeholder='Room Name' autocomplete='off' /></td></tr>
    <tr><th>Room Password:<span class='form_subtext'><br />Optional. Up to 20 characters.</span></th><td><input type='password' class='text auto_off' id='room_pass' placeholder='Leave blank if no password.' autocomplete='off' /></td></tr>
    </table>
    <div class='btn lightbox_btn' id='lightbox_btn_create_game'>Submit</div>");


echo genLightbox("Enter Room", "enter_room", "
  This room requires a password to join, please enter the password below.<br /><table class='form_table'>

    <tr><th>Room Password: <span class='required'>*</span></th><td><input type='password' class='text auto_off' id='join_pass' placeholder='Password' autocomplete='off' /></td></tr>
    </table>
    <div class='btn lightbox_btn' id='lightbox_btn_enter_room'>Join Room</div>
    <div class='btn lightbox_btn lightbox_close'>Cancel</div>");

echo genLightbox("How To Play", "tutorial", "
  <div class='center'>Select from one of four tutorials below.<br /><br />
    <div class='btn lightbox_btn' id='tut1'>Tutorial 1</div>
    <div class='btn lightbox_btn' id='tut2'>Tutorial 2</div>
    <div class='btn lightbox_btn' id='tut3'>Tutorial 3</div>
    <div class='btn lightbox_btn' id='tut4'>Tutorial 4</div>
   </div> ");
?>