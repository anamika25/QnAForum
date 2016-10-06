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

<link href="<c:url value="/resources/css/homepage.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/semantic.min.css" />" rel="stylesheet">
<script src="/resources/semantic.min.js"></script>
</head>

<body>
<%-- 	<h1>Title : ${title}</h1> --%>
<%-- 	<h1>Message : ${message}</h1> --%>

<form name='QuestionForm'
action="<c:url value='/Add_Question/create?${_csrf.parameterName}=${_csrf.token}' />" method='POST'>
<div style="margin-top: 12px" class="input-group">
<select class="ui fluid search dropdown" multiple="">
  <option value="">Category</option>
  <c:forEach items="${category_list}" var="category">
        <option value=""> ${category} </option>
   </c:forEach>
</select>
</div>
<label for="question_create">Write your Question here:</label><br>
<textarea name= "title" class="title" rows="1" id="title"></textarea><br><br>
  <textarea name= "text" class="text" rows="5" id="text"></textarea><br><br>
</div>
<button type="submit" value="submit" class="btn btn-success">Submit</button>
</form>					

	<sec:authorize access="hasRole('ROLE_USER')">
		<!-- For login user -->
		<c:url value="/j_spring_security_logout" var="logoutUrl" />
		
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>

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