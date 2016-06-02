<?php
ekko($su_errorHTML).ekko($su_successHTML);
if (!isset($su_successHTML)) {
?>
  <form role="form" action="index" method="post" class="registration-form">

    <div class="form-group">
        <input type="text" name="username" placeholder="Username" class="form-control" value="<?php ekko($username); ?>" required>
    </div>

    <div class="form-group">
        <input type="email" name="email" placeholder="Email" class="form-control" value="<?php ekko($email); ?>" required>
    </div>
    <div class="form-group">
        <input type="email" name="email2" placeholder="Re-enter Email" class="form-control" value="<?php ekko($email); ?>" required>
    </div>

  <?php
  if (!isset($_GET['social_register']) || !isset($_SESSION['social_signup'])) {
  ?>
      <div class="form-group">
          <input type="password" name="password" placeholder="Password" class="form-control" required>
      </div>
      <div class="form-group">
          <input type="password" name="password2" placeholder="Re-enter Password" class="form-control" required>
      </div>
  <?php
  } else {
    echo "
    &nbsp;Signing up via your <b>{$_SESSION['social_signup']}</b> account.<br /><br />
    <input type='hidden' name='social_signup' value='{$_SESSION['social_signup']}' />
    <input type='hidden' name='social_signup_id' value='{$_SESSION['social_signup_id']}' />";
  }
  ?>
  <button type="submit" class="btn red" name="register">Sign me up!</button>
  </form>
<?php
}
?>