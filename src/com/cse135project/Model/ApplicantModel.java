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

public class ApplicantModel {
	private static final String applicantsByReviewerString
		= "SELECT ungradedApplications.username, numgraded, numungraded FROM "
			+ "(SELECT username, COUNT(users.id) AS numGraded "
			+ "FROM users, reviews "
			+ "WHERE users.id = reviews.reviewer "
			+ "GROUP BY username) AS gradedApplications "
			+ "INNER JOIN "
			+ "(SELECT username, COUNT(users.id) AS numUngraded "
			+ "FROM users, workload "
			+ "WHERE users.id = workload.reviewer "
			+ "GROUP BY username) AS ungradedApplications "
			+ "ON gradedApplications.username = ungradedApplications.username";
	
	private static final String gradedApplicantsByReviewerUsernameString
		= "SELECT firstname, middlename, lastname, avgGrade, applicationStatus "
			+ "FROM "
				+ "(SELECT applicants.id AS applicantId, AVG(grade) as avgGrade "
				+ "FROM reviews, applicants "
				+ "WHERE applicant = applicants.id "
				+ "GROUP BY applicants.id) AS applicantAvgGrades, "
				+ "applicants, "
				+ "reviews "
			+ "WHERE applicantAvgGrades.applicantId = applicants.id "
			+ "AND reviews.applicant = applicants.id "
			+ "AND reviews.reviewer IN "
			+"(SELECT id FROM users WHERE username = ?);";
	
	public static CachedRowSet getApplicantsByReviewer() throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(applicantsByReviewerString);
			
			ResultSet applicantsByReviewer = pstmt.executeQuery();
			CachedRowSet crsApplicantsByReviewer = new CachedRowSetImpl();
			crsApplicantsByReviewer.populate(applicantsByReviewer);
			
			applicantsByReviewer.close();
			pstmt.close();
			conn.close();
			
			return crsApplicantsByReviewer;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static CachedRowSet getGradedApplicants(String reviewerUsername) throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(gradedApplicantsByReviewerUsernameString);
			
			pstmt.setString(1, reviewerUsername);
			ResultSet gradedApplicantsByReviewer = pstmt.executeQuery();
			CachedRowSet crsApplicantsByReviewer = new CachedRowSetImpl();
			crsApplicantsByReviewer.populate(gradedApplicantsByReviewer);
			
			gradedApplicantsByReviewer.close();
			pstmt.close();
			conn.close();
			
			return crsApplicantsByReviewer;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
}
