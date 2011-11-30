package com.cse135project.Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.sql.rowset.CachedRowSet;
import javax.xml.bind.DataBindingException;

import com.cse135project.DBConnection;
import com.cse135project.db.DbException;
import com.sun.rowset.CachedRowSetImpl;
import com.cse135project.forms.ReviewerFormSubmit;

public class ReviewerModel{
	private static final String addReviewerString=
	"INSERT INTO userRoles (username, role) VALUES( ?, 'reviewer')";
	private static final String addReviewerString1 =
			"INSERT INTO users (username, password) " +
			"VALUES (?, md5(?));";
	private static final String deleteReviewerString =
	        "DELETE " +
	        "FROM userRoles " +
	        "WHERE username = ?";
	private static final String deleteReviewerString1 =
			"DELETE " +
			"FROM users " +
			"WHERE username = ?";
	private static final String getReviewersString =
			"SELECT * FROM users s " +
			"WHERE s.username IN " +
			"(SELECT userName " +
			"FROM userRoles " +
			"WHERE role = 'reviewer')";
	private static final String roundRobin =
			"SELECT count(*) " +
			"FROM applicants";
	private static final String roundRobin1 =
			"SELECT count(*) " +
			"FROM userRoles " +
			"WHERE role = 'reviewer'";
	private static final String roundRobin2 =
			"CREATE TABLE tmp " +
			"SELECT * " +
			"FROM userRoles " +
			"WHERE role = 'reviewer'";
	private static final String roundRobin3 =
			"INSERT INTO workload (reviewer, applicant) " +
			"SELECT t.userRoleID, s.ID " +
			"FROM tmp t, applicants s  " +
			"WHERE t.ID = ? AND s.ID " +
			"BETWEEN ? AND ?";

	private static final String roundRobin4 = 
			"DROP TABLE tmp";
	
	private static final String getUnassignedApplicantsString =
			"SELECT * FROM applicants "
			+ "WHERE id NOT IN (SELECT applicant FROM reviews) "
			+ "AND id NOT IN (SELECT applicant FROM workload);";
	
	private static final String assignApplicantString = 
			"INSERT INTO workload (reviewer, applicant) VALUES (?, ?)";
	
	private static final String isInDb = 
			"SELECT count(*) FROM userRoles WHERE username = ?";
	
	public static CachedRowSet getReviewers() throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(getReviewersString);
			
			
			ResultSet reviewers = pstmt.executeQuery();
			CachedRowSet crsReviewers = new CachedRowSetImpl();
			crsReviewers.populate(reviewers);
			
			reviewers.close();
			pstmt.close();
			conn.close();
			
			return crsReviewers;
		} catch (SQLException e) {
			throw new DbException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	/*is in database*/
	public static boolean isInDatabase(String username) throws DbException {
		try{
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(isInDb);
			pstmt.setString(1, username);
			ResultSet rst = pstmt.executeQuery();
			rst.next();
			int inDB = rst.getInt(1);
			if(inDB == 0){
				return false;
			}
			else{
				return true;
			}
			
			
		} catch (SQLException e) {
			throw new DbException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	/*add reviewer*/
	public static void addReviewer(ReviewerFormSubmit reviewer) throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(addReviewerString);
			pstmt.setString(1, reviewer.getUsername());
			pstmt.execute();
			pstmt.close();
			
			PreparedStatement pstmt1 = conn.prepareStatement(addReviewerString1);
			pstmt1.setString(1, reviewer.getUsername());
			pstmt1.setString(2, reviewer.getPassword());
			pstmt1.execute();
			
			pstmt1.close();
			conn.close();
			
		
		} catch (SQLException e) {
			throw new DbException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	

	/*delete reviewer*/
	public static void deleteReviewer(ReviewerFormSubmit reviewer) throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(deleteReviewerString);
			pstmt.setString(1, reviewer.getUsername());
			pstmt.execute();
			
			PreparedStatement pstmt1 = conn.prepareStatement(deleteReviewerString1);
			pstmt1.setString(1, reviewer.getUsername());
			pstmt1.execute();
		
			pstmt.close();
			conn.close();
			
		
		} catch (SQLException e) {
			throw new DbException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static void assignWorkload() throws DbException{
		try {
			Connection conn = DBConnection.dbConnect();
			
			/* Get all applicants not assigned to reviewer */
			PreparedStatement pstmt = conn.prepareStatement(getUnassignedApplicantsString);
			ResultSet unassignedApplicants = pstmt.executeQuery();
			
			/* Get all reviewers */
			CachedRowSet reviewers = getReviewers();
			
			/* Do nothing if there are no reviewers */
			if (reviewers.size() == 0) return;
			
			PreparedStatement assignApplicantStmt = conn.prepareStatement(assignApplicantString);
			while (unassignedApplicants.next()) {
				if (!reviewers.next()) {
					reviewers.beforeFirst();
					reviewers.next();
				}
				
				assignApplicantStmt.setInt(1, reviewers.getInt("id"));
				assignApplicantStmt.setInt(2, unassignedApplicants.getInt("id"));
				assignApplicantStmt.execute();
			}
		
			pstmt.close();
			assignApplicantStmt.close();
			
			conn.close();
			
		
		} catch (SQLException e) {
			throw new DbException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
}

