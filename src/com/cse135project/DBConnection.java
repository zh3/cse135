package com.cse135project;
import java.sql.*;

public class DBConnection {
	public static Connection dbConnect() throws SQLException, ClassNotFoundException {
		Class.forName("org.postgresql.Driver"); //load the driver
	
		return DriverManager.getConnection("jdbc:postgresql:ApplicationSystem",
            							   "cse135", "cl2um43z"); //connect to the db
	}
}
