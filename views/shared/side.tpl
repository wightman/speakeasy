<!-- DESKTOP/TABLET -->

	<div class="well sidebar-nav hidden-phone">
            <ul class="nav nav-list">

	<li class="nav-header">
		<img src="/static/avatar-small.png" />{{username}}
		
	</li>
		<li><a href="/{{username}}">Tweets <span class="pull-right">{{counts[2]}} </span></a></li>
		<li><a href="/following">Following<span class="pull-right">{{counts[0]}}</span></a></li>
		<li><a href="/followers">Followers<span class="pull-right">{{counts[1]}}</span></a></li>
		<li><a href="/mentions">@{{username}}</a></li>
	</ul>
	</div>

<!-- PHONE -->

	<div id="sidebar-collapsed" class="navbar visible-phone">
		<div class="navbar-inner">
			<div class="row">
			<ul class="nav">
				<li class="brand"><img src="/static/avatar-small.png" />{{username}}</li>
				</ul>
			<ul class="row nav">
			</div>
			<div class="row">
				<ul class="nav">
					<li><a href="/{{username}}">Tweets:</a></li>
					<li class="brand">{{counts[2]}}</li>
				</ul>
			</div>
			<div class="row">
			<ul class="nav">
				<li><a href="/following">Following:</a></li>
				<li class="brand">{{counts[0]}}</li>
			</ul>
			</div>
			<div class="row">
				<ul class="nav">
				<li><a href="/followers">Followers:</a></li>
				<li class="brand">{{counts[1]}}</li>
			</ul>
			</div>
		</div>
	</div>

