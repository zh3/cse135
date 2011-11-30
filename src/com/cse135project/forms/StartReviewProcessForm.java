package com.cse135project.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import com.cse135project.Model.ReviewerModel;
import com.cse135project.db.DbException;


public class StartReviewProcessForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	private int id = -1;
	
	private String selectedReviewers = "0"; 


	public String getSelectedReviewers() {
		return selectedReviewers;
	}
	
	public void setSelectedReviewers(String selectedReviewers) {
		this.selectedReviewers = selectedReviewers;
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
		
		setSelectedReviewers("0");
	}
	
	/**
	 * Validate the input data. If validation fails, then report the errors in
	 * selectReviewers.jsp, and specifically where <html:errors/> is located.
	 * 
	 * @param mapping
	 *            The mapping used to select this instance
	 * @param request
	 *            The servlet request we are processing
	 */
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {

		ActionErrors errors = new ActionErrors();
		
		if(Integer.parseInt(selectedReviewers) < 3)
			errors.add("reviewers", new ActionMessage("errors.reviewers"));
		request.setAttribute("enoughReviewers", 0);
		return errors;
	}

}
