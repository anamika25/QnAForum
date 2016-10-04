<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
		
		
		<div class="header">
			Question Page
		</div>

		<script>
		function add_text(text){
		    var TheTextBox = document.getElementById("textbox");
		    TheTextBox.value = TheTextBox.value + text;
		}
		
		function Add()
		{
			var name1 = document.createElement("select");
  			name1.setAttribute('id',"year1")
  			name1.setAttribute('oncreate',"Date1()");
		}
	
		function Date1()
		{
  			d = new Date();
  			curr_year = d.getFullYear();
  			for(i = 0; i < 5; i++)
  			{
    			document.getElementById('year1').options[i] = new Option((curr_year-1)-i,(curr_year-1)-i);
  			}
		}
		</script>
		<script>
			function formSubmit() {
				document.getElementById("logoutForm").submit();
			}
		</script>

		<c:if test="${pageContext.request.userPrincipal.name != null}">
			<h2>
				User : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
		</c:if>


	</sec:authorize>
</body>
</html>