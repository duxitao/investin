<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>loginfund-account info</title>
<meta name="viewport" content="width=device-width, initial-scale=0.4,user-scalable=yes">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/select2.min.css">
<link rel="stylesheet" type="text/css" href="css/accountInfo.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.placeholder.min.js"></script>
	<script type="text/javascript" src="js/select2.min.js"></script>
</head>

<body>


 <%@include file="bottom-menu.jsp"%>
<div id="accountInfo_1">

	<div id="container" class="container" >
		<div class="row center" style="margin-top: 200px">
			<c:if test="${account.pay_status=='0'}">
				<div class="alert tips" role="alert"><strong><spring:message code="accountInfo.status_notpay"></spring:message></strong></div>
			</c:if>
			<c:if test="${account.pay_status=='1' or account.pay_status=='2' }">
				<div class="alert tips" role="alert"><strong><spring:message code="accountInfo.status_haspay"></spring:message></strong></div>
			</c:if>
		</div>

		<div class="row">
			<h4>
				<span class="label label-title"><spring:message code="accountInfo.myAccount"></spring:message></span>
			</h4>
		</div>

		<div class="row">
			<dl>
				<dt><spring:message code="accountInfo.country"></spring:message>:</dt>
				<dd>${account.countryDesc_en }</dd>
				<dt><spring:message code="accountInfo.institute"></spring:message>:</dt>
				<dd>${account.userName }</dd>
				<dt><spring:message code="accountInfo.institute"></spring:message>:</dt>
				<dd>${account.companyName }</dd>
				<dt><spring:message code="accountInfo.tel"></spring:message>:</dt>
				<dd>${account.tel }</dd>
				<dt><spring:message code="accountInfo.email"></spring:message>:</dt>
				<dd>${account.email }</dd>
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
				<dd>${info.scaleDesc_en }</dd>
				<dt><spring:message code="accountInfo.field"></spring:message>:</dt>
				<dd>${info.fieldDesc_en }</dd>
			</dl>
		</div>
		<div class="row" style="text-align: right;">		
			<img id="edit" alt="edit" src="images/eidt.jpg" style="cursor:pointer;">
		</div>
		
		<c:if test="${account.pay_status=='1' or account.pay_status=='2'}">
			<div class="row center">
				<button id="creatBtn" class="btn" style="font-size: 18px;font-weight: 700;padding: 5px 30px;"
					type="button"><spring:message code="accountInfo.generateCode"></spring:message></button>					
					<span style="color:#0066cc;font-size: 16px; " id="creditCode"></span>
			</div>

			<div class="row center" style="width: 570px;margin-left: auto;margin-right: auto;">
				<spring:message code="accountInfo.codeDesc"></spring:message>
			</div>
		</c:if>
	</div>
	<!-- /container -->
	<c:if test="${account.pay_status=='0'}">
	<div id="gotoPay" class="container-fluid navbar-fixed-bottom" style="padding:20px 0; color:black; background:rgba(0, 0, 0, 0.6)!important;filter:Alpha(opacity=60); background:#000;text-align: center;">
			
			<div class="row center">
				<button id="presentBtn" class="btn" style="font-size: 18px;font-weight: 700;padding: 5px 30px;"
					type="button"><spring:message code="accountInfo.goToPay"></spring:message></button><span style="color: white;margin-left: 10px;"><spring:message code="accountInfo.access"></spring:message></span>
			</div>
		
	</div>
	
	</c:if>
</div>
<div id="accountInfo_3">
</div>
<div id="accountInfo_2">
</div>
	<script type="text/javascript">
		$(document).ready(function() {
			/* $("body").css("padding-bottom",$("#gotoPay").height()+20);*/
			$("#presentBtn").click(function() {
				window.location.href = "onlinePayment"; 
			});
			$("#creatBtn").click(function() {
				$.post("getCreditCode", null, function(result) {
					if ("-1" == result) {
						//生成失败
						$("#creditCode").html("create code error!");						
					}else
						{
						if(result.substring(0,3)=='new')
							{
							$("#creditCode").html(result.substring(3));		
							}
						else
							{
							$("#creditCode").html(result.substring(3)+" <spring:message code="accountInfo.codeNotUsed"></spring:message>");		
							}
						}
						
				});
			});
			
			
			$("#edit").click(function() {
				window.location.href = "editAccountInfo"; 
			});
			
			
			
			$(window).scroll(function(){  
			         var $this =$(this),  
			         viewH =$(this).height(),//可见高度  
			         contentH =$(this).get(0).scrollHeight,//内容高度  
			         scrollTop =$(this).scrollTop();//滚动高度  
			 
			         
			 });
			
		});
		window.onload = function() {
			$("#accountInfo_3").height($("#container").height()-$("#accountInfo_1").height()+20);
			//$("#accountInfo_1").css("margin-top",($(window).height()-$("body").height())+"px");
			if($(window).height()-$("#accountInfo_1").height()-$("#accountInfo_2").height()-$("#accountInfo_3").height()-66>0)
				$("#accountInfo_1").css("margin-top",($(window).height()-$("#accountInfo_1").height()-$("#accountInfo_2").height()-$("#accountInfo_3").height()-66)+"px");
			//$('select').select2({
			//	minimumResultsForSearch : Infinity
			//});
			//container的高度会超出accountInfo_1，超出部分由accountInfo_3补充，container的高度-accountInfo_1的高度=超出部分
		
			$('input, textarea').placeholder();
			$("#name").width(548 - $("#name_lbl").width() - 5);
			$("#company").width(548 - $("#company_lbl").width() - 5);
			$("#tel").width(548 - $("#tel_lbl").width() - 5);
		};
	</script>

</body>
</html>