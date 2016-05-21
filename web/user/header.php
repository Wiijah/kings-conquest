<?php
include '../common.php';

if (!isset($_SESSION['id'])) {
  header ("Location: ../{$LOGIN_FORM_DIR}");
  die();
}
$FULL_NAME = $user->firstname. " ".$user->lastname;
?>
<!DOCTYPE html>
<html>

<head>
    <title><?php echo $title." - ".$APP_NAME; ?></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:300,400' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,900' rel='stylesheet' type='text/css'>
    <!-- CSS Libs -->
    <link rel="stylesheet" type="text/css" href="form.css">
    <link rel="stylesheet" type="text/css" href="lib/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="lib/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="lib/css/animate.min.css">
    <link rel="stylesheet" type="text/css" href="lib/css/bootstrap-switch.min.css">
    <link rel="stylesheet" type="text/css" href="lib/css/checkbox3.min.css">
    <link rel="stylesheet" type="text/css" href="lib/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="lib/css/dataTables.bootstrap.css">
    <link rel="stylesheet" type="text/css" href="lib/css/select2.min.css">
    <!-- CSS App -->
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/themes/flat-blue.css">

    <link rel="icon" type="image/png" href="../images/favicon.png" />

    <!--<script src="../utils/angular.js"></script>
    <script src="../utils/angular_sanitize.js"></script>-->
    <script type="text/javascript" src="lib/js/jquery.min.js"></script>
</head>

<body class="flat-blue">
    <div class="app-container">
        <div class="row content-container">
            <nav class="navbar navbar-default navbar-fixed-top navbar-top">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-expand-toggle">
                            <i class="fa fa-bars icon"></i>
                        </button>
                        <ol class="breadcrumb navbar-breadcrumb">
                            <li class="active"><?php echo $title; ?></li>
                        </ol>
                        <button type="button" class="navbar-right-expand-toggle pull-right visible-xs">
                            <i class="fa fa-th icon"></i>
                        </button>
                    </div>
                    <ul class="nav navbar-nav navbar-right">
                        <button type="button" class="navbar-right-expand-toggle pull-right visible-xs">
                            <i class="fa fa-times icon"></i>
                        </button>
                        <!--<li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-comments-o"></i></a>
                            <ul class="dropdown-menu animated fadeInDown">
                                <li class="title">
                                    Notification <span class="badge pull-right">0</span>
                                </li>
                                <li class="message">
                                    No new notification
                                </li>
                            </ul>
                        </li>-->
                        <li class="dropdown danger">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-star-half-o"></i> 2</a>
                            <ul class="dropdown-menu danger  animated fadeInDown">
                                <li>
                                    <ul class="list-group notifications">
                                        <a href="#">
                                            <li class="list-group-item">
                                                <span class="badge">2</span> <i class="fa fa-bolt icon"></i> level
                                            </li>
                                        </a>
                                        <a href="#">
                                            <li class="list-group-item">
                                                <span class="badge success">50%</span> <i class="fa fa-area-chart icon"></i> progress till next level
                                            </li>
                                        </a>
                                        <!--<a href="#">
                                            <li class="list-group-item">
                                                <span class="badge danger">0</span> <i class="fa fa-comments icon"></i> new messages
                                            </li>
                                        </a>
                                        <a href="#">
                                            <li class="list-group-item message">
                                                view all
                                            </li>
                                        </a>-->
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown profile">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><?php echo $FULL_NAME; ?> <span class="caret"></span></a>
                            <ul class="dropdown-menu animated fadeInDown">
                                <li class="profile-img">
                                    <img src="images/blank_avatar.png" class="profile-img">
                                </li>
                                <li>
                                    <div class="profile-info">
                                        <h4 class="username"><?php echo $FULL_NAME; ?></h4>
                                        <p><?php echo $user->email; ?></p>
                                        <div class="btn-group margin-bottom-2x" role="group">
                                            <button type="button" class="btn btn-default"><i class="fa fa-user"></i> Profile</button>
                                            <button type="button" class="btn btn-default" onclick="window.location='logout'"><i class="fa fa-sign-out"></i> Logout</button>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="side-menu sidebar-inverse">
                <nav class="navbar navbar-default" role="navigation">
                    <div class="side-menu-container">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="index">
                                <div class="icon glyphicon glyphicon-king"></div>
                                <div class="title"><?php echo $APP_NAME; ?></div>
                            </a>
                            <button type="button" class="navbar-expand-toggle pull-right visible-xs">
                                <i class="fa fa-times icon"></i>
                            </button>
                        </div>
                        <ul class="nav navbar-nav">
                            <li>
                                <a href="index">
                                    <span class="icon fa fa-bar-chart"></span><span class="title">Dashboard</span>
                                </a>
                            </li>



                            <li>
                                <a href="lobby">
                                    <span class="icon fa fa-gamepad"></span><span class="title">Game Lobby</span>
                                </a>
                            </li>

                            <li>
                                <a href="highscores">
                                    <span class="icon fa fa-trophy"></span><span class="title">Highscores</span>
                                </a>
                            </li>
                            
                            <li>
                                <a href="how_to_play">
                                    <span class="icon fa fa-book"></span><span class="title">How To Play</span>
                                </a>
                            </li>

                            <!--<li>
                                <a href="trade" target="_blank">
                                    <span class="icon fa fa-bank"></span><span class="title">Trade</span>
                                </a>
                            </li>-->
                            <!--<li class="panel panel-default dropdown">
                                <a data-toggle="collapse" href="#dropdown-table">
                                    <span class="icon fa fa-table"></span><span class="title">Communication</span>
                                </a>
                                <!-- Dropdown level 1 -->
                                <div id="dropdown-table" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <ul class="nav navbar-nav">
                                            <li>
                                              <a href="#">Chatroom</a>
                                            </li>
                                            <li>
                                              <a href="#">Friends List</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </li>-->
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->
                </nav>
            </div>