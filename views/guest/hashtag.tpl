%#WORK IN PROGRESS!
%#list of currents posts
%include shared/header.tpl header=page,logged=logged
<div class="container-fluid">
	<div class="row-fluid">
	<div style="overflow: auto; max-height: 675px" class="tweets hero-unit span9">
	<h1>#{{title}}</h1>
	<br/>
		
	
	%for post in hashtags:
<p><img src="/static/avatar.png" /> <strong><a href="/{{post.user.username}}">{{post.user.username}}</a></strong> {{post.content}}<span><a href="/{{post.user.username}}/statuses/{{post.id}}">permalink</a></span></p>
	%end
	</div>
	</div>
</div>
	
%include shared/footer.tpl
