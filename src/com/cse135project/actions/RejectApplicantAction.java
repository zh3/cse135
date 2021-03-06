package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.forms.ApplicantFormReject;

public class RejectApplicantAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws Exception {
		ApplicantFormReject admitForm = (ApplicantFormReject) form;
		ApplicantModel.rejectApplicant(admitForm.getId());
		
		Action lastShowApplicationsAction 
			= (Action) request.getSession().getAttribute("lastShowApplicationsAction");
		lastShowApplicationsAction.execute(mapping, form, request, response);
		
		return mapping.findForward("success");
	}
}
