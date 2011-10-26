<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Specialization Analytics</title>
		<!-- Get the chosen parameter from either the specialization analytics page
		     or the disciplineAnalytics page.  -->
			<% 
			    String location;
				Connection db = DBConnection.dbConnect();
				 if(request.getParameter("chosenDiscipline") != null){
					 location = request.getParameter("chosenDiscipline");
				 }
		   else{
				   location = request.getParameter("chosenSpecialization");
		   }
			%>
	</head>
	<body>
		<h3>Applications</h3>
	
		 
		

		<!-- print out a 3-column table of all the names of the applicants who have the previously
		    clicked on attribute (whether it be specialization or discipline)-->
		<table>
			<tr>
			<% 
			PreparedStatement sql;
			 if(request.getParameter("chosenDiscipline") != null){
				sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName FROM applicants t, degrees s WHERE t.ID = s.applicant AND s.discipline = ?");
			 }
			 else{
				 sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName FROM applicants t WHERE t.specialization= ?");
			 }
			    sql.setString(1, location);
				ResultSet rset = sql.executeQuery();
			
				int i = 0;
	            while (rset.next()) {
	        %>
	        		<% if (i % 3 == 0 && i > 0) { %>
						</tr><tr>
					<% } %>
					<td>
						<%= rset.getString(2)+rset.getString(3)+rset.getString(4) %>
					</td>
					
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