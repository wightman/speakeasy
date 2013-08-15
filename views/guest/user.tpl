%#list of currents posts
%include shared/header.tpl header=page, logged=logged
<div class="container-fluid">

	<div class="row-fluid">
	<div style="overflow: auto; max-height: 675px" class="tweets hero-unit span9">
	%include shared/profile.tpl user=user, logged=logged
	<br/>
		%if posts:
			%for tweet in posts:
				<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{username}}/statuses/{{tweet.id}}">permalink</a></span></p>
			%end
  	
	    %else:
	    <p>{{username}} hasn't posted any tweet yet</p>
	    %end
	</div>


<div class="span3 hidden-phone"> 
	%include shared/side.tpl username=username,counts=counts
	</div>

</div>

%include shared/footer.tpl
