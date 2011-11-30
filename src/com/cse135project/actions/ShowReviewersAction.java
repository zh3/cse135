package com.cse135project.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.cse135project.Model.ReviewerModel;
import javax.sql.rowset.CachedRowSet;

public class ShowReviewersAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) 
					throws Exception {
;
		
	
		// retrieve all students
		CachedRowSet crsReviewers = ReviewerModel.getReviewers();
		// store the RowSet in the request scope
		request.setAttribute("crsReviewers", crsReviewers);

		return mapping.findForward("success");
	}
}