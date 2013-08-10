
%#WORK IN PROGRESS!
%#list of currents posts
%include shared/header.tpl header=page,logged=logged,username=username
<div class="container-fluid">
	
	<div class="visible-phone">
		%include shared/side.tpl username=username,counts=counts
	</div>	

	<div class="row-fluid">

	<div class="hero-unit tweets span9">
	<h1>#{{title}}</h1>
	<p/>
	
	%for post in hashtags:
%include shared/post.tpl tweet=post,username=username
	%end
	</div>

</div>
</div>
</div>

	
%include shared/footer.tpl
