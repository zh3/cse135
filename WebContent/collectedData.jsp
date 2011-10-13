<%@page import="com.cse135project.*, java.util.*" %>
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
			support supp = new support();
			String cPath = config.getServletContext().getRealPath("txtdata/countries.txt");
			Vector<String> countriesVector = supp.getCountries(cPath);
		
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
			String countryCode = (String) session.getAttribute("countryCode");
			String areaCode = (String) session.getAttribute("areaCode");
			String telNumber = (String) session.getAttribute("telNumber");
			
			String residencyStatus = (String) session.getAttribute("residencyStatus");
		%>
		
		<h3>Your Application Summary</h3>
		<% if (firstName != null && middleInitial != null && lastName != null) { %>
			<p> <b>Name </b> <%= firstName + " " + middleInitial + " " + lastName %> </p>
		<% } %>
		
		<% if (countryCitizenshipId != null) { %>
			<p> <b>Country of Citizenship </b> <%= countriesVector.get(countryCitizenshipId) %> </p>
		<% } %>
		
		<% if (countryResidenceId != null) { %>
			<p> <b>Country of Residence </b> <%= countriesVector.get(countryResidenceId) %> </p>
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
	</body>
</html>