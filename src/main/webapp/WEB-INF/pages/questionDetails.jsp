<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="header.jsp"%>

<html>
<head>
<link href="<c:url value="/resources/css/jAlert.css" />"
	rel="stylesheet">
<script src="/resources/js/jquery-3.1.1.min.js"></script>
<script src="/resources/js/jAlert.min.js"></script>
<script src="/resources/js/jAlert-functions.min.js"></script>

<script>
	$(document).ready(function() {
		$.jAlert('attach');
	});
	
	function addAnswer(quesId) {
		/* Popup an alert with the form */
		$.jAlert({
			'id' : 'myAlert',
			'content' : '<h4>Add your answer</h4><form action="updateAnswer?${_csrf.parameterName}=${_csrf.token}&quesId=' + quesId + '" method=\'POST\'><textarea class="required" name="answer" placeholder="Type here and click \'Submit\'"></textarea><input type="submit" class="button submitAnsBtn" value="Submit"></form>',
			'autofocus' : 'textarea',
			'size' : 'md'
		});
	}
	
	function updateAnswer(ansId, quesId, counter) {
		/* Popup an alert with the form */
		var answer = document.getElementById("ans-" + counter).innerText;
		$.jAlert({
			'id' : 'myAlert',
			'content' : '<h4>Update your answer</h4><form action="updateAnswer?${_csrf.parameterName}=${_csrf.token}&quesId='+quesId+'&ansId=' + ansId + '" method=\'POST\'><textarea class="required" name="answer">'+answer+'</textarea><input type="submit" class="button submitAnsBtn" value="Submit"></form>',
			'autofocus' : 'textarea',
			'size' : 'md'
		});
	}
	
	function deleteAnswer(quesId,ansId) {
		var url = "deleteAnswer?${_csrf.parameterName}=${_csrf.token}&quesId="+quesId+"&ansId="+ansId;
		$.post(url, function(){
			location.reload();
		});
	}
</script>
</head>

<style>
.tags div {
	background-color: #a9a9a9;
	padding: 10px;
	color: #fff;
	display: inline-block;
	line-height: 11px;
	border-radius: 2px;
	margin-bottom: 5px;
	margin-right: 2px;
	text-decoration: none;
}

.editButton, .deleteButton, .addAnswerButton {
	background-color: #0095ff;
	padding: 10px;
	color: #FFF;
	cursor: pointer;
	display: inline-block;
	line-height: 11px;
	border-radius: 2px;
	margin-bottom: 5px;
}

.addAnswerButton {
	margin-top: 20px;
}

.answerBox:hover {
	background-color: #d9d9d9;
}

#myAlert h4 {
	font-weight: 800;
	margin-top: 0;
}

.submitAnsBtn {
	margin-bottom: 0px;
	position: absolute;
	right: 20px;
	bottom: 8px;
}

textarea {
	height: 150px;
	width: 100%;
}
</style>
<body>
	<div style="margin-left: 50px; margin-right: 50px;">
		<h2 style="margin-top: 40px; border-bottom: 1px solid #e4e6e8;">${question.title}</h2>
		<p style="border-bottom: 1px solid #e4e6e8;">${question.text }</p>
		<div class="tags">
			<c:forEach items="${question.categories}" var="cat" varStatus="ctr">
				<div>${cat.name }</div>
			</c:forEach>
			<h4 style="float: right; color:red;">Posted By: ${question.user.username}</h4>
		</div>

		<div class="addAnswerButton"
			onClick="addAnswer(${question.questionId});">Add Your Answer</div>

		<h2 style="border-bottom: 1px solid #e4e6e8; padding-top: 20px;">Posted
			Answers:</h2>
		<c:forEach items="${question.answers}" var="ans" varStatus="ctr">
			<div class="answerBox">
				<div style="display: table; margin-left: -40px; padding-top: 10px;">
					<div style="display: table-cell; min-width: 40px;">
						<b>${ctr.count}</b>
					</div>
					<div id="ans-${ctr.count }" style="word-wrap: break-word;">${ans.text }</div>
				</div>
				<c:set var="ansText" scope="session" value="${ans.text}" />
				<div
					style="border-bottom: 1px solid #e4e6e8; margin-top: 20px; padding-bottom: 10px;">
					<h4 style="padding-bottom: 10px; display: inline;">Answer by:
						${ans.user.username}</h4>
					<c:if
						test="${pageContext.request.userPrincipal.name == ans.user.username}">
						<div class="editButton"
							onClick="updateAnswer(${ans.answerId},${question.questionId}, ${ctr.count});">Edit</div>
						<div class="deleteButton"
							onClick="deleteAnswer(${question.questionId}, ${ans.answerId});">Delete</div>
					</c:if>
				</div>
			</div>
		</c:forEach>

		<c:if test="${error }">
		alert(${error });
	</c:if>
	</div>
</body>
</html>