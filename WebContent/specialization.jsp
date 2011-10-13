<%@page import="com.cse135project.*, java.util.*" %>

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
			support supp = new support();
			String cPath = config.getServletContext().getRealPath("txtdata/specializations.txt");
			Vector<String> specializations = supp.getSpecializations(cPath);
		%>
		
		<form action="verification.jsp" method="GET">
			<select name="specialization">
				<% 
					for (int i = 0; i < specializations.size(); i++) {
				%>
						<option value="<%= specializations.get(i) %>">
							<%= specializations.get(i) %>
						</option>
				<%  } %>
			</select>
			<input type="submit" value="Submit" />
		</form>
		
	</body>
</html>