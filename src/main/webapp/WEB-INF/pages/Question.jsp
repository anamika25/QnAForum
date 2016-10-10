<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="header.jsp"%>
<html>

<head>
<title>Add Question</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<link href="<c:url value="/resources/css/homepage.css" />"
	rel="stylesheet">
<script type="text/javascript" src="/resources/js/jquery-3.1.1.min.js"></script>

<script>
	function add_text(text) {
		var TheTextBox = document.getElementById("textbox");
		TheTextBox.value = TheTextBox.value + text;
	}

	function Add() {
		var name1 = document.createElement("select");
		name1.setAttribute('id', "year1")
		name1.setAttribute('oncreate', "Date1()");
	}

	function Date1() {
		d = new Date();
		curr_year = d.getFullYear();
		for (i = 0; i < 5; i++) {
			document.getElementById('year1').options[i] = new Option(
					(curr_year - 1) - i, (curr_year - 1) - i);
		}
	}
</script>
</head>

<body>
	<form class="form-horizontal"
		action="<c:url value='/Add_Question/create?${_csrf.parameterName}=${_csrf.token}' />"
		method='POST' style="margin-top: 20px">
		<fieldset>
			<!-- Form Name -->
			<legend style="text-align: center;">Add a Question</legend>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="textinput">Title</label>
				<div class="col-md-4">
					<input id="textinput" name="title" type="text" placeholder="Title"
						class="form-control input-md">
				</div>
			</div>

			<!-- Textarea -->
			<div class="form-group" style="height: 100px;">
				<label class="col-md-4 control-label" for="textarea">Detailed
					description</label>
				<div class="col-md-4">
					<textarea class="form-control" id="textarea"
						placeholder="Describe in detail" name="text" style="height: 100px;"></textarea>
				</div>
			</div>

			<!-- Select Multiple -->
			<div class="form-group" style="height: 150px;">
				<label class="col-md-4 control-label" for="selectmultiple">Tags</label>
				<div class="col-md-4">
					<select id="selectmultiple" name="categories" class="form-control"
						multiple="multiple" style="height: 150px;">
						<c:forEach items="${category_list}" var="category" varStatus="ctr">
							<option id="${category.categoryId}"
								value="${category.categoryId}">${category.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<!-- Button -->
			<div class="form-group">
				<label class="col-md-4 control-label" for="singlebutton"></label>
				<div class="col-md-4">
					<button type="submit" value="submit" id="singlebutton"
						name="singlebutton" class="btn btn-primary">Submit</button>
				</div>
			</div>

		</fieldset>
	</form>

	<%-- <form name='QuestionForm'
		action="<c:url value='/Add_Question/create?${_csrf.parameterName}=${_csrf.token}' />"
		method='POST'>
		<select multiple="true" name="categories" class="form-control">
			<c:forEach items="${category_list}" var="category" varStatus="ctr">
				<option id="${category.categoryId}" value="${category.categoryId}">${category.name}</option>
			</c:forEach>
		</select> <label for="question_create">Write your Question here:</label><br>
		<textarea name="title" class="title" rows="1" id="title"></textarea>
		<br> <br>
		<textarea name="text" class="text" rows="5" id="text"></textarea>
		<br> <br>
		<button type="submit" value="submit" class="btn btn-success">Submit</button>
	</form> --%>

</body>
</html>