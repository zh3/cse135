<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="saveAddress.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Provide Degrees - Choose Location</title>
		<%
			String resStatus = request.getParameter("residencyStatus");
			session.setAttribute("residencyStatus", resStatus);
			support s = new support();
			String universitiesPath = config.getServletContext().getRealPath("txtdata/universities.txt");
			Vector universities = s.getUniversities(universitiesPath);
		
			
			
			// Only save address if there is no residency status information
			// as address has already been saved by another page if this
			// information exists
			if (resStatus == null) {
				saveAddress(session, request);
			}
		%>
	</head>
	<body>
	<h3>Choose Location</h3>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
		
		
		<table>
			<tr>
			<%for (int i = 0; i < universities.size(); i++) {
			    Vector tuple = (Vector)universities.get(i);
                String stateOrUniversity = (String)tuple.get(0);
				if (i % 3 == 0 && i > 0) {
					%>
					</tr><tr>
				<% } %>
				<td><a href = "provideDegreesChooseUniversity.jsp?chosenCountryOrStateId=<%= i %>"> <%= stateOrUniversity %> </a></td>
			<% } %>
			</tr>
		</table>
	</body>
</html>