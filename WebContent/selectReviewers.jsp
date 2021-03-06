<%@ page import="javax.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Application Review</title>
		<%
		RowSet reviewers = null;
		if(request.getAttribute("crsReviewers") != null){
			reviewers = (RowSet) request.getAttribute("crsReviewers");
		} 

		%>
	</head>
	<body>
		<!-- in case validation of the entry data fails in the data bean -->
		<html:errors />
		
		<h3>Add Reviewers</h3>
		<html:form action= "/addReviewer">
			<td>username: <html:text property = "username" size = "20" /></td>
			<td>password: <html:password property = "password" size = "20" /></td>
			<td><html:submit value= "Add" /></td>
			<td><html:reset /></td>
		</html:form>
		
		<h3>Current Reviewers</h3>
		<table>
		<%  int i = 0;
			while(reviewers!=null && reviewers.next()){ %>
			   <tr>
			   <html:form action= "/deleteReviewer">
			   <td>
			   <html:text property = "username" size = "15" readonly="true"
			   	    value="<%=reviewers.getString(\"username\") %>" />
			   	</td>
			   	
			   	<td><html:submit value= "Delete" /></td>
			   	</html:form>
			   	</tr>
		<% i++; } 
			
		%>
		   </table>
		<h3>Start Review Process</h3>
		<html:form action = "/startReviewProcess" >
		   Total Reviewers: <html:text property="selectedReviewers" size="3" value="<%= Integer.toString(i)%>" 
		   			  readonly="true"/>
		   <td><html:submit value= "Start" /></td>
		</html:form>
		
	</body>
</html>