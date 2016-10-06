<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="header.jsp"%>
<html>

<head>
<script type="text/javascript" src="/resources/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="/resources/js/jquery.simplePagination.js"></script>
<link href="<c:url value="/resources/css/homepage.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/simplePagination.css" />"
	rel="stylesheet">

<script>
	function addQuestion() {
		document.getElementById("addQuestion").submit();
	}
</script>
</head>
<style>
.navigationButton {
	background-color: #0095ff;
	padding: 10px;
	color: #FFF;
	cursor: pointer;
	display: inline-block;
	line-height: 11px;
	border-radius: 2px;
	margin-bottom: 5px;
	margin-right: 5px;
	text-decoration: none;
}

.quesTitle {
	border-bottom: 1px solid #e4e6e8;
	font-size: 18px;
	padding-bottom: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
}

.quesTitle:hover {
	background-color: #f2f2f2;
}

.quesLink {
	text-decoration: none;
	color: blue;
}
</style>
<body>

	<form action="${questionUrl}" method="get" id="addQuestion">
		<input type="button" name="button 1" onclick="addQuestion()"
			value="Add Question" />
	</form>
	<ul id="questions">
		<c:forEach items="${questions}" var="ques" varStatus="ctr">
			<li class="quesTitle"><a class="quesLink"
				href="quesDetail?quesId=${ques.questionId}" target="_blank">${ques.title}</a></li>
		</c:forEach>
	</ul>

	<div style="text-align: center;">
		<%--For displaying Previous link except for the 1st page --%>
		<c:if test="${currentPage != 0}">
			<a class="navigationButton" href="welcome?pageNum=${currentPage - 1}">Previous</a>
		</c:if>

		<%--For displaying Next link --%>
		<c:if test="${currentPage lt noOfPages}">
			<a class="navigationButton" href="welcome?pageNum=${currentPage + 1}">Next</a>
		</c:if>
	</div>

</body>
</html>