%#list of currents posts
%if himself:
	%active='profile'
	%include shared/header.tpl header=page,logged=logged,username=username,active=active
%else:
	%include shared/header.tpl header=page,logged=logged,username=viewer
	%end

<div class="visible-phone">
		%include shared/side.tpl username=username,counts=counts
</div>

<div class="container-fluid">

	<div class="row-fluid">
	<div class="tweets hero-unit span9">

	%include shared/profile.tpl user=user, logged=logged, himself=himself

	%if logged and not himself:
		%if is_following:
		<form action="/unfollow/{{username}}" method="post" accept-charset="utf-8" class="unfollow-user">	
			<p><input type="submit" value="Unfollow {{username}}"></p>
		</form>
		%else:
		<form action="/follow/{{username}}" method="post" accept-charset="utf-8" class="follow-user">	
			<p><input type="submit" value="Follow {{username}}"></p>
		</form>
		%end
	%end


	%if posts:
  	%for tweet in posts:
		%if himself:
			%include shared/post.tpl tweet=tweet,username=username
		%else:
			%include shared/post.tpl tweet=tweet,username=viewer
  	%end
   %else:
   <p>{{username}} hasn't posted any tweet yet</p>
  %end
	</div>




<div class="span3 hidden-phone"> 
	%include shared/side.tpl username=username,counts=counts
	</div>
</div>
	</div>
%include shared/footer.tpl
