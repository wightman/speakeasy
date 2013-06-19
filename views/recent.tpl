%#list of currents posts
%include shared/header.tpl header=page,logged=logged,username=username
<div id="main">
	<h1>Recent Posts</h1>
	%if posts:
		%include shared/form.tpl tweet=posts[0]
	%else:
		%include shared/form.tpl tweet= None
	%end
	
	<div class="tweets">
	%for tweet in recent:
		<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink</a></span></p>
	%end
	</div>
</div>
%include shared/side.tpl username=username,counts=counts
	
%include shared/footer.tpl
