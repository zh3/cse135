<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Address</title>
		<%
			boolean isUSCitizen;
			boolean isUSResident;
		
			Connection db = DBConnection.dbConnect();
			Statement s = db.createStatement();
			ResultSet rs = s.executeQuery("SELECT id FROM countries WHERE name = 'United States'");
			Integer unitedStatesId = -10;
			if (rs.next()) {
				unitedStatesId = rs.getInt(1);
			}
			
			rs.close();
			s.close();
			db.close();
			
			Integer countryOfResidenceId = Integer.parseInt(request.getParameter("countryOfResidenceId"));
			session.setAttribute("countryOfResidenceId", countryOfResidenceId);
			
			Integer countryOfCitizenshipId = (Integer) session.getAttribute("countryOfCitizenshipId");
			isUSCitizen = countryOfCitizenshipId.equals(unitedStatesId);
			isUSResident = countryOfResidenceId.equals(unitedStatesId);
		%>
	</head>
	<body>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
		
		<h3>Enter Address</h3>
		<!-- If the applicant is a US citizen, go to provide degrees page, else go to residency -->
		<form action=<%= isUSCitizen ? "provideDegreesChooseLocation.jsp" : "residency.jsp" %>>
			Street Address: <input type="text" size="30" name="streetAddress"/>
			<br> City: <input type="text" size="20" name="city"/>
			<% if (isUSResident) { %>
				<br> State: <input type="text" size ="20" name="state"/>
			<% } %>
			<br> Zip Code: <input type="text" size="10" name="zipCode"/>
			<% if (!isUSResident) { %>
				<br> Country Code: <input type="text" size="4" name="countryCode"/>
			<% } %>
			<br> Area Code: <input type="text" size="4" name="areaCode"/>
			<br> Number: <input type="text" size="7" name="telNumber"/>
			<br> <input type="submit" value="Submit"/>
		</form>
	</body>
</html>