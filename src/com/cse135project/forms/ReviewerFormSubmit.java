package com.cse135project.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import com.cse135project.Model.ReviewerModel;
import com.cse135project.db.DbException;


public class ReviewerFormSubmit extends ActionForm {

	private static final long serialVersionUID = 1L;

	private int id = -1;
	
	private String username; //the username
	private String password; //the password

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
	public String getUsername(){
		return username;
	}
	public void setUsername(String username){
		this.username = username;
	}
	
	public String getPassword(){
		return password;
	}
	public void setPassword(String password){
		this.password = password;
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
		setId(-1);
		setUsername(null);
		setPassword(null);
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

		if (username == null || username.length() < 3) {
			errors.add("username", new ActionMessage("errors.minlength", 
					username, 3));
		}
		
		boolean isInDb = false;
		try {
			isInDb = ReviewerModel.isInDatabase(username);
		} catch (DbException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(isInDb){
			errors.add("username1", new ActionMessage("errors.taken", 
					   username));
		}
		String rx1 = "^.*[a-z].*$";
		String rx2 = "^.*[A-Z].*$";
		if(!(password.matches(rx1) && password.matches(rx2) && password.length() >= 8)){
			errors.add("password", new ActionMessage("errors.passwordInvalid"));
		}
		
		return errors;
	}

}
