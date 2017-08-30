<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>loginfund- create account</title>
<meta name="viewport" content="width=device-width, initial-scale=0.4,user-scalable=yes">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/select2.min.css">
<link rel="stylesheet" type="text/css" href="css/createAccount.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/select2.min.js"></script>
</head>

<body>
<%@include file="bottom-menu.jsp"%>
<div id="createAccount">

	<div class="container">
		<form id="formId" action="" style="margin-top: 180px;">
			<div class="row center">
				<p class="title"><strong><spring:message code="account.title"></spring:message></strong></p>
				<p>
					<spring:message code="account.chooseCountry"></spring:message>:<span style="text-align: left;"> <select
						id="contryId" name="contryId" style="width: 150px;">
							<c:forEach items="${countryList}" var="country">
								<option value="${country.id}">${country.countryDesc_en}</option>
							</c:forEach>
					</select></span>
				</p>
			</div>

			<div class="row info-div">
				<div class="row" style="margin: 5px 10px;height: 30px;">				
					<span id="name_lbl"><spring:message code="account.yourName"></spring:message>:</span><input id="userName"
						name="userName" class="none-border" type="text" maxlength="45">
		   		</div>
				<div class="row" style="margin: 5px 10px;height: 36px;">	
					<span id="company_lbl"><spring:message code="account.company"></spring:message>:</span><input
						id="companyName" name="companyName" class="none-border"
						type="text" maxlength="45">				
				<p style="color: #7c7c7c;margin-top: 0px;font-size: 0.8em"><spring:message code="account.individual"></spring:message></p>
				</div>
				<div class="row" style="margin: 5px 10px;height: 30px;">	
					<span id="tel_lbl"><spring:message code="account.tel"></spring:message>:</span><input id="tel" name="tel"
						class="none-border" type="text" maxlength="20">
				</div>

			</div>

			<div class="row center info-email">
				<div>
					<label id="email_lbl"><spring:message code="login.Email"></spring:message>:</label>
					<input id="email" name="email" class="none-border" type="text" maxlength="45">
				</div>
				<div>
					<label id="code_lbl"></label><label> 
					<input id="code" name="code" class="blue-border" type="text" placeholder="Enter the verification code"></label>	
					<label id="code_lbl1"></label>				
				</div>
				<div>
					<spring:message code="login.Press"></spring:message> <button id="generateBtn" class="btn btn-xs" type="button"><spring:message code="login.generate"></spring:message></button><spring:message code="login.generateCode"></spring:message>
					<p style="margin-bottom: 0">
					<span id="generateMsg" style="visibility:hidden;" class="label label-danger">Please enter your email</span>
					</p>
				</div>
			</div>
			<div class="row center">
				<button id="postBtn" class="btn" type="button" style="font-size: 18px;font-weight: 700;padding: 5px 30px;"><spring:message code="account.finish"></spring:message></button>
				<p><span id="postDiv" style="visibility:hidden;" class="label label-danger"><spring:message code="account.enterInfo"></spring:message></span></p>		
			</div>
		</form>
	</div>
	<!-- /container -->
</div>


	<script type="text/javascript">
	var wait = 60;
		$(document).ready(function() {
				
				$("#postBtn").click(function() {
												$("#generateMsg").css("visibility","hidden");
												$("#postDiv").css("visibility","hidden");
												if ($.trim($("#userName").val()) == ""|| $.trim($("#companyName").val()) == ""|| $.trim($("#tel").val())== "") {													
													$("#postDiv").css("visibility","visible");	
													return;
												}
												if ($.trim($("#code").val()) == "") {
													$("#generateMsg").html("<spring:message code="login.enterCode"></spring:message>");
													$("#generateMsg").removeClass();
													$("#generateMsg").addClass("label label-danger");
													$("#generateMsg").css("visibility","visible");														
													return;
												}
												$("#postBtn").attr("disabled", "disabled");
												$.post("submitCreateAccount",$('#formId').serialize(),
																function(result) {
																	if ("001" == result){
																		$("#generateMsg").html("<spring:message code="login.incorrectCode"></spring:message>");
																		$("#generateMsg").removeClass();
																		$("#generateMsg").addClass("label label-danger");
																		$("#generateMsg").css("visibility","visible");	
																		$("#postBtn").removeAttr("disabled");
																	} else if ("002" == result) {
																		$("#postDiv").css("visibility","visible");	
																		$("#postBtn").removeAttr("disabled");
																	} else if ("003" == result) {
																		window.location.href = "expectation.html";
																		$("#postBtn").removeAttr("disabled");
																	} else if ("000" == result) {
																		$("#postDiv").html("<spring:message code="account.submitSuccessfully"></spring:message>");
																		$("#postDiv").removeClass();
																		$("#postDiv").addClass("label label-success");
																		$("#postDiv").css("visibility","visible");	
																	
																		//window.location.href = "onlinePayment.html";
																	} else if ("004" == result) {
																		window.location.href = "accountInfo";//重复注册
																		$("#postBtn").removeAttr("disabled");
																	} else {
																		$("#postDiv").html("<spring:message code="systemException"></spring:message>");
																		$("#postDiv").css("visibility","visible");	
																		$("#postBtn").removeAttr("disabled");
																	}
																});
											});
							$("#generateBtn").click(function() {
												$("#generateMsg").css("visibility","hidden");
												var email = $("#email").val();
												var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; //验证邮箱的正则表达式
												if (!reg.test(email)) {
													$("#generateMsg").html("<spring:message code="login.enterEmail"></spring:message>");
													$("#generateMsg").removeClass();
													$("#generateMsg").addClass("label label-danger");
													$("#generateMsg").css("visibility","visible");													
													return;
												}
												time($("#generateBtn"));
												$.post("sendEmailCode",{email : $.trim($("#email").val()),type : "reg"},
																function(result) {
																	if ("000" == result) {
																		$("#generateMsg").html("<spring:message code="login.codeSent"></spring:message>");
																		$("#generateMsg").removeClass();
																		$("#generateMsg").addClass("label label-success");
																		$("#generateMsg").css("visibility","visible");
																		//setTimeout(function() {$("#generateMsg").css("visibility","hidden");},3000)
																		
																	} else if ("001" == result) {																		
																		$("#generateMsg").html("<spring:message code="login.hasReg"></spring:message>");
																		$("#generateMsg").removeClass();
																		$("#generateMsg").addClass("label label-danger");
																		$("#generateMsg").css("visibility","visible");
																		wait=0;
																	} else {
																		$("#generateMsg").html("<spring:message code="systemException"></spring:message>");
																		$("#generateMsg").removeClass();
																		$("#generateMsg").addClass("label label-danger");
																		$("#generateMsg").css("visibility","visible");
																		wait=0;
																	}
																});
											});
						});
		window.onload = function() {
		
			
			if($(window).height()-$("body").height()>0)
				$("#createAccount").css("margin-top",($(window).height()-$("body").height())+"px");
			//$('select').select2({
			//	minimumResultsForSearch : Infinity
			//});
			$('input, textarea').placeholder();
			
			$("#userName").width(548 - $("#name_lbl").width() - 20);
			$("#companyName").width(548 - $("#company_lbl").width() - 20);
			$("#tel").width(548 - $("#tel_lbl").width() - 20);
		};

		

		function time(o) {
			if (wait == 0) {
				o.removeAttr("disabled");
				o.text("<spring:message code="login.generate"></spring:message>");
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
	   
</body>
</html>