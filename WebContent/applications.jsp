<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Application</title>
		<!-- Get the chosen parameter from either the specialization analytics page
		     or the disciplineAnalytics page.  -->
			<% 
				Connection db = null;
				ResultSet rset = null;
				PreparedStatement sql = null;
			
				try {
			
			    Integer location;
				db = DBConnection.dbConnect();
				if(request.getParameter("chosenDiscipline") != null){
					location = Integer.parseInt(request.getParameter("chosenDiscipline"));
				} else if(request.getParameter("chosenSpecialization")!= null){
					location = Integer.parseInt(request.getParameter("chosenSpecialization"));
		   		} else {
		   			location = -1;
		   		}
		   %>
	</head>
	<body>
		<h3>Applications</h3>

			<% 
			 if(request.getParameter("chosenDiscipline") != null){
				sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName , t.streetAddress, t.city, t.state, t.zipCode, t.countryCode, t.areaCode, t.number, t.residencyStatus, t.countryOfCitizenship, t.countryOfResidence, t.specialization FROM applicants t, degrees s WHERE t.ID = s.applicant AND s.discipline = ?");
				sql.setInt(1, location);
				rset = sql.executeQuery();
			 } else if(request.getParameter("chosenSpecialization")!= null) {
				 sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName, t.streetAddress, t.city, t.state, t.zipCode, t.countryCode, t.areaCode, t.number, t.residencyStatus, t.countryOfCitizenship, t.countryOfResidence, t.specialization FROM applicants t WHERE t.specialization= ?");
				 sql.setInt(1, location);
				 
			 } else{
				 sql = db.prepareStatement("SELECT DISTINCT t.ID, t.firstName, t.middleName, t.lastName FROM applicants t");	 
			 }
			 rset = sql.executeQuery();
			    
			
				int i = 0;
	            while (rset.next()) {
	        %>
						
						<% 
						if(location == -1){
							%>
							<!-- Print the name only -->
							<%= rset.getString(2)+ " " +rset.getString(3)+" "+rset.getString(4)%>
						<% } else { %>
							<div>
							<% 
								String state = rset.getString(7); 
								String residencyStatus = rset.getString(10);
								String countryCode = rset.getString(9);
							%> 
							<b>Name: </b><%= rset.getString(2) + " " + rset.getString(3) + " " + rset.getString(4) %>
							<br><b>Address: </b><br> <%= rset.getString(5) + " " + rset.getString(6) + ((state == null) ? "" : " " + state) + " " + rset.getString(8) %> 
							<br><b>Number: </b> <%= ((countryCode != null) ? "(" + countryCode + ")" : "") + " " +  rset.getString(10) + " " + rset.getString(11) %>
							<% if (residencyStatus != null) { %>
								<br><b>Residency Status:</b> <%=rset.getString(12) %>
							<% } %>
							<%
								Integer cCitizenship = rset.getInt(13);
								Integer cResidence = rset.getInt(14);
								Integer specialization = rset.getInt(15);
								
								String citizenship = null;
								String residence = null;
								String spec = null;
								
								ResultSet nameRes = null;
								PreparedStatement nameQuery = null;
								ResultSet degreeRes = null;
								PreparedStatement degreeQuery = null;
								
								try {
									nameQuery = db.prepareStatement("SELECT name from countries where id = ?");
									nameQuery.setInt(1, cCitizenship);
									nameRes = nameQuery.executeQuery();
									
									if (nameRes.next()) {
										citizenship = nameRes.getString(1);
									}
									
									nameRes = nameQuery.executeQuery();
									nameQuery.setInt(1, cResidence);
									if (nameRes.next()) {
										residence = nameRes.getString(1);
									}
									
									nameQuery = db.prepareStatement("SELECT name from specializations where id = ?");
									nameQuery.setInt(1, specialization);
									nameRes = nameQuery.executeQuery();
									if (nameRes.next()) {
										spec = nameRes.getString(1);
									}
								
							%>
							<br><b>Country of Citizenship: </b> <%= citizenship %>
							<br><b>Country of Residence: </b> <%= residence  %>
							<br><b>Specialization: </b> <%= spec %>
							<br><b>Degrees: </b><br>
							<%
									Integer id = rset.getInt(1);
									degreeQuery = db.prepareStatement("SELECT * FROM degrees WHERE applicant = ?");
									degreeQuery.setInt(1, id);
									degreeRes = degreeQuery.executeQuery();
									
									String degreeString;
									while (degreeRes.next()) { 
										degreeString = "";
										
										nameQuery = db.prepareStatement("SELECT name FROM disciplines WHERE id = ?");
										nameQuery.setInt(1, degreeRes.getInt(7));
										nameRes = nameQuery.executeQuery();
										
										if (nameRes.next()) {
											degreeString = nameRes.getString(1);
										}
										
										nameQuery = db.prepareStatement("SELECT name, location FROM universities WHERE id = ?");
										nameQuery.setInt(1, degreeRes.getInt(6));
										nameRes = nameQuery.executeQuery();
										
										if (nameRes.next()) {
											degreeString += ", " + nameRes.getString(1) + ", " + nameRes.getString(2);
										}
										String gpa = degreeRes.getString(8);
										final int PRECISION = 4;
										if (gpa.length() > PRECISION) {
											gpa = gpa.substring(0, PRECISION);
										}
										//degreeString += " GPA: " + degreeRes.getString(8) + " Awarded: " +degreeRes.getString(3) + "-" + degreeRes.getString(4);
							%>
										<%= degreeString %><b> GPA: </b> <%= gpa %> <b> Awarded: </b> <%= degreeRes.getString(3) + "-" + degreeRes.getString(4) %><br> 
									
							<%		}
								} catch (SQLException e) {
									throw new RuntimeException(e);
								} finally {
									if (nameRes != null) nameRes.close();
									if (nameQuery != null) nameQuery.close();
								}
							%>
							
							</div>
						<% 
						}
						%>
						<br>
	        <% 		
	        		i++;
	           } 
	            
				} catch (SQLException e) {
					throw new RuntimeException(e);
				} finally {
		            if (rset != null) rset.close();
		            if (sql != null) sql.close();
		            if (db != null) db.close();
				}
	        %>
	</body>
</html>