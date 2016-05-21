<?php
require_once 'common.php';

$links = array(
  array("link" => "#app-features", "text" => "Features"),
  array("link" => "#how-it-works", "text" => "How it works"),
  array("link" => "#about-us", "text" => "Our team"),
  array("link" => "#how-it-works", "text" => "How it works")
  );
?>

<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><?php echo $APP_NAME; ?></title>
        <meta name="robots" content="noindex"> <!-- in production, so don't put in search engines -->


        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">        
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/typicons/typicons.min.css">
        <link rel="stylesheet" href="assets/css/animate.css">
		<link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/media-queries.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">

    </head>

    <body>
    
        <!-- Loader -->
    	<div class="loader">
    		<div class="loader-img"></div>
    	</div>
				
        <!-- Top content -->
        <div class="top-content">
        	
        	<!-- Top menu -->
			<nav class="navbar navbar-inverse navbar-no-bg" role="navigation">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="index"><?php echo $APP_NAME; ?></a>
					</div>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="top-navbar-1">
						<ul class="nav navbar-nav navbar-right">
            <?php
            foreach ($links as $value) {
              echo "<li><a class='scroll-link' href='{$value['link']}'>{$value['text']}</a></li>";
            }
            ?>
						</ul>
					</div>
				</div>
			</nav>
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                    	<div class="col-sm-5 phone wow fadeInLeft">
                        	<img src="assets/img/devices/iphone.png" alt="">
                        </div>
                        <div class="col-sm-7 text wow fadeInUp">
                            <h1>Get <strong><?php echo $APP_NAME; ?></strong> now!<br />Available on iOS and Android.</h1>
                            <div class="description">
                            	<p>
	                            	We have been working hard to get this application available not only on the desktop, but on iOS and Android devices as well.
                            	</p>
                            </div>
                            <div class="top-big-link">
		                    	<a class="btn btn-link-1" href="<?php echo $LOGIN_FORM_DIR; ?>">Login</a>
		                    	<a class="btn btn-link-2" href="<?php echo $LOGIN_FORM_DIR; ?>">Join Now</a>
		                    </div>
		                    <div class="vendors">
		                    	<a href="#"><span class="typcn typcn-vendor-apple"></span></a>
		                    	<a href="#"><span class="typcn typcn-vendor-android"></span></a>
		                    	<!--<a href="#"><span class="typcn typcn-vendor-microsoft"></span></a>-->
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        
        <!-- App Features -->
        <div class="app-features-container section-container">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12 app-features section-description wow fadeIn">
	                    <h2>App's features</h2>
	                    <div class="divider-1 wow fadeInUp"><span></span></div>
	                    <p>
	                    	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut 
	                    	labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.
	                    </p>
	                </div>
	            </div>
	            <div class="row">
                	<div class="col-sm-4 app-features-wrapper wow fadeInUp">
                		<div class="app-features-box">
		                	<div class="app-features-box-icon">
		                		<span aria-hidden="true" class="typcn typcn-eye-outline"></span>
		                	</div>
		                    <h3>Easy To Use</h3>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
	                    </div>
	                    <div class="app-features-box">
		                	<div class="app-features-box-icon">
		                		<span aria-hidden="true" class="typcn typcn-thumbs-ok"></span>
		                	</div>
		                    <h3>Responsive Design</h3>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
	                    </div>
                    </div>
                    <div class="col-sm-4 app-features-image wow fadeInDown">
	                	<img src="assets/img/devices/iphone2.png" alt="">
                    </div>
                    <div class="col-sm-4 app-features-wrapper wow fadeInUp">
                		<div class="app-features-box">
		                	<div class="app-features-box-icon">
		                		<span aria-hidden="true" class="typcn typcn-cog-outline"></span>
		                	</div>
		                    <h3>Bootstrap Engine</h3>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
	                    </div>
	                    <div class="app-features-box">
		                	<div class="app-features-box-icon">
		                		<span aria-hidden="true" class="typcn typcn-group-outline"></span>
		                	</div>
		                    <h3>Big Community</h3>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
	                    </div>
                    </div>
	            </div>
	        </div>
        </div>
        
        <!-- How it works -->
        <div class="how-it-works-container section-container section-container-image-bg">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12 how-it-works section-description wow fadeIn">
	                    <h2>How it works</h2>
	                    <div class="divider-1 wow fadeInUp"><span></span></div>
	                </div>
	            </div>
	            <div class="row">
                	<div class="col-sm-4 col-sm-offset-1 how-it-works-box wow fadeInUp">
	                	<div class="how-it-works-box-icon">
	                		<span aria-hidden="true" class="typcn typcn-pencil"></span>
	                		<span aria-hidden="true" class="how-it-works-step">1</span>
	                	</div>
	                    <h3>Sign up</h3>
	                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
                    </div>
                    <div class="col-sm-4 col-sm-offset-2 how-it-works-box wow fadeInDown">
	                	<div class="how-it-works-box-icon">
	                		<span aria-hidden="true" class="typcn typcn-ticket"></span>
	                		<span aria-hidden="true" class="how-it-works-step">2</span>
	                	</div>
	                    <h3>Make payment</h3>
	                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-1 how-it-works-box wow fadeInUp">
	                	<div class="how-it-works-box-icon">
	                		<span aria-hidden="true" class="typcn typcn-download"></span>
	                		<span aria-hidden="true" class="how-it-works-step">3</span>
	                	</div>
	                    <h3>Download the app</h3>
	                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
                    </div>
                    <div class="col-sm-4 col-sm-offset-2 how-it-works-box wow fadeInDown">
	                	<div class="how-it-works-box-icon">
	                		<span aria-hidden="true" class="typcn typcn-thumbs-up"></span>
	                		<span aria-hidden="true" class="how-it-works-step">4</span>
	                	</div>
	                    <h3>Start using it</h3>
	                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.</p>
                    </div>
	            </div>
	            <div class="row">
	            	<div class="col-sm-12 section-bottom-button wow fadeInUp">
                        <a class="btn btn-link-1 scroll-link" href="#top-content">Download it</a>
	            	</div>
	            </div>
	        </div>
        </div>

		<!-- More features -->
        <div class="more-features-container section-container">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12 more-features section-description wow fadeIn">
	                    <h2>More features</h2>
	                    <div class="divider-1 wow fadeInUp"><span></span></div>
	                </div>
	            </div>
	            <div class="row">
	            	<div class="col-sm-5 more-features-box wow fadeInLeft">
	                    <img src="assets/img/devices/iphone.png" alt="">
	                </div>
	                <div class="col-sm-7 more-features-box wow fadeInUp">
	                    <div class="more-features-box-text">
	                    	<div class="more-features-box-text-icon">
	                    		<span aria-hidden="true" class="typcn typcn-attachment"></span>
	                    	</div>
	                    	<h3>Ut wisi enim ad minim</h3>
	                    	<div class="more-features-box-text-description">
	                    		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
	                    		Ut wisi enim ad minim veniam, quis nostrud.
	                    	</div>
	                    </div>
	                    <div class="more-features-box-text">
	                    	<div class="more-features-box-text-icon">
	                    		<span aria-hidden="true" class="typcn typcn-user"></span>
	                    	</div>
	                    	<h3>Quis nostrud exerci tat</h3>
	                    	<div class="more-features-box-text-description">
	                    		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
	                    		Ut wisi enim ad minim veniam, quis nostrud.
	                    	</div>
	                    </div>
	                    <div class="more-features-box-text">
	                    	<div class="more-features-box-text-icon">
	                    		<span aria-hidden="true" class="typcn typcn-cloud-storage"></span>
	                    	</div>
	                    	<h3>Lorem ipsum dolor sit</h3>
	                    	<div class="more-features-box-text-description">
	                    		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
	                    		Ut wisi enim ad minim veniam, quis nostrud.
	                    	</div>
	                    </div>
	                    <div class="more-features-box-text">
	                    	<div class="more-features-box-text-icon">
	                    		<span aria-hidden="true" class="typcn typcn-flash"></span>
	                    	</div>
	                    	<h3>Do eiusmod tempor</h3>
	                    	<div class="more-features-box-text-description">
	                    		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
	                    		Ut wisi enim ad minim veniam, quis nostrud.
	                    	</div>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
        
        <!-- Always beautiful -->
        <div class="always-beautiful-container section-container section-container-gray-bg">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12 always-beautiful section-description wow fadeIn">
	                    <h2>Always beautiful</h2>
	                    <div class="divider-1 wow fadeInUp"><span></span></div>
	                </div>
	            </div>
	            <div class="row">
	            	<div class="col-sm-7 always-beautiful-box wow fadeInLeft">
	                    <div class="always-beautiful-box-text">
	                    	<h3>Ut wisi enim ad minim</h3>
	                    	<p class="medium-paragraph">
	                    		Lorem ipsum dolor sit amet, <span class="colored-text">consectetur adipisicing</span> elit, 
	                    		sed do eiusmod tempor incididunt ut labore et. Ut wisi enim ad minim veniam, quis nostrud.
	                    	</p>
	                    	<p>
	                    		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
	                    		Ut wisi enim ad minim veniam, quis nostrud. 
	                    		Exerci tation ullamcorper suscipit <span class="colored-text">lobortis nisl</span> ut aliquip ex ea commodo consequat. 
	                    		Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl.
	                    	</p>
	                    </div>
	                    <div class="always-beautiful-box-text">
	                    	<p class="medium-paragraph">
	                    		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod 
	                    		tempor incididunt ut labore et. Ut wisi enim ad <span class="colored-text">minim veniam</span>, quis nostrud.
	                    	</p>
	                    	<p>
	                    		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
	                    		Ut wisi enim ad minim veniam, quis nostrud. 
	                    		Exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea <span class="colored-text">commodo consequat</span>. 
	                    		Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl.
	                    	</p>
	                    </div>
	                </div>
	                <div class="col-sm-5 always-beautiful-box wow fadeInUp">
	                    <img src="assets/img/devices/iphone2.png" alt="">
	                </div>
	            </div>
	        </div>
        </div>
        
        <!-- Call to action -->
        <div class="call-to-action-container section-container section-container-image-bg">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12 call-to-action section-description wow fadeInLeftBig">
	                    <h2>Call to action</h2>
	                    <div class="divider-1 wow fadeInUp"><span></span></div>
	                    <p>
	                    	Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut 
	                    	aliquip ex ea commodo consequat. Ut wisi enim ad minim veniam, quis nostrud.
	                    </p>
	                </div>
	            </div>
	            <div class="row">
	            	<div class="col-sm-12 section-bottom-button wow fadeInUp">
                        <a class="btn btn-link-1 scroll-link" href="#top-content">Get our app now!</a>
	            	</div>
	            </div>
	        </div>
        </div>
        
        <!-- About us -->
        <div class="about-us-container section-container">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12 about-us section-description wow fadeIn">
	                    <h2>Our Team</h2>
	                    <div class="divider-1 wow fadeInUp"><span></span></div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="col-sm-4 about-us-box wow fadeInUp">
		                <div class="about-us-photo">
		                	<img src="assets/img/about/1.jpg" alt="" data-at2x="assets/img/about/1.jpg">
		                	<div class="about-us-role">Web Developer</div>
		                </div>
	                    <h3>Kai Du</h3>
	                    <p>Just a typical web developer. Studying at Imperial College London.</p>
	                    <div class="about-us-social">
		                	<a href="#"><span class="typcn typcn-social-facebook"></span></a>
		                	<a href="#"><span class="typcn typcn-social-dribbble"></span></a>
		                    <a href="#"><span class="typcn typcn-social-twitter"></span></a>
		                </div>
	                </div>
	                <div class="col-sm-4 about-us-box wow fadeInDown">
		                <div class="about-us-photo">
		                	<img src="assets/img/about/2.jpg" alt="" data-at2x="assets/img/about/2.jpg">
		                	<div class="about-us-role">Graphics Designer</div>
		                </div>
	                    <h3>Tim Brown</h3>
	                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.</p>
	                    <div class="about-us-social">
		                	<a href="#"><span class="typcn typcn-social-facebook"></span></a>
		                	<a href="#"><span class="typcn typcn-social-dribbble"></span></a>
		                    <a href="#"><span class="typcn typcn-social-twitter"></span></a>
		                </div>
	                </div>
	                <div class="col-sm-4 about-us-box wow fadeInUp">
		                <div class="about-us-photo">
		                	<img src="assets/img/about/3.jpg" alt="" data-at2x="assets/img/about/3.jpg">
		                	<div class="about-us-role">Database</div>
		                </div>
	                    <h3>Sarah Red</h3>
	                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.</p>
	                    <div class="about-us-social">
		                	<a href="#"><span class="typcn typcn-social-facebook"></span></a>
		                	<a href="#"><span class="typcn typcn-social-dribbble"></span></a>
		                    <a href="#"><span class="typcn typcn-social-twitter"></span></a>
		                </div>
	                </div>
	            </div>
	        </div>
        </div>

        <!-- Testimonials -->
        <div class="testimonials-container section-container section-container-image-bg">
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12 testimonials section-description wow fadeIn">
	                    <h2>Testimonials</h2>
	                    <div class="divider-1 wow fadeInUp"><span></span></div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="col-sm-10 col-sm-offset-1 testimonial-list wow fadeInUp">
	                	<div role="tabpanel">
	                		<!-- Tab panes -->
	                		<div class="tab-content">
	                			<div role="tabpanel" class="tab-pane fade in active" id="tab1">
	                				<div class="testimonial-image">
	                					<img src="assets/img/testimonials/1.jpg" alt="" data-at2x="assets/img/testimonials/1.jpg">
	                					<div class="testimonial-icon">
	                						<span aria-hidden="true" class="typcn typcn-pin"></span>
	                					</div>
	                				</div>
	                				<div class="testimonial-text">
		                                <p>
		                                	"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
		                                	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
		                                	Lorem ipsum dolor sit amet, consectetur..."<br>
		                                	<a href="#">Lorem Ipsum, dolor.co.uk</a>
		                                </p>
	                                </div>
	                			</div>
	                			<div role="tabpanel" class="tab-pane fade" id="tab2">
	                				<div class="testimonial-image">
	                					<img src="assets/img/testimonials/2.jpg" alt="" data-at2x="assets/img/testimonials/2.jpg">
	                					<div class="testimonial-icon">
	                						<span aria-hidden="true" class="typcn typcn-pin"></span>
	                					</div>
	                				</div>
	                				<div class="testimonial-text">
		                                <p>
		                                	"Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip 
		                                	ex ea commodo consequat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit 
		                                	lobortis nisl ut aliquip ex ea commodo consequat..."<br>
		                                	<a href="#">Minim Veniam, nostrud.com</a>
		                                </p>
	                                </div>
	                			</div>
	                			<div role="tabpanel" class="tab-pane fade" id="tab3">
	                				<div class="testimonial-image">
	                					<img src="assets/img/testimonials/3.jpg" alt="" data-at2x="assets/img/testimonials/3.jpg">
	                					<div class="testimonial-icon">
	                						<span aria-hidden="true" class="typcn typcn-pin"></span>
	                					</div>
	                				</div>
	                				<div class="testimonial-text">
		                                <p>
		                                	"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
		                                	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
		                                	Lorem ipsum dolor sit amet, consectetur..."<br>
		                                	<a href="#">Lorem Ipsum, dolor.co.uk</a>
		                                </p>
	                                </div>
	                			</div>
	                			<div role="tabpanel" class="tab-pane fade" id="tab4">
	                				<div class="testimonial-image">
	                					<img src="assets/img/testimonials/4.jpg" alt="" data-at2x="assets/img/testimonials/4.jpg">
	                					<div class="testimonial-icon">
	                						<span aria-hidden="true" class="typcn typcn-pin"></span>
	                					</div>
	                				</div>
	                				<div class="testimonial-text">
		                                <p>
		                                	"Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip 
		                                	ex ea commodo consequat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit 
		                                	lobortis nisl ut aliquip ex ea commodo consequat..."<br>
		                                	<a href="#">Minim Veniam, nostrud.com</a>
		                                </p>
	                                </div>
	                			</div>
	                		</div>
	                		<!-- Nav tabs -->
	                		<ul class="nav nav-tabs" role="tablist">
	                			<li role="presentation" class="active">
	                				<a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab"></a>
	                			</li>
	                			<li role="presentation">
	                				<a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab"></a>
	                			</li>
	                			<li role="presentation">
	                				<a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab"></a>
	                			</li>
	                			<li role="presentation">
	                				<a href="#tab4" aria-controls="tab4" role="tab" data-toggle="tab"></a>
	                			</li>
	                		</ul>
	                	</div>
	                </div>
	            </div>
	        </div>
        </div>

        <!-- Footer -->
        <footer>
	        <div class="container">
	        	<div class="row">
                    <div class="col-sm-12 footer-social">
                    	<a href="#"><span class="typcn typcn-social-facebook"></span></a>
                    	<a href="#"><span class="typcn typcn-social-dribbble"></span></a>
                    	<a href="#"><span class="typcn typcn-social-twitter"></span></a>
                    	<a href="#"><span class="typcn typcn-social-google-plus"></span></a>
                    	<a href="#"><span class="typcn typcn-social-instagram"></span></a>
                    	<a href="#"><span class="typcn typcn-social-pinterest"></span></a>
                    </div>
	            </div>
	            <div class="row">
                    <div class="col-sm-12 footer-copyright">
                    	&copy; <?php echo date("Y"); ?> <?php echo $APP_NAME; ?>.
                    </div>
                </div>
	        </div>
        </footer>
        

        <!-- Javascript -->
        <script src="assets/js/jquery-1.11.1.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.backstretch.min.js"></script>
        <script src="assets/js/wow.min.js"></script>
        <script src="assets/js/retina-1.1.0.min.js"></script>
        <script src="assets/js/scripts.js"></script>

    </body>

</html>