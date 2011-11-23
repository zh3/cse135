package com.cse135project.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

public class ReviewFormSubmit extends ActionForm {

	private static final long serialVersionUID = 1L;
	private static final int GRADE_MAX = 4;
	private static final int GRADE_MIN = 1;

	private int grade = -1;
	private String comment = null;
	private int reviewer = -1;
	private int applicant = -1;

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getReviewer() {
		return reviewer;
	}

	public void setReviewer(int reviewer) {
		this.reviewer = reviewer;
	}

	public int getApplicant() {
		return applicant;
	}

	public void setApplicant(int applicant) {
		this.applicant = applicant;
	}

	/**
	 * Reset all properties to their default values.
	 * 
	 * @param mapping
	 *            The mapping used to select this instance
	 * @param request
	 *            The servlet request we are processing
	 */
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		setGrade(-1);
		setComment(null);
		setApplicant(-1);
		setReviewer(-1);
	}

	/**
	 * Validate the input data. If validation fails, then report the errors in
	 * applicationReview.jsp, and specifically where <html:errors/> is located.
	 * 
	 * @param mapping
	 *            The mapping used to select this instance
	 * @param request
	 *            The servlet request we are processing
	 */
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {

		ActionErrors errors = new ActionErrors();

		if (grade < GRADE_MIN || grade > GRADE_MAX) {
			errors.add("grade", new ActionMessage("errors.range", 
					grade, GRADE_MIN, GRADE_MAX));
		}
		
		return errors;
	}

}
