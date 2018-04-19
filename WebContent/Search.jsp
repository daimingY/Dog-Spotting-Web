<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dog Spotting</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="guestfile.css" />
  <link rel="stylesheet" href="guestfile.css" />
  <script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
  	window.onload = function(){
  		var loggedin = <%=request.getSession().getAttribute("loggedin")%>;
  		console.log(loggedin);
  		if(loggedin===false || loggedin===null){
  			console.log("loggedin");
  			document.getElementById("guestusernavbar").innerHTML = "<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalg\">Log In</a></li><li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalg2\">Sign Up</a></li>";
  			document.getElementById("dogspottinglogo").innerHTML = "<a class=\"navbar-brand\" href=\"GuestPage.jsp\">DogSpotting</a>";
  		
  		}else{
  	  		// socket
  	  		var socketUsername = '<%=(String)request.getSession().getAttribute("currentusername")%>';
  	  		socket = new WebSocket("ws://localhost:8080/DogSpotting/ws");
  	  		socket.onopen = function(event){
  	  			socket.send(socketUsername);
  	  		}
  				socket.onmessage = function(event){
  		          console.log(event.data);
  		          if (event.data != 0) {
  		            $.post("GetNotifications", { username: socketUsername }, function(responseJson) {
  		              $.each(responseJson, function(index, notification) {
  		            	  var html = "";
  		            	  html+="<div id='notificationdiv'><img id='userprof' style='height: 15px; width: 15px; border-radius: 10px;' src=\"" + notification.user.userPicURL + "\">  " + notification.user.username +" : ";
  		            	  html+= notification.message + "</div><br>";
  		                document.getElementById("notifyNum").innerHTML += html;
  		              });
  		            });
  		          }
  		          //document.getElementById("notifyNum").innerHTML += event.data + "<br />";
  		        }
  				
  		}
  	}
  	function logout(){
  		var xhttp = new XMLHttpRequest();
  		xhttp.open("GET", "Logout?", false); //synchronous
  		xhttp.send();
  		window.location.replace("GuestPage.jsp");
  	}
    function validate() {
        console.log("here");
        var requeststr = "Login?";
        requeststr += "username="
                + document.getElementById("loginusername").value;
        requeststr += "&password="
                + document.getElementById("loginpassword").value;
        console.log(requeststr);
        var xhttp = new XMLHttpRequest();
        xhttp.open("POST", requeststr, false);
        xhttp.send();
        console.log(xhttp.responseText);
        if (xhttp.responseText.trim().length > 0) {
            console.log('login failed')
            document.getElementById("login_err").innerHTML = xhttp.responseText;
        } else {
            console.log('login success')
            window.location = "HomeFeed.jsp"
        }
    }
    function validatesignup() {
        console.log("here");
        var requeststr = "Signup?";
        requeststr += "username="
                + document.getElementById("signupusername").value;
        requeststr += "&password="
                + document.getElementById("signuppassword").value;
        requeststr += "&retypepassword="
            + document.getElementById("signupretypepassword").value;
        requeststr += "&url="
            + document.getElementById("signupurl").value;
        console.log(requeststr);
        var xhttp = new XMLHttpRequest();
        xhttp.open("POST", requeststr, false);
        xhttp.send();
        console.log(xhttp.responseText);
        if (xhttp.responseText.trim().length > 0) {
            console.log('Sign Up failed')
            document.getElementById("signup_err").innerHTML = xhttp.responseText;
        } else {
            console.log('sign up success')
            window.location = "HomeFeed.jsp"
        }
    }
    function validatePost() {
        console.log("here");
        var requeststr = "NewPost?";
        requeststr += "img="
                + document.getElementById("img").value;
        requeststr += "&description="
                + document.getElementById("description").value;
        requeststr += "&tag1="
            + document.getElementById("tag1").value;
        requeststr += "&tag2="
            + document.getElementById("tag2").value;
        requeststr += "&tag3="
            + document.getElementById("tag3").value;
        requeststr += "&tag4="
            + document.getElementById("tag4").value;
        requeststr += "&tag5="
            + document.getElementById("tag5").value;
        console.log(requeststr);
        var xhttp = new XMLHttpRequest();
        xhttp.open("POST", requeststr, false);
        xhttp.send();
        console.log(xhttp.responseText);
        if(xhttp.responseText.trim().length>0){
			console.log('post failed');
			document.getElementById("inputError").innerHTML = xhttp.responseText;
        }
        else{
        		console.log('post success');
        		window.location = 'Search.jsp?search='+'<%=(String)request.getParameter("search")%>';
        }
    }
  	</script>
