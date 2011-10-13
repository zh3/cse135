<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<%!
			void saveAddress(HttpSession currentSession, HttpServletRequest request) {
				currentSession.setAttribute("streetAddress", request.getParameter("streetAddress"));
				currentSession.setAttribute("city", request.getParameter("city"));
				currentSession.setAttribute("state", request.getParameter("state"));
				currentSession.setAttribute("zipCode", request.getParameter("zipCode"));
				currentSession.setAttribute("countryCode", request.getParameter("countryCode"));
				currentSession.setAttribute("areaCode", request.getParameter("areaCode"));
				currentSession.setAttribute("telNumber", request.getParameter("telNumber"));
				currentSession.setAttribute("addressSaved", new Boolean(true));
			}
		
			boolean isAddressSaved(HttpSession currentSession) {
				return (currentSession.getAttribute("addressSaved") != null);
			}
		%>
	</head>
</html>