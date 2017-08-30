<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>paymentTransfer</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<form id="form1" name="form1" action="${payment.pay_url}" method="post">
		<input type="hidden" name="cmd" value="${payment.cmd}"> <input
			type="hidden" name="business" value="${payment.business}"> <input
			type="hidden" name="item_name" value="loginfund VIP"> <input
			type="hidden" name="item_number" value="${payment.id}"> <input
			type="hidden" name="currency_code" value="${payment.currency_code}">
		<input type="hidden" name="amount" value="${payment.amount}">
		<!-- <input type="hidden" name="notify_url"
			value="http://www.loginfund.com:8080/investin/paypalNotify" /> <input
			type="hidden" name="cancel_return"
			value="http://www.loginfund.com:8080/investin/paypalCancel" /> <input
			type="hidden" name="return"
			value="http://www.loginfund.com:8080/investin/paypalReturn" /> -->
		<input type="hidden" name="notify_url"
			value="http://www.loginfund.com/paypalNotify" /> <input
			type="hidden" name="cancel_return"
			value="http://www.loginfund.com/paypalCancel" /> <input
			type="hidden" name="return"
			value="http://www.loginfund.com/paypalReturn" />
	</form>

	<script type="text/javascript">
		document.form1.submit()
	</script>

</body>
</html>