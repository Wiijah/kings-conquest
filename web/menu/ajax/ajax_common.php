<?php
/* Common include of each ajax file */
header('Access-Control-Allow-Origin: *');
header("Content-Type: application/json; charset=UTF-8");

require_once '../../common.php';

function ajax_success($msg) {
  return '{"kc_success": "'.$msg.'"}';
}

function kc_error($msg) {
  die('{"kc_error": "'.$msg.'"}');
}

$AJAX_SUCCESS = '{"kc_success": "The operation was successful."}';
?>