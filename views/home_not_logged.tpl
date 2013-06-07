%#this is the homepage :)
%include shared/header.tpl header='home', logged=logged
<div id="main">
	<h1>Welcome! Create an account and start posting!</h1>
	<div class="tweets">
	%for tweet in recent:
<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink</a></span></p>
	%end
	</div>
</div>
%include shared/footer.tpl