<%@page import="com.cse135project.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>More Degrees</title>
	<% 
		int i = 0; // iterator for setting attributes
		String chosenUniversity; // the chosen university
		String submittedDegree; // the submitted degree all in one string
		String submittedDegreeLocation; // the submitted degree location
		String submittedDegreeUniversity; // university of the submitted degree
		String submittedDegreeName; // name of the submitted degree
		String submittedDegreeTitle; // title of the submitted degree
		String submittedDegreeMonth; // month degree was awarded
		String submittedDegreeYear; // year degree was awarded
		String submittedDegreeGpa; // GPA achieved in degree
		Degree degree; // Current degree to be created with existing information
		Vector<Degree> degreeVector;
		
		Integer chosenCountryOrStateId;
		Integer chosenUniversityId;
		String chosenDegree;
		
		// Create Degree Vector if it doesn't exist already
		if (session.getAttribute("degreeVector") == null) {
			session.setAttribute("degreeVector", new Vector<Degree>());
		}
		
		// Get degree vector
		degreeVector = (Vector<Degree>) session.getAttribute("degreeVector");
		
		
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
			chosenDegree = request.getParameter("radios"); //If parameter is existing degree
		} else {
			chosenDegree = request.getParameter("newDegree"); // if the user set his own degree
		}
		
		
		submittedDegreeLocation = countryOrState;
		submittedDegreeUniversity = chosenUniversity;
		submittedDegreeName = chosenDegree;
		submittedDegreeTitle = request.getParameter("degree");
		submittedDegreeMonth = request.getParameter("month");
		submittedDegreeYear = request.getParameter("year");
		submittedDegreeGpa = request.getParameter("gpa");

		degree = new Degree(submittedDegreeLocation, submittedDegreeUniversity, submittedDegreeName, submittedDegreeTitle,
							submittedDegreeMonth, submittedDegreeYear, submittedDegreeGpa);
		degreeVector.add(degree);
	%>
</head>
<body>
    <%@ include file="printDegrees.jsp" %>
	
	<button onclick="window.location='provideDegreesChooseLocation.jsp'">
		Submit Next Degree
	</button>
	<button onclick="window.location='specialization.jsp'">
		Done
	</button>
</body>
</html>