<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration confirmation</title>

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



session.setAttribute("blankPassword", new String("false"));
session.setAttribute("passwordsDontMatch", new String("false"));
session.setAttribute("alreadyRegistered", new String("false"));
session.setAttribute("usernameAlreadyChosen", new String("false"));

String username = request.getParameter("username");
String password = request.getParameter("password");
String password2 = request.getParameter("password2");
String email = request.getParameter("email");

PreparedStatement sql = conn.prepareStatement("SELECT username, email FROM users WHERE username = ?");
sql.setString(1, username);
ResultSet rset = sql.executeQuery();

int i = 0;
while (rset.next()) {
	if(username.equals(rset.getString(1)) && email.equals(rset.getString(2)))
	{
		if(password == "")
		{
			
			session.setAttribute("blankPassword", new String("true"));
			response.sendRedirect("applicantRegistration.jsp");
		}
		else if(!password.equals(password2)){
			
			session.setAttribute("passwordsDontMatch", new String("true"));
			response.sendRedirect("applicantRegistration.jsp");
		}
		session.setAttribute("alreadyRegistered", new String("true"));
		response.sendRedirect("applicantRegistration.jsp");
	}
	else if(username.equals(rset.getString(1))){
	
		session.setAttribute("usernameAlreadyChosen", new String("true"));
		response.sendRedirect("applicantRegistration.jsp");
	}
	i++;
}

rset.close();
sql.close();
if(password == "")
{
	
	session.setAttribute("blankPassword", new String("true"));
	
	response.sendRedirect("applicantRegistration.jsp");
}
else if(!password.equals(password2)){


	session.setAttribute("passwordsDontMatch", new String("true"));
	response.sendRedirect("applicantRegistration.jsp");
}


%>
</head>
<body>
<%
out.write("You have successfully registered!");
PreparedStatement sql2 = conn.prepareStatement("INSERT INTO users (username, password, email) VALUES (?, md5(?),?);");
sql2.setString(1, username);
sql2.setString(2, password);
sql2.setString(3, email);
sql2.executeUpdate();
sql2.close();


PreparedStatement sql3 = conn.prepareStatement("INSERT INTO userRoles (userName, role) VALUES (?, ?)");
sql3.setString(1, username);
sql3.setString(2, "applicant");
sql3.executeUpdate();
sql3.close();
%>
</body>
</html>