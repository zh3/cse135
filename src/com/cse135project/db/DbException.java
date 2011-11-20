package com.cse135project.db;

/**
 * Implementation of <strong>Exception</strong> that handles all database
 * exceptions thrown by the application.
 * 
 */
public class DbException extends Exception {

	private static final long serialVersionUID = 1L;

	public DbException() {
		super();
	}

	public DbException(String message) {
		super(message);
	}
	
	public DbException(Throwable cause)
	{
		super(cause);
	}
	
	public DbException(String message, Throwable cause)
	{
		super(message, cause);
	}

}
