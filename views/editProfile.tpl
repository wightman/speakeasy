%#login page
%include shared/header.tpl header=page,logged=logged,username=user.username

<form method="POST" action="/edit" id="edit">
	<br/>
	<h2>Tell us more about yourself:</h2>
<p><label for="edit-firstName">first name:</label><input type="text" name="firstName" id="edit-firstName" value="{{user.firstName}}"/></p>
<p><label for="edit-lastName">last name:</label><input type="text" name="lastName" id="edit-lastName" value="{{user.lastName}}"/></p>
<p><label for="edit-greeting">Personal Greeting:</label><input type="textarea" name="greeting" id="edit-greeting" value="{{user.greeting}}"/></p>
<!--  <p><label for="edit-password">password:</label><input type="password" name="password" id="edit-password" value="{{user.password}}"/></p> -->
<p><input type="submit" value="Save" /></p>
</form>

%include shared/footer.tpl
