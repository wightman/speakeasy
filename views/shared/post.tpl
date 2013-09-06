<div class="tweets">
	<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}
	
	<span>
		<a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink</a>
		%if tweet.user.username == username:
			<a> | </a><a href="/recent/delete/{{tweet.id}}">delete</a>
		%end
		<span class="pull-right"> {{tweet.get_timestamp()}} 
		</span>
	</span>
	</p>
</div>
