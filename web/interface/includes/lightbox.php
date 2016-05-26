<?php
/* Lightbox */
function genLightbox($title, $id, $html) {
  $out = "
    <div class='lightbox_container' id='lightbox_".$id."'>
    <div class='title_container'>
    <div class='circle_btn lightbox_cross lightbox_close'>x</div>
    ".genTitle($title)."
    </div>

    <div class='lightbox'>
    {$html}
    <div class='lightbox_error'>".genTitle('Error')."
    <span class='lightbox_error_text'></span>

    </div>
    </div> <!-- lightbox -->
    </div>";
  return $out;
}

echo genLightbox("Alert", "alert", "<div id='lb_alert_txt'></div><br /><div class='btn form_btn alert_btn lightbox_close' id='alert_btn'>Okay</div>");

echo genLightbox("Create Game", "create_game", "<table class='form_table'>
    <tr><th class='lightbox_left'>Room Name: <span class='required'>*</span><span class='form_subtext'><br />3 - 20 characters.</span></th><td><input type='text' class='text auto_off' id='room_name' placeholder='Room Name' autocomplete='off' /></td></tr>
    <tr><th>Room Password:<span class='form_subtext'><br />Optional. Up to 20 characters.</span></th><td><input type='password' class='text auto_off' id='room_pass' placeholder='Leave blank if no password.' autocomplete='off' /></td></tr>
    </table>
    <div class='btn lightbox_btn' id='lightbox_btn_create_game'>Submit</div>");
?>
<div id="lightbox_behind" class="lightbox_close"></div>
<div id="fs_load"><img src='images/loading_white.png' /></div>