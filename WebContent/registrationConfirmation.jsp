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
	PreparedStatement sql = null;
	ResultSet rset = null;
	Connection conn = null;
	
	try {
	
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
	
	if (username.equals("")) {
		response.sendRedirect("applicantRegistration.jsp?problem=usernameBlank");
	}
	
	sql = conn.prepareStatement("SELECT username FROM users WHERE username = ?");
	sql.setString(1, username);
	rset = sql.executeQuery();
	if (rset.next()) {
		response.sendRedirect("applicantRegistration.jsp?problem=usernameAlreadyChosen");
	}
	
	if (password.equals("") || password2.equals("")) {
		response.sendRedirect("applicantRegistration.jsp?problem=blankPassword");
	}
	
	if (!password.equals(password2)) {
		response.sendRedirect("applicantRegistration.jsp?problem=passwordsDontMatch");
	}
	
	if (email.equals("")) {
		response.sendRedirect("applicantRegistration.jsp?problem=blankEmail");
	}
	
	sql = conn.prepareStatement("SELECT email FROM users WHERE email = ?");
	sql.setString(1, email);
	rset = sql.executeQuery();
	if (rset.next()) {
		response.sendRedirect("applicantRegistration.jsp?problem=alreadyRegistered");
	}
%>
</head>
<body>
<%
	sql = conn.prepareStatement("INSERT INTO users (username, password, email) VALUES (?, md5(?),?);");
	sql.setString(1, username);
	sql.setString(2, password);
	sql.setString(3, email);
	sql.executeUpdate();
	sql.close();
	
	
	sql = conn.prepareStatement("INSERT INTO userRoles (userName, role) VALUES (?, ?)");
	sql.setString(1, username);
	sql.setString(2, "applicant");
	sql.executeUpdate();
	sql.close();
	
	out.write("<h3>You have successfully registered!</h3>");
	
	} catch (SQLException e) {
		out.write("<h3>An error occurred with your registration</h3>");
	} finally {
		if (rset != null) rset.close();
		if (sql != null) sql.close();
		if (conn != null) conn.close();
	}

%>
</body>
</html>