<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<body>
	<div class="modal-header" style="text-align: center;">
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
		</button>
		<span class="modal-title" id="myModalLabel"><spring:message code="contact.fillBlanks"></spring:message></span>
	</div>
	<div id="contact_body" class="modal-body"
		style="overflow-y: auto; text-align: left;">
		<form id="contactForm">
			<div class="row">
				<p>
					<label id="contry_lbl"
						style="width: 5.5em; text-align: right; font-weight: normal;"><spring:message code="contact.country"></spring:message>:</label><span
						style="text-align: left;"> <select id="contact_countryId"
						name="countryId" style="width: auto; padding-left: 0;text-align: left;">
							<c:forEach items="${countryList}" var="country">							
								<option value="${country.id}" <c:if test="${account.contryId==country.id}">selected="selected"</c:if> >${country.countryDesc_en}</option>
							</c:forEach>
					</select></span>
				</p>
				<p>
					<label id="subject_lbl"
						style="width: 5.5em; text-align: right; font-weight: normal;"><spring:message code="contact.subject"></spring:message>:</label><input
						id="contact_subject" name="subject" class="none-border"
						type="text" maxlength="100" style="width: auto;">
				</p>
				<p>
					<label id="message_lbl"
						style="width: 5.5em; text-align: right; font-weight: normal; vertical-align: top;"><spring:message code="contact.message"></spring:message>:</label>
					<textarea id="contact_message" name="message"
						maxlength="200" rows="5"></textarea>

				</p>
				<p>
					<label id="name_lbl"
						style="width: 5.5em; text-align: right; font-weight: normal;"><spring:message code="contact.name"></spring:message>:</label><input
						id="contact_name" name="name" class="none-border" <c:if test="${nul!= account }">readonly="readonly"</c:if> 
						type="text" maxlength="50" value="${account.userName }">
				</p>
				<p>
					<label id="tel_lbl"
						style="width: 5.5em; text-align: right; font-weight: normal;"><spring:message code="contact.tel"></spring:message>:</label><input id="contact_tel" name="tel" <c:if test="${nul!= account }">readonly="readonly"</c:if> 
						class="none-border" type="text" maxlength="20" value="${account.tel }">
				</p>
				<p>
					<label id="contact_email_lbl"
						style="width: 5.5em; text-align: right; font-weight: normal;"><spring:message code="contact.email"></spring:message>:</label><input id="contact_email" name="email" <c:if test="${nul!= account }">readonly="readonly"</c:if> 
						class="none-border" type="text" maxlength="45" value="${account.email }">
				</p>
				
				<c:if test="${null== account }">
				<p>
					<label id="contact_email_lbl"
						style="width: 5.5em; text-align: right; font-weight: normal;"></label><input
						style="width: 250px" id="contact_code"
						placeholder="<spring:message code="login.enterCode2"></spring:message>" name="code"
						class="" type="text" maxlength="6">
				</p>

				
				<p style="padding-left: 15px">
					<spring:message code="login.Press"></spring:message>
					<button id="contact_generateBtn" class="btn btn-xs" type="button"><spring:message code="login.generate"></spring:message></button>
					<spring:message code="login.generateCode"></spring:message>
				</p>
								<p style="text-align: center;">
					<span id="contact_tips" style="visibility: hidden;"
						class="label label-danger">Please enter account information</span>
				</p>
				</c:if>
				<c:if test="${null== account }">
				<input name="type" id="type" type="hidden" value="0"/>
				</c:if>
				<c:if test="${null!= account }">
				<input name="type" id="type" type="hidden" value="1"/>
				</c:if>
				
				<p style="text-align: center;">
					<button id=contact_submit class="btn" type="button"><spring:message code="contact.submit"></spring:message></button>
				</p>

				<p style="text-align: center;">
					<span id="submit_tips" style="visibility: hidden;"
						class="label label-danger"><spring:message code="contact.fillBlanks"></spring:message></span>
				</p>

			</div>
		</form>
	</div>
	
