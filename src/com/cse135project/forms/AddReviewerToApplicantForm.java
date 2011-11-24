package com.cse135project.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class AddReviewerToApplicantForm extends ActionForm {

	private static final long serialVersionUID = 1L;

	private int reviewerId = -1;
	private int applicantId = -1;

	public int getReviewerId() {
		return reviewerId;
	}

	public void setReviewerId(int id) {
		this.reviewerId = id;
	}
	
	public int getApplicantId() {
		return applicantId;
	}

	public void setApplicantId(int id) {
		this.applicantId = id;
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
		setReviewerId(-1);
		setApplicantId(-1);
	}

}
