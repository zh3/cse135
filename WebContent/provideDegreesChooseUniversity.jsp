<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
		<script type="text/javascript">
			function enableSubmit() {
				document.getElementById("submit").disabled = false;
			}
			
			function disableSubmit() {
				document.getElementById("submit").disabled = true;
			}
			
			function showAlreadyExistsMessage() {
				document.getElementById("alreadyExistsMessage").style.display = 'inline';
			}
			
			function hideAlreadyExistsMessage() {
				document.getElementById("alreadyExistsMessage").style.display = 'none';
			}
			
			
		
			function validateUniversity() {
				var universityName = document.getElementsByName("newUniversity")[0].value;
				
				var xmlHttp = new XMLHttpRequest();
				var url = "universityExists.do?universityName=" + universityName;
				xmlHttp.onreadystatechange = function() {
					if (xmlHttp.readyState==4) {
						var xmlDoc = xmlHttp.responseXML.documentElement;
						
						var inputValid = true;
						if (xmlDoc.getElementsByTagName("exists")[0].childNodes[0].nodeValue
								== 'true') {
							showAlreadyExistsMessage();
							inputValid = false;
						} else {
							hideAlreadyExistsMessage();

						}
						
						if (universityName == "") {
							inputValid = false;
						}
						
						if (inputValid) {
							enableSubmit();
						} else {
							disableSubmit();
						}
					}
				}
				
				xmlHttp.open("GET", url, true);
				xmlHttp.send(null);
			}
		</script>
		
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
			Don't see your university? Enter here:  
			<input id="newUniversity" type="text" size="10" name="newUniversity" onkeyup="validateUniversity();"/>
			<input type="hidden" name="newUniversityLocation" value="<%=location %>"/>
			<input id="submit" type= "submit" value="Submit" disabled="disabled"/>
		</form>
		
		<div id="alreadyExistsMessage" style="display:none;color:red">
			The entered university already exists
		</div>

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