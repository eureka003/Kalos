<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
	
	<title>Login</title>
</head>
<body class="sfondo-login">
  	<div class="login-card">
	<h2>Login</h2>

	<form action="Login" method="post" id="myform">
			<%if(request.getParameter("action")!=null && request.getParameter("action").equalsIgnoreCase("error") ){ %>
				<div>
					<p></p>
					<p class="error">Username o password errati.</p> 
				</div>
			
			<%}else if(request.getParameter("action")!=null && request.getParameter("action").equalsIgnoreCase("checkout")){ %>
					<input type="hidden" name="checkout"/><br><br>		
				
			<%}%>
			
			<div>
			<p>Username:</p>	
			<p><input type="text" name="un" required placeholder="inserisci username"/></p>		
			</div>
			<div>
			<p>Password:</p>
			<p><input type="password" name="pw" required placeholder="inserisci password"/></p>
			</div>
			<div>
			<p id=login><input type="submit" value="Login"> &nbsp;&nbsp;&nbsp; <a href="<%= request.getContextPath() %>/Registrazione.jsp"><br>non sei registrato?</a></p>		
			</div>
		</form>
	</div>
	
</body>
</html>