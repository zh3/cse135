<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%
		Integer applicantId = (Integer) request.getAttribute("applicantId");
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Decide Application Status</title>
</head>
<body>
	<h3>Decide Application Status</h3>
	<html:form action="/reviewerAdmitApplicant" style="display:inline">
	<html:hidden property="id" value="<%=Integer.toString(applicantId) %>" />
	<html:submit value="Admit" />
	</html:form>
						
	<html:form action="/reviewerRejectApplicant" style="display:inline">
	<html:hidden property="id" value="<%=Integer.toString(applicantId) %>" />
	<html:submit value="Reject" />
	</html:form>
						
	<html:form action="/reviewerCancelDecision" style="display:inline">
	<html:hidden property="id" value="<%=Integer.toString(applicantId) %>" />
	<html:submit value="Remain Pending" />
	</html:form>
</body>
</html>