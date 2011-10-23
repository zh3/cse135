<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
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
			Connection database = DBConnection.dbConnect();	
		
			Vector<Degree> degreeVec = (Vector<Degree>) session.getAttribute("degreeVector"); 
			if (degreeVec != null && degreeVec.size() > 0) {
		%>
			<h3> Your Submitted Degrees </h3>
		<%  } %>
	
		<!-- Loop through all the submitted degree attributes, printing them out. -->
		<%
			if (degreeVec != null) {
		
				for (Degree d: degreeVec) {
					int disciplineId = d.getDisciplineId();
					int universityId = d.getUniversityId();
					String disciplineName = "";
					String universityName = "";
					String locationName = "";
					
					// Get discipline name from database
					PreparedStatement pstmt 
						= database.prepareStatement("SELECT name FROM disciplines WHERE id = ?");
					pstmt.setInt(1, disciplineId);
					ResultSet rset = pstmt.executeQuery();
					
					if (rset.next()) {
						disciplineName = rset.getString(1);
					}
					
					rset.close();
					pstmt.close();
					
					// Get university name and location from db
					pstmt = database.prepareStatement("SELECT location, name FROM universities WHERE id = ?");
					pstmt.setInt(1, universityId);
					rset = pstmt.executeQuery();
					
					if (rset.next()) {
						locationName = rset.getString(1);
						universityName = rset.getString(2);
					}
					
					rset.close();
					pstmt.close();
		%>
					<div> 
						<b> Degree</b> <%= disciplineName %>
						<br> <b>University</b> <%= universityName %>
						<br> <b>Location</b> <%= locationName %>
						<br> <b>Degree Award Date</b>  <%= d.getMonth()+ "-" + d.getYear() %>
						<br> <b>Degree Title</b>  <%= d.getTitle() %>
						<br> <b>GPA / Expected GPA</b> <%= d.getGpa() %>
					</div>
					<br>
		<% 		
				}
				
				
			}
		
			database.close();
		%>
	</body>
</html>