<%@ page import="javax.sql.*"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Suggest Reviewer</title>
	<%
		Integer numReviews = (Integer) request.getAttribute("numReviews");
		Integer applicantId = (Integer) request.getAttribute("applicantId");
		RowSet unassociatedReviewers 
			= (RowSet) request.getAttribute("unassociatedReviewers");
	%>
</head>
<body>
	<h3>Not Enough Reviews: <%= numReviews %> / 3</h3>
	
	<html:form action="/addReviewerToApplicant">
		<html:hidden property="applicantId" value="<%= Integer.toString(applicantId) %>"/>
		<html:select property="reviewerId">
			<html:option value="-1">-- None --</html:option>
		<% 
			while (unassociatedReviewers.next()) { 
				String username = unassociatedReviewers.getString("username");
				int id = unassociatedReviewers.getInt("id");
		%>
				<html:option value="<%= Integer.toString(id) %>"><%= username %></html:option>
		<% } %>
		</html:select>
		<html:submit value="Submit"/>
	</html:form>
</body>
</html>