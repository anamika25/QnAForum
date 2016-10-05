<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="header.jsp"%>

<html>
<style>
.tags div {
	background-color: #756f5d;
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
</style>
<body>
	<div style="margin-left: 50px; margin-right: 50px;">
		<h2 style="margin-top: 40px; border-bottom: 1px solid #e4e6e8;">${question.title}</h2>
		<p style="border-bottom: 1px solid #e4e6e8;">${question.text }</p>
		<div class="tags">
			<c:forEach items="${question.categories}" var="cat" varStatus="ctr">
				<div>${cat.name }</div>
			</c:forEach>
			<h4 style="float: right;">Posted By: ${question.user.username}</h4>
		</div>

		<div class="addAnswerButton">Add Your Answer</div>

		<h2 style="border-bottom: 1px solid #e4e6e8; padding-top: 20px;">Posted
			Answers:</h2>
		<c:forEach items="${question.answers}" var="ans" varStatus="ctr">
			<div class="answerBox">
				<div style="display: table; margin-left: -40px; padding-top: 10px;">
					<div style="display: table-cell; min-width: 40px;">
						<b>${ctr.count}</b>
					</div>
					<div style="word-wrap: break-word;">${ans.text }</div>
				</div>
				<div
					style="border-bottom: 1px solid #e4e6e8; margin-top: 20px; padding-bottom: 10px;">
					<h4 style="padding-bottom: 10px; display: inline;">Answer by:
						${ans.user.username}</h4>
					<c:if
						test="${pageContext.request.userPrincipal.name == ans.user.username}">
						<div class="editButton">Edit</div>
						<div class="deleteButton">Delete</div>
					</c:if>
				</div>
			</div>
		</c:forEach>

	</div>
</body>
</html>