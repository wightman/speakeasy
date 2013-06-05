
%#WORK IN PROGRESS!
%#list of currents posts
%include shared/header.tpl header=page,logged=logged
<div id="main">
	<h1>#{{title}}</h1>
	<p/>
	
	<div class="tweets">
	%for post in hashtags:
<p><img src="/static/avatar.png" /> <strong><a href="/{{post.user.username}}">{{post.user.username}}</a></strong> {{post.content}}<span><a href="/{{post.user.username}}/statuses/{{post.id}}">permalink</a></span></p>
	%end
	</div>
</div>
	
%include shared/footer.tpl