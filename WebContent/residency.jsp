<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="saveAddress.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Residency</title>
		<%
			saveAddress(session, request);
		%>
	</head>
	<body>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
		
		<h3>Residency Status</h3>
		<form action="provideDegreesChooseLocation.jsp">
			US Permanent Resident <input type="radio" name="residencyStatus" value="US Permanent Resident"/>
			<br> Non-Resident <input type="radio" name="residencyStatus" value="Non-Resident"/>
			<br><input type="submit" value="Submit"/>
		</form>
	</body>
</html>