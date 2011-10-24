<%@page import="com.cse135project.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Current Data</title>
	</head>
	<body>
		<% 
			Connection dbs = DBConnection.dbConnect();
			support supp = new support();
			String cPath = config.getServletContext().getRealPath("txtdata/countries.txt");
		
			String firstName = (String) session.getAttribute("firstName"); 
			String middleInitial = (String) session.getAttribute("middleInitial");
			String lastName = (String) session.getAttribute("lastName");
			Integer countryCitizenshipId = (Integer) session.getAttribute("countryOfCitizenshipId");
			Integer countryResidenceId = (Integer) session.getAttribute("countryOfResidenceId");
			/*james code*/
			
			String streetAddress = (String) session.getAttribute("streetAddress");
			String city = (String) session.getAttribute("city");
			String state = (String) session.getAttribute("state");
			String zipCode = (String) session.getAttribute("zipCode");
			Integer countryCode = (Integer) session.getAttribute("countryCode");
			Integer areaCode = (Integer) session.getAttribute("areaCode");
			Integer telNumber = (Integer) session.getAttribute("telNumber");
			
			String residencyStatus = (String) session.getAttribute("residencyStatus");
			Integer specializationId = (Integer) session.getAttribute("specialization");
			
			String countryOfCitizenship = null;
			String countryOfResidence = null;
			String specialization = null;
			
			if (specializationId != null) {
				PreparedStatement pstatement = dbs.prepareStatement("SELECT name from specializations WHERE id = ?");
				pstatement.setInt(1, specializationId);
				ResultSet resSet = pstatement.executeQuery();
				
				specialization = "";
				if (resSet.next()) {
					specialization = resSet.getString(1);
				}
				
				resSet.close();
				pstatement.close();
			}
			
			if (countryCitizenshipId != null) {
				PreparedStatement pstatement = dbs.prepareStatement("SELECT name from countries WHERE id = ?");
				pstatement.setInt(1, countryCitizenshipId);
				ResultSet resSet = pstatement.executeQuery();
				
				countryOfCitizenship = "";
				if (resSet.next()) {
					countryOfCitizenship = resSet.getString(1);
				}
				
				resSet.close();
				pstatement.close();
			}
			
			if (countryResidenceId != null) {
				PreparedStatement pstatement = dbs.prepareStatement("SELECT name FROM countries WHERE id = ?");
				pstatement.setInt(1, countryResidenceId);
				ResultSet resSet = pstatement.executeQuery();
				
				countryOfResidence = "";
				if (resSet.next()) {
					countryOfResidence = resSet.getString(1);
				}
				
				resSet.close();
				pstatement.close();
			}
		%>
		
		<h3>Your Application Summary</h3>
		<% if (firstName != null && middleInitial != null && lastName != null) { %>
			<p> <b>Name </b> <%= firstName + " " + middleInitial + " " + lastName %> </p>
		<% } %>
		
		<% if (countryOfCitizenship != null) { %>
			<p> <b>Country of Citizenship </b> <%= countryOfCitizenship %> </p>
		<% } %>
		
		<% if (countryOfResidence != null) { %>
			<p> <b>Country of Residence </b> <%= countryOfResidence %> </p>
		<% } %>
		
		<% if (streetAddress != null) { %>
			<p> <b>Street Address </b> <%= streetAddress %> </p>
		<% } %>
		
		<% if (city != null) { %>
			<p> <b>City </b> <%= city %> </p>
		<% } %>
		
		<% if (state != null) { %>
			<p> <b>State </b> <%= state %> </p>
		<% } %>
		
		<% if (zipCode != null) { %>
			<p> <b>Zip Code </b> <%= zipCode %> </p>
		<% } %>
		
		<% if (countryCode != null) { %>
			<p> <b>Country Call Code </b> <%= countryCode %> </p>
		<% } %>
		
		<% if (areaCode != null) { %>
			<p> <b>Area Code </b> <%= areaCode %> </p>
		<% } %>
		
		<% if (telNumber != null) { %>
			<p> <b>Phone Number </b> <%= telNumber %> </p>
		<% } %>
		
		<% if (residencyStatus != null) { %>
			<p> <b>Residency Status </b> <%= residencyStatus %> </p>
		<% } %>
		
		<%@ include file="printDegrees.jsp" %>
		
		<% if (specialization != null) { %>
			<p> <b>Specialization </b> <%= specialization %> </p>
		<% } %>
		
		<%
			dbs.close();
		%>
	</body>
</html>