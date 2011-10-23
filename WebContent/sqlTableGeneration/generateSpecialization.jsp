<%@page import="com.cse135project.*, java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Generate Specialization</title>
	</head>
	<body>
		<%
			support supp = new support();
			String cPath = config.getServletContext().getRealPath("txtdata/specializations.txt");
			Vector<String> specializations = supp.getSpecializations(cPath);
		%>
		
			<% 
				for (int i = 0; i < specializations.size(); i++) {
			%>
				INSERT INTO specializations (name) VALUES ('<%= specializations.get(i) %>');<br>
			<%  } %>
		
	</body>
</html>