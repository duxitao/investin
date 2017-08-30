<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="en">
<head>
<meta charset="utf-8">
<title>loginfund-onlinePayment</title>
<meta name="viewport" content="width=device-width, initial-scale=0.4,user-scalable=yes">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/onlinePayment.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.placeholder.min.js"></script>


</head>

<body>
		

<div id="onlinePayment">
				<div class="container-fluid" style="padding:8px 0; color:#fff; background:rgb(255, 102, 0);text-align: center;width:100%;">
				<spring:message code="onlinePayment.membership"></spring:message>
				</div>				
		<%@include file="bottom-menu.jsp"%>
	<div class="container" style="margin-top: 20px;">
		
			<div class="row">
				<span style="font-size: 18px; font-weight: 800; margin-right: 10px;"><spring:message code="onlinePayment.onlinePayment"></spring:message></span><img style="height: 20px; width: auto;" alt="PayPal"
					src="images/PayPal.png">
				<hr style="margin-top: 5px">
				<div class="form-group-lg">
					<div class="radio">
						<label> <input type="radio" name="option_amount"
							id="option_amount" value="399" checked="checked"><span
							style="color: rgb(255, 102, 0); font-size: 16px; font-weight: 800"><spring:message code="onlinePayment.399"></spring:message></span>
						</label>
						<p style="margin-left: 25px; color: gray;"><spring:message code="onlinePayment.standardPrice"></spring:message></p>
					</div>
				</div>
				<div class="form-group-lg">
					<div class="radio">
						<label> <input type="radio" name="option_amount"
							id="option_amount" value="299"> <span
							style="color: rgb(255, 102, 0); font-size: 16px; font-weight: 800"><spring:message code="onlinePayment.299"></spring:message></span>
						</label>
						<p style="margin-left: 25px; color: gray;"><spring:message code="onlinePayment.creditPrice"></spring:message></p>
					</div>
				</div>
			</div>
			<div class="row" style="text-align: right;">
			<div class="col-xs-4">&nbsp</div>
			<div class="col-xs-6" style="text-align: center;margin-bottom: 20px;"><button id="continueBtn" type="button" class="btn" style="font-size: 18px;font-weight: 700;padding: 5px 30px;"
					style="margin-left:15px;"><spring:message code="onlinePayment.continue"></spring:message></button></div>
				
			</div>

			<div class="row" style="margin-top: 40px;text-align: left;">
			<div class="col-xs-12" style="margin-left: -15px">
			<span style="font-size: 18px; font-weight: 800;"><spring:message code="onlinePayment.bankTransfer"></spring:message></span>
			</div>
				
				<hr style="margin-top: 5px">
				<div class="form-group-lg">
					<div class="radio">
						<label> <input type="radio" name="option_amount"
							id="option_amount" value="459"> <span
							style="color: rgb(255, 102, 0); font-size: 16px; font-weight: 800"><spring:message code="onlinePayment.459"></spring:message></span>
						</label>
						<p style="margin-left: 25px; color: gray;"><spring:message code="onlinePayment.standardPrice"></spring:message></p>
					</div>
					<div class="form-group-lg">
						<div class="radio">
							<label> <input type="radio" name="option_amount"
								id="option_amount" value="359"> <span
								style="color: rgb(255, 102, 0); font-size: 16px; font-weight: 800"><spring:message code="onlinePayment.359"></spring:message></span>
							</label>
							<p style="margin-left: 25px; color: gray;"><spring:message code="onlinePayment.creditPrice"></spring:message></p>
						</div>
					</div>
				</div>
				<p><spring:message code="onlinePayment.press"></spring:message></p>
			</div>
							<div class="row">
				
				<div class="col-xs-4"  style="text-align:center;">
				<!-- 
				<input name="tel" id="tel" class="blue-border"
						style="width: 198px; height: 36px" type="text"
						placeholder="confirm your phone number"> --> &nbsp
						</div> 
						
				<div class="col-xs-6" style="text-align:center;margin-bottom: 20px;"><button id="requestBtn" type="button" class="btn" style="font-size: 18px;font-weight: 700;padding: 5px 30px;"
						><spring:message code="onlinePayment.contactUs"></spring:message></button></div>
					
					
				</div>
				<div class="row">
				<div class="col-xs-6" style="text-align:right;"><span id="fillTelText" style="display: none;"
							class="label label-danger">please fill your phone number</span></div>
				<div class="col-xs-6" style="text-align:left;"><span
							id="callYouText" style="display: none;"
							class="label label-success">we will call you soon</span></div>
							
				</div>

		
</div>
</div>
<div id="onlinePayment_bottom">

