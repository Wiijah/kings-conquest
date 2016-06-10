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

echo genLightbox("Welcome", "tutorial", "
  <div class='center'>Welcome to Kings' Conquest!<br /><br />If this is your first time here, then you may want to look at the tutorials section. If you cancel, you can still revisit the tutorials anytime you wish.<br /><br />
    <div class='btn lightbox_btn js_link' data-href='tutorials'>Visit Tutorials</div>
    <div class='btn lightbox_btn lightbox_close'>Cancel</div>
    <img src='images/archer.png' class='tut_guy' />
    <img src='images/wizard.png' class='tut_guy_left' />
   </div> ");

?>