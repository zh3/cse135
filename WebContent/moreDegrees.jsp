<%@page import="com.cse135project.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>More Degrees</title>
		<% 
           int i = 0;
		   int j = 0;
		   String chosenUniversity;
		   String submittedDegree;
           Integer chosenCountryOrStateId;
           Integer chosenUniversityId;
           String chosenDegree;
           chosenCountryOrStateId = (Integer)session.getAttribute("chosenCountryOrStateId");
           chosenUniversityId = (Integer)session.getAttribute("chosenUniversityId");
           
          
           
           support s = new support();
			String universitiesPath = config.getServletContext().getRealPath("txtdata/universities.txt");
			Vector universities = s.getUniversities(universitiesPath);
           Vector tuple = (Vector)universities.get(chosenCountryOrStateId);
           String countryOrState = (String)tuple.get(0);
           
			 Vector<String> universityList = (Vector<String>)tuple.get(1);
			 out.println("size is: " + universityList.size());
			 out.println("id is: " + chosenUniversityId);
			 if(universityList.size() == chosenUniversityId){
				out.println("in if statement");
				 chosenUniversity = request.getParameter("newUniversity");
			 }
			 else{
			chosenUniversity = (String)universityList.get(chosenUniversityId);
			 }
			 while(session.getAttribute("submittedDegree"+ Integer.toString(i)) != null)
			 {
				 i++;
			 }
			 
			if(request.getParameter("newDegree") == ""){
				chosenDegree= request.getParameter("degree");
			}
			else{
					chosenDegree=request.getParameter("newDegree");
				}
			submittedDegree = countryOrState+" "+chosenUniversity+" "+" "+ chosenDegree+" "+request.getParameter("radios")+" "+request.getParameter("month/year")+" "+"GPA/expectedGPA: "+request.getParameter("GPA/expectedGPA");
			session.setAttribute("submittedDegree"+ Integer.toString(i), submittedDegree);
		%>
</head>
<body>
<%
while(session.getAttribute("submittedDegree"+ Integer.toString(j)) != null)
{
	out.println( (String)session.getAttribute("submittedDegree"+ Integer.toString(j)));
	 j++;
	 %>
	 <br>
<% }%>
<form name="myform2" action= "provideDegreesChooseLocation.jsp" method="POST">
<input type= "submit" value="Submit Next Degree"/>
</form>
</body>
</html>