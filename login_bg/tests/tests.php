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

  public function testCanValidateStrLengths() {
    $this->assertTrue(isValidEmail("test@test.com"));
    $this->assertTrue(isValidEmail("example@example.co.uk"));
    $this->assertTrue(isValidEmail("ex.a_mple@example.org"));
  }

  public function testRatioCanCalculatePercentagesToTwoDP() {
    $this->assertEquals(3.50, ratio(7, 2));
    $this->assertEquals(4.50, ratio(9, 2));
    $this->assertEquals(3.33, ratio(10, 3));
    $this->assertEquals(0, ratio(13713, 0));
  }

  public function testPercentCanBeCalculated() {
    $this->assertEquals(50, percent(9, 9));
    $this->assertEquals(75, percent(3, 1));
    $this->assertEquals(0, percent(0, 4));
  }

  public function testSQLDateCanBeFormatted() {
    $this->assertEquals("23<sup>rd</sup> May 2016", formatSQLDate("2016-05-23 22:22:33"));
    $this->assertEquals("04<sup>th</sup> May 2014", formatSQLDate("2014-05-04 11:11:11"));
  }

  public function testPasswordsEncryptedCorrectly() {
    $this->assertTrue(passVerify("Hello", hashPass("Hello")));
    $this->assertTrue(passVerify("kingsconquest135", hashPass("kingsconquest135")));
    $this->assertTrue(passVerify("%£!RWEz£ASD3%&&*", hashPass("%£!RWEz£ASD3%&&*")));
  }

  public function testContainsFunctionBehaviour() {
    $this->assertTrue(contains("test@test.com", "test"));
    $this->assertTrue(contains("hello", ""));
    $this->assertFalse(contains("hello", "HELLO"));
    $this->assertFalse(contains("HELLO", "hello"));
    $this->assertFalse(contains("", "testing"));
  }
}

?>