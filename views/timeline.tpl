%#list of currents posts
%active='home'
%include shared/header.tpl header=page,logged=logged,active=active,username=username
<div class="container-fluid">
	
	<div class="visible-phone">
		%include shared/side.tpl username=username,counts=counts
	</div>

	<div class="row-fluid">

		<div class="tweets hero-unit span9">
			%include shared/form.tpl tweet=last_tweet
			%for tweet in timeline:
				%include shared/post.tpl tweet=tweet,username=username
			%end
		</div>

	<div class="span3 hidden-phone"> 
	%include shared/side.tpl username=username,counts=counts
	</div>
	</div>
</div>


	
%include shared/footer.tpl
