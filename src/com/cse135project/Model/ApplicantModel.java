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
	
	private static final String applicantWithIdString
		= "SELECT DISTINCT firstname, middlename, lastname, streetAddress, city, state, zipCode, countryCode, "
				+ "areaCode, number, residencyStatus, c1.name AS countryOfCitizenship, c2.name AS countryOfResidence, " 
				+ "specializations.name AS specialization, applicationstatus "
			+ "FROM applicants, countries AS c1, countries AS c2, specializations "
			+ "WHERE applicants.id = ? "
			+ "AND c1.id = countryOfCitizenship "
			+ "AND c2.id = countryOfResidence "
			+ "AND specialization = specializations.id;";
	
	private static final String applicantDegreesString
		= "SELECT awardMonth, awardYear, title, universities.name AS university, "
			+ "location, disciplines.name AS discipline, gpa "
			+ "FROM degrees, universities, disciplines "
			+ "WHERE applicant = ? "
			+ "AND discipline = disciplines.id "
		  	+ "AND university = universities.id;";
	
	private static final String applicantReviewsString
		= "SELECT grade, comment, users.username "
			+ "FROM reviews, users "
			+ "WHERE applicant = ? "
			+ "AND reviewer = users.id;";
	
	private static final String reviewerIdString
		= "SELECT id FROM users WHERE username = ?";
	
	private static final String addReviewString
		= "INSERT INTO reviews (grade, comment, reviewer, applicant) VALUES (?, ?, ?, ?);";
	
	private static final String removeFromWorkloadString
		= "DELETE FROM workload WHERE reviewer = ? AND applicant = ?";
	
	private static final String unassociatedReviewersString
		= "SELECT * FROM users "
			+ "WHERE "
			+ "id IN ( "
				+ "SELECT users.id "
				+ "FROM users, userroles "
				+ "WHERE users.username = userroles.username "
				+ "AND userroles.role = 'reviewer'"
			+ ") "
			+ "AND id NOT IN (SELECT reviewer FROM reviews WHERE applicant = ?) " 
			+ "AND id NOT IN (SELECT reviewer FROM workload WHERE applicant = ?);";
	
	private static final String addApplicantToReviewerWorkloadString
		= "INSERT INTO workload (reviewer, applicant) VALUES (?, ?)";
	private static final String getApplicationForUserString
		= "SELECT * FROM applicants, users WHERE applicants.userId = users.id AND username = ?";
	
	private static final String universityExistsString 
		= "SELECT name FROM "
		    + "(SELECT LOWER(name) AS name FROM universities) AS universityNames "
		    + "WHERE name = LOWER(?);";
	
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
	
	public static void addApplicantToReviewerWorkload(int reviewerId, 
			int applicantId) throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(addApplicantToReviewerWorkloadString);
			
			pstmt.setInt(1, reviewerId);
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
	
	public static CachedRowSet getApplicantWithId(int applicantId) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(applicantWithIdString);
			
			pstmt.setInt(1, applicantId);
			ResultSet applicantByIdSet = pstmt.executeQuery();
			CachedRowSet applicantWithId = new CachedRowSetImpl();
			applicantWithId.populate(applicantByIdSet);
			
			applicantByIdSet.close();
			pstmt.close();
			conn.close();
			
			return applicantWithId;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static CachedRowSet getApplicantDegrees(int applicantId) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(applicantDegreesString);
			
			pstmt.setInt(1, applicantId);
			ResultSet applicantDegreesSet = pstmt.executeQuery();
			CachedRowSet applicantDegrees = new CachedRowSetImpl();
			applicantDegrees.populate(applicantDegreesSet);
			
			applicantDegreesSet.close();
			pstmt.close();
			conn.close();
			
			return applicantDegrees;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static CachedRowSet getApplicantReviews(int applicantId) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(applicantReviewsString);
			
			pstmt.setInt(1, applicantId);
			ResultSet applicantDegreesSet = pstmt.executeQuery();
			CachedRowSet applicantDegrees = new CachedRowSetImpl();
			applicantDegrees.populate(applicantDegreesSet);
			
			applicantDegreesSet.close();
			pstmt.close();
			conn.close();
			
			return applicantDegrees;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static CachedRowSet getUnassociatedReviewers(int applicantId) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(unassociatedReviewersString);
			
			pstmt.setInt(1, applicantId);
			pstmt.setInt(2, applicantId);
			ResultSet unassociatedreviewersSet = pstmt.executeQuery();
			CachedRowSet unassociatedReviewers = new CachedRowSetImpl();
			unassociatedReviewers.populate(unassociatedreviewersSet);
			
			unassociatedreviewersSet.close();
			pstmt.close();
			conn.close();
			
			return unassociatedReviewers;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static CachedRowSet getApplication(String username) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(getApplicationForUserString);
			
			pstmt.setString(1, username);
			ResultSet applicationSet = pstmt.executeQuery();
			
			int applicantId = -1;
			if (applicationSet.next()) {
				applicantId = applicationSet.getInt("id");
			}
			
			applicationSet.close();
			pstmt.close();
			conn.close();
			
			return getApplicantWithId(applicantId);
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static CachedRowSet getApplicantDegrees(String username) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(getApplicationForUserString);
			
			pstmt.setString(1, username);
			ResultSet applicationSet = pstmt.executeQuery();
			
			int applicantId = -1;
			if (applicationSet.next()) {
				applicantId = applicationSet.getInt("id");
			}
			
			applicationSet.close();
			pstmt.close();
			conn.close();
			
			return getApplicantDegrees(applicantId);
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static int getNumApplicantReviews(int applicantId) 
			throws DbException {
		try {
			int reviewCount = -1;
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT COUNT(grade) AS numReviews FROM (" 
					+ applicantReviewsString.substring(0, applicantReviewsString.length() - 1)
					+ ") AS applicantReviews");
			
			pstmt.setInt(1, applicantId);
			ResultSet applicantCountSet = pstmt.executeQuery();
			
			if (applicantCountSet.next()) {
				reviewCount = applicantCountSet.getInt("numReviews");
			}
			
			applicantCountSet.close();
			pstmt.close();
			conn.close();
			
			return reviewCount;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static int getReviewerId(String username) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(reviewerIdString);
			
			pstmt.setString(1, username);
			ResultSet reviewerIdSet = pstmt.executeQuery();
			
			int reviewerId = -1;
			if (reviewerIdSet.next()) {
				reviewerId = reviewerIdSet.getInt("id");
			}
			
			reviewerIdSet.close();
			pstmt.close();
			conn.close();
			
			return reviewerId;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static boolean applicationExists(String username) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(getApplicationForUserString);
			
			pstmt.setString(1, username);
			ResultSet applicationSet = pstmt.executeQuery();
			
			boolean applicationExists = applicationSet.next();
			applicationSet.close();
			pstmt.close();
			conn.close();
			
			return applicationExists;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static boolean universityExists(String name) 
			throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(universityExistsString);
			
			pstmt.setString(1, name);
			ResultSet universitySet = pstmt.executeQuery();
			
			boolean universityExists = universitySet.next();
			universitySet.close();
			pstmt.close();
			conn.close();
			
			return universityExists;
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		} 
	}
	
	public static void addReview(int grade, String comment, int reviewerId, 
			int applicantId) throws DbException {
		try {
			Connection conn = DBConnection.dbConnect();
			PreparedStatement pstmt = conn.prepareStatement(addReviewString);
			
			pstmt.setInt(1, grade);
			pstmt.setString(2, comment);
			pstmt.setInt(3, reviewerId);
			pstmt.setInt(4, applicantId);
			pstmt.executeUpdate();

			pstmt.close(); 
			
			pstmt = conn.prepareStatement(removeFromWorkloadString);
			pstmt.setInt(1, reviewerId);
			pstmt.setInt(2, applicantId);
			pstmt.executeUpdate();
			
			conn.close();
		} catch (SQLException e) {
			throw new DataBindingException(e);
		} catch (NamingException e) {
			throw new DbException(e);
		}
	}
}
