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

public class ShowSpecializationApplicationsAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		String specializationIdString = request.getParameter("chosenSpecialization");
		if (specializationIdString == null) {
			specializationIdString = (String) request.getSession().getAttribute("lastSpecialization");
		}
		
		int specializationId = Integer.parseInt(specializationIdString);
		RowSet applicantsByReviewer = ApplicantModel.getApplicantsWithSpecialization(specializationId);
		
		request.setAttribute("applicants", applicantsByReviewer);
		request.setAttribute("applicationsTitle", "Applications specializing in " 
				+ ApplicantModel.getSpecializationName(specializationId));
		
		request.getSession().setAttribute("lastShowApplicationsAction", this);
		request.getSession().setAttribute("lastSpecialization", specializationIdString);

		return mapping.findForward("success");
	}
}
