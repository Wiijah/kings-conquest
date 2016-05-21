<?php
require_once '../common.php';
$HA_CONSTRUCTOR_PATH = "../hybridauth/hybridauth/config.php";
require_once '../inc_ha.php';

if (isset($_POST['register'])) {
  require_once 'inc_signup.php';
} else if (isset($_POST['login'])) {
  require_once 'inc_login.php';
}

if (verifyToken($_GET['token'])) {
  if (isset($_GET['social_login'])) {
    require_once 'inc_social_login.php';
  } else if (isset($_GET['social_register'])) {
    require_once 'inc_social_register.php';
  }
} else {
  //print_r($_GET);
}
?>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <title><?php echo $APP_NAME; ?></title>
        <meta name="robots" content="noindex"> <!-- in production, so don't put in search engines -->

        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href="assets/css/style.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="icon" type="image/png" href="../images/favicon.png" />
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    </head>

    <body>

<!-- Social Login JS -->
<script>

$(document).ready(function(){
    $("a.social_login").click(function(){
      var type = $(this).attr("data-type");
      $("#social_login").val(type);
      $("#social_login_form").submit();
    });

    $("a.social_register").click(function(){
      var type = $(this).attr("data-type");
      $("#social_register").val(type);
      $("#social_register_form").submit();
    });
});



</script>
<!-- End social login JS -->
<form method="GET" id="social_login_form" style="display: none">
<input type="text" name="token" value="<?php echo $TOKEN; ?>" />
<input type="text" name="social_login" id="social_login" />
<input type="submit" name="social_login_submit" />
</form>

<form method="GET" id="social_register_form" style="display: none">
<input type="text" name="token" value="<?php echo $TOKEN; ?>" />
<input type="text" name="social_register" id="social_register" />
<input type="submit" name="social_register_submit" />
</form>

        <!-- Top content -->
        <div class="top-content">
        	
            <img src="../images/logo_splash.png" style="width: 75%" />
            <div class="inner-bg">
                <div class="container">
                	
                    <!--<div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong><?php echo $APP_NAME; ?></strong></h1>
                            <div class="description">
                            	<p>
	                            	<?php echo $QUOTE; ?>




                            	</p>
                            </div>
                        </div>
                    </div>-->
                    
                    <div class="row">
                        <div class="col-sm-5">
                        	
                        	<div class="form-box">
	                        	<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3>Login</h3>
	                            		<p>Enter your email and password to login.</p>
	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-key"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom">
                                    <?php ekko($login_errorHTML).ekko($login_successHTML); ?>
				                    <form role="form" action="" method="post" class="login-form">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-email">Email</label>
				                        	<input type="email" name="email" placeholder="Email" class="form-email form-control" id="form-username" required>
				                        </div>
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password</label>
				                        	<input type="password" name="password" placeholder="Password" class="form-password form-control" id="form-password" required>
				                        </div>
				                        <input type="hidden" name="token" value="<?php echo $TOKEN; ?>" />
				                        <button type="submit" class="btn" name="login">Sign in!</button>
				                    </form>
                                    
			                    </div>
		                    </div>
		                
		                	<div class="social-login">
	                        	<h3>...or login with:</h3>
	                        	<div class="social-login-buttons">
		                        	<a class="btn btn-link-1 btn-link-1-facebook social_login" data-type="Facebook">
		                        		<i class="fa fa-facebook"></i> Facebook
		                        	</a>
		                        	<a class="btn btn-link-1 btn-link-1-twitter" href="#">
		                        		<i class="fa fa-twitter"></i> Twitter
		                        	</a>
		                        	<a class="btn btn-link-1 btn-link-1-google-plus" href="#">
		                        		<i class="fa fa-google-plus"></i> Google Plus
		                        	</a>
	                        	</div>



	                        </div>
	                        
                        </div>
                        
                        <div class="col-sm-1 middle-border"></div>
                        <div class="col-sm-1"></div>
                        	
                        <div class="col-sm-5">
                        	
                        	<div class="form-box">
                        		<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h3>Sign Up</h3>
	                            		<p>Join us by filling in the form below.</p>
	                        		</div>
	                        		<div class="form-top-right">
	                        			<i class="fa fa-pencil"></i>
	                        		</div>
	                            </div>
	                            <div class="form-bottom">
<?php
require_once 'inc_signup_form.php';
?>
			                    </div>
                        	</div>


                            <div class="social-login">
                                <h3>...or sign up with:</h3>
                                <div class="social-login-buttons">
                                    <a class="btn btn-link-1 btn-link-1-facebook social_register" data-type="Facebook">
                                        <i class="fa fa-facebook"></i> Facebook
                                    </a>
                                    <a class="btn btn-link-1 btn-link-1-twitter" href="#">
                                        <i class="fa fa-twitter"></i> Twitter
                                    </a>
                                    <a class="btn btn-link-1 btn-link-1-google-plus social_register" data-type="Google">
                                        <i class="fa fa-google-plus"></i> Google Plus
                                    </a>
                                </div>
                            </div>
                        	
                        </div>
                    </div>
                    
                </div>
            </div>
            
        </div>

        <!-- Footer -->
        <footer>
        	<div class="container">
        		<div class="row">
        			
        			<div class="col-sm-8 col-sm-offset-2">
        				<div class="footer-border"></div>
        				<p>&copy; <?php echo date("Y") . " " . $APP_NAME; ?>.</p>
        			</div>
        			
        		</div>
        	</div>
        </footer>

        <!-- Javascript -->
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.backstretch.min.js"></script>
        <script src="assets/js/scripts.js"></script>
        
        <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

    </body>

</html>