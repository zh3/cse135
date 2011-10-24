<%@page import="com.cse135project.*, java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Application Submitted</title>
	</head>
	<body>
		<%
			Connection db = DBConnection.dbConnect();
			String insert = "INSERT INTO applicants (firstName, middleName, lastName, " 
					+ "streetAddress, city, state, zipCode, countryCode, areaCode, number, " 
					+ "residencyStatus, countryOfCitizenship, countryOfResidence, specialization)" 
					+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";
			PreparedStatement ps = db.prepareStatement(insert);
			
			ps.setString(1, (String) session.getAttribute("firstName"));
			ps.setString(2, (String) session.getAttribute("middleInitial"));
			ps.setString(3, (String) session.getAttribute("lastName"));
			
			ps.setString(4, (String) session.getAttribute("streetAddress"));
			ps.setString(5, (String) session.getAttribute("city"));
			ps.setString(6, (String) session.getAttribute("state"));
			ps.setString(7, (String) session.getAttribute("zipCode"));
			
			ps.setInt(8, (Integer) session.getAttribute("countryCode"));
			ps.setInt(9, (Integer) session.getAttribute("areaCode"));
			ps.setInt(10, (Integer) session.getAttribute("telNumber"));
			
			ps.setString(11, (String) session.getAttribute("residencyStatus"));
			ps.setInt(12, (Integer) session.getAttribute("countryOfCitizenshipId"));
			ps.setInt(13, (Integer) session.getAttribute("countryOfResidenceId"));
			ps.setInt(14, (Integer) session.getAttribute("specialization"));
			
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
		%>
				<h3> Your Application has been submitted </h3>
				<p> Your Application Id is : <b> <%= res.getInt(1) %></b></p>
		<%
			} else {
		%>
				<h3> Your Application has failed to submit </h3>
		<%
			}
			
			res.close();
			ps.close();
			db.close();
		%>
		
	</body>
</html>