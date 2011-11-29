<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<script type="text/javascript">
			var previousClickedButton;
		
			function loadApplication(id, button) {
				if (previousClickedButton == button) {
					button.innerHTML = "Show Application";
					document.getElementById("showApplicationArea").innerHTML = "";
					
					previousClickedButton = undefined;
				} else {
					button.innerHTML = "Hide Application";
					var xmlHttp = new XMLHttpRequest();
					var url = "showCompleteApplication.do?applicantId=" + id;
					xmlHttp.onreadystatechange = function() {
						if (xmlHttp.readyState==4) {
							document.getElementById("showApplicationArea").innerHTML = xmlHttp.responseText;
						}
					};
					
					if (previousClickedButton != undefined) {
						previousClickedButton.innerHTML = "Show Application";
					}
					
					previousClickedButton = button;
					xmlHttp.open("GET", url, true);
					xmlHttp.send(null);
				}
			}
		</script>
		
		<title>Applications</title>
		<%!
			private String getStyle(String buttonDisabledState, String applicationStatus) {
				return (buttonDisabledState.equals(applicationStatus)
						? "display:none"
						: "display:inline");
			}
		%>
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
				double avgGrade = applicants.getDouble("avgGrade");
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
						<%= ((avgGrade > 0) ? String.format("%.4f", avgGrade) : "N/A") %>
					</div></td>
					<td><div style="text-align:center">
						<%= applicationStatus %>
					</div></td>
					<td>
						<html:form action="/admitApplicant" style="<%=getStyle(\"Accepted\", applicationStatus)%>">
						<html:hidden property="id" value="<%=Integer.toString(applicants.getInt(\"id\")) %>" />
						<html:submit value="Admit" />
						</html:form>
						
						<html:form action="/rejectApplicant" style="<%=getStyle(\"Rejected\", applicationStatus)%>">
						<html:hidden property="id" value="<%=Integer.toString(applicants.getInt(\"id\")) %>" />
						<html:submit value="Reject" />
						</html:form>
						
						<html:form action="/cancelDecision" style="<%=getStyle(\"Pending\", applicationStatus)%>">
						<html:hidden property="id" value="<%=Integer.toString(applicants.getInt(\"id\")) %>" />
						<html:submit value="Cancel Decision" />
						</html:form>
						
						<button type="button" onclick="loadApplication(<%=Integer.toString(applicants.getInt("id")) %>, this)">
							Show Application
						</button>
					</td>
				</tr>
		<% } %>
		</table>
		
		<div id="showApplicationArea">
		</div>
		
		<h4>Navigation</h4>
		<%@ include file="reviewHub.jsp" %>
	</body>
</html>