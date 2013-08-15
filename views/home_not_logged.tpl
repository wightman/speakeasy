%#this is the homepage :)
%include shared/header.tpl header='home', logged=logged

<div class="container-fluid">

<div style="overflow: auto; max-height: 555px" class="hero-unit tweets span9">
	<h1>Welcome!<h1>
		<h3>Create an account and start posting!</h3>
		<br/>
	<div class="tweets">
	%for tweet in recent:
<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink</a></span></p>
	%end
	</div>
</div>
</div>
%include shared/footer.tpl
