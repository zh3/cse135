<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Applicant Registration</title>

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

String problem = request.getParameter("problem");
%>
</head>



<body>

<%
	if (problem != null) {
		if (problem.equals("blankEmail")) {
			out.write("<h3>Please enter an email address.</h3>");
		} else if (problem.equals("usernameBlank")) {
			out.write("<h3>Please enter a username.</h3>");
		} else if (problem.equals("alreadyRegistered")) {
			out.write("<h3>You are already registered. Please login to submit an application.</h3>");
		} else if (problem.equals("usernameAlreadyChosen")) {
			out.write("<h3>Sorry, the user name you have selected has already been chosen.</h3>");
		} else if (problem.equals("blankPassword")) {
			out.write("<h3>Please enter a password.</h3>");
		} else if (problem.equals("passwordsDontMatch")) {
			out.write("<h3>Passwords do not match.</h3>");
		} else {
			out.write("<h3>Unknown problem occurred.</h3>");
		}
	}
%>
	
	
<h3>Applicant Registration</h3>
		
		
			<form name="myform" action= "registrationConfirmation.jsp"  method="GET">
			
			
			username: <input type="text" size="20" name="username" />
			<br>password: <input type="password" size="20" name="password" />
			<br>retype password: <input type="password" size="20" name="password2" />
			<br>email:  <input type="text" size="20" name="email"/>
			
			
		    <br>
		    <br>
		    <br>
		    <input type= "submit" value="Submit"/>
		</form>

</body>
</html>