%#list of currents posts
%active='mentions'
%include shared/header.tpl header=page,logged=logged,active=active,username=username
<div id="main">
	<h1>What's happening?</h1>
	<form method="POST" action="/post" class="update">
		<textarea name="content"></textarea>
		<fieldset>
		%if posts:
			<p>{{posts[0].content}}</p>
		%end
		<input type="submit" value="update!" />
		</fieldset>
	</form>
	
	<div class="tweets">
	%for tweet in mentions:
<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink</a></span></p>
	%end
	</div>
</div>
%include shared/side.tpl username=username,counts=counts
	
%include shared/footer.tpl