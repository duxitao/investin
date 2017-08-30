<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="about" class="modal fade" data-keyboard="false"
	data-backdrop="static">
	<div class="modal-dialog"
		style="width: 30%; height: 80%; position: absolute; top: 10%; left: 35%; margin: 0;min-width: 200px;">
		<div class="modal-content">
			<div class="modal-header" style="text-align: center;">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<span class="modal-title" id="myModalLabel"><spring:message code="menu.about"></spring:message></span>
			</div>
			<div class="modal-body"
				style="overflow-y: auto; text-align: left; margin: 0">
				<spring:message code="menu.aboutContent"></spring:message>
			</div>
		</div>
	</div>
</div>

<div id="terms" class="modal fade" data-keyboard="false"
	data-backdrop="static" style="text-align: center;">
	<div class="modal-dialog"
		style="width: 30%; height: 80%; position: absolute; top: 10%; left: 35%; margin: 0;min-width: 200px;">
		<div class="modal-content">
			<div class="modal-header" style="text-align: center;">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<span class="modal-title" id="myModalLabel"><spring:message code="menu.terms"></spring:message></span>
			</div>
			<div class="modal-body"
				style="overflow-y: auto; text-align: left; margin: 0">
				<spring:message code="menu.termsContent"></spring:message>
			</div>
		</div>
	</div>
</div>


<div id="contact" class="modal fade" data-keyboard="false"
	data-backdrop="static">
	<div id="contact_dialog" class="modal-dialog"
		style="width: 30%; height: 80%; position: absolute; top: 10%; left: 35%; margin: 0;min-width: 200px;">
		<div class="modal-content"></div>
	</div>
</div>

<div style="text-align: center;width: 100%"> 

<div class="row" style="width: 800px;line-height: 66px;margin:0 auto;">
<div class="col-xs-3" style="text-align: left;">

<img alt="logo" src="images/logo.png" style="width:200px;height: 46px;margin: 10px 0; "> 
</div>
<div class="col-xs-8" style="text-align: right;">

		<a href="#" onclick="openModal('about')"><spring:message code="menu.about"></spring:message></a> <span style="margin: 0 15px">|</span><a
		href="#" onclick="openModal('terms')"><spring:message code="menu.terms"></spring:message></a><span style="margin: 0 15px">|</span><a
		href="#" onclick="openModal('contact')"><spring:message code="menu.contact"></spring:message></a>
</div>
</div>
</div>



<script type="text/javascript">
	function openModal(modalName) {
		var h = $(window).height() * 0.8
				+ $("div#" + modalName + " .modal-header").height() - 2 - 30;//减去modal-header的高度(得到的modal-header为负数)、边框高度-padding高度
		try {
			var browser = navigator.appName;
			var b_version = navigator.appVersion;
			var version = b_version.split(";");
			var trim_Version = version[1].replace(/[ ]/g, "");
			if (browser == "Microsoft Internet Explorer"
					&& trim_Version == "MSIE7.0") {
				h = h - $(window).height() * 0.1;
			}
		} catch (e) {
		}
		if ("contact" == modalName) {
			$("#" + modalName).modal({
				remote : "contact?w=" + ($(window).width() * 0.3 - 30)
			});
		} else {
			$("div#" + modalName + " .modal-body").height(h);
			$('#' + modalName).modal('toggle')
		}
	}
	$('#contact').on(
			'loaded.bs.modal',
			function(e) {
				var h = $(window).height() * 0.8
						+ $("div#contact.modal-header").height() - 2 - 30;//减去modal-header的高度(得到的modal-header为负数)、边框高度-padding高度
				try {
					var browser = navigator.appName;
					var b_version = navigator.appVersion;
					var version = b_version.split(";");
					var trim_Version = version[1].replace(/[ ]/g, "");
					if (browser == "Microsoft Internet Explorer"
							&& trim_Version == "MSIE7.0") {
						h = h - $(window).height() * 0.1;
					}
				} catch (e) {
				}

			})
</script>