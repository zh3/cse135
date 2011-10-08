<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Country of Residence</title>
		<%
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
			Generate table of hyperlinks which invoke country of residence page with selected country's index in
			the vector as an id.
		-->
		<table>
			<tr>
			<%for (int i = 0; i < countries.size(); i++) { %>
				<% if (i % 3 == 0 && i > 0) { %>
					</tr><tr>
				<% } %>
				<td><a href = "address.jsp?countryOfResidenceId=<%= i %>"> <%= countries.get(i) %> </a></td>
			<% } %>
			</tr>
		</table>
	</body>
</html>