<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Discipline Analytics</title>
		<!-- connect to the database -->
			<% 
				Connection db = DBConnection.dbConnect();
			int year = Calendar.getInstance().get(Calendar.YEAR);
			%>
	</head>
	<body>
		<h3>Discipline Analytics</h3>
		<!-- Provide an option for the user to add his or her own university. -->
		 
		

		<!-- print out a 3-column table of the discipline name and the number of applicants for
		that discipline -->
		<table>
			<tr>
				<th>Discipline </th>
				<th>Number of Applicants</th>
			</tr>
			<% 
				PreparedStatement sql = db.prepareStatement("SELECT t.ID, t.name, count (DISTINCT s.applicant) FROM disciplines t, degrees s WHERE t.ID = s.discipline AND s.awardYear <= ?  GROUP BY t.ID, t.name");
				sql.setInt(1, year);
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
						<a href = "applications.jsp?chosenDiscipline=<%= rset.getString(1) %>"> 
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
		</table>
	</body>
</html>