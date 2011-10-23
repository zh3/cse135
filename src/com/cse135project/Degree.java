package com.cse135project;

/**
 * Encapsulates Degree Information
 * 
 * @author Zhanzhan He
 *
 */
public class Degree {
	public Degree(Integer degreeUniversityId, Integer degreeDisciplineId, 
			String degreeTitle, String degreeMonth, 
			String degreeYear, String degreeGpa) {
		universityId = degreeUniversityId;
		disciplineId = degreeDisciplineId;
		title = degreeTitle;
		month = degreeMonth;
		year = degreeYear;
		gpa = degreeGpa;
	}
	
	public Integer getUniversityId() {
		return universityId;
	}
	
	public Integer getDisciplineId() {
		return disciplineId;
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getMonth() {
		return month;
	}
	
	public String getYear() {
		return year;
	}
	
	public String getGpa() {
		return gpa;
	}
	
	private Integer universityId;
	private Integer disciplineId;
	private String title;
	private String month;
	private String year;
	private String gpa;
}
