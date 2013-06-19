<div class="navbar">
      <div class="navbar-inner">
        <ul class="nav pull-left visible-phone">
         	<li>
			 	<form class="navbar-search">
				  <input type="text" class="search-query" placeholder="Search">
				</form>
			</li>	
         	%if logged:
			<li><a href="/logout">Sign out</a></li>
			%else:
			<li><a href="/login">Sign in</a></li>
			%end 
		</ul>
        <ul class="nav">
        	%if logged:
       			<li><a class="brand" href="/recent">Speakeasy</a></li>
       		%else:
       			<li><a class="brand" href="/">Speakeasy</a></li>	
       		%end
       		 %if logged:
	        	%if active == 'home':
	        		<li class="active"><a href="/home">Home</a></li>
	    		%else:
	    			<li><a href="/home">Home</a></li>
	    		%end

	    		%if active == 'mentions':
	        		<li class="active"><a href="/mentions">@{{username}}</a></li>
	    		%else:
	    			<li><a href="/mentions">@{{username}}</a></li>
	    		%end 
	          	%if active == 'profile':
	          		<li class="active"><a href="/{{username}}">Profile</a></li>
	         	 %else:
	          		<li><a href="/{{username}}">Profile</a></li>	         	 
	     		%end
         	%end
         </ul>
         <ul class="nav pull-right hidden-phone">
         	<li>
			 	<form class="navbar-search pull-right">
				  <input type="text" class="search-query" placeholder="Search">
				</form>
			</li>	
         	%if logged:
			<li><a href="/logout">Sign out</a></li>
			%else:
			<li><a href="/login">Sign in</a></li>
			%end 
		</ul>
		
        
      </div>
    </div>


<!--<p><a href="/home">home</a> <a href="/logout">logout</a></p>-->