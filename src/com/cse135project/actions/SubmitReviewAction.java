package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.RowSet;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.forms.ReviewFormSubmit;

public class SubmitReviewAction extends Action {
	private static final int MIN_REVIEWS_FOR_DECISION = 3;
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws Exception {
		ReviewFormSubmit reviewForm = (ReviewFormSubmit) form;
		int applicantId = reviewForm.getApplicant();
		ApplicantModel.addReview(reviewForm.getGrade(), reviewForm.getComment(), 
				reviewForm.getReviewer(), applicantId);
		
		Integer numReviews = ApplicantModel.getNumApplicantReviews(applicantId);
		
		request.setAttribute("numReviews", numReviews);
		request.setAttribute("applicantId", reviewForm.getApplicant());
		
		if (numReviews >= MIN_REVIEWS_FOR_DECISION) {
			return mapping.findForward("enoughReviews");
		} else {
			RowSet unassociatedReviewers = ApplicantModel.getUnassociatedReviewers(applicantId);
			request.setAttribute("unassociatedReviewers", unassociatedReviewers);
			
			return mapping.findForward("notEnoughReviews");
		}
	}
}
