package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.db.DbException;

public class UniversityExistsAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		String universityName = (String) request.getParameter("universityName");
		
		if (universityName != null && ApplicantModel.universityExists(universityName)) {
			request.setAttribute("exists", "true");
		} else {
			request.setAttribute("exists", "false");
		}
		
		return mapping.findForward("success");
	}
}
