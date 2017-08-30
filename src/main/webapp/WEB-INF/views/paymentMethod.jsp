<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>paymentTransfer</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/onlinePayment.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
</head>

<body>
		

<div id="onlinePayment">
	<div class="container" style="margin-top: 20px;">
	<form id="form1" name="form1" action="${payment.pay_url}" method="post">
		<c:forEach items="${paymentMethodList}" var="paymentMethod">
			<div class="radio">
				<label> <input type="radio" name="pm_id_radio"
					id="${paymentMethod.pm_id}" value="${paymentMethod.pm_id}">
					${paymentMethod.method_es}
				</label>
			</div>
		</c:forEach>
		<input type="hidden" name="pm_id" id="pm_id" value="">
		<input type="hidden" name="api_key" value="${api_key}">
		<input type="hidden" name="api_sig" id="api_sig" value=""> 
 		<input type="hidden" name="order_id" value="${payment.id}"> 
		<input type="hidden" name="description" value="loginfund VIP"> 
		<input type="hidden" name="amount" value="${payment.amount}"> 
		<input type="hidden" name="currency" value="${payment.currency_code}"> 
		<input type="hidden" name="payer_email" value="${email}">		
		<input type ="button" id="btn_submit" value ="Submit">
	</form>
	</div>
	</div>
	
</body>
<script type="text/javascript">

$(document).ready(function() {
	$("#btn_submit").click(function() {	
		//获取api_sig
		var pm_id=$('input:radio[name=pm_id_radio]:checked').val();
		$.post("getPayssionSign",{pm_id:pm_id}, function(result) {				
			$("#pm_id").val(pm_id);
			$("#api_sig").val(result);
			$("#form1").submit();
		});
	});
	
});

</script>
</html>