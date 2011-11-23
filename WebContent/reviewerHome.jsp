<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%
			RowSet applicants = (RowSet) request.getAttribute("applicantsByReviewer");
			String username = request.getUserPrincipal().getName();
		%>
		<title><%= username %>'s Review Home</title>
	</head>
	<body>
		<h3><%= username %>'s Review Home</h3>
		
		<h4>Ungraded Applicants</h4>
		
		<%  while (applicants.next()) { 
			String applicantId = applicants.getString("id");
		%>
		<a href="applicationReview.do?applicantId=<%= applicantId %>">
			<%= 
				applicants.getString("firstName") + applicants.getString("middleName")
					+ applicants.getString("lastName")
			%>
		</a>
		<br/>
		<%  } %>
	</body>
</html>