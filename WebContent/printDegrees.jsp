<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Print Degrees</title>
	</head>
	<body>
		<h3> Your Submitted Degrees </h3>
	
		<!-- Loop through all the submitted degree attributes, printing them out. -->
		<%
			int j = 0;
			while(session.getAttribute("submittedDegree"+ Integer.toString(j)) != null)
			{
		%>
				<div> 
					<b> Degree</b> <%= (String) session.getAttribute("submittedDegreeName"+ Integer.toString(j)) %>
					<br> <b>University</b> <%= (String) session.getAttribute("submittedDegreeUniversity"+ Integer.toString(j))  %>
					<br> <b>Location</b> <%= session.getAttribute("submittedDegreeLocation"+ Integer.toString(j))  %>
					
					<br> <b>Degree Award Date</b>  <%= (String) session.getAttribute("submittedDegreeMonth" + Integer.toString(j)) 
											+ "-" + (String) session.getAttribute("submittedDegreeYear"+ Integer.toString(j)) %>
					<br> <b>Degree Title</b>  <%= (String) session.getAttribute("submittedDegreeTitle"+ Integer.toString(j)) %>
					<br> <b>GPA / Expected GPA</b> <%= (String) session.getAttribute("submittedDegreeGpa"+ Integer.toString(j)) %>
				</div>
			 <br>
			 <% j++; %>
		<% 	} %>
	</body>
</html>