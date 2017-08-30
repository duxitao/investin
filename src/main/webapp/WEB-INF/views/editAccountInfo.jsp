<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>loginfund-edit account</title>
<meta name="viewport" content="width=device-width, initial-scale=0.4,user-scalable=yes">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/select2.min.css">
<link rel="stylesheet" type="text/css" href="css/accountInfo.css">

	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="js/select2.min.js"></script>
</head>
 <%@include file="bottom-menu.jsp"%>
<div id="accountInfo_1">

	<div id="container" class="container">

		<div class="row" style="margin-top: 200px">
			<h4>
				<span class="label label-title"><spring:message code="accountInfo.myAccount"></spring:message></span>
			</h4>
		</div>

		<div class="row">
			<dl>
				<dt><spring:message code="accountInfo.Country"></spring:message>:</dt>
				<dd>${account.countryDesc_en }</dd>
				<dt><spring:message code="accountInfo.institute"></spring:message>:</dt>
				<dd>${account.userName }</dd>
				<dt><spring:message code="accountInfo.institute"></spring:message>:</dt>
				<dd>${account.companyName }</dd>
				<dt><spring:message code="accountInfo.tel"></spring:message>:</dt>
				<dd><span id="tel_text">${account.tel } </span><input  id="input_tel" name="input_tel" style="width: 100px;display: none;" value="${account.tel }" maxlength="45"/><a id="edit_tel" style="margin-left: 10px;" href="###">Edit</a><a id="done_tel" style="margin-left: 10px;display: none;" href="###">Done</a></dd> 
				<dt><spring:message code="accountInfo.email"></spring:message>:</dt>
				<dd><span id="email_text">${account.email }</span> <a id="edit_email"  href="#myModal" data-toggle="modal">Edit</a></dd>
			</dl>
		</div>

		<div class="row">
			<h4>
				<span class="label label-title"><spring:message code="accountInfo.myExpectation"></spring:message></span>
			</h4>
		</div>

		<div class="row">
			<dl>
				<dt><spring:message code="accountInfo.projectName"></spring:message>:</dt>
				<dd>${info.title_en }</dd>
				<dt><spring:message code="accountInfo.description"></spring:message>:</dt>
				<dd>${info.description_en }</dd>
				<dt><spring:message code="accountInfo.scale"></spring:message>:</dt>
				<dd>
				<span id="scale_text">${info.scaleDesc_en } </span>
				<span id="input_scale" style="display: none;">
				<select	id="select_scale">
						<c:forEach items="${scaleList}" var="scale">
							<option value="${scale.id}">${scale.scaleDesc_en}</option>
						</c:forEach>
				</select>
				</span>

				<a id="edit_scale" href="###">Edit</a>
				<a id="done_scale" href="###" style="display: none;">Done</a></dd>
				<dt><spring:message code="accountInfo.field"></spring:message>:</dt>
				<dd>${info.fieldDesc_en } </dd>
			</dl>
		</div>

<form action="">
			<input name="account_id" id="account_id" type="hidden" value="${account.id}">
			<input name="info_id" id="info_id" type="hidden" value="${info.id}">
			<input name="old_tel" id="old_tel" type="hidden" value="${account.tel}">
			<input name="tel" id="tel" type="hidden" value="">
			
			<input name="old_scaleId" id="old_scaleId" type="hidden" value="${info.scaleId}">
			<input name="scaleId" id="scaleId" type="hidden" value="">
			
			<input name="old_email" id="old_email" type="hidden" value="${account.email } ">
			<input name="email" id="email" type="hidden" value="">
			
			<div class="row margin-top-50 center">
				<button id="finishtBtn" class="btn" style="font-size: 18px;font-weight: 700;padding: 5px 30px;"
					type="button"><spring:message code="accountInfo.finish"></spring:message></button>
			</div>
			<div class="row center">
				<span id="msg" style="visibility:hidden;margin-bottom: 3px;" class="label label-danger"><spring:message code="accountInfo.approval"></spring:message></span>
			</div>
</form>





	</div>
	</div>
