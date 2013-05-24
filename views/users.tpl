%#list of currents posts
%include shared/header.tpl header=page,logged=logged
<div id="main">
	<h1>Users</h1>
	
	<div class="tweets">
	%for u in users:
<p><img src="/static/avatar.png" /> <strong><a href="/{{u.username}}">{{u.username}}</a></strong></p>
	%end
	</div>
</div>
%include shared/side.tpl username=username,counts=counts
	
%include shared/footer.tpl