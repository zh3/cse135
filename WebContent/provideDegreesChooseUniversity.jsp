<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Provide Degrees - Choose University</title>
		<!-- Set the attribute for chosen Country or State id and
		   Get the university list for that chosen country or state  -->
			<% 
				Connection db = DBConnection.dbConnect();
				String location = request.getParameter("chosenCountryOrState");
			%>
	</head>
	<body>
		<h3>Provide Degrees - Choose University</h3>
		<!-- Provide an option for the user to add his or her own university. -->
		 
		<form action= "provideDegreesChooseDiscipline.jsp?chosenUniversityId=<%= -1/*universityList.size()*/ %>" method="POST">
			Don't see your university? Enter here:  <input type="text" size="10" name="newUniversity"/>
			<input type="hidden" name="newUniversityLocation" value="<%=location %>"/>
			<input type= "submit" value="Submit"/>
		</form>

		<!-- print out a 3-column table of all the universities for that chosen country or state -->
		<table>
			<tr>
			<% 
				PreparedStatement sql = db.prepareStatement("SELECT id, name FROM universities where location = ?");
				sql.setString(1, location);
				ResultSet rset = sql.executeQuery();
			
				int i = 0;
	            while (rset.next()) {
	        %>
	        		<% if (i % 3 == 0 && i > 0) { %>
						</tr><tr>
					<% } %>
					<td>
						<a href = "provideDegreesChooseDiscipline.jsp?chosenUniversityId=<%= rset.getInt(1) %>"> 
							<%= rset.getString(2) %> 
						</a>
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