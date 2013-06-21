%#list of currents posts
%active='users'
%include shared/header.tpl header=page,logged=logged,active=active

<div class="container-fluid">

<div class="row-fluid">
<div class="tweets hero-unit span9">

	<h1>Users</h1>
	<br/>
	
	
	%for u in users:
<p><img src="/static/avatar.png" /> <strong><a href="/{{u.username}}">{{u.username}}</a></strong></p>
	%end
	</div>
</div>

</div>
	
%include shared/footer.tpl