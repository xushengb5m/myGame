<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>用户反馈编辑</title>
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script src="${request.contextPath}/js/Calendar.js"></script>
	
	<script type="text/javascript">
	
		$(function() {
			//提交申请
			$(".button").click(function() {
				$.ajax({
					url : "${request.contextPath}/feedback/saveEditFeedBack",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						request:setfeedbackInfo(),
						problemOwnershipstr:$("#problemOwnershipstr").val(),
						progressstr:$("#progressstr").val(),
						remarkstr:$("#remarkstr").val()
					}),
					success : function(data) {
						alert(data.message);
						window.close();
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据
			function setfeedbackInfo() {
				var feedbackRequest = new Object;
				feedbackRequest.id = $("#feedbackId").text();
				feedbackRequest.problemOwnership = $("#problemOwnership").val();
				feedbackRequest.progress = $("#progress").val();
				feedbackRequest.remark = $("#remark").val();
				return feedbackRequest;
			}
		})
	  $(document).ready(function (){
	  });
	</script>
</head>
  
<body>
	<div class="content content1">
		<div class="infor1">
			<div class="product ms">
				<div class="main">
					<input type="hidden" id="problemOwnershipstr" value="${input.problemOwnership}">
					<input type="hidden" id="progressstr" value="${input.progress}">
					<input type="hidden" id="remarkstr" value="${input.remark}">
					<div class="title" style="text-align :center;margin-bottom:50px;" ><h2>用户反馈操作</h2></div>
					<div class="part" style="text-align :center">
						<span style="margin-left:10px;">问题编号：</span><span style="margin-left:10px;display: inline-block;width: 50px;text-align: left;" id="feedbackId">${(input.id)!''}</span>
						<span style="margin-left:95px;">提交时间：</span><span style="margin-left:10px;">${input.createTime?string("yyyy-MM-dd HH:mm:ss")}</span>
						<span style="margin-left:190px;">会员号：</span><span style="margin-left:10px;">${(input.userName)!''}</span>
					</div>
					<div class="part" style="text-align :center">
						<span style="margin-left:10px;">产品线：</span><span style="margin-left:10px;">${(input.productStr)!''}</span>
						<span style="margin-left:10px;"> 联系手机：</span><span style="margin-left:10px;">${(input.mobile)!''}</span>
						
					</div>
					<div class="part" style="text-align :center;">
						<span style="margin-right:10px;vertical-align: top;">内容：</span><textarea style="width:660px" readonly="true" rows="10">${(input.content)!''}</textarea>
					</div>
					<div class="part" style="text-align:left;padding-left:28%;padding-bottom:10px;">
					<span style="margin-right:10px;">问题类型</span>
						<select name="problemOwnership" id="problemOwnership">
							<#list problemType as type>
								<#if type == input.problemOwnership>
									<option value="${type}" selected>${type.cnName}</option>
								<#else>
									<#if 'ALL' !='${type}'>
									<option value="${type}" >${type.cnName}</option>
									</#if>
								</#if>
							</#list>
				        </select>
					</div>
					<div class="part" style="text-align :center;">
					<span style="margin-right:10px;vertical-align: top;">备注：</span><textarea style="width:660px" placeholder="备注" rows="10" id="remark">${(input.remark)!''}</textarea>
					</div>
					<div class="part" style="text-align:left;padding-left:28%;">
					<span style="margin-right:10px;">处理结果</span>
						<select name="progress" id="progress">
						<#list progress as pro>
							<#if pro == input.progress>
								<option value="${pro}" selected>${pro.cnName}</option>
							<#else>
								<#if 'ALL' !='${pro}'>
								<option value="${pro}" >${pro.cnName}</option>
								</#if>
							</#if>
						</#list>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="click">
			<a href="javascript:void();"><div class="button" id="queryBtn">保存</div></a>
		</div>
	</div>
</body>
</html>