<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="saveAttributes.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Provide Degrees - Choose Location</title>
		<!-- get universities vector and set attribute residencyStatus  -->
		
		<%
			Connection db = DBConnection.dbConnect();
		
        	Statement sql = db.createStatement();
        	
        	if (!isResidencySaved(session)) {
        		saveResidency(session, request);
        	}
			
			// Only save address and residency if it hasn't already been done by another page
			if (!isAddressSaved(session)) {
				saveAddress(session, request);
			}
		%>
	</head>
	<body>
		<h3>Provide Degrees - Choose University Location</h3>
		
		<!-- make a 3-column table of all the locations, linking to provideDegreesChooseUniversity-->
		<table>
			<tr>
			<% 
				ResultSet rset = sql.executeQuery("SELECT DISTINCT location FROM universities ORDER BY location");
			
				int i = 0;
	            while (rset.next()) {
	        %>
	        		<% if (i % 3 == 0 && i > 0) { %>
						</tr><tr>
					<% } %>
					<td>
						<a href = "provideDegreesChooseUniversity.jsp?chosenCountryOrState=<%= rset.getString(1) %>"> 
							<%= rset.getString(1) %> 
						</a>
					</td>
	        <% 		
	        		i++;
	           }
	            
	            rset.close();
	            sql.close();
	            db.close();
	        %>
			</tr>
		</table>
	</body>
</html>