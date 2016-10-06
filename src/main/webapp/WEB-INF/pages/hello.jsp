<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@include file="header.jsp"%>
<html>

<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">
	
<!-- <link rel="stylesheet" href="/resources/css/homepage.css" type="text/css"> -->
<link href="<c:url value="/resources/css/homepage.css" />" rel="stylesheet" />
<script type="text/javascript" src="<c:url value="/resources/jquery.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/jquery.simplePagination.js"/>"></script>
<link type="text/css" rel="stylesheet" href="<c:url value="resources/css/simplePagination.css"/>"/>
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
			
			document.getElementById("paginator").pagination({
		        items: 44,
		        itemsOnPage: 20,
		        cssStyle: 'light-theme'
		    });
		});

		</script>

<div id="paginator"></div>

<%--
<div class="text-center">
<ul class="pagination ">
<c:forEach var="i" begin="1" end="44">
<li id="page${i-1}" class="page-item"><a
href="./welcome?pageNum=${i-1}">${i}</a></li>
</c:forEach>
</ul>
</div> 


<div id="paginator">
<ul class="pagination">
              <li class="disabled"><a href="#">«</a></li>
              <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">3</a></li>
              <li><a href="#">4</a></li>
              <li><a href="#">5</a></li>
              <li><a href="#">»</a></li>
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