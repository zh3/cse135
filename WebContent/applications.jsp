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
			    Integer location;
				Connection db = DBConnection.dbConnect();
				 if(request.getParameter("chosenDiscipline") != null){
					 location = Integer.parseInt(request.getParameter("chosenDiscipline"));
				 }
		   else if(request.getParameter("chosenSpecialization")!= null){
				   location = Integer.parseInt(request.getParameter("chosenSpecialization"));
		   }
		   else {location = -1;
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
				sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName , t.streetAddress, t.city, t.state, t.zipCode, t.countryCode, t.residencyStatus, t.countryOfCitizenship, t.countryOfResidence, t.specialization FROM applicants t, degrees s WHERE t.ID = s.applicant AND s.discipline = ?");
				sql.setInt(1, location);
				ResultSet rset = sql.executeQuery();
			 }
			 else if(request.getParameter("chosenSpecialization")!= null) {
				 sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName, t.streetAddress, t.city, t.state, t.zipCode, t.countryCode, t.residencyStatus, t.countryOfCitizenship, t.countryOfResidence, t.specialization FROM applicants t WHERE t.specialization= ?");
				 sql.setInt(1, location);
				 
			 }
			 else{
				 sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName FROM applicants t");
				 		 
			 }
			 ResultSet rset = sql.executeQuery();
			    
			
				int i = 0;
	            while (rset.next()) {
	        %>
	        		<% if (i % 3 == 0 && i > 0) { %>
						</tr><tr>
					<% } %>
					<td>
						<% 
						if(location == -1){
							%>
							<%= rset.getString(2)+ " " +rset.getString(3)+" "+rset.getString(4)%>
						<% 
						} else {
							%> 
						<%= rset.getString(2)+ " " +rset.getString(3)+" "+rset.getString(4)+ " " +rset.getString(5)+" "+rset.getString(6)+ " " +rset.getString(7)+" "+rset.getString(8)+ " " +rset.getString(9)+" "+rset.getString(10) + " " +rset.getString(11)+" "+rset.getString(12)+ " " +rset.getString(13)%>
						<% 
						}
						%>
						
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