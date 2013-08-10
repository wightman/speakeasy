<div class="hero-unit tweets">
	<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink - {{tweet.created_at}}</a>
%if tweet.user.username == username:
	<a href="/recent/delete/{{tweet.id}}">delete</a>
%end
</span></p>
</div>
