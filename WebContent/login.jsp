<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Login</title>
	</head>
	<body>
		<form method="POST" action="j_security_check">
			Username:
			<input size="12" name="j_username" type="text" /><br/>
			Password:
			<input size="12" name="j_password" type="password" /><br/>
			<input type="submit" value="Login"/>
		</form>
	</body>
</html>