%#login page
%include shared/header.tpl header=page,logged=logged
<div class="row">
<div class="hero-unit span4">
<form method="POST" action="/login" id="login">
	<h2>Login</h2>
	%if error_login:
		<p>wrong username/password</p>
	%end
	<p><label for="login-name">username:</label><input type="text" name="name" id="login-username"/></p>
	<p><label for="login-password">password:</label><input type="password" name="password" id="login-password"/></p>
<p><input type="submit" value="login!" /></p>
</form>
</div>

<div class="hero-unit span4">
<form method="POST" action="/signup" id="signup">
		<h2>Sign up</h2>
	%if error_signup:
		<p>username already exists</p>
	%end
<p><label for="signup-name">username:</label><input type="text" name="name" id="signup-username"/></p>
<p><label for="signup-password">password:</label><input type="password" name="password" id="signup-password"/></p>

<br/>
<h2>Tell us a little bit about yourself:</h2>
<p><label for="signup-firstName">first name:</label><input type="text" name="firstName" id="signup-firstName"/></p>
<p><label for="signup-lastName">last name:</label><input type="text" name="lastName" id="signup-lastName"/></p>
<p><label for="signup-greeting">Personal Greeting:</label><input type="textarea" name="greeting" id="signup-greeting"/></p>
<p><input type="submit" value="signup!" /></p>
</form>
</div>
</div>
%include shared/footer.tpl
