<?php
require_once '../web/utils.php';
class Tests extends PHPUnit_Framework_TestCase {
  
  public function testCanDetectWrongEmails() {
    $this->assertFalse(isValidEmail("test"));
    $this->assertFalse(isValidEmail("example@example"));
    $this->assertFalse(isValidEmail("ex.ample@example"));
  }

  public function testCanDetectCorrectEmails() {
    $this->assertTrue(isValidEmail("test@test.com"));
    $this->assertTrue(isValidEmail("example@example.co.uk"));
    $this->assertTrue(isValidEmail("ex.a_mple@example.org"));
  }
}

?>