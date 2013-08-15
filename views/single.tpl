%#single post template
%include shared/header.tpl header=page,logged=logged,username=viewer
<div style="overflow: auto; max-height: 675px" class="hero-unit tweets">
	<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink</a></span></p>
</div>
%include shared/footer.tpl
