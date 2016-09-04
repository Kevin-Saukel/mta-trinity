<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<?php
	require_once("lib/mysql/PDODatabase.class.php");
	session_start();
	if (ini_get('register_globals'))
	{
		foreach ($_SESSION as $key=>$value)
		{
			if (isset($GLOBALS[$key]))
				unset($GLOBALS[$key]);
		}
	}
	
	if ( isset($_POST["Username"]) ) {
		if ( isset($_POST["E-Mail"]) ) {
			
		} else {
			
		}
	}
	
	if ( isset($_SESSION["Logged"]) )
	{
		header("Location: index.php"); 
	}
?>
<html>
	<head>
		<title>MTA-Trinity</title>
		<meta keywords="Controlpanel, MTA, Trinity, MTA-Trinity" />
		<meta author="Kevin Saukel" />
		<meta description="Copyright by Kevin Saukel" />
		<meta license="All rights reserved" />
		<meta charset="utf-8">
		
		<link rel="stylesheet" type="text/css" href="style/main.css">
		<link rel="stylesheet" type="text/css" href="style/form.css">
		<link rel="stylesheet" type="text/css" href="style/login.css">
		
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="js/login.js"></script>
	</head>
	
	<body>
		<div>
			<h1 class="title fade-in">MTA-Trinity</h1>
		</div>
		<div>
			<div class="tab-panel">
				<ul class="tab-list">
					<li class="active"><a href="#" redirection="#Login">Login</a></li>
					<li><a href="#" redirection="#Register">Register</a></li>
				</ul>
				
				<div class="tab-content"> 
					<div id="Login" class="c_active">
						<form class="form_center" method="POST" action="login.php">
							<div class="form_center">
								Username:
								<input class="text" type="text" name="Username" /><br />
								Password:
								<input class="text" type="text" name="Password" /><br />
								<input class="form_submit" type="submit" name="Login" />
							</div>
						</form>
					</div>
					
					<div id="Register" class="c_inactive">
						<form class="form_center" method="POST" action="login.php">
							<div class="form_center">
								Username:
								<input class="text" type="text" name="Username" /><br />
								E-Mail:
								<input class="text" type="text" name="E-Mail" /><br />						
								Password:
								<input class="text" type="text" name="Password" /><br />
								Repeat Password:
								<input class="text" type="text" name="Repeat_Password" /><br />
								<input class="form_submit" type="submit" name="Login" />
							</div>
						</form>
					</div>				
				</div>
			
			</div>
		</div>
	</body>
</html>
<?php
	session_destroy();
?>
