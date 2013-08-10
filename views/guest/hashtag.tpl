
%#WORK IN PROGRESS!
%#list of currents posts
%include shared/header.tpl header=page,logged=logged
<div class="container-fluid">
	<div class="row-fluid">
	<div class="tweets hero-unit span9">
	<h1>#{{title}}</h1>
	<br/>
		
	
	%for post in hashtags:
		%include shared/post.tpl tweet=post,username=username
	%end
	</div>
	</div>
</div>
	
%include shared/footer.tpl
