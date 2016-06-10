<?php
require_once 'ajax_common.php';

$tut = secureInt($_POST['tut']);
$tut2 = secureInt($_POST['tut2']);

if ($user->tutorial < $tut && $tut != 1) kc_error("You must complete the previous tutorials before you can try this tutorial.");
if ($tut2 > 0) {
  $tut2++;
  $db->query("UPDATE users SET tutorial = '{$tut2}' WHERE id = {$user->id}");
  kc_error("AAA {$tut2}");
}
/* Success */
echo $AJAX_SUCCESS;
?>