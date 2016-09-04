<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<?php 
	session_start();
	if (ini_get('register_globals'))
	{
		foreach ($_SESSION as $key=>$value)
		{
			if (isset($GLOBALS[$key]))
				unset($GLOBALS[$key]);
		}
	}
	
	if ( !isset ($_SESSION["Logged"]) || ($_SESSION["Logged"] == false) ) {
		header("Location: login.php");
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
	</head>
	
	<body>
		<h1>This is a test.</h1>
	</body>
</html>

<?php 
	session_destroy(); 
?>