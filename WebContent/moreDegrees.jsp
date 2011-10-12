<%@page import="com.cse135project.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>More Degrees</title>
	<% 
		int i = 0; //iterator for setting attributes
		int j = 0; //iterator for printing attributes
		String chosenUniversity; //the chosen university
		String submittedDegree; //the submitted degree
		Integer chosenCountryOrStateId; 
		Integer chosenUniversityId;
		String chosenDegree;
		chosenCountryOrStateId = (Integer)session.getAttribute("chosenCountryOrStateId");
		chosenUniversityId = (Integer)session.getAttribute("chosenUniversityId");
           //create a new country or state.
		support s = new support();
		String universitiesPath = config.getServletContext().getRealPath("txtdata/universities.txt");
		Vector universities = s.getUniversities(universitiesPath);
		Vector tuple = (Vector)universities.get(chosenCountryOrStateId);
		String countryOrState = (String)tuple.get(0);
           
		Vector<String> universityList = (Vector<String>)tuple.get(1);
		if (universityList.size() == chosenUniversityId) {
			chosenUniversity = request.getParameter("newUniversity");
		} else {
			chosenUniversity = (String)universityList.get(chosenUniversityId);
		}
		
		//Loop through existing submittedDegree attributes and check if the are not null
		//If an empty submittedDegree attribute is found then set attribute submittedDegree(i)
		while(session.getAttribute("submittedDegree"+ Integer.toString(i)) != null) {
			i++;
		}
			 
		if (request.getParameter("newDegree") == "") {
			chosenDegree= request.getParameter("degree"); //If parameter is old degree
		} else {
			chosenDegree=request.getParameter("newDegree"); // if the user set his own degree
		}
		
		submittedDegree = countryOrState+" "+chosenUniversity+" "+" "+ chosenDegree+" "+request.getParameter("radios")+" "+request.getParameter("month/year")+" "+"GPA/expectedGPA: "+request.getParameter("GPA/expectedGPA");
		session.setAttribute("submittedDegree"+ Integer.toString(i), submittedDegree);
	%>
</head>
<body>
    <!-- Loop through all the submitted degree attributes, printing them out. -->
	<%
		while(session.getAttribute("submittedDegree"+ Integer.toString(j)) != null)
		{
			out.println( (String)session.getAttribute("submittedDegree"+ Integer.toString(j)));
			j++;
	%>
		 <br>
	<%  } 	%>
	
	<form action="provideDegreesChooseLocation.jsp">
		<input type= "submit" value="Submit Next Degree"/>
	</form>
	
	<form action="specialization.jsp">
		<input type= "submit" value="Done"/>
	</form>
</body>
</html>