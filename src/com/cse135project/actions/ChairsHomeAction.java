package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.cse135project.db.DbException;
import com.cse135project.Model.*;

public class ChairsHomeAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws DbException {
		request.setAttribute("crsReviewers", ReviewerModel.getReviewers());
		
		Boolean processStarted = (Boolean) request.getServletContext().getAttribute("processStarted");
		
		if (processStarted != null && processStarted) {
			return mapping.findForward("processStarted");
		} else {
			return mapping.findForward("processNotStarted");
		}
	}
}
