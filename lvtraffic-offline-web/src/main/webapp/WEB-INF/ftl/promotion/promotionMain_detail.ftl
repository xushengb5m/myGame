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

.noshow table tr th, .noshow table tr td {
    border: 1px solid #e4e4e4;
    text-align: left;
    border: 0;
}
@media(max-width:1200px){
		.content1 .infor1 .message .main .part span {
	    width: 13%;
	    text-align: right;
	    display: inline-block;
	}
}
@media(max-width:1200px){
		.content {
	    width: 103%;
	    padding: 1%;
	    line-height: 30px;
	}
}
</style>
</head>
<body>
	
	<div class="content content1">
	  
		<div class="infor1" id="conditionDiv" >
			
			<div class="order message">
				<div class="main">
					<center>
						<h1 style="display:block">修改活动信息</h1>
					</center>
					
					<div class="part noshow">
							<table  style="width:60%;">
								<tr>
									<#if (promotionMain.id)!''!=''>
										<td>活动ID:<input type="text" id="id" value="${(promotionMain.id)!''}" disabled="true"></td>
									</#if>
									<td>活动名称:<input type="text" id="promotionMianName" value="${(promotionMain.promotionMianName)!''}"></td>
								</tr>
								<tr>
									<td>活动有效性:
										<select id="validity" style="width:20%" >
											<#list allValids as valid>
												<#if valid != 'NONE'>
													<!--${valid}--11111${promotionMain.validity}-->
													<#if promotionMain?? && promotionMain.validity == valid >
														<option value="${(valid)!''}" selected='selected'>${(valid.cnName)!''}</option>
														<#else>
														<option value="${(valid)!''}">${(valid.cnName)!''}</option>	
													</#if>
												</#if>
											</#list>
										</select>
									</td>
									<td>专题url:<input type="text" id="url" value="${(promotionMain.url)!''}" ></td>
								</tr>
								<tr>
									<td>创建人:<input type="text" id="createUser" value="${(promotionMain.createUser)!''}" disabled='disabled'></td>
									<td>最后修改人:<input type="text" id="operateSuccessUsername" value="${(promotionMain.operateSuccessUsername)!''}" disabled='disabled'></td>
								</tr>
							</table>
					</div>
						<div style="position: relative;margin-left: -5%;" id="time_and_other">
							<div class="part" id="limitSource" >
								<span>渠道限制</span>&nbsp;&nbsp;
								<input type="checkbox" name="limeSource" value="ALL">不限&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="checkbox" name="limeSource" value="PC">PC端&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="checkbox" name="limeSource" value="ANDROID">Android&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="checkbox" name="limeSource" value="IOS">IOS&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="checkbox" name="limeSource" value="WAP">WAP
							</div>
							<div class="part">
								<span>产品线</span>&nbsp;&nbsp;
								<input type="radio" name="category" value="FLIGHT">机票&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="category" value="TRAIN" >火车票&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="category" value="FANDH" >机+酒
							</div>
							<div class="part">
								<span>有效时间</span> &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="validTime_start"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" style="width:123px;" 
								class="Wdate" readonly="readonly"/>
								 - 
								<input type="text" name="validTime_end" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" style="width:123px;" 
								 	class="Wdate" readonly="readonly"/>&nbsp;&nbsp;&nbsp;&nbsp;
								 <input type="button" value="新增时间段" id="add_timeSegment" size=1>	
							</div>
						</div>
					
						<div class="part" style="position: relative;margin-top: 5%;">
							<a href="javascript:void(0);" id="promotion-button" style="display: inline-block;width: 100px;height:30px;"><div class="button" >子活动</div></a>  <a href="javascript:void(0);" id="rule-button" style="display: inline-block;width: 100px;height:30px;"><div class="button" style="background-color: #ccF;">参与规则</div></a>
						</div>	   
							 
						<div class="part" style="margin-top: -1%;position: relative;" id="promotion-div">
						
							 <a href="javascript:;" onclick="addPro()" style="position: absolute;right: 41%;"><div class="button">添加子活动</div></a> <br>
							
							<table style="width:60%;margin-top: 10px; ">
								<tr>
									<th>子活动ID</th>
									<th>名称</th>
									<th>活动方式</th>
									<th>状态</th>
									<th>发放频次</th>
									<th>使用量</th>
									<th>操作</th>
								</tr>
								<#if proMainList??>
									<#list proMainList as pm>
										<tr>
											<td>${(pm.id)!''}</td>
											<td>${(pm.promotionName)!''}</td>
											<td>${(pm.activityType.cnName)!''}</td>
											<td>${(pm.validity.cnName)!''}</td>
											<td>${(pm.quantity.cnName)!''}</td>
											<td>${(pm.usageAmount)!''}</td>
											<td style="width: 20%;">
											<a href="javascript:;" onclick="deletePro(${(pm.promLinkId)!''})">删除</a> </td>
										</tr>
									</#list>
								</#if>
							</table>
							<a href="javascript:;" style="position: absolute;right: 41%;" onclick="queryOtherPro()"><div class="button">查询其他子活动</div></a><br>
							<table style="width:60%" id="other_pro">
								<tr>
									<th>子活动ID</th>
									<th>名称</th>
									<th>活动方式</th>
									<th>状态</th>
									<th>发放频次</th>
									<th>使用量</th>
									<th>操作</th>
								</tr>
								
								<tr>
									<!--<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td style="width: 20%;"><a style="margin-right: 15px;">添加</a> <a href="${request.contextPath}/promotion/queryPromotionById/${(pm.id)!''}">编辑</a> </td>-->
								</tr>
							
							</table>
						</div>
						<div class="part" style="position: relative;margin-top: -1%;display:none" id="rule-div">
							<a href="javascript:;" id="addRule" style="position: absolute;right: 30%;"><div class="button">添加规则</div></a> <br> 
							<table style="width:70%;margin-top: 10px;" id="validRule">
								<tr>
									<th>规则ID</th>
									<th>名称</th>
									<th>维护人</th>
									<th>出发城市</th>
									<th>抵达城市</th>
									<th>出行时间</th>
									<th>航班/车次</th>
									<th>舱位/坐席</th>
									<th>航空公司</th>
									<th>操作</th>
								</tr>
								<#if ruleList??>
									<#list ruleList as rule>
										<tr>
											<td>${(rule.id)!''}</td>
											<td>${(rule.promotionRuleName)!''}</td>
											<td>${(rule.maintainName)!''}</td>
											<td>${(rule.departure)!''}</td>
											<td>${(rule.arrival)!''}</td>
											<td>${(rule.timeQuantum)!''}</td>
											<td>${(rule.trafficNo)!''}</td>
											<td>${(rule.trafficLevel)!''}</td>
											<td>${(rule.airplaneCompany)!''}</td>
											<td style="width:10%;"><a href="javascript:;" onclick="deleteRule(${(rule.promLinkId)!''})" >删除</a></td>
										</tr>
									</#list>
								</#if>
							</table>
							<a style="position: absolute;right: 30%;" href="javascript:;" id="queryOtherRule"><div class="button">查询其他可用规则</div></a><br>
							<table style="width:70%" id="unvalidRule">
								<tr>
									<th>规则ID</th>
									<th>名称</th>
									<th>维护人</th>
									<th>出发城市</th>
									<th>抵达城市</th>
									<th>出行时间</th>
									<th>航班/车次</th>
									<th>舱位/坐席</th>
									<th>航空公司</th>
									<th>操作</th>
								</tr>
								<tr >
									<!--<td>新增</td>
									<td>呵呵</td>
									<td>呵呵</td>
									<td>呵呵呵</td>
									<td>呵呵</td>
									<td>呵呵</td>
									<td>呵呵</td>
									<td>呵呵</td>
									<td>呵呵</td>
									<td style="width: 20%;"><a style="margin-right: 15px;">复制</a > <a style="margin-right: 15px;">添加</a> <a href="${request.contextPath}/rule/queryRuleById/10">编辑</a></td>-->
								</tr>
							</table>
					</div>
					<div class="click" style="position: relative;right: 21%;">
						<a href="javascript:;" onclick="insertProMain()"><div class="button">保存</div></a> <a href="${request.contextPath}/promotionMain/toPromotionMainList" ><div class="button">返回</div></a>
					</div>
					<input type="hidden" id="pmid" value="${(promotionMain.id)!''}">
					<input type="hidden" id="promotionMainType" value="${(promotionMain.promotionMainType)!''}">
					<input type="hidden" id="createUsername" value="${(promotionMain.createUsername)!''}">
				</div>
			</div>
		</div>
