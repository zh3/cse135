<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Application Review</title>
		<%
			RowSet applicant = (RowSet) request.getAttribute("applicant");
			RowSet degrees = (RowSet) request.getAttribute("degrees");
			RowSet reviews = (RowSet) request.getAttribute("reviews");
		%>
	</head>
	<body>
		<h3>Application Review</h3>
		
		<% if (applicant.next()) { %>
			<p> <b>Name </b> 
				<%= applicant.getString("firstName") + " " 
						+ applicant.getString("middleName") + " " 
						+ applicant.getString("lastName") %> 
			</p>
			
			<p> <b>Country of Citizenship </b> <%= applicant.getString("countryOfCitizenship") %> </p>
			
			<p> <b>Country of Residence </b> <%= applicant.getString("countryOfResidence") %> </p>
			
			<p> <b>Street Address </b> <%= applicant.getString("streetAddress") %> </p>
			
			<p> <b>City </b> <%= applicant.getString("city") %> </p>
			
			<p> <b>State </b> <%= applicant.getString("state") %> </p>
			
			<p> <b>Zip Code </b> <%= applicant.getString("zipCode") %> </p>
			
			<p> <b>Country Call Code </b> <%= applicant.getString("countryCode") %> </p>
			
			<p> <b>Area Code </b> <%= applicant.getString("areaCode") %> </p>
			
			<p> <b>Phone Number </b> <%= applicant.getString("number") %> </p>
			
			<% if (applicant.getString("residencyStatus") != null) { %>
			<p> <b>Residency Status </b> 
				<%= applicant.getString("residencyStatus") %> </p>
			<% } %>
			
			<p> <b>Specialization </b> <%= applicant.getString("specialization") %> </p>
		<% } %>
		
		<h3>Applicant Degrees</h3>
		
		<% while (degrees.next()) { %>
			<div> 
				<b> Degree</b> <%= degrees.getString("discipline") %>
				<br/> <b>University</b> <%= degrees.getString("university") %>
				<br/> <b>Location</b> <%= degrees.getString("location") %>
				<br/> <b>Degree Award Date</b>  
					<%= degrees.getString("awardMonth")+ "-" + degrees.getString("awardYear") %>
				<br/> <b>Degree Title</b>  <%= degrees.getString("title") %>
				<br/> <b>GPA / Expected GPA</b> <%= degrees.getString("gpa") %>
			</div>
			<br/>
		<% } %>

		<% 
			boolean firstIteration = true;
			while (reviews.next()) { 
		%>
				<% 
					if (firstIteration) { 
						firstIteration = false;
				%>
						<h3>Applicant Reviews</h3>
				<% 	} %>
		
			<div> 
				<b>Reviewer </b> <%= reviews.getString("username") %>
				<br/> <b>Grade</b> <%= reviews.getString("grade") %>
				<br/> <b>Comment</b> 
				<br/><%= reviews.getString("comment") %>
			</div>
			<br/>
		<% } %>
	</body>
</html>