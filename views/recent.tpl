%#list of currents posts
%include shared/header.tpl header=page,logged=logged,username=username
<div class="container-fluid">

	<div class="visible-phone">
		%include shared/side.tpl username=username,counts=counts
	</div>

	<div class="row-fluid">

		<div class="tweets hero-unit span9">
		<h3>Recent Posts</h3>
			%if posts:
				%include shared/form.tpl tweet=posts[0]
			%else:
				%include shared/form.tpl tweet= None
			%end
		
		
		%for tweet in recent:
			%include shared/post.tpl tweet=tweet,username=username
		%end
		</div>

		<div class="span3 hidden-phone"> 
		%include shared/side.tpl username=username,counts=counts
		</div>
	</div>
</div>

	
%include shared/footer.tpl
