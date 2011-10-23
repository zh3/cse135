<%@page import="com.cse135project.*, java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Generate Universities</title>
		<%
			support s = new support();
			String universitiesPath = config.getServletContext().getRealPath("txtdata/universities.txt");
			Vector universities = s.getUniversities(universitiesPath);
			//Vector tuple = (Vector)universities.get(chosenCountryOrStateId);
			//Vector universityList = (Vector)tuple.get(1);
		%>
	</head>
	<body>
		<% 
			for (int i = 0; i < universities.size(); i++) {
				Vector tuple = (Vector) universities.get(i);
				String location = (String) tuple.get(0);
				Vector universityList = (Vector) tuple.get(1);
				
				for (int j = 0; j < universityList.size(); j++) {
					String universityName = (String) universityList.get(j);
					universityName = universityName.replace("'", "''");
		%>
					<br> INSERT INTO universities (location, name) VALUES ('<%= location %>', '<%= universityName %>');
		<%	
				}
			}
		%>
	</body>
</html>