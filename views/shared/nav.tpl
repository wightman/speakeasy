<div class="navbar navbar-fixed-top visible-phone">
    <div class="navbar-inner">
        <ul class="row-fluid nav">
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
        <ul class="row nav">
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
    </div>
 </div>

 
 <div class="navbar hidden-phone">
     <div class="navbar-inner">
        <ul class="nav pull-left">
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
         <ul class="nav pull-right">
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