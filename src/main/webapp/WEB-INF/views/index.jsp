<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>loginfund-Home</title>
<meta name="viewport" content="width=device-width, initial-scale=0.4,user-scalable=yes">
<meta name="description" content="The portal of seeking Chinese investors">
<meta http-equiv="X-UA-Compatible" content="IE=9">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/select2.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.placeholder.min.js"></script>
<script type="text/javascript" src="js/select2.min.js"></script>
</head>

<body>

<%@include file="bottom-menu-index.jsp"%>
	<div id="index">
	<div class="container" style="width: 900px">
 		
		<div class="row" style="text-align: center;">
			<div class="title"></div>			
		</div>
		<div class="row">			
			<p class="desc"><spring:message code="index.title"></spring:message></p>
		</div>
		<div class="row" style="text-align: center;">
			
		
			<div id="postBtn" class="postBtn">
			<div style="font-size: 22px;color:#fff;padding-top: 10px;padding-left: 38px;"><spring:message code="index.post"></spring:message></div>
			</div>		
			<!--  
			 <button id="postBtn" class="btn btn-index" type="button">SUBMIT YOUR FUNDING REQUIREMENTS</button>-->
		</div>
			<div class="row login-desc">
			<spring:message code="index.already"></spring:message><a href="#myModal" data-toggle="modal"
				class="login"><spring:message code="index.login"></spring:message></a>
		</div>
	
	</div>	
</div>
 
	<!-- /container -->
	<div id="myModal" class="modal fade" data-keyboard="false" data-backdrop="static"
		style="text-align: center;">
		<div class="modal-dialog" style="margin: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<span class="modal-title" id="myModalLabel"><spring:message code="index.typeEmail"></spring:message></span>
				</div>
				<div class="modal-body">
				<!--
					<p>
						<label id="email_lbl">Email:</label><input id="email"
							class="none-border" name="email" type="text" maxlength="45">
					</p>
					<p>
						<label id="code_lbl"></label><label> <input id="code"
							class="blue-border" name="code" type="text"
							placeholder="Enter the verification code" maxlength="6"></label>
						<button id="generat1eBtn" class="btn btn-warning  btn-xs"
							type="button">Generate</button>
					</p>
				<div id="emailDiv" class="alert alert-success"
					style="margin:10px;padding: 0;display:none;" role="alert"><span id="emailMsg">A verification code was sent to your email address</span></div>
				  -->
				
				<div>
				<label id="email_lbl"><spring:message code="login.Email"></spring:message>:</label>
					<input id="email" name="email" class="none-border" type="text" maxlength="45">
				</div>
				<div>
					<label id="code_lbl"></label>
					<input id="code" name="code" class="blue-border" style="width: 250px" type="text" placeholder="<spring:message code="login.enterCode2"></spring:message>" maxlength="6">
					<label style="width: 10px;" ></label>	
				</div>
				<div>
					<spring:message code="login.Press"></spring:message> <button id="generateBtn" class="btn btn-xs" type="button" style="padding-left: 0px;padding-right: 0px;"><spring:message code="login.generate"></spring:message></button> <spring:message code="login.generateCode"></spring:message>
					<p style="margin-bottom: 0">
					<span id="generateMsg" style="visibility:hidden;" class="label label-danger">Please enter your email</span>
					</p>
				</div>
				
				
				
				
				</div>

				<div class="modal-footer">

					<button id="loginBtn" class="btn btn-large btn-warning"
						type="button"><spring:message code="index.login"></spring:message></button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->


	<script type="text/javascript">
	
	var wait=60;
	function time(o) {
	        if (wait == 0) {
	            o.removeAttr("disabled");           
	            o.text( "<spring:message code="login.generate"></spring:message>");
	            wait = 60;
	        } else {
	            o.attr("disabled", "disabled");
	            o.text( wait+"s");
	            wait--;
	            setTimeout(function() {
	                time(o)
	            },
	            1000)
	        }
	    }
	
	$(document).ready(function() {
	$("#generateBtn").click(function() {
		$("#generateMsg").css("visibility","hidden");
		var email=$("#email").val();
		var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; //验证邮箱的正则表达式
		if(!reg.test(email))
		{
			$("#generateMsg").html("<spring:message code="login.enterEmail"></spring:message>");
			$("#generateMsg").removeClass();
			$("#generateMsg").addClass("label label-danger");
			$("#generateMsg").css("visibility","visible");			
			return;
		}
		time($("#generateBtn"));
		$.post("sendEmailCode", {
			email : $("#email").val(),
			type:"login"
		}, function(result) {
			if ("000" == result) {
				$("#generateMsg").html("<spring:message code="login.codeSent"></spring:message>");
				$("#generateMsg").removeClass();
				$("#generateMsg").addClass("label label-success");
				$("#generateMsg").css("visibility","visible");	
				
				
			}else if ("001" == result) {
				$("#generateMsg").html("<spring:message code="login.notReg"></spring:message>");
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
	
	$("#loginBtn").click(function() {
		$("#generateMsg").css("visibility","hidden");
		if($("#code").val()==""){
			$("#generateMsg").html("<spring:message code="login.enterCode"></spring:message>");
			$("#generateMsg").removeClass();
			$("#generateMsg").addClass("label label-danger");
			$("#generateMsg").css("visibility","visible");			
			return;
		}		
		$.post("login",{
			code : $("#code").val()			
		}, function(result) {				
			if ("001" == result) {
				$("#generateMsg").html("<spring:message code="login.incorrectCode"></spring:message>");
				$("#generateMsg").removeClass();
				$("#generateMsg").addClass("label label-danger");
				$("#generateMsg").css("visibility","visible");	
			}else if("000"==result){				
				window.location.href = "accountInfo";
			}else{
				$("#generateMsg").html("<spring:message code="systemException"></spring:message>");
				$("#generateMsg").removeClass();
				$("#generateMsg").addClass("label label-danger");
				$("#generateMsg").css("visibility","visible");		
				
			}
		});				
	});
});
	
	
		window.onload = function() {
			
				if($(window).height()-$("body").height()>0)
					$("#index").css("margin-top",($(window).height()-$("body").height())+"px");
			
			$("#postBtn").click(function() {
				window.location.href = "expectation.html";
			});
			$("#myModal").on("show.bs.modal", function(e) {
				
				//设置弹出框垂直位置及宽度
				$(this).find('.modal-content').css("margin-top", 100);
				$(this).find('.modal-dialog').css("width", 400);
				//根据弹出框宽度计算水平位置
				//$(this).find('.modal-content').css("margin-left", ($(window).width() - 400) / 2 + 'px');
			});

			$('input, textarea').placeholder();
		};

	</script>
</body>
</html>