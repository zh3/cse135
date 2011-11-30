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
			throw new DataBindingException(e);
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
			throw new DataBindingException(e);
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
			
			/*calculate number of applications*/
			PreparedStatement pstmt = conn.prepareStatement(roundRobin);
			ResultSet rset = pstmt.executeQuery();
			rset.next();
			int numberOfApplications = rset.getInt(1);
			
			/*calculate number of reviewers*/
			PreparedStatement pstmt1 = conn.prepareStatement(roundRobin1);
			ResultSet rset1 = pstmt1.executeQuery();
			rset.next();
			int numberOfReviewers = rset1.getInt(1);
			
			/* calculate applicants per reviewer*/
			int applicantsPerReviewer = numberOfApplications / numberOfReviewers;
			
			/*create a temporary table of reviewers*/
			PreparedStatement pstmt2 = conn.prepareStatement(roundRobin2);
			pstmt2.execute();
			
			int i = 1; //tmp reviewer id
			int j = 1; //starting place for reviewer i
			int k = applicantsPerReviewer+1;  //finishing place for reviewer i
		
			while(i != numberOfReviewers){
				PreparedStatement pstmt3 = conn.prepareStatement(roundRobin3);
				pstmt3.setInt(1, i);
				pstmt3.setInt(2, j);
				pstmt3.setInt(3, k);
				i++;
				j = k;
				k = k + applicantsPerReviewer;
				pstmt3.close();
				
			}
			
			/*delete tmp table of reviewers*/
			PreparedStatement pstmt4 = conn.prepareStatement(roundRobin4);
			pstmt4.execute();
			
		
			pstmt.close();
			pstmt1.close();
			pstmt2.close();
			
			pstmt4.close();
			
			conn.close();
			
		
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
}

