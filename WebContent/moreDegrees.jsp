<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>More Degrees</title>
	<% 
		int i = 0; // iterator for setting attributes
		
		String submittedDegree; // the submitted degree all in one string
		Integer submittedDegreeUniversityId; // university of the submitted degree
		Integer submittedDegreeDisciplineId = 0; // name of the submitted degree
		String submittedDegreeTitle; // title of the submitted degree
		String submittedDegreeMonth; // month degree was awarded
		String submittedDegreeYear; // year degree was awarded
		Float submittedDegreeGpa; // GPA achieved in degree
		Degree degree; // Current degree to be created with existing information
		Vector<Degree> degreeVector;
		
		Integer chosenCountryOrStateId;
		
		Connection db = DBConnection.dbConnect();
		
		// Create Degree Vector if it doesn't exist already
		if (session.getAttribute("degreeVector") == null) {
			session.setAttribute("degreeVector", new Vector<Degree>());
		}
		
		// Get degree vector
		degreeVector = (Vector<Degree>) session.getAttribute("degreeVector");
		
		submittedDegreeUniversityId = (Integer)session.getAttribute("chosenUniversityId");

		if (submittedDegreeUniversityId < 0) {
			String chosenUniversityLocation = request.getParameter("newUniversityLocation");
			String chosenUniversityName = request.getParameter("newUniversity");
			
			// Insert new university into table
			PreparedStatement pstmt 
				= db.prepareStatement("INSERT INTO universities (location, name) VALUES (?, ?)");
			pstmt.setString(1, chosenUniversityLocation);
			pstmt.setString(2, chosenUniversityName);
			pstmt.executeUpdate();
			pstmt.close();
			
			// Get the ID of the new entry
			pstmt = db.prepareStatement("SELECT id FROM universities WHERE location = ? AND name = ?");
			pstmt.setString(1, chosenUniversityLocation);
			pstmt.setString(2, chosenUniversityName);
			ResultSet rset = pstmt.executeQuery();
			
			if (rset.next()) {
				submittedDegreeUniversityId = rset.getInt(1);
			}
			
			rset.close();
			pstmt.close();
		}
			 
		if (request.getParameter("newDegree") == "") {
			//If parameter is existing degree
			submittedDegreeDisciplineId = Integer.parseInt(request.getParameter("disciplineId")); 
		} else {
			String newDiscipline = request.getParameter("newDegree"); // if the user set his own degree
			// Add new discipline
			PreparedStatement pstmt = db.prepareStatement("INSERT INTO disciplines (name) VALUES (?)");
			pstmt.setString(1, newDiscipline);
			pstmt.executeUpdate();
			
			// Get the new discipline's ID
			pstmt = db.prepareStatement("SELECT id FROM disciplines WHERE name = (?)");
			pstmt.setString(1, newDiscipline);
			
			ResultSet rset = pstmt.executeQuery();
			
			if (rset.next()) {
				submittedDegreeDisciplineId = rset.getInt(1);
			}
			
			pstmt.close();
			rset.close();
		}
		
		submittedDegreeTitle = request.getParameter("degree");
		submittedDegreeMonth = request.getParameter("month");
		submittedDegreeYear = request.getParameter("year");
		submittedDegreeGpa = Float.parseFloat(request.getParameter("gpa"));

		degree = new Degree(submittedDegreeUniversityId, submittedDegreeDisciplineId, submittedDegreeTitle,
							submittedDegreeMonth, submittedDegreeYear, submittedDegreeGpa);
		degreeVector.add(degree);
		
		db.close();
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