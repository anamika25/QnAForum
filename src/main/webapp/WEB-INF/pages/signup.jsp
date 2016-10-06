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
<script src="/resources/js/jquery-3.1.1.min.js"></script>
<script>
	function function openLoginPage() {
		window.location.href = './login';
	}
</script>
</head>

<body onload='document.signUpForm.fullname.focus();'>

	<div class="container" id="signupbox"
		style="margin-top: 30px; display: none;">
		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						<strong>Sign Up </strong>
					</h3>
				</div>

				<div class="panel-body">
					<form name='signUpForm' action="createUser" method='POST'>
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
							<label>Full Name:</label> <input id="signup-fullname" type="text"
								class="form-control" name="fullname" value=""
								placeholder="First name and Last name" autocomplete="off"
								type="reset">
						</div>

						<div style="margin-bottom: 12px" class="input-group">
							<label>Username:</label> <input id="signup-username" type="text"
								class="form-control" name="username"
								placeholder="username or email" autocomplete="off" type="reset">
						</div>

						<div style="margin-bottom: 12px" class="input-group">
							<label>Password:</label> <input id="signup-password"
								type="password" class="form-control" name="password"
								placeholder="password" autocomplete="off" type="reset">
						</div>

						<button type="submit" value="submit" class="btn btn-success">Sign
							Up</button>

						<hr style="margin-top: 10px; margin-bottom: 10px;">

						<div class="form-group">
							<div style="font-size: 85%">
								Already have an account! <a href="#" onClick="openLoginPage()">
									Log In </a>
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