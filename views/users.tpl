%#list of currents posts
%active='users'
%include shared/header.tpl header=page,logged=logged,active=active,username=username

<div class="container-fluid">

	<div class="visible-phone">
			%include shared/side.tpl username=username,counts=counts
	</div>

	<div class="row-fluid">

			<div style="overflow: auto; max-height: 675px" class="tweets hero-unit span9">
				<h1>Users</h1>
				<br></br>
				%for u in users:
					<p><img src="/static/avatar.png" /> <strong><a href="/{{u.username}}">{{u.username}}</a></strong></p>
				%end
			</div>

			<div class="span3 hidden-phone"> 
			%include shared/side.tpl username=username,counts=counts
			</div>
		</div>	
	</div>	
</div>
%include shared/footer.tpl
