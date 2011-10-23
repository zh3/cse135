<%@page import="com.cse135project.*, java.util.*" %>

<html>
	<head>
		<title>Country Inserts</title>
		<%
			support s = new support();
			String countriesPath = config.getServletContext().getRealPath("txtdata/countries.txt");
			Vector<String> countries = s.getCountries(countriesPath);
		%>
	</head>

	<body>
		<%for (int i = 0; i < countries.size(); i++) { 
			String country = countries.get(i).replace("'", "''");
		%>
			INSERT INTO countries (name) VALUES ('<%= country %>'); <br>
		<% } %>
	</body>
</html>
