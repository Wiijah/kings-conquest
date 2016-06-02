<?php
require_once 'ajax_common.php';
require_once 'social_sdks/facebook/autoload.php';

$fb = new Facebook\Facebook([
  'app_id' => '190990184598813', // Replace {app-id} with your app id
  'app_secret' => 'f8b6dfbe71acb92c6d6a708a50b856f2',
  'default_graph_version' => 'v2.2',
  ]);

$access_token = secureStr($_POST['access_token']);

try {
  // Returns a `Facebook\FacebookResponse` object
  $response = $fb->get('/me?fields=id,name', $access_token);
} catch(Facebook\Exceptions\FacebookResponseException $e) {
  kc_error('There is a problem signing in with Facebook. Please try again.');
} catch(Facebook\Exceptions\FacebookSDKException $e) {
  kc_error('There is a problem signing in with Facebook. Please try again.');
}

$user = $response->getGraphUser();

$socialID = $user["id"];
$result = $db->query("SELECT * FROM login WHERE socialid = '{$socialID}'");

if (!$fetch = $result->fetch_object()) {
  kc_error('You have not registered with us with that Facebook account yet.');
}

$_SESSION['id'] = $fetch->userid;
echo $AJAX_SUCCESS;
?>