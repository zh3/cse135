<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Applications</title>
	</head>
	<body>
	
		<h3> <%= request.getAttribute("applicationsTitle") %></h3>
		
		<table>
		
		<tr>
			<th>Applicant Name</th>
			<th>Average Grade</th>
			<th>Admission Status</th>
			<th>Actions</th>
		</tr>
		
		<%
				// Get the studentsRowSet
			RowSet applicants = (RowSet) request.getAttribute("applicants");
			
				// Iterate over the RowSet
			while (applicants.next()) {
				String applicationStatus = applicants.getString("applicationStatus");
		%>
				<tr>
					<td>
					<div style="text-align:left">
						<%= applicants.getString("firstName") 
							+ " " + applicants.getString("middleName") 
							+ " " + applicants.getString("lastName") %>
					</div>
					</td>
					<td><div style="text-align:center">
						<%= String.format("%.4f", applicants.getDouble("avgGrade")) %>
					</div></td>
					<td><div style="text-align:center">
						<%= applicationStatus %>
					</div></td>
					<td>
						<html:form action="/admitApplicant">
						<html:hidden property="id" value="<%=Integer.toString(applicants.getInt(\"id\")) %>" />
						<html:submit value="Admit" />
						</html:form>
						
						<html:form action="/rejectApplicant">
						<html:hidden property="id" value="<%=Integer.toString(applicants.getInt(\"id\")) %>" />
						<html:submit value="Reject" />
						</html:form>
						
						<html:form action="/cancelDecision">
						<html:hidden property="id" value="<%=Integer.toString(applicants.getInt(\"id\")) %>" />
						<html:submit value="Cancel Decision" />
						</html:form>
					</td>
				</tr>
		<% } %>
		
		</table>
	</body>
</html>