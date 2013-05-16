%#list of currents posts
%include shared/header.tpl header=page,logged=logged
<div id="main">
	<h1>Followers</h1>
	
	<div class="tweets">
	%for user_id in followers:
<p><img src="/static/avatar.png" /> <strong><a href="/{{user_id.username}}">{{user_id.username}}</a></strong></p>
	%end
	</div>
</div>
%include shared/side.tpl username=username,counts=counts
	
%include shared/footer.tpl