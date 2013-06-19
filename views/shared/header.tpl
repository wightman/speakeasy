%#header :)
<!DOCTYPE html>
<html lang="en-US">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">	
		<title>Speakeasy</title>
		<link href="/static/bootstrap.min.css" rel="stylesheet" media="screen">
    	<link href="/static/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
		<link rel="stylesheet" href="/static/retwis-py.css" type="text/css" media="screen" />
	</head>
	<body class="{{header}}">
		%if 'active' not in locals():
			%active=''
		%end
		%if 'username' not in locals():
			%username=''
		%end
		%include shared/nav.tpl logged=logged, active=active, username=username
		<div id="container">