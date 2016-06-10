<?php
$hide_footer_links = true;
$title = "Feedback";
require_once 'includes/header_checks.php';
include 'includes/header.php';
include 'includes/avatar.php';
include 'includes/logout_container.php';
include 'includes/logo.php';
require_once 'includes/back_container.php';

$message = "";

if (isset($_POST['subject'])) {
  $subject = secureInt($_POST['subject']);
  $body = secureStr($_POST['body']);
  $error = false;
  if ($subject < 1 || $subject > 4) $subject = 0;

  if (strlen($body) < 5) {
    $message = Message("Error", "Your feedback was too short. Please enter at least 5 characters.");
    $error = true;
  }
  if (!$error) {
    $db->query("INSERT INTO feedback (subject, body, user_id, fb_created) VALUES('{$subject}', '{$body}', '{$user->id}', '".time()."')");
    $message = Message("Thank you", "Thank you for your feedback. It will help us in improving Kings' Conquest.");
  }
}
?>

<div class="small_container friends_container">
<?php
echo genBreadcrumbs(array("Lobby|index", "Feedback"));

echo $message;
?>

<?php echo genTitle("Feedback Form"); ?>
<div class="box standard_box center">
Fill in the form below and click on <span class='highlight'>Submit Feedback</span> to leave your feedback.<br /><br />

Subject:<br />
<form action="feedback" method="POST">
<select class="text" name="subject"/>
<option value="1">New Idea</option>
<option value="2">Modify Existing Feature Idea</option>
<option value="3">Complaint</option>
<option value="4">Bug</option>
</select><br /><br />

Message Body:<br />
<textarea class="text" rows="5" name="body">
<?php
if (isset($error) && $error) echo secureStr($body);
?>
</textarea>
<div class='btn lightbox_btn form_submit'>Submit Feedback</div>
</form>
</div> 
<br />


<?php include 'includes/footer.php'; ?>