<?php
$HA_CONFIG_PATH = "hybridauth/hybridauth/config.php";
$HA_AUTH_PATH = "hybridauth/hybridauth/Hybrid/Auth.php";
require_once($HA_CONFIG_PATH);
require_once($HA_AUTH_PATH);
//$ha = new Hybrid_Auth($CONFIG_PATH);

if (!isset($HA_CONSTRUCTOR_PATH)) die("Please define the hybrid auth constructor path.");

$hybridauth = new Hybrid_Auth($HA_CONSTRUCTOR_PATH); //to be defined by the includer

function getAuth($network) {
    global $hybridauth;
    
      // hybridauth will try to authenticate the user, then return an instance of $network adapter
    $adapter = $hybridauth->authenticate($network);
     
    // get the user profile
    $user_profile = $adapter->getUserProfile();
     
    // disconnect the user
    $adapter->logout();
    return $user_profile;
}
?>