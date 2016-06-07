<?php
require_once '../includes/lightbox.php';

echo genLightbox("Play As Guest", "guest", "
  Enter a display name below and then click on the <span class='home_highlight'>Play</span> button to play as a guest.<br /><br /><table class='form_table'>

    <tr><th>Display Name: <span class='required'>*</span></th><td><input type='text' class='text auto_off' id='display_name' placeholder='Display Name' autocomplete='off' /></td></tr>
    </table>
    <div class='btn lightbox_btn' id='lightbox_btn_guest'>Play</div>
    <div class='btn lightbox_btn lightbox_close'>Cancel</div>");
?>