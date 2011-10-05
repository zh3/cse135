<html>
<head>
<title>Country of Citizenship</title>
<%
    String firstName = request.getParameter("firstName");
    String middleInitial = request.getParameter("middleInitial");
    String lastName = request.getParameter("lastName");

    session.setAttribute("firstName", firstName);
    session.setAttribute("middleInitial", middleInitial);
    session.setAttribute("lastName", lastName);
%>
</head>
</html>
