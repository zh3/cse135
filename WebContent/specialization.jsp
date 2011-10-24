<%@page import="com.cse135project.*, java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Specialization</title>
	</head>
	<body>
		<h3> Choose Specialization </h3>
		<%
			Connection db = DBConnection.dbConnect();
		
			Statement sql = db.createStatement();
			
			ResultSet result = sql.executeQuery("SELECT * FROM specializations");
		%>
		
		<form action="verification.jsp" method="GET">
			<select name="specialization">
				<% 
					while (result.next()) {
				%>
						<option value="<%= result.getInt(1) %>">
							<%= result.getString(2) %>
						</option>
				<%  } 
					
					result.close();
					sql.close();
					db.close();
				%>
			</select>
			<input type="submit" value="Submit" />
		</form>
		
	</body>
</html>