</div>
	<!-- /container -->
	<div id="myModal" class="modal fade" data-keyboard="false"
		data-backdrop="static" style="text-align: center;">
		<div class="modal-dialog" style="margin: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<span class="modal-title" id="myModalLabel"><spring:message code="onlinePayment.enterCode"></spring:message></span>
				</div>
				<div class="modal-body">
					<p style="margin-bottom: 0px;">
						<label> <input id="code" class="blue-border" name="code"
							type="text" placeholder="Enter credit code" maxlength="6"></label>
						<button id="confirmBtn" class="btn btn-warning  btn-xs"
							type="button"><spring:message code="onlinePayment.confirm"></spring:message></button>
						<span id="validCode" style="margin-left: 10px; display: none;"
							class="label label-success"><spring:message code="onlinePayment.valid"></spring:message></span><span
							id="invalidCode" style="margin-left: 10px; display: none;"
							class="label label-danger"><spring:message code="onlinePayment.invalid"></spring:message></span>
					</p>
					<p>
						<span style="color: rgb(255, 102, 0);"><spring:message code="onlinePayment.usingCredit"></spring:message></span>
					</p>
					<p style="text-align: left;font-size: 0.8em"><spring:message code="onlinePayment.example"></spring:message></p>
				</div>


			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<script type="text/javascript">
		$(document).ready(function() {
			$(":radio").click(function() {
				if ($(this).val() == 299 || $(this).val() == 359)
					$.post("checkCreditCodeOfAccount",null, function(result) {				
						if ("1" == result) {
							
						}else if("0" == result){
							$('#myModal').modal('show');
						}
						else
							alert("<spring:message code="systemException"></spring:message>");
					});	
				
					
			});

			$("#confirmBtn").click(function() {
				$("#invalidCode").hide();
				var code = $("#code").val();
				var reg = new RegExp("\\d{6}");
				if (reg.test(code)) {
					$.post("checkCreditCode",{
						code : code
					}, function(result) {				
						if ("1" == result) {
							$("#validCode").show();	
							 setTimeout(function() {
								 $('#myModal').modal('hide');								
					            },
					            1000)
						}else if("0" == result){
							$("#invalidCode").show();
						}
						else
							alert("<spring:message code="systemException"></spring:message>");
					});	

				} else {
					$("#invalidCode").show();
					return;
				}
			});
			$("#continueBtn").click(function() {	
				if (!($('input:radio[name=option_amount]:checked').val() == 399||$('input:radio[name=option_amount]:checked').val() == 299))
					{
							$('input:radio').eq(0).prop("checked", true)
					}
				
				
				if ($('input:radio[name=option_amount]:checked').val() == 299)
					{
					$.post("checkCreditCodeOfAccount",null, function(result) {				
						if ("1" == result) {
							createPayment();							
						}else if("0" == result){
							$('#myModal').modal('show');
						}
						else
							alert("<spring:message code="systemException"></spring:message>");
					});	
					}
				else
					createPayment();
			});			
			function createPayment(){
				var amount=$('input:radio[name=option_amount]:checked').val();
				$.post("createPayment",{amount:amount}, function(result) {				
					if ("000" == result) {
						//创建订单成功，转到支付页面
						window.location.href = "payment"; 							
					}else if("002" == result){
						$('#myModal').modal('show');
					}else if("003" == result){
						//已支付
						window.location.href = "accountInfo"; 							
					}
					else
						alert("<spring:message code="systemException"></spring:message>");
				});
			}
			
			$("#requestBtn").click(function() {	
				if (!($('input:radio[name=option_amount]:checked').val() == 459||$('input:radio[name=option_amount]:checked').val() == 359))
				{
		
					$('input:radio').eq(2).prop("checked", true)
					
					
				}
				/*
				var tel=$("#tel").val();
				//验证号码格式
				var reg = new RegExp("\\d{6,20}");
				if (!reg.test(tel)) {
					$('#fillTelText').show();
					$('#fillTelText').delay(2000).hide(0);
					return;					
				}*/
				if ($('input:radio[name=option_amount]:checked').val() == 359)
					{
					$.post("checkCreditCodeOfAccount",null, function(result) {				
						if ("1" == result) {
							createRequest();							
						}else if("0" == result){
							$('#myModal').modal('show');
						}
						else
							alert("<spring:message code="systemException"></spring:message>");
					});	
					}
				else
					createRequest();
			});	
			
			function createRequest(){
	    		$("#contact").modal({  
	       			 remote: "contact?w="+( $(window).width() *0.3-30)
	    		});  
				/*
				var amount=$('input:radio[name=option_amount]:checked').val();
				var tel=$("#tel").val();
				$.post("createRequest",{amount:amount,tel:tel}, function(result) {				
					if ("000" == result) {
						$('#callYouText').show();
						$('#callYouText').delay(2000).hide(0);
					}else if("002" == result){
						$('#myModal').modal('show');
					}
					else
						alert("system error");
				});*/
			}

		});
		window.onload = function() {
			
			var body_height=$("body").height();
			var body_window=$(window).height();			
			if(body_window>body_height)
				body_height=body_window;		
			
			$("#onlinePayment").css("height",body_height-255+"px");
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