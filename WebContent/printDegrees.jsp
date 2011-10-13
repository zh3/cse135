<%@page import="com.cse135project.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Print Degrees</title>
	</head>
	<body>
		<% 
			Vector<Degree> degreeVec = (Vector<Degree>) session.getAttribute("degreeVector"); 
			if (degreeVec != null && degreeVec.size() > 0) {
		%>
			<h3> Your Submitted Degrees </h3>
		<%  } %>
	
		<!-- Loop through all the submitted degree attributes, printing them out. -->
		<%
			if (degreeVec != null) {
		
				for (Degree d: degreeVec) {
		%>
					<div> 
						<b> Degree</b> <%= d.getName() %>
						<br> <b>University</b> <%= d.getUniversity()  %>
						<br> <b>Location</b> <%= d.getLocation()  %>
						<br> <b>Degree Award Date</b>  <%= d.getMonth()+ "-" + d.getYear() %>
						<br> <b>Degree Title</b>  <%= d.getTitle() %>
						<br> <b>GPA / Expected GPA</b> <%= d.getGpa() %>
					</div>
					<br>
		<% 		
				}
			}
		%>
	</body>
</html>