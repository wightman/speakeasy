%#list of currents posts
%include shared/header.tpl header=page, logged=logged
<div id="main">
	%include shared/profile.tpl user=user, logged=logged

<div class="tweets">
		%if posts:
			%for tweet in posts:
				<p><img src="/static/avatar.png" /> <strong><a href="/{{tweet.user.username}}">{{tweet.user.username}}</a></strong> {{tweet.content}}<span><a href="/{{username}}/statuses/{{tweet.id}}">permalink</a></span></p>
			%end
  	
	    %else:
	    <p>{{username}} hasn't posted any tweet yet</p>
	    %end
	</div>

</div>

%include shared/side.tpl username=username,counts=counts
%include shared/footer.tpl
