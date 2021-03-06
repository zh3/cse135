package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ReviewerModel;
import com.cse135project.forms.ReviewerFormSubmit;

public class DeleteReviewerAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws Exception {
		ReviewerFormSubmit submitForm = (ReviewerFormSubmit) form;
		ReviewerModel.deleteReviewer(submitForm);
		
		return mapping.findForward("success");
	}
}