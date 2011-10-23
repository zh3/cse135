<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Choose Discipline</title>
		<!-- Get the majors vector and set the chosenUniversityid attribute -->
		<%
			Connection db = DBConnection.dbConnect();
			String newUniversity = request.getParameter("newUniversity");
			String newUniversityLocation = request.getParameter("newUniversityLocation");
					 
			Integer chosenUniversityId = Integer.parseInt(request.getParameter("chosenUniversityId"));
					
			session.setAttribute("chosenUniversityId", chosenUniversityId);		
		%>
	</head>
	
	<body>
		<h3>Provide Degrees - Choose Discipline</h3>
		
		<!-- Loop through the majors vector, making radio buttons for each major -->
		
		<form name="myform" action= "moreDegrees.jsp" method="GET">
			<input type="hidden" name="newUniversity" value="<%= newUniversity %>"/>
			<input type="hidden" name="newUniversityLocation" value="<%= newUniversityLocation %>"/>
		<% 
			Statement sql = db.createStatement();
			ResultSet rset = sql.executeQuery("SELECT * FROM disciplines");
		%>
		<% while (rset.next()) { %>
			<input type="radio" name="disciplineId" value="<%= rset.getInt(1) %>" >
			<%= rset.getString(2) %>
			<br>
		<%} %>
			<br> Don't see your degree? Enter here:  <input type="text" size="10" name="newDegree"/>
			<br> Date of Award:  
			<input type="text" size="2" name="month" value="mm"/>
			- <input type="text" size="4" name="year" value="yyyy"/>
			<br> GPA / Expected GPA:  <input type="text" size="5" name="gpa"/>
			<br> Title of Degree: 
			<select name="degree">
				<option value = "BS">BS
				<option value = "MS">MS
				<option value = "PhD">PhD 
		    </select> 
		    <br>
		    <br>
		    <br>
		    <input type= "submit" value="Submit"/>
		</form>
	</body>
</html>