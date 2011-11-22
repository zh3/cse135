<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Applications by Reviewer</title>
	</head>
	<body>
		<h3>Applications By Reviewer</h3>
		
		<table>
			<tr>
				<th>Reviewer</th>
				<th>Graded Applications</th>
				<th>Ungraded Applications</th>
			</tr>
			<%
				// Get the studentsRowSet
				RowSet applicantsByReviewer = (RowSet) request.getAttribute("applicantsByReviewer");
			
				// Iterate over the RowSet
				while (applicantsByReviewer.next()) {
					String username = applicantsByReviewer.getString("username");
			%>
				<tr>
					<td><%=username%></td>
					<td>
						<div style="text-align:center">
							<a href="showGradedApplications.do?username=<%=username%>">
								<%=applicantsByReviewer.getString("numGraded")%>
							</a>
						</div>
					</td>
					<td>
						<div style="text-align:center">
							<a href="showUngradedApplications.do?username=<%=username%>">
								<%=applicantsByReviewer.getString("numUngraded")%>
							</a>
						</div>
					</td>
				</tr>
			<%  } %>
		
		</table>
	</body>
</html>