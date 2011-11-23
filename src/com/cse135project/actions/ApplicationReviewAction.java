package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.RowSet;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.db.DbException;

public class ApplicationReviewAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws DbException {
		String applicantIdString = (String) request.getParameter("applicantId");
		int applicantId = Integer.parseInt(applicantIdString);
		
		RowSet applicant = ApplicantModel.getApplicantWithId(applicantId);
		RowSet applicantDegrees = ApplicantModel.getApplicantDegrees(applicantId);
		RowSet applicantReviews = ApplicantModel.getApplicantReviews(applicantId);
		
		request.setAttribute("applicant", applicant);
		request.setAttribute("degrees", applicantDegrees);
		request.setAttribute("reviews", applicantReviews);
		return mapping.findForward("success");
	}
}
