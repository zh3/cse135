<%@page import="com.cse135project.*, java.util.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Choose Discipline</title>
			<%
			support s = new support();
			String majorsPath = config.getServletContext().getRealPath("txtdata/majors.txt");
			Vector majors = s.getMajors(majorsPath);
			
			String newUniversity = request.getParameter("newUniversity");
			 
			Integer chosenUniversityId = Integer.parseInt(request.getParameter("chosenUniversityId"));
			
			session.setAttribute("chosenUniversityId", chosenUniversityId);
			
			 
		
			%>
</head>
<body>
<h3>Provide Degrees - Choose Discipline</h3>



<form name="myform" action= "moreDegrees.jsp" method="GET">
	<input type="hidden" name="newUniversity" value="<%=newUniversity %>"/>
<%for (int i = 0; i < majors.size(); i++) { %>
	 <INPUT TYPE="radio" NAME="radios" VALUE="<%=majors.get(i)%>" >
     <%= majors.get(i) %>
    <BR>
    <%} %>
    <br> Don't see your degree? Enter here:  <input type="text" size="10" name="newDegree"/>
    <br> Date of Award (mm-yyyy):  <input type="text" size="10" name="month/year"/>
    <br> GPA / Expected GPA:  <input type="text" size="5" name="GPA/expectedGPA"/>
    <br> Title of Degree: <select name="degree">
		<option value = "BS">BS
		<option value = "MS">MS
		<option value = "PhD">PhD 
    </select> 
    <br>
  
    <br>
    <br>
    <input type= "submit" value="Submit"/>
      </form>
    
   
</body>
</html>