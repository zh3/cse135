package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.db.DbException;
import com.cse135project.forms.AddReviewerToApplicantForm;

public class AddReviewerToApplicantAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		AddReviewerToApplicantForm addReviewerForm = 
				(AddReviewerToApplicantForm) form;
		int reviewerId = addReviewerForm.getReviewerId();
		int applicantId = addReviewerForm.getApplicantId();
		
		if (reviewerId > 0) {
			ApplicantModel.addApplicantToReviewerWorkload(reviewerId, applicantId);
		}
		
		return mapping.findForward("success");
	}
}
