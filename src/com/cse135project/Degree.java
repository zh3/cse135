package com.cse135project;

/**
 * Encapsulates Degree Information
 * 
 * @author Zhanzhan He
 *
 */
public class Degree {
	public Degree(String degreeLocation, String degreeUniversity,
			String degreeName, String degreeTitle, String degreeMonth, 
			String degreeYear, String degreeGpa) {
		location = degreeLocation;
		university = degreeUniversity;
		name = degreeName;
		title = degreeTitle;
		month = degreeMonth;
		year = degreeYear;
		gpa = degreeGpa;
	}
	
	public String getLocation() {
		return location;
	}
	
	public String getUniversity() {
		return university;
	}
	
	public String getName() {
		return name;
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
	
	String location;
	String university;
	String name;
	String title;
	String month;
	String year;
	String gpa;
}
