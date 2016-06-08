<?php

  $chance_win = abs((1 / (1 + pow(10, ((1 - 1) / 400)))) * 100);
  $chance_lose = abs(100 - $chance_win);

  $elo_won = round(32 * ($chance_win / 100));
  $elo_lost = round(32 * ($chance_lose / 100));
  
  echo $elo_won ."...".$elo_lost;
?>
include 'common.php';
header ("Location: {$LOGIN_FORM_DIR}");
?>