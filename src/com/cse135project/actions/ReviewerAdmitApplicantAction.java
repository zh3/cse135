package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.Model.ApplicantModel;
import com.cse135project.forms.ApplicantFormAdmit;

public class ReviewerAdmitApplicantAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws Exception {
		ApplicantFormAdmit admitForm = (ApplicantFormAdmit) form;
		ApplicantModel.admitApplicant(admitForm.getId());
		
		return mapping.findForward("success");
	}
}
