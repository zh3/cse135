<%@ include file="DBConnect.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Country of Residence</title>
		<%
			Connection db = dbConnect();
	
	        Statement sql = db.createStatement();
			support s = new support();
			String countriesPath = config.getServletContext().getRealPath("txtdata/countries.txt");
			Vector<String> countries = s.getCountries(countriesPath);
		
			Integer countryOfCitizenshipId = Integer.parseInt(request.getParameter("countryOfCitizenshipId"));
			session.setAttribute("countryOfCitizenshipId", countryOfCitizenshipId);
		%>
	</head>
	<body>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
		
		<h3> Select your country of residence </h3> 
		
		<!-- Offer option to make country of residence same as country of citizenship -->
		<a href="address.jsp?countryOfResidenceId=<%= countryOfCitizenshipId %>">
			Same as country of citizenship
		</a>
		
		<br><br>
		
		<!-- 
			Generate table of hyperlinks which invoke country of residence page with selected country's id in
			the database as an id.
		-->
		
		<table>
			<tr>
			<% 
				ResultSet rset = sql.executeQuery("SELECT * FROM countries");
				
				int i = 0;
	            while (rset.next()) {
	        %>
	        		<% if (i % 3 == 0 && i > 0) { %>
						</tr><tr>
					<% } %>
					<td><a href = "address.jsp?countryOfResidenceId=<%= rset.getInt(1) %>"> <%= rset.getString(2) %> </a></td>
	        <% 		
	        		i++;
	           } 
	        %>
			</tr>
		</table>
	</body>
</html>