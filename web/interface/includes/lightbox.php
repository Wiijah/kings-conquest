<?php
/* Lightbox */
function genLightBox($title, $id, $html) {
  $out = "
    <div class='lightbox_container' id='lightbox_".$id."'>
    ".genTitle($title)."
    <div class='lightbox'>
    {$html}
    <div class='lightbox_error'>".genTitle('Error')."
    <span class='lightbox_error_text'></span>

    </div>
    </div> <!-- lightbox -->
    </div>";
  return $out;
}

echo '<div id="lightbox_behind"></div>';

echo genLightBox("Create Game", "create_game", "<table class='form_table'>
    <tr><th class='lightbox_left'>Room Name:</th><td><input type='text' class='text' id='name' /></td></tr>
    <tr><th>Room Password:</th><td><input type='password' class='text' id='password' /></td></tr>
    </table>
    <div class='btn lightbox_btn' id='lightbox_btn_create_game'>Submit</div>");

?>