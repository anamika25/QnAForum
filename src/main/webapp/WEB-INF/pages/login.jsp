<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@page session="true"%>
<%@include file="header.jsp"%>
<html>
<head>
<title>Login Page</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"
	integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">
</head>
<body onload='document.loginForm.username.focus();'>

	<div class="container" style="margin-top: 30px">
		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<strong>Sign in </strong>
					</h3>
				</div>

				<div class="panel-body">
					<form name='loginForm'
						action="<c:url value='/j_spring_security_check' />" method='POST'>
						<c:if test="${not empty error}">
							<div class="alert alert-danger">
								<div class="error">${error}</div>
							</div>
						</c:if>
						<c:if test="${not empty msg}">
							<div class="alert alert-danger">
								<div class="msg">${msg}</div>
							</div>
						</c:if>
						<div style="margin-bottom: 12px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-user"></i></span> <input id="login-username"
								type="text" class="form-control" name="username" value=""
								placeholder="username or email">
						</div>

						<div style="margin-bottom: 12px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-lock"></i></span> <input id="login-password"
								type="password" class="form-control" name="password"
								placeholder="password">
						</div>

						<button type="submit" value="submit" class="btn btn-success">Sign
							in</button>

						<hr style="margin-top: 10px; margin-bottom: 10px;">

						<div class="form-group">
							<div style="font-size: 85%">
								Don't have an account! <a href="#"
									onClick="$('#loginbox').hide(); $('#signupbox').show()">
									Sign Up Here </a>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>