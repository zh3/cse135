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
			
			// Only save address if there is no residency status information
			// as address has already been saved by another page if this
			// information exists
			if (resStatus == null) {
				saveAddress(session, request);
			}
		%>
	</head>
	<body>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
	</body>
</html>