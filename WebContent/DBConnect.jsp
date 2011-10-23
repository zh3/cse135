<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%!
			Connection dbConnect() throws SQLException, ClassNotFoundException {
				Class.forName("org.postgresql.Driver"); //load the driver
			
				return DriverManager.getConnection("jdbc:postgresql:ApplicationSystem",
                    							   "cse135", "cl2um43z"); //connect to the db
			}
		%>
	</head>
</html>