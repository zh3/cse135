<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Verification</title>
		<%
			String specializationParam = request.getParameter("specialization");
			session.setAttribute("specialization", Integer.parseInt(specializationParam));
		%>
	</head>
	<body>
		<h3>Verification</h3>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
		
		<!-- Call submit or cancel pages -->
		<button onclick="window.location='cancel.jsp'">Cancel</button>
		<button onclick="window.location='submit.jsp'">Submit Application</button>
	</body>
</html>