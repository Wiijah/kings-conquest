<?php
if (isset($text) && isset($link)) {
} else if (isset($_GET['close']) && $_GET['close'] == 1) {
  $text = "Close";
  $link = "javascript:window.close();";
} else {
  $text = "Back To Lobby";
  $link = "index";
}

?>
<a href="<?php echo $link; ?>"><div class="back_container">
  <div class="back_btn btn"><?php echo $text; ?></div>
</div></a>