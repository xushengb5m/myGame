<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
		<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
		<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
		<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
		<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
		<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
		<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script> 
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.content1 .infor1 .message .main .part input {
    width:initial;
    
}
@media(max-width:1200px){
	.content1 .infor1 .message .main .part span {
	    width: 13%;
	    text-align: right;
	    display: inline-block;
	}
}

#descripton{
	width:300px;
	height:130px;
	margin-left: 10%;
	
}
@media(max-width:1200px){
	#descripton{
		margin-left: 14%;
	}
}
@media(max-width:1200px){
	.content1 .button {
    width: 100px;
    height: 30px;
    background-color: #009dda;
    text-align: center;
    color: #fff;
    line-height: 30px;
    float: left;
    margin-right: -86px;
}
}


</style>
</head>
<body>
	
	<div class="content content1">
		<div class="infor1" id="conditionDiv">
			<div class="order message">
				<div class="main">
					<center>
						<h1 id="active1" style="display:none">新增直减活动</h1>
						<h1 id="active2" style="display:block">新增优惠券发放活动</h1>
						<h1 id="active3" style="display:none">新增满减活动</h1>
					</center>
					<div class="part">
						<span>名称：</span><input type="text" id="promotionName" name="promotionName">
						<span>列表标签：</span><input type="text" id="listTag" name="listTag">
						<!--<select id="listTag" name="listTag">
							<#list types as type>  
							  <#if type !="NULL">
							  	<#if type == 'NONE'>
							  		<option value="">${type.cnName}</option>
							  		<#elseif type == 'COUPONS' >
							  		<option value="${type}" selected="selected" >${type.cnName}</option>
							  		<#else>
							  		<option value="${type}" >${type.cnName}</option>	
							  	</#if>
							  </#if> 
							</#list>
						</select>-->
					</div>
					<div class="part">
						<span>有效性</span><select id="validity" name="validity">
							<#list valids as val>  
								 <#if val !="NULL">
								  	<#if val != 'NONE'>
								  		<!--<option value="">${val.cnName}</option>-->
								  		<#if val == 'VALID'>
								  			<option value="${val}" selected='selected'>${val.cnName}</option>
								  			<#else>
								  			<option value="${val}">${val.cnName}</option>	
								  		</#if>
								  	</#if>
								</#if> 
							</#list>
						</select>
					</div>
					
					<div class="part">						
						<span>预算：</span><input type="text" id="budget" name="budget">
						<span>超预算自动下线</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<label><input type="radio" name="logoff" value="true">是</label>
							<label><input type="radio" name="logoff" value="false" checked="checked">否</label>
					</div>
					
					<!--<div class="part" id="active1" style="display:none">						
						<span>活动方式：</span>
						<input type="radio"  name="orderNo">无条件减<br/>
						<div style="padding: 0 0 0 10.25%;">
							<input type="radio"  name="orderNo" >直减 
							<select id="orderAuditStatus" name="orderStatus.orderAuditStatus">
								<option value="按照车票立减">按车票立减</option>
								<option value="按订单立减">按订单立减</option>
							</select>
							&nbsp;&nbsp;<input type="text" style="width: 60px;">&nbsp;&nbsp;每张票价最低金额&nbsp;&nbsp;<input type="text" style="width: 60px;">
						</div>	
					</div>
					<div class="part" id="active3" style="display:none">						
						<span>活动方式：</span>
						<input type="radio"  name="orderNo">无条件减<br/>
						<div style="padding: 0 0 0 10.25%;">
							<input type="radio"  name="orderNo" >满减&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							&nbsp;&nbsp;满&nbsp;&nbsp;<input type="text" style="width: 60px;">&nbsp;&nbsp;减&nbsp;&nbsp;<input type="text" style="width: 60px;">
							&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="添加条件"></input>
						</div>
						<div style="padding: 0 0 0 10.25%;">
							<input type="radio"  name="orderNo" >满人数减
							&nbsp;&nbsp;满&nbsp;&nbsp;<input type="text" style="width: 60px;">&nbsp;&nbsp;人减&nbsp;&nbsp;<input type="text" style="width: 60px;">
						</div>		
					</div>-->
					
					
					
					<div class="part" id="active2" style="display:block">						
						<span>活动方式：</span>
						<input type="radio"  name="promotionType" value="NO_CONDITION" checked='checked'>无条件减<br/>
						<div style="padding: 0 0 0 10.25%;">
							<input type="radio"  name="promotionType" value="FULL_SEND">满送&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							&nbsp;&nbsp;满&nbsp;&nbsp;<input type="text" style="width: 60px;" id="promotionValue_R">&nbsp;&nbsp;元
						</div>
						<div style="padding: 0 0 0 10.25%;">
							<input type="radio"  name="promotionType" value="FULL_PEOPLE_SEND" >满人数送
							&nbsp;&nbsp;满&nbsp;&nbsp;<input type="text" style="width: 60px;" id="promotionValue_P" >&nbsp;&nbsp;成人
						</div>	
					</div>
					
					<div class="part">						
						<span>发放频次：</span>&nbsp;&nbsp;
						<input type="radio" name="quantity" value="FIRST_ORDER" checked='checked'>首单发放&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="quantity" value="UNLIMITED">当前活动不限发放次数&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="quantity" value="LIMITED_AMOUNT">当前活动每个用户只发放<input type="text" style="width:2%" id="quantityValue">次
					</div>
					
					<div class="part" id="active21" style="display:block">						
						<span>优惠券ID </span> <input type="text" id="vstBatchNO" >&nbsp;&nbsp;<input type="button" value="确定" style="width:50px" id="queryVstBatch"></input> 
						<table style="width:50%;position:relative;left: 97px;" id="promotionBatch">
							<tr>
								<th>优惠券ID</th>
								<th>优惠券名称</th>
								<th>有效性</th>
								<th>导入时间</th>
								<th>有效张数</th>
							</tr>
							<!--<tr>
								<td id="vstBatchNO" value=""></td>
								<td id="vstProName" value=""></td>
								<td id="vstValid" value=""></td>
								<td id="vstCreateTime" value=""></td>
								<td id="vstAmount" value=""></td>
							</tr>-->
						</table>	
					</div>
					<div class="part" style="position:relative; margin-top: 1%;">						
						<span style="position: absolute;left:0;">规则描述：</span>
						<textarea  id="descripton" value=""></textarea>
					</div>
					<div class="part" style="position: relative;left: 20%;">
						<a href="javascript:;" id="savePromotion" ><div class="button">保存</div></a>
						<input type="hidden" id="pmid" value="${(pmid)!''}">
						<input type="hidden" id="flag" value="${(flag)!''}">
						<a href="javascript:;" onclick="window.history.go(-1);" style="position: absolute;right: 84%;"><div class="button">返回</div></a>
					</div>
				</div>
			</div>
		</div>
