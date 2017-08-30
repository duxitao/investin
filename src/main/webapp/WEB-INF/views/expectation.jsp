<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>loginfund-expectation</title>
<meta name="viewport" content="width=device-width, initial-scale=0.4,user-scalable=yes">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/expectation.css">
<link rel="stylesheet" type="text/css" href="css/select2.min.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="js/select2.min.js"></script>
</head>

<body>
	<%@include file="bottom-menu.jsp"%>
	<div id="expectation" >

	<div class="container" > 
		
		<form id="formId" action="createAccount" method="post" style="margin-top: 180px;">
			<div class="row">
				<p id="project_name">
					<span id="title_lbl"><strong><spring:message code="expectation.projectName"></spring:message>:</strong></span><input id="title_en"
						name="title_en" class="title-input none-border" type="text"
						placeholder="<spring:message code="expectation.projectwrite"></spring:message>" maxlength="200">
				</p>

				<p>
					<span><strong><spring:message code="expectation.description"></spring:message>:</strong></span><br>
					<textarea id="description_en" name="description_en" maxlength="2000"
						class="description-textarea" rows="8"
						placeholder="<spring:message code="expectation.descriptionDetail"></spring:message>"></textarea>
				</p>				
				<p id="a" >
					<span style="margin-right: 5px;"><strong><spring:message code="expectation.chooseScale"></spring:message>:</strong></span>
					<select	id="scaleId" name="scaleId" style="width: 200px;">
						<c:forEach items="${scaleList}" var="scale">
							<option value="${scale.id}">${scale.scaleDesc_en}</option>
						</c:forEach>
					</select>
				</p>
				<p id="b">
					<span style="margin-right: 5px;"><strong><spring:message code="expectation.chooseField"></spring:message>:</strong></span><select class="selectpicker"
						id="fieldId" name="fieldId" style="width: 328px;">
						<c:forEach items="${fieldList}" var="field">
							<option value="${field.id}">${field.fieldDesc_en}</option>
						</c:forEach>
					</select>
				</p>
			</div>
			<div class="row center">
				<p><span id="msg" style="visibility:hidden;" class="label label-danger"><spring:message code="expectation.notwrite"></spring:message></span>	</p>
				<button id="postBtn" class="btn" style="font-weight: 700; padding: 5px 30px;font-size: 18px;"  type="button"><spring:message code="expectation.submit"></spring:message></button>
			</div>
		</form>
	</div>
	</div>
	<!-- /container -->


 	

	<script type="text/javascript">
		$(document).ready(function() {
			//调整Project Name输入框宽度			
			$("#title_en").css("width", $("#project_name").width()-$("#title_lbl").width()-6);
			
			//调整第二排choose的宽度		
			var firstLength=$("#a span").width()+5+200;				
			$("#b select").css("width", firstLength-$("#b span").width());
			
			
			$("#postBtn").click(function() {
				if ($.trim($("#title_en").val()) == ""|| $.trim($("#description_en").val()) == "") {
					$('#msg').show();
					$("#msg").css("visibility","visible");	
					return;
				}
				$("#msg").css("visibility","hidden");
				$("#formId").submit();		
				
			});
			$('input, textarea').placeholder();
			$("#title").width(548 - $("#title_lbl").width() - 5);
			});
		window.onload = function() {	
			if($(window).height()-$("body").height()>0)
			$("#expectation").css("margin-top",($(window).height()-$("body").height())+"px");
			//$("#formId").css("margin-top","300px");
			//$('select').select2({
			//	minimumResultsForSearch : Infinity
			//});		
		};
	</script>

</body>
</html>