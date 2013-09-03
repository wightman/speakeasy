%#this is the homepage :)
%include shared/header.tpl header='home', logged=logged

<div class="container-fluid">

<div class="hero-unit tweets span9">
	<h1>Welcome!<h1>
		<h3>Create an account and start posting!</h3>
		<br/>
	<div class="tweets">
	%for tweet in recent:
%include shared/post.tpl tweet=tweet
	%end
	</div>
</div>
</div>
%include shared/footer.tpl
