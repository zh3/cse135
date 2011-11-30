package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ReviewerModel;
import com.cse135project.forms.StartReviewProcessForm;

public class StartReviewProcessAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws Exception {
		StartReviewProcessForm submitForm = (StartReviewProcessForm) form;
		request.setAttribute("enoughReviewers", 1);
		if (Integer.parseInt(submitForm.getSelectedReviewers()) >= 3)
		{
			ReviewerModel.assignWorkload();
		}
		
	
		
		return mapping.findForward("success");
	}
}