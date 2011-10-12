<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Choose University</title>
			<% 
			
			Integer chosenCountryOrStateId = Integer.parseInt(request.getParameter("chosenCountryOrStateId"));
			session.setAttribute("chosenCountryOrStateId", chosenCountryOrStateId);
			support s = new support();
			String universitiesPath = config.getServletContext().getRealPath("txtdata/universities.txt");
			Vector universities = s.getUniversities(universitiesPath);
			 Vector tuple = (Vector)universities.get(chosenCountryOrStateId);
			 Vector universityList = (Vector)tuple.get(1);
			
			%>
</head>
<body>
<h3>Choose University</h3>

<%@ include file="collectedData.jsp" %>
<form name="myform3" action= "provideDegreesChooseDiscipline.jsp?chosenUniversityId=<%= universityList.size() %>" method="POST">
<br> Don't see your university? Enter here:  <input type="text" size="10" name="newUniversity"/>
  <input type= "submit" value="Submit"/>

</form>
               <table>
			<tr>
			<%for (int i = 0; i < universityList.size(); i++) {
			   
				if (i % 3 == 0 && i > 0) {
					%>
					</tr><tr>
				<% } %>
				<td><a href = "provideDegreesChooseDiscipline.jsp?chosenUniversityId=<%= i %>"> <%= (String)universityList.get(i) %> </a></td>
			<% } %>
			</tr>
		</table>
		
	</body>
</body>
</html>