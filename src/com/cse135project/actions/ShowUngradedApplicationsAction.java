package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.RowSet;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.db.DbException;

public class ShowUngradedApplicationsAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		String username = request.getParameter("username");
		if (username == null) {
			username = (String) request.getSession().getAttribute("lastUsername");
		}
		
		RowSet applicantsByReviewer = ApplicantModel.getUngradedApplicants(username);
		
		request.setAttribute("applicants", applicantsByReviewer);
		request.setAttribute("applicationsTitle", "Graded Applications by " + username);
		
		request.getSession().setAttribute("lastShowApplicationsAction", this);
		request.getSession().setAttribute("lastUsername", username);

		return mapping.findForward("success");
	}
}