</body>
<script type="text/javascript">

	//查询优惠券http://10.200.2.124:8585/traffic-union-offline
	$("#queryVstBatch").click(function(){
		var vstBatchNO = $("#vstBatchNO").val();
		$.ajax({
			url : '${request.contextPath}/promotion/queryCouponCodeByParam/'+vstBatchNO,
			type : 'get',
			data : {},
			success : function(data){
				if(data.flag){
					var list = data.list;
					var s = "<tr><th>优惠券ID</th><th>优惠券名称</th><th>有效性</th><th>导入时间</th><th>有效张数</th></tr>";
					if(list != ""){
						for(var i=0; i<list.length; i++){
							s += "<tr><td id='vstBatchNO' >"+list[i].couponId+"</td><td id='vstProName' >"
							+list[i].couponName+"</td><td id='vstValid' >"+list[i].valid+"</td><td id='vstCreateTime'>"+data.time+"</td><td id='vstAmount' ></td></tr>";
							
						}
						$("#promotionBatch").html("");
						$("#promotionBatch").html(s);
					}
				}else{
					alert("抱歉，优惠券没找到");
				}
				
			}
		});
	});
	
	
	//保存
	$("#savePromotion").click(function(){
		var promotionName = $("#promotionName").val();
		var listTag = $("#listTag").val();
		var validity = $("#validity").val();
		var budget = $("#budget").val();
		
		var logoffs = $("input[name='logoff']");
		var logoff = "";
		for(var i=0; i<logoffs.length; i++){
			if(logoffs.eq(i).prop('checked')){
				logoff = logoffs.eq(i).val();
			}
		}
		
		var vstBatchNO = $("#vstBatchNO").val();
		var vstProName = $("#vstProName").text() ;
		var vstValid = $("#vstValid").text();
		
		var vstCreateTime = $("#vstCreateTime").text();
		var vstAmount = $("#vstAmount").text();
		var vstPCrTime = vstCreateTime;
		var vstVa = vstValid;
		
		var promotionTypes = $("input[name='promotionType']");
		var promotionType = "";
		var promotionValue = "";
		for(var i=0; i<promotionTypes.length; i++){
			if(promotionTypes.eq(i).prop('checked')){
				if(promotionTypes.eq(i).val() == 'NO_CONDITION'){
					promotionType = "NO_CONDITION";
				}else if(promotionTypes.eq(i).val() == 'FULL_SEND'){
					promotionType = "FULL_SEND";
					promotionValue = $("#promotionValue_R").val();
				}else if(promotionTypes.eq(i).val() == 'FULL_PEOPLE_SEND'){
					promotionType = "FULL_PEOPLE_SEND";
					promotionValue = $("#promotionValue_P").val();
				}
			}
		}
		
		var quantitys = $("input[name='quantity']");
		var quantity = "";
		var quantityValue = "";	
		for(var i=0; i< quantitys.length; i++){
			if(quantitys.eq(i).prop('checked')){
				if(quantitys.eq(i).val() == 'LIMITED_AMOUNT'){
					quantity = "LIMITED_AMOUNT";
					quantityValue = $("#quantityValue").val();
				}else{
					quantity = quantitys.eq(i).val();
				}
			}
		}
		
		var descripton = $("#descripton").val();
		
		if(promotionName == ''|| listTag == ''|| validity == ''|| budget == ''|| descripton == ''  ){
			alert("数据不能空");
			return;
		}
		if(promotionType != 'NO_CONDITION' && promotionValue == ''){
			alert("活动方式数据不能为空");
			return ;
		}
		if(quantity == 'LIMITED_AMOUNT' && quantityValue == '' ){
			alert("发放频次数据不能为空");
			return ;
		}
		
		var pmid = $("#pmid").val();
		var flag = $("#flag").val();
		$.ajax({
			url : '${request.contextPath}/promotion/insertPromotion',
			type : 'POST',
			data : {
				promotionName : promotionName,
				listTag : listTag,
				validity : validity,
				budget : budget,
				logoff : logoff,
				vstBatchNO : vstBatchNO,
				promotionType : promotionType,
				promotionValue : promotionValue,
				quantity : quantity,
				quantityValue : quantityValue,
				descripton : descripton,
				
				vstProName : vstProName,
				vstVa : vstVa,
				vstPCrTime : vstPCrTime,
				vstAmount : vstAmount,
				pmid : pmid,
				flag : flag
				
			},
			success : function(data){
				if(data.name == 'SUCCESS'){
					alert("数据新增成功！");
					if(data.flag == 'false'){
						window.location.href="${request.contextPath}/promotionMain/changeValid/"+data.pmid;						
					}else if(data.flag == 'true'){
						window.location.href="${request.contextPath}/promotion/toPromotionList";
					}
				}else{
					alert("数据新增失败");					
				}
				
			}
		});
	});
</script>
</html>