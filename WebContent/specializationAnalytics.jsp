<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Specialization Analytics</title>
		<!-- Connect to the database -->
			<% 
				Connection db = DBConnection.dbConnect();
				
			%>
	</head>
	<body>
		<h3>Specialization Analytics</h3>
		<!-- Provide an option for the user to add his or her own university. -->
		 
		

		<!--print out a 3-column table of the specialization name followed by the number of applicants for
		that discipline -->
		<table>
			<tr>
				<th>Specialization </th>
				<th>Number of Applicants</th>
			</tr>
			<tr>
			<% 
				PreparedStatement sql = db.prepareStatement("SELECT t.ID, t.name, count (DISTINCT s.ID) FROM specializations t, applicants s WHERE t.ID = s.specialization GROUP BY t.ID, t.name");
				
				ResultSet rset = sql.executeQuery();
			
				int i = 0;
	            while (rset.next()) {
	        %>
		        	<tr>
						<td>
							<%= rset.getString(2)%>
						</td>
						
						<td>
						<div style="text-align:center">
							<a href="showSpecializationApplications.do?chosenSpecialization=<%= rset.getString(1) %>"> 
								<%= rset.getInt(3) %> 
							</a>
						</div>
						</td>
					</tr>
			<%
	        		i++;
	           } 
	            
	            rset.close();
	            sql.close();
	            db.close();
	        %>
			</tr>
		</table>
	</body>
</html>