</head>
<body>

	<%
String search = (String)request.getParameter("search");
%>

	<div class="container">
		<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div id="dogspottinglogo" class="navbar-header">
				<a class="navbar-brand" href="TopRanked.jsp">DogSpotting</a>
			</div>
			<form method="GET" class="navbar-form navbar-left"
				action="Search.jsp">
				<div class="input-group">
					<input type="text" id="search" class="form-control"
						placeholder="Search" name="search">
					<div class="input-group-btn">
						<button class="btn btn-default" type="submit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</form>
			<ul id="guestusernavbar" class="nav navbar-nav">
				<li><a type="button" data-toggle="modal" data-target="#myModal">+</a></li>
				<li><a href="TopRanked.jsp" type="button">Top</a></li>

				<li><a type="button" onclick="location.href='UserProfile.jsp'"><%=request.getSession().getAttribute("currentusername")%></a></li>

				<li><a type="button" onclick="logout()">Log Out</a></li>
				<li>
					<div class="dropdown show">
						<a type="button" class="dropdown-toggle" href="#" role="button"
							id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> Notifications </a>

						<div id="notifyNum" style="width: 250px; padding: 10px;"
							class="dropdown-menu large" aria-labelledby="dropdownMenuLink">
						</div>
					</div>
				</li>
			</ul>
			<div id="notifyNum"> </div>
		</div>
		</nav>
	</div>
	<!-- Trigger the modal with a button -->

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

      <!-- Modal content-->
   <div class="modal-content">
     <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h1 class="modal-title">New Post</h1>
    </div>
     <div id="postform">
        <div class="modal-body">
  		Image URL:<input type="url" id="img" name="img"><br>
  		Caption:<input type="text" id="description" name="description"><br>
  		Tag 1:<input type="text" id="tag1" name="tag1"><br>
  		Tag 2:<input type="text" id="tag2" name="tag2"><br>
  		Tag 3:<input type="text" id="tag3" name="tag3"><br>
  		Tag 4:<input type="text" id="tag4" name="tag4"><br>
  		Tag 5:<input type="text" id="tag5" name="tag5"><br>
  		<span id="inputError" style="color: darkred; font-weight: bold"></span>
      </div>
      </div>
      <div class="modal-footer">
          <button type="button" id="closebutton" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" id="postbutton" class="btn btn-default" onclick="validatePost()">Post</button>
      </div>
    </div>
  </div>
    </div>

	<!-- Modal guest sign up-->
	<div class="modal fade" id="myModalg2" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h1 class="modal-title">Sign Up</h1>
				</div>
				<div id="signupform">
					<div class="modal-body">
						Username:<input type="text" id="signupusername"></><br>
						<br> Password:<input type="password" id="signuppassword"></><br>
						<br> Retype Password:<input type="password" id="signupretypepassword"></><br>
						<br> Profile Image URL Link:<input type="url" id="signupurl"></><br>
						<span id="signup_err" style="color: darkred; font-weight: bold"></span>
					</div>
					<div class="modal-footer">
						<button type="button" id="closesignup" class="btn btn-default"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-default" onclick="validatesignup()">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal guest log in-->
	<div class="modal fade" id="myModalg" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h1 class="modal-title">Log In</h1>
				</div>
				<div id="loginform">
					<div class="modal-body">
						Username:<input type="text" id="loginusername"></><br>
						<br> Password:<input type="password" id="loginpassword"></><br>
						<span id="login_err" style="color: darkred; font-weight: bold"></span>
					</div>
					<div class="modal-footer">
						<button type="button" id="closelogin" class="btn btn-default"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-default" onclick="validate()">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</div>






	<div class="container" style="padding-top: 70px">
		<div id="posts"></div>
		<div id="readMoreButton">
			<button class="btn btn-default" id="readMore">Read More</button>
		</div>
	</div>
	<br>
	<br>

	<script>
	var numOfPost = 0;
	var postEachPage = 20;
	var curCount = 0;
	var follow = Array();
	var like = Array();
	var numLike = Array();
  $(document).ready(function() {
    $("#readMore").click();
  });
  
  
  
  $("#readMore").on("click", function() {

	    numOfPost += postEachPage;
	    curCount = 0;
	    $.post("Search", { search: "<%= search %>", limit: numOfPost }, function(responseJson) {
	        $("#posts").empty();
	        $.each(responseJson, function(index, post) {
	          curCount++;
	          follow[index] = post.isFollow;
	          like[index] = post.isLike;
	          numLike[index] = post.numOfLikes;
	          
	          
	          var loggedin = <%=request.getSession().getAttribute("loggedin")%>;
	          var html = "";

	          if(loggedin===false || loggedin ===null){
	          html+="<div id='post' class='container post thumbnail'><span><img id=\"userprofpic\" src=\"" + post.user.userPicURL + "\"><text id=\"userusername\" href=\"#\">" + post.user.username + "</text></span><a href=\"#\"><img src=\"" +post.imageURL+"\"></a></div><br><br><br>";
	          $("#posts").append(html);

	          }else{
	          
	          html += "<div id='post' class='container thumbnail'>";
	          html += "<span>" + "<img id='userprofpic' src='"+ post.user.userPicURL +"'>";
	          html += "<a type='button' onclick='userProfile(\""+ post.user.username+ "\")'>" + post.user.username + "</a>";
	          html += "</span>"
	          html += "<a href='PostPage?postID=" + post.postID + "'><img src='" + post.imageURL + "'></a>";
	          html += "<div id='like' class=\"btn-group btn-group-justified\" role=\"group\" aria-label=\"...\">";
	          html += "<div class=\"btn-group\" role=\"group\"><button class='btn btn-default' id='l" + post.postID + "'>" + (post.isLike ?  "<i class=\"fas fa-heart\"></i>" : "<i class=\"far fa-heart\"></i>") + " " + (post.numOfLikes) + "</button></div>";
	          if (!(post.user.username === "<%= request.getSession().getAttribute("currentusername") %>")) {
	              html += "<div class=\"btn-group\" role=\"group\"><button class='btn btn-default float-right' id='f" + post.postID + "'>" + (post.isFollow ? "Unfollow" : "Follow") + "</button></div>";
	          }
	          html += "</div>";
	          html += "</div>";
	          }
	          
	          

	          $("#posts").append(html);
	          var curID = "#f" + post.postID;
	          $(document).on("click", curID, function() {
	              $.post("Follow", {username: post.user.username, isFollow: follow[index]});
	              if (follow[index]) {
	                follow[index] = false;
	                this.innerText = "Follow";
	              } else {
	              	 follow[index] = true;
	              	 this.innerText = "Unfollow";
	              }
	          });
	          curID = "#l" + post.postID;
	          $(document).on("click", curID, function() {
	              $.post("Like", {postID: post.postID, isLike: like[index]});
	              if (like[index]) {
	                like[index] = false;
	                numLike[index]--;
	                this.innerHTML = "<i class=\"far fa-heart\"></i>" + numLike[index];
	              } else {
	                 like[index] = true;
	                 numLike[index]++;
	                 this.innerHTML = "<i class=\"fas fa-heart\"></i>" + numLike[index];
	              }
	          });        
	        });
	        if (curCount <= numOfPost - postEachPage) {
	          $("#readMoreButton").html("No more posts");
	        }
	    });
	  });

  function userProfile(str){
	  console.log("str:" + str);
	  var requeststr = "ValidateUsername?";
  requeststr += "otherusername="
          + str;
  var validInput = false;
	  var userVal = "<%=(String) session.getAttribute("currentusername")%>"
	  if(str == userVal)
		  {
		  	validInput = true;
		  	window.location = "UserProfile.jsp?username="+"<%=(String) session.getAttribute("currentusername")%>";
		  }
	  if(validInput == false){
 // add if statement to check if this is you're own profile
  console.log(requeststr);
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", requeststr, true);
  xhttp.send();
  console.log(xhttp.responseText);
	  //HttpSession session  = request.getSession();
	  //session.setAttribute("otherusername",str);
	  window.location = "OtherProfile.jsp?otherusername="+str;
	  console.log("other profile buton: " + str);}
}  
</script>
</body>

</body>
</html>
