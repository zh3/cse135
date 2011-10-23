<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>

<html>
	<head>
		<title>Country of Citizenship</title>
		<%
			Connection db = DBConnection.dbConnect();

            Statement sql = db.createStatement();
		
			session.setAttribute("firstName", request.getParameter("firstName"));
			session.setAttribute("middleInitial", request.getParameter("middleInitial"));
			session.setAttribute("lastName", request.getParameter("lastName"));
		%>
	</head>

	<body>
		<!-- Display all previously collected data -->
		<%@ include file="collectedData.jsp" %>
		
		<h3> Select your country of citizenship </h3>
		
		<!-- 
			Generate table of hyperlinks which invoke country of residence page with selected country's id in
			the database as an identifier.
		-->
		<table>
			<tr>
			<% 
				ResultSet rset = sql.executeQuery("SELECT * FROM countries");
				
				int i = 0;
	            while (rset.next()) {
	        %>
	        		<% if (i % 3 == 0 && i > 0) { %>
						</tr><tr>
					<% } %>
					<td><a href = "countryOfResidence.jsp?countryOfCitizenshipId=<%= rset.getInt(1) %>"> <%= rset.getString(2) %> </a></td>
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
