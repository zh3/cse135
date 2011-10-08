<%@page import="com.cse135project.*, java.util.*" %>

<html>
	<head>
		<title>Country of Citizenship</title>
		<%
			support s = new support();
			String countriesPath = config.getServletContext().getRealPath("txtdata/countries.txt");
			Vector<String> countries = s.getCountries(countriesPath);
		
			session.setAttribute("firstName", request.getParameter("firstName"));
			session.setAttribute("middleInitial", request.getParameter("middleInitial"));
			session.setAttribute("lastName", request.getParameter("lastName"));
		%>
	</head>

	<body>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
		
		<h3> Select your country of citizenship </h3>
		
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
				<td><a href = "countryOfResidence.jsp?countryOfCitizenshipId=<%= i %>"> <%= countries.get(i) %> </a></td>
			<% } %>
			</tr>
		</table>
	</body>
</html>