</body>
<script type="text/javascript">
	var wait = 60;
	var w = ${w} -82.5;	
	$("#contact_countryId").width(w);
	$("#contact_subject").width(w);
	$("#contact_message").width(w - 5);
	$("#contact_name").width(w);
	$("#contact_tel").width(w);
	$("#contact_email").width(w);
	$('input, textarea').placeholder();
	
	$("#contact_generateBtn").click(function() {
		$("#contact_tips").css("visibility","hidden");
		var email = $("#contact_email").val();
		var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; //验证邮箱的正则表达式
		if (!reg.test(email)) {
			$("#contact_tips").html("<spring:message code="login.enterEmail"></spring:message>");
			$("#contact_tips").removeClass();
			$("#contact_tips").addClass("label label-danger");
			$("#contact_tips").css("visibility","visible");													
			return;
		}
		time($("#contact_generateBtn"));
		$.post("sendEmailCode",{email : $.trim($("#contact_email").val()),type : "0"},
						function(result) {
							if ("000" == result) {
								$("#contact_tips").html("<spring:message code="login.codeSent"></spring:message>");
								$("#contact_tips").removeClass();
								$("#contact_tips").addClass("label label-success");
								$("#contact_tips").css("visibility","visible");
								//setTimeout(function() {$("#generateMsg").css("visibility","hidden");},3000)
								
							} else {
								$("#contact_tips").html("<spring:message code="systemException"></spring:message>");
								$("#contact_tips").removeClass();
								$("#contact_tips").addClass("label label-danger");
								$("#contact_tips").css("visibility","visible");
								wait=0;
							}
						});
	});
	
	$("#contact_submit").click(function() {
		$("#submit_tips").css("visibility","hidden");
		$("#contact_tips").css("visibility","hidden");
		if ($.trim($("#contact_subject").val()) == ""|| $.trim($("#contact_message").val()) == ""|| $.trim($("#contact_name").val())== ""|| $.trim($("#contact_tel").val())== ""|| $.trim($("#contact_email").val())== "") {													
			$("#submit_tips").css("visibility","visible");	
			return;
		}
		if ($.trim($("#contact_code").val()) == ""&&$("#type").val()=='0') {
			$("#contact_tips").html("<spring:message code="login.enterCode"></spring:message>");
			$("#contact_tips").removeClass();
			$("#contact_tips").addClass("label label-danger");
			$("#contact_tips").css("visibility","visible");														
			return;
		}
		$("#contact_submit").attr("disabled", "disabled");
		$.post("addContactInfo",$('#contactForm').serialize(),
						function(result) {
							if ("001" == result){
								$("#contact_tips").html("<spring:message code="login.incorrectCode"></spring:message>");
								$("#contact_tips").removeClass();
								$("#contact_tips").addClass("label label-danger");
								$("#contact_tips").css("visibility","visible");	
								
								$("#contact_submit").removeAttr("disabled");
							} else if ("000" == result) {
								$("#submit_tips").html("<spring:message code="contact.contact"></spring:message>");
								$("#submit_tips").removeClass();
								$("#submit_tips").addClass("label label-success");
								$("#submit_tips").css("visibility","visible");								
															
								
							}  else {
								$("#submit_tips").html("<spring:message code="systemException"></spring:message>");
								$("#submit_tips").removeClass();
								$("#submit_tips").addClass("label label-danger");
								$("#submit_tips").css("visibility","visible");	
								
								$("#contact_submit").removeAttr("disabled");
							}
						});
	});

	function time(o) {
		if (wait == 0) {
			o.removeAttr("disabled");
			o.text("Generate");
			wait = 60;
		} else {
			o.attr("disabled", "disabled");
			o.text(wait + "s");
			wait--;
			setTimeout(function() {
				time(o)
			}, 1000)
		}
	}
</script>
</html>
