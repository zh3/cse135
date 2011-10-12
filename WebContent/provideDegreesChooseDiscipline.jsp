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
<h3>Choose Discipline</h3>
<%@ include file="collectedData.jsp" %>



<form name="myform" action= "moreDegrees.jsp?newUniversity =<%=newUniversity %>" method="POST">
<br>
<%for (int i = 0; i < majors.size(); i++) { %>
	 <INPUT TYPE="radio" NAME="radios" VALUE=<%=majors.get(i)%> >
     <%= majors.get(i) %>
    <BR>
    <%} %>
    <br> Don't see your degree? Enter here:  <input type="text" size="10" name="newDegree"/>
    <br> month/year: <input type="text" size="10" name="month/year"/>
    <br> GPA/expectedGPA:<input type="text" size="5" name="GPA/expectedGPA"/>
    <br> select degree: <select name="degree">
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