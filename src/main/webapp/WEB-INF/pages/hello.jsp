<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

=======
<%@include file="header.jsp"%>
<html>

<head>
<!-- <link rel="stylesheet" href="/resources/css/homepage.css" type="text/css"> -->
<link href="<c:url value="/resources/css/homepage.css" />" rel="stylesheet">
</head>

<body>
<%-- 	<h1>Title : ${title}</h1> --%>
<%-- 	<h1>Message : ${message}</h1> --%>

	<sec:authorize access="hasRole('ROLE_USER')">
		<!-- For login user -->
		<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<c:url value="/Add_Question" var="questionUrl" />
		
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
		
		<div class="header">
			QnA forum
		</div>
		
<!-- 		<button> -->
<!-- 		<div class="button"> -->
<!-- 			Add Question -->
<!-- 		</div> -->
<!-- 		</button> -->
		
 		<form action="${questionUrl}" method="get" id="addQuestion"> 
			<input type="button" name="button 1" onclick="addQuestion()"
				value="Add Question" />
		</form>
		
		
		<script>
			function addQuestion() {
 				document.getElementById("addQuestion").submit();
			}
		</script>
		
		<script>
			function formSubmit() {
				document.getElementById("logoutForm").submit();
			}
		</script>
<%--
<%! var pages = 44;%>
<div class="text-center">
<ul class="pagination ">
<c:forEach var="i" begin="1" end="${pages}">
<li id="page${i-1}" class="page-item"><a
href="./welcome?&page=${i-1}">${i}</a></li>
</c:forEach>
</ul>
</div>
--%>

		<c:if test="${pageContext.request.userPrincipal.name != null}">
			<h2>
				User : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
		</c:if>
	</sec:authorize>
</body>
</html>