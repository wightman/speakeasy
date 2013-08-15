%#WORK IN PROGRESS!
%#list of currents posts
%include shared/header.tpl header=page,logged=logged,username=username
<div class="container-fluid">
	
	<div class="visible-phone">
		%include shared/side.tpl username=username,counts=counts
	</div>	

	<div class="row-fluid">

	<div style="overflow: auto; max-height: 675px" class="hero-unit tweets span9">
	<h1>#{{title}}</h1>
	<p/>
	
	%for post in hashtags:
<p><img src="/static/avatar.png" /> <strong><a href="/{{post.user.username}}">{{post.user.username}}</a></strong> {{post.content}}<span><a href="/{{post.user.username}}/statuses/{{post.id}}">permalink</a></span></p>
	%end
	</div>

</div>
</div>
</div>

	
%include shared/footer.tpl
