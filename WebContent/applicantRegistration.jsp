<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%-- Import packages --%>

<%-- Open Connection Code --%>
<%
Connection conn = null;

// Obtain the environment naming context
Context initCtx = new InitialContext();
// Look up the data source
DataSource ds = (DataSource)
initCtx.lookup("java:comp/env/jdbc/ApplicationSystemPool");
// Allocate and use a connection from the pool
conn = ds.getConnection();


%>

</head>



<body>


<%
if((String)session.getAttribute("alreadyRegistered") != null)
{
	if((String)session.getAttribute("alreadyRegistered") == "true")
			{
		
	out.write("<h1>You are already registered. Please proceed to submit an application.</h1>");

}
	
	
}


if(session.getAttribute("usernameAlreadyChosen") != null)
{
	
	if((String)session.getAttribute("usernameAlreadyChosen") == "true"){
		
	out.write("<h2>Sorry, the user name you have selected has already been chosen.</h2>");

}
	
}
	

if((String)session.getAttribute("blankPassword") != null)
{
	
	
	if((String)session.getAttribute("blankPassword") == "true"){
		
	out.write("<h3>Please enter a password.</h3>");

}
	
}
	
	
	if((String)session.getAttribute("passwordsDontMatch") != null){
		
	if((String)session.getAttribute("passwordsDontMatch") == "true"){
		
	
	out.write("<h4>Passwords do not match.</h4>");

}
	
}
	%>
	
	
<h5>applicant registration</h5>
		
		
			<form name="myform" action= "registrationConfirmation.jsp"  method="GET">
			
			
			username: <input type="text" size="20" name="username" />
			<br>password: <input type="text" size="20" name="password" />
			<br>retype password: <input type="text" size="20" name="password2" />
			<br>email:  <input type="text" size="20" name="email"/>
			
			
		    <br>
		    <br>
		    <br>
		    <input type= "submit" value="Submit"/>
		</form>

</body>
</html>