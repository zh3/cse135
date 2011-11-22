package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.db.DbException;
import com.cse135project.forms.ApplicantFormCancel;

public class CancelDecisionAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		ApplicantFormCancel admitForm = (ApplicantFormCancel) form;
		ApplicantModel.cancelDecision(admitForm.getId());
		
		ShowGradedApplicationsAction lastShowApplicationsAction 
			= (ShowGradedApplicationsAction) request.getSession().getAttribute("lastShowApplicationsAction");
		lastShowApplicationsAction.execute(mapping, form, request, response);
		
		return mapping.findForward("success");
	}
}
