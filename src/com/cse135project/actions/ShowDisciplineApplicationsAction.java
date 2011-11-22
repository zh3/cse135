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

public class ShowDisciplineApplicationsAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		String disciplineIdString = request.getParameter("chosenDiscipline");
		if (disciplineIdString == null) {
			disciplineIdString = (String) request.getSession().getAttribute("lastDiscipline");
		}
		
		int disciplineId = Integer.parseInt(disciplineIdString);
		RowSet applicantsByReviewer = ApplicantModel.getApplicantsWithDegreeDiscipline(disciplineId);
		
		request.setAttribute("applicants", applicantsByReviewer);
		request.setAttribute("applicationsTitle", "Applications with degrees in " 
				+ ApplicantModel.getDisciplineName(disciplineId));
		
		request.getSession().setAttribute("lastShowApplicationsAction", this);
		request.getSession().setAttribute("lastDiscipline", disciplineIdString);

		return mapping.findForward("success");
	}
}
