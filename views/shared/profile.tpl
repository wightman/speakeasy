%if user:
	<div id="profile">
		%if user.firstName and user.lastName:
			<div><h3><b>{{user.firstName}} {{user.lastName}}</b></h3></div>
		%end
		%if user.username:
			<div><p>@{{user.username}}</p></div>
		%end
		%if user.greeting:
			<div><i>{{user.greeting}}</i></div> 
		%end
		%if logged and himself:
			<form action="/edit/{{user.username}}" method="get" accept-charset="utf-8" class="">
				<p><input type="submit" value="Edit Profile"></p>
			</form>
			<br/>
		%end
	</div>