<div id="accountInfo_3">
</div>
<div id="accountInfo_2"></div>
	<!-- /container -->
	
		<!-- /container -->
	<div id="myModal" class="modal fade" data-keyboard="false" data-backdrop="static"
		style="text-align: center;">
		<div class="modal-dialog" style="margin: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<span class="modal-title" id="myModalLabel"><spring:message code="editAccountInfo.typeEmail"></spring:message></span>
				</div>
				<div class="modal-body">
				
				<div>
					<label id="email_lbl"><spring:message code="login.Email"></spring:message>:</label>
					<input id="input_email" name="input_email" class="none-border" type="text" maxlength="45">
				</div>
				<div>
					<label id="code_lbl"></label><label> 
					<input id="code" name="code" class="blue-border" type="text" placeholder="<spring:message code="login.enterCode2"></spring:message>"></label>	
					<label id="code_lbl1"></label>				
				</div>
				<div>
					<spring:message code="login.Press"></spring:message>  <button id="generateBtn" class="btn btn-xs" type="button" style="padding-left: 0px;padding-right: 0px;"><spring:message code="login.generate"></spring:message></button> <spring:message code="login.generateCode"></spring:message>
					<p style="margin-bottom: 0">
					<span id="generateMsg" style="visibility:hidden;" class="label label-danger">Please enter your email</span>
					</p>
				</div>
				</div>
				

				<div class="modal-footer" style="text-align: center;">

					<button id="DoneBtn" class="btn btn-large btn-warning"
						type="button">Done</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<script type="text/javascript">
	var wait = 60;
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
		$(document).ready(function() {
			$("#input_scale").hide();
			$("#edit_tel").click(function() {
				$("#edit_tel").hide();
				$("#tel_text").hide();
				$("#done_tel").show();
				$("#input_tel").show();
			});
			$("#done_tel").click(function() {
				$("#tel_text").show();
				$("#edit_tel").show();				
				$("#done_tel").hide();
				$("#input_tel").hide();
				
				
				$("#tel_text").html($("#input_tel").val());
				$("#tel").val($("#input_tel").val());				
			});
			

			$("#edit_scale").click(function() {
				$("#edit_scale").hide();
				$("#scale_text").hide();
				$("#done_scale").show();
				$("#input_scale").show();
				//var text=$("#scale_text").html();
				//$("#select_scale option[text='"+text+"']").attr("selected",true);
				$("#select_scale").attr("value","2");
				//修改select长度
				$("span[dir='ltr']").width(200);
				});
			$("#done_scale").click(function() {
				$("#edit_scale").show();
				$("#scale_text").show();
				$("#done_scale").hide();
				$("#input_scale").hide();
				
				
				$("#scale_text").html($("#select_scale").find('option:selected').text());
				$("#scaleId").val($("#select_scale").val());
				});
			
			$("#finishtBtn").click(function(){
				//判断有无修改				
				var tel=$.trim($("#tel").val());
				var scaleId=$.trim($("#scaleId").val());
				var email=$.trim($("#email").val());
				var account_id=$.trim($("#account_id").val());
				var info_id=$.trim($("#info_id").val());
				if(""==tel&&""==scaleId&&""==email){				
					window.location.href = "accountInfo";
					return;
				}
				var old_tel=$.trim($("#old_tel").val());
				var old_scaleId=$.trim($("#old_scaleId").val());
				var old_email=$.trim($("#old_email").val());
				var count=0;
				if(old_tel!=tel&&tel!=""){				
					count=count+1;
				}
				if(old_scaleId!=scaleId&&scaleId!=""){				
					count=count+1;
				}				
				if(old_email!=email&&email!=""){
					count=count+1;
				}
				if(count==0){
					window.location.href = "accountInfo";
					return;
				}
			
				$("#msg").css("visibility","hidden");
				$.post("updateAccountAndInfo",{
					tel :tel,
					scaleId : scaleId,
					email:email,
					account_id:account_id,
					info_id:info_id
				}, function(result) {					
					if ("000" == result) {
						window.location.href = "accountInfo";
					}else if("004"==result){						
						$("#msg").html("<spring:message code="login.hasReg"></spring:message>");
						$("#msg").css("visibility","visible");	
					}else{					
						$("#msg").html("system exception");
						$("#msg").css("visibility","visible");	
					}
				});
			
				
			});
			
			$("#DoneBtn").click(function(){
				$("#generateMsg").css("visibility","hidden");
				$.post("checkCode",{
					code : $("#code").val(),
					email : $("#input_email").val()		
				}, function(result) {				
					if ("001" == result) {
						$("#generateMsg").html("<spring:message code="login.incorrectCode"></spring:message>");
						$("#generateMsg").removeClass();
						$("#generateMsg").addClass("label label-danger");
						$("#generateMsg").css("visibility","visible");		
					}else if("000"==result){						
						$("#email_text").html($("#input_email").val());						
						$("#email").val($("#input_email").val());
						$('#myModal').modal('hide');
					}else{					
						$("#generateMsg").html("<spring:message code="systemException"></spring:message>");
						$("#generateMsg").removeClass();
						$("#generateMsg").addClass("label label-danger");
						$("#generateMsg").css("visibility","visible");		
					}
				});	
				
			});
			
			
			$("#generateBtn").click(function() {
				$("#generateMsg").css("visibility","hidden");
				var email=$("#input_email").val();
				var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; //验证邮箱的正则表达式
				if(!reg.test(email))				{
					$("#generateMsg").html("<spring:message code="login.enterEmail"></spring:message>");
					$("#generateMsg").removeClass();
					$("#generateMsg").addClass("label label-danger");
					$("#generateMsg").css("visibility","visible");				
					return;
				}
				time($("#generateBtn"));
				$.post("sendEmailCode", {
					email : $("#input_email").val(),
					type:"edit"
				}, function(result) {
					if ("000" == result) {
						$("#generateMsg").html("<spring:message code="login.codeSent"></spring:message>");
						$("#generateMsg").removeClass();
						$("#generateMsg").addClass("label label-success");
						$("#generateMsg").css("visibility","visible");							
						
					}else {
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
			$("#accountInfo_3").height($("#container").height()-$("#accountInfo_1").height()+20);
			if($(window).height()-$("#accountInfo_1").height()-$("#accountInfo_2").height()-$("#accountInfo_3").height()-66>0)
				$("#accountInfo_1").css("margin-top",($(window).height()-$("#accountInfo_1").height()-$("#accountInfo_2").height()-$("#accountInfo_3").height()-66)+"px");
			
			$('input, textarea').placeholder();
			$("#myModal").on("show.bs.modal", function(e) {
				
				//设置弹出框垂直位置及宽度
				$(this).find('.modal-content').css("margin-top", 100);
				$(this).find('.modal-dialog').css("width", 400);
				//根据弹出框宽度计算水平位置
				//$(this).find('.modal-content').css("margin-left", ($(window).width() - 400) / 2 + 'px');
			});
			
			//$('select').select2({
			//	minimumResultsForSearch : Infinity
			//});
		};
	</script>
</body>
</html>