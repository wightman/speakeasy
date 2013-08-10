%#list of currents posts
%include shared/header.tpl header=page, logged=logged
<div class="container-fluid">

	<div class="row-fluid">
	<div class="tweets hero-unit span9">
	%include shared/profile.tpl user=user, logged=logged
	<br/>
		%if posts:
			%for tweet in posts:
				%include shared/post.tpl tweet=tweet,username=username
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
