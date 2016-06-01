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
?>
<div id="lightbox_behind" class="lightbox_close"></div>
<div id="fs_load"><img src='../images/loading_white.png' /></div>