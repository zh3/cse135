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
		= "SELECT applicants.id, firstname, middlename, lastname, avgGrade, applicationStatus "
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
	
	private static final String ungradedApplicantsByReviewerUsernameString
		= "SELECT applicants.id, firstname, middlename, lastname, 0 AS avgGrade, applicationStatus "
			+ "FROM workload, applicants "
			+ "WHERE workload.applicant = applicants.id "
			+ "AND workload.reviewer IN "
			+ "(SELECT id FROM users WHERE username = ?);";
	
	private static final String updateApplicantByIdString
		= "UPDATE applicants SET applicationStatus = ? WHERE id = ?;";
	
	private static final String disciplineNameQueryString
		= "SELECT name FROM disciplines WHERE id = ?";
	
	private static final String specializationNameQueryString
	= "SELECT name FROM specializations WHERE id = ?";
	
	private static final String applicantsWithDegreeDisciplineString
		= "SELECT id, firstname, middlename, lastname, SUM(avgGrade) as avgGrade, applicationStatus "
			+ "FROM "
			+ "(SELECT applicants.id, firstname, middlename, lastname, 0 AS avgGrade, applicationStatus "
			+ "FROM workload, applicants "
			+ "WHERE workload.applicant = applicants.id "
			+ "UNION "
			+ "SELECT applicants.id, firstname, middlename, lastname, avgGrade, applicationStatus "
			+ "FROM "
			+ "(SELECT applicants.id AS applicantId, AVG(grade) as avgGrade "
			+ "FROM reviews, applicants "
			+ "WHERE applicant = applicants.id "
			+ "GROUP BY applicants.id) AS applicantAvgGrades, "
			+ "applicants, "
			+ "reviews "
			+ "WHERE applicantAvgGrades.applicantId = applicants.id "
			+ "AND reviews.applicant = applicants.id) AS applicantsWithAvgGrade "
			+ "WHERE applicantsWithAvgGrade.id IN "
			+ "(SELECT DISTINCT t.ID "
			+ "FROM "
			+ "applicants t, degrees s "
			+ "WHERE t.ID = s.applicant AND s.discipline = ?) "
			+ "GROUP BY id, firstname, middlename, lastname, applicationStatus;";
	
	private static final String applicantsWithSpecializationString
		= "SELECT id, firstname, middlename, lastname, SUM(avgGrade) as avgGrade, applicationStatus "
			+ "FROM "
			+ "(SELECT applicants.id, firstname, middlename, lastname, 0 AS avgGrade, applicationStatus "
			+ "FROM workload, applicants "
			+ "WHERE workload.applicant = applicants.id "
			+ "UNION "
			+ "SELECT applicants.id, firstname, middlename, lastname, avgGrade, applicationStatus "
			+ "FROM "
			+ "(SELECT applicants.id AS applicantId, AVG(grade) as avgGrade "
			+ "FROM reviews, applicants "
			+ "WHERE applicant = applicants.id "
			+ "GROUP BY applicants.id) AS applicantAvgGrades, "
			+ "applicants, "
			+ "reviews "
			+ "WHERE applicantAvgGrades.applicantId = applicants.id "
			+ "AND reviews.applicant = applicants.id) AS applicantsWithAvgGrade "
			+ "WHERE applicantsWithAvgGrade.id IN "
			+ "(SELECT DISTINCT id FROM applicants WHERE specialization = ?) "
			+ "GROUP BY id, firstname, middlename, lastname, applicationStatus;";
	
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
	
	public static CachedRowSet getUngradedApplicants(String reviewerUsername) throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(ungradedApplicantsByReviewerUsernameString);
			
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
	
	public static void admitApplicant(int applicantId) throws DbException {
		 updateApplicantAdmissionStatusById(applicantId, "Accepted");
	}
	
	public static void rejectApplicant(int applicantId) throws DbException {
		 updateApplicantAdmissionStatusById(applicantId, "Rejected");
	}
	
	public static void cancelDecision(int applicantId) throws DbException {
		 updateApplicantAdmissionStatusById(applicantId, "Pending");
	}
	
	private static void updateApplicantAdmissionStatusById(int applicantId, 
			String newStatus) throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(updateApplicantByIdString);
			
			pstmt.setString(1, newStatus);
			pstmt.setInt(2, applicantId);
			pstmt.executeUpdate();

			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		}
	}
	
	public static CachedRowSet getApplicantsWithDegreeDiscipline(int disciplineId) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(applicantsWithDegreeDisciplineString);
			
			pstmt.setInt(1, disciplineId);
			ResultSet applicantsByDiscipline = pstmt.executeQuery();
			CachedRowSet crsApplicantsByReviewer = new CachedRowSetImpl();
			crsApplicantsByReviewer.populate(applicantsByDiscipline);
			
			applicantsByDiscipline.close();
			pstmt.close();
			conn.close();
			
			return crsApplicantsByReviewer;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static CachedRowSet getApplicantsWithSpecialization(int specializationId) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(applicantsWithSpecializationString);
			
			pstmt.setInt(1, specializationId);
			ResultSet applicantsByDiscipline = pstmt.executeQuery();
			CachedRowSet crsApplicantsByReviewer = new CachedRowSetImpl();
			crsApplicantsByReviewer.populate(applicantsByDiscipline);
			
			applicantsByDiscipline.close();
			pstmt.close();
			conn.close();
			
			return crsApplicantsByReviewer;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static String getSpecializationName(int specializationId) 
			throws DbException {
		String disciplineName = "";
		
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(specializationNameQueryString);
			
			pstmt.setInt(1, specializationId);
			ResultSet disciplineNameSet = pstmt.executeQuery();
			
			if (disciplineNameSet.next()) {
				disciplineName = disciplineNameSet.getString("name");
			}
			
			disciplineNameSet.close();
			pstmt.close();
			conn.close();
			
			return disciplineName;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static String getDisciplineName(int disciplineId) 
			throws DbException {
		String disciplineName = "";
		
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(disciplineNameQueryString);
			
			pstmt.setInt(1, disciplineId);
			ResultSet disciplineNameSet = pstmt.executeQuery();
			
			if (disciplineNameSet.next()) {
				disciplineName = disciplineNameSet.getString("name");
			}
			
			disciplineNameSet.close();
			pstmt.close();
			conn.close();
			
			return disciplineName;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
}
