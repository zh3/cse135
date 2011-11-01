package com.cse135project;
import java.sql.*;

import javax.naming.*;
import javax.sql.*;

public class DBConnection {
	public static Connection dbConnect() throws SQLException, ClassNotFoundException, NamingException {
		//Class.forName("org.postgresql.Driver"); //load the driver
	
		//return DriverManager.getConnection("jdbc:postgresql://localhost/ApplicationSystem",
        //    							   "cse135", "cl2um43z"); //connect to the db
		
		Context initCtx = new InitialContext();
		DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/ApplicationSystemPool");
		return ds.getConnection();
	}
	
	public static Connection dbConnectUsers() throws SQLException, ClassNotFoundException, NamingException {
		//Class.forName("org.postgresql.Driver"); //load the driver
	
		//return DriverManager.getConnection("jdbc:postgresql://localhost/ApplicationSystem",
        //    							   "cse135", "cl2um43z"); //connect to the db
		
		Context initCtx = new InitialContext();
		DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/UsersPool");
		return ds.getConnection();
	}
}
