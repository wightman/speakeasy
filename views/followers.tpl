%#list of currents posts
%include shared/header.tpl header=page,logged=logged
<div class="container-fluid">

<div class="visible-phone">
		%include shared/side.tpl username=username,counts=counts
	</div>	
	<div class="row-fluid">
	<div style="overflow: auto; max-height: 675px" class="tweets hero-unit span9">

	<h1>Followers</h1><br/>
	
	
	%for user_id in followers:
		<p><img src="/static/avatar.png" /> <strong><a href="/{{user_id.username}}">{{user_id.username}}</a></strong></p>
	%end
	</div>

	<div class="span3 hidden-phone"> 
	%include shared/side.tpl username=username,counts=counts
	</div>

</div>
	
</div>
%include shared/footer.tpl
