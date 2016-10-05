<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<style>
header {
	padding: 1em;
	color: white;
	background-color: black;
	clear: left;
	text-align: left;
}

header h1 {
	display: inline-block;
	margin: 12px;
}

header div {
	display: inline-block;
	float: right;
}

header div h5 {
	margin-bottom: 10px;
	margin-top: 10px;
}
</style>
<script>
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
</script>
</head>
<header>
	<h1>QnAForum</h1>
	<c:url value="/j_spring_security_logout" var="logoutUrl" />

	<c:if test="${pageContext.request.userPrincipal.name != null}">
		<div>
			<h5>Welcome ${pageContext.request.userPrincipal.name}</h5>
			<a href="javascript:formSubmit()"> Logout</a>
		</div>
	</c:if>
	<form action="${logoutUrl}" method="post" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
</header>
</html>