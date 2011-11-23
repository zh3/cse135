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

public class ReviewAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		String username = request.getUserPrincipal().getName();
		
		RowSet applicantsByReviewer = ApplicantModel.getUngradedApplicants(username);
		
		request.setAttribute("applicantsByReviewer", applicantsByReviewer);
		return mapping.findForward("success");
	}
}
