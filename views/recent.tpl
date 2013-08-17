%#list of currents posts
%include shared/header.tpl header=page,logged=logged,username=username
<div class="container-fluid">

	<div class="visible-phone">
		%include shared/side.tpl username=username,counts=counts
	</div>

	<div class="row-fluid">

		<div style="overflow: auto; max-height: 675px" class="tweets hero-unit span9">
		<h3>Recent Posts</h3>
			%if posts:
				%include shared/form.tpl tweet=posts[0]
			%else:
				%include shared/form.tpl tweet= None
			%end
		
		
		%for tweet in recent:
			<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{tweet.user.username}}/statuses/{{tweet.id}}">permalink</a></span></p>
		%end
		</div>

		<div class="span3 hidden-phone"> 
		%include shared/side.tpl username=username,counts=counts
		</div>
	</div>
</div>

	
%include shared/footer.tpl
