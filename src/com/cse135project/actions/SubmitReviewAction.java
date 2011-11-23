package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.forms.ReviewFormSubmit;

public class SubmitReviewAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws Exception {
		ReviewFormSubmit reviewForm = (ReviewFormSubmit) form;
		ApplicantModel.addReview(reviewForm.getGrade(), reviewForm.getComment(), 
				reviewForm.getReviewer(), reviewForm.getApplicant());
		
		request.setAttribute("applicantId", reviewForm.getApplicant());
		return mapping.findForward("enoughReviews");
	}
}
