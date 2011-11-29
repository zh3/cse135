<% response.setContentType("text/xml") ; %>
<universityExists>
	<exists><%= request.getAttribute("exists") %></exists>
</universityExists>
