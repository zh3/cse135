package com.cse135project;

/**
 * Encapsulates Degree Information
 * 
 * @author Zhanzhan He
 *
 */
public class Degree {
	public Degree(Integer degreeUniversityId, Integer degreeDisciplineId, 
			String degreeTitle, Integer degreeMonth, 
			Integer degreeYear, Float degreeGpa) {
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
	
	public Integer getMonth() {
		return month;
	}
	
	public Integer getYear() {
		return year;
	}
	
	public Float getGpa() {
		return gpa;
	}
	
	private Integer universityId;
	private Integer disciplineId;
	private String title;
	private Integer month;
	private Integer year;
	private Float gpa;
}