</body>
<script>
	$(function(){
		var categs = $("input[name='category']"); 
		var category = '${(promotionMain.category)!''}';
		
		var limes = $("input[name='limeSource']"); 
		var limeSource = '${(promotionMain.limeSource)!''}';
		if(category != ""){
			if(category.includes("-")){
				var categorys = category.split("-");
				for(var j=0; j<categs.length; j++){
					for(var i=0; i<categorys.length; i++){
						if(categs.eq(j).val() == categorys[i]){
							categs.eq(j).prop('checked',true);
						}						
					}
				}
			}else{
				for(var j=0; j<categs.length; j++){
					if(categs.eq(j).val() == category){
						categs.eq(j).prop('checked',true);
					}
				}
			}
		}
		
		if(limeSource !=''){
			if(limeSource.includes("-")){
				var limeSources = limeSource.split("-");
				for(var i=0; i<limes.length; i++){
					for(var j=0; j<limeSources.length; j++){
						if(limes.eq(i).val() == limeSources[j]){
							limes.eq(i).prop("checked",true);
						}
					}
				}
			}else{
				for(var i=0; i<limes.length; i++){
					if(limes.eq(i).val() == limeSource){
						limes.eq(i).prop("checked",true);
					}
				}
			}
		}
		
		var validTime = '${(promotionMain.validTime)!''}';
		//alert("validTime"+validTime);
		if(validTime != ''){
			//alert(1111);
			if(validTime.includes("/")){
				var validTimes = validTime.split("/");
				var size = validTimes.length;
				//alert("size-----"+size);
				var timeSegment = "";
				for(var i=1; i<size; i++){
					var aa={dateFmt:'yyyy-MM-dd HH:mm'};
					timeSegment += "<div class='part' name='timeSegment'><span>有效时间</span> &nbsp;&nbsp;&nbsp;&nbsp;"+
					"<input type='text' name='validTime_start'  onfocus='WdatePicker("+JSON.stringify(aa)+")' style='width:123px;' class='Wdate' readonly='readonly'/>"+
					"&nbsp;-&nbsp;<input type='text' name='validTime_end'  onfocus='WdatePicker("+JSON.stringify(aa)+")' style='width:123px;' class='Wdate' readonly='readonly'/>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' size='"+(i+1)+"' name='deletetSegment' onclick='delete_time(this)' value='删除'></div>";
				}
				//alert("timeSegment-------"+timeSegment);
				$("#time_and_other").append(timeSegment);
				$("#add_timeSegment").attr("size",size);
				
				var startTimes = $("input[name='validTime_start']");
				var endTimes = $("input[name='validTime_end']");
				for(var i=0; i<validTimes.length; i++){
					var times = validTimes[i].split("~");
					startTimes.eq(i).val(times[0]);
					endTimes.eq(i).val(times[1]);
				}
			}else{
				var times = validTime.split("~");
				//alert("start--"+times[0]+"---"+times[1]);
				//alert("========"+$("input[name='validTime_start']"));
				//alert("=====+++"+$("input[name='validTime_end']"));
				$("input[name='validTime_start']").val(times[0]);
				$("input[name='validTime_end']").val(times[1]);
				$("#add_timeSegment").attr("size",1);
			}
		}
		
	})
	//点击渠道限制里的不限
	$("#limitSource").click(function(){
		var limeSources = $("input[name='limeSource']");
		for(var i=0; i<limeSources.length; i++){
			if(limeSources.eq(0).prop('checked') && limeSources.eq(0).val()=='ALL' ){				
				if(i != 0){
					limeSources.eq(i).prop('checked',false);
				}
			}
		}
	});
	
	//修改保存主活动
	function insertProMain(){
		var promotionMianName = $("#promotionMianName").val();
		var validity = $("#validity").val();
		var url = $("#url").val();
		var createUser = $("#createUser").val();
		var operateSuccessUsername = $("#operateSuccessUsername").val();
		var limeSources = $("input[name='limeSource']");
		var limeSource = "";
		for(var i=0; i<limeSources.length; i++){
			if(limeSources.eq(i).prop('checked')){
				limeSource += limeSources.eq(i).val(); 
				limeSource += "-"; 
			}
		} 
		limeSource = limeSource.substring(0,limeSource.lastIndexOf("-"));
		var categorys = $("input[name='category']");
		var category = "";
		for(var i=0; i<categorys.length; i++){
			if(categorys.eq(i).prop('checked')){
				category += categorys.eq(i).val();
				category += "-"; 
			}
		}
		category = category.substring(0,category.lastIndexOf("-"));
		
		var validTime_starts = $("input[name='validTime_start']");
		var validTime_ends = $("input[name='validTime_end']");
		var validTime = "";
		for(var i=0; i<validTime_starts.length; i++){
			for(var j=0; j<validTime_ends.length; j++){
				if(i == j){
					if((validTime_starts.eq(i).val() != '' && validTime_ends.eq(j).val() =='')||(validTime_starts.eq(i).val() == '' && validTime_ends.eq(j).val() !='')){
						alert("有效时间数据不能一边为空");
						return;
					}
					validTime += validTime_starts.eq(i).val() +"~"+ validTime_ends.eq(j).val();
					validTime += "/"; 
				}
			}
		}
		validTime = validTime.substring(0,validTime.lastIndexOf("/"));
		var s1 = validTime.substring(0,1);
		if(!(1<=parseInt(s1) && parseInt(s1)<=9)){
			validTime = "";
		}
		/**var reg = new RegExp("^(0|[1-9][0-9]*)$");
		if(!reg.test(validTime)){
			validTime = "";
		}*/
		/**if(validTime == '~'){
			validTime = "";
		}*/
		
		if(promotionMianName==''||validity==''||limeSource==''||category==''){
			alert("数据不能为空！");
			return ;
		}
		
		var createUsername = $("#createUsername").val();
		var promotionMainType = $("#promotionMainType").val();
		
		var pmid = $("#pmid").val();
		$.ajax({
			url : '${request.contextPath}/promotionMain/updatePromotionMain',
			type : 'POST',
			data : {
				id : pmid,
				promotionMianName:promotionMianName,
				validity:validity,
				url:url,
				createUser:createUser,
				operateSuccessUsername:operateSuccessUsername,
				limeSource:limeSource,
				category:category,
				validTime:validTime,
				
				createUsername : createUsername,
				promotionMainType : promotionMainType
			},
			success : function(data){
				if(data.flag == 'SUCCESS'){
					alert("修改主活动成功！");
					window.location.href = "${request.contextPath}/promotionMain/toPromotionMainList";
				}else{
					alert("修改主活动失败");
				}
			}
		});
		
	}
	
	//点击添加规则 
	$("#addRule").click(function(){
		var pmid = $("#pmid").val();
		if(pmid == ''){
			alert("请先保存完主活动之后，再进行添加操作，谢谢");
			return;
		}
		window.location.href = "${request.contextPath}/rule/addrule?pmid="+pmid; 
	});
	
	//点击添加子活动
	function addPro(){
		var pmid = $("#pmid").val();
		if(pmid == ''){
			alert("请先保存完主活动之后，再进行添加操作，谢谢");
			return;
		}
		window.location.href = "${request.contextPath}/promotion/addPromotion?pmid="+pmid+"&flag=false";
	}
	
	//点击查询其他规则
	$("#queryOtherRule").click(function(){
		var pmid = $("#pmid").val();
		if(pmid == ''){
			alert("请先保存完主活动之后，再进行查询操作，谢谢");
			return;
		}
		
		$.ajax({
			url : "${request.contextPath}/rule/queryOtherRule",
			type : "POST",
			data : {
				pmid : pmid
			},
			success : function(data){
				if(data.name){
					var s = "<tr><th>规则ID</th><th>名称</th><th>维护人</th><th>出发城市</th><th>抵达城市</th><th>出行时间</th><th>航班/车次</th><th>舱位/坐席</th><th>航空公司</th><th>操作</th></tr>";
					var rules = data.otherRules;
					for(var i=0; i<rules.length; i++){                 
						s += "<tr><td>"+rules[i].id+"</td><td>"+rules[i].promotionRuleName+"</td><td>"
						+rules[i].maintainNameStr+"</td><td>"+rules[i].departureStr+"</td><td>"
						+rules[i].arrivalStr+"</td><td>"+rules[i].timeQuantum+"</td><td>"
						+rules[i].trafficNoStr+"</td><td>"+rules[i].trafficLevelStr+"</td><td>"
						+rules[i].airplaneCompanyStr+"</td><td style='width: 20%;'><a style='margin-right: 15px;' href='javascript:;' onclick='copyRule("+rules[i].id+")'>复制</a> <a style='margin-right: 15px;' href='javascript:;' onclick='toValidRule("+rules[i].id+")'>添加</a> <a href='javascript:;' onclick='editRule("+rules[i].id+")'>编辑</a></td></tr>"
					}
					$("#unvalidRule").html("");
					$("#unvalidRule").html(s);
				}
			}
		});
	});
	
	//复制规则
	function copyRule(id){
		var pmid = $("#pmid").val();
		window.location.href = "${request.contextPath}/rule/copyOrEditRule/"+id+"/"+pmid+"/c";
		
	}
	//编辑规则
	function editRule(id){
		var pmid = $("#pmid").val();
		window.location.href = "${request.contextPath}/rule/copyOrEditRule/"+id+"/"+pmid+"/e";
		
	}
	
	//添加规则
	function toValidRule(id){
		var pmid = $("#pmid").val();
		$.ajax({
			url : '${request.contextPath}/rule/queryRule',
			type : 'POST',
			data : {
				id : id
			},
			success : function(data){
				if(!data.flag){
					if(confirm("活动"+data.pmn+"也用到了这条规则，是否继续添加?") ){
						window.location.href = "${request.contextPath}/promotionMain/addDeProRuleToP/"+id+"/"+pmid+"/rule/add";
					}
				}else{
					window.location.href = "${request.contextPath}/promotionMain/addDeProRuleToP/"+id+"/"+pmid+"/rule/add";
				}
			}
		});
	}
	
	//删除规则
	function deleteRule(id){
		var pmid = $("#pmid").val();
		window.location.href = "${request.contextPath}/promotionMain/addDeProRuleToP/"+id+"/"+pmid+"/rule/delete";
	}
	
	
	//查询其他子活动
	function queryOtherPro(){
		var pmid = $("#pmid").val();
		if(pmid == ''){
			alert("请先保存完主活动之后，再进行查询操作，谢谢");
			return;
		}
		$.ajax({
			url : '${request.contextPath}/promotion/queryOtherProM',
			type : 'POST',
			data : {
				pmid:pmid	
			},
			success : function(data){
				if(data.name){
					var list = data.list;
					var s = "<tr> <th>子活动ID</th> <th>名称</th> <th>活动方式</th> <th>状态</th> <th>发放频次</th> <th>使用量</th> <th>操作</th> </tr>";
					for(var i=0; i<list.length; i++){
						s += "<tr><td>"+list[i].id+"</td><td>"+list[i].promotionName+"</td><td>"
						+list[i].activityTypeStr+"</td><td>"+list[i].validtyStr+"</td><td>"
						+list[i].quantityStr+"</td><td>"+list[i].usageAmountStr+"</td><td style='width: 20%;'><a href='javascript:;' onclick='add("+list[i].id+")' style='margin-right: 15px;'>添加</a> <a href='javascript:;' onclick='edit("+list[i].id+")'>编辑</a> </td></tr>";
					}
					$("#other_pro").html("");
					$("#other_pro").html(s);
				}
			}
		});
		
	}
	
	//活动设为无效
	/**function setProUnvalid(linkId){
		var pmid = $("#pmid").val();
		$.ajax({
			url : '${request.contextPath}/promotion/setUnvalid',
			type : 'POST',
			data : {
				pmid : pmid,
				linkId : linkId
			},
			success : function(data){
				if(data.flag){
					alert("设为无效成功");
					window.location.href = "${request.contextPath}/promotionMain/aqueryById/"+data.pmid;
				}else{
					alert("设为无效失败");
				}
			}
		});
	}*/
	
	//删除子活动
	function deletePro(id){
		var pmid = $("#pmid").val();
		window.location.href = "${request.contextPath}/promotionMain/addDeProRuleToP/"+id+"/"+pmid+"/pro/delete";
	}
	
	//添加活动
	function add(id){
		var pmid = $("#pmid").val();
		$.ajax({
			url : '${request.contextPath}/promotion/queryPromotion',
			type : 'POST',
			data : {
				id : id
			},
			success : function(data){
				if(data.flag){
					if(confirm("主活动"+data.pmname+"也用到了这个活动，是否继续添加?") ){
						window.location.href = "${request.contextPath}/promotionMain/addDeProRuleToP/"+id+"/"+pmid+"/pro/add";
					}
				}else{
					window.location.href = "${request.contextPath}/promotionMain/addDeProRuleToP/"+id+"/"+pmid+"/pro/add";
				}
			}
		});
	}
	
	//编辑子活动
	function edit(id){
		var pmid = $("#pmid").val();
		window.location.href = "${request.contextPath}/promotion/copyAndEditPromotion/"+id+"/"+pmid+"/false/e";
	}
	
	
	
	
	
	//点击子活动
	$("#promotion-button").click(function(){
		$("#promotion-div").css("display","block");
		$("#rule-div").css("display","none");
	});
	//点击规则
	$("#rule-button").click(function(){
		$("#promotion-div").css("display","none");
		$("#rule-div").css("display","block");
	});
	//点击新增时间段
	$("#add_timeSegment").click(function(){
		var size = parseInt($("#add_timeSegment").attr("size"));
		if(size >= 5){
			alert("最多添加5 个时间段");
			return;
		}
		var aa={dateFmt:'yyyy-MM-dd HH:mm'};
		var timeSegment = "<div class='part' name='timeSegment'><span>有效时间</span> &nbsp;&nbsp;&nbsp;&nbsp;"+
		"<input type='text' name='validTime_start'  onfocus='WdatePicker("+JSON.stringify(aa)+")' style='width:123px;' class='Wdate' readonly='readonly'/>"+
		"&nbsp;-&nbsp;<input type='text' name='validTime_end'  onfocus='WdatePicker("+JSON.stringify(aa)+")' style='width:123px;' class='Wdate' readonly='readonly'/>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' size='"+(size+1)+"' name='deletetSegment' onclick='delete_time(this)' value='删除'></div>";
		$("#time_and_other").append(timeSegment);
		$("#add_timeSegment").attr("size",size+1);
	});
	
	//删除时间段
	function delete_time(obj){
		var $this = $(obj);
		var size = parseInt($("#add_timeSegment").attr("size"));
		var sz = $this.attr("size");
		var timeSegments = $("div[name='timeSegment']");
		for(var i=1; i<=timeSegments.length; i++){
			if((i+1) == parseInt(sz) ){
				//timeSegments.eq(i-1).css("display","none");
				timeSegments.eq(i-1).remove();
			}
		}
		var ds = $("input[name='deletetSegment']");
		for(var i=0; i<ds.length; i++){
			ds.eq(0).attr("size",i+2);
		}
		$("#add_timeSegment").attr("size",size-1);
		
	}
</script>
</html>