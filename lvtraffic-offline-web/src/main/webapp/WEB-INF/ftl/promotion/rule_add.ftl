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
#input_period_day{
	    width: 200px;
    	position: absolute;
	    left: 16%;
	    top: -1px;
	    
}
@media (max-width: 1200px) {
    #input_period_day{
	    width: 200px;
    	position: absolute;
	    left: 20%;
	    top: -1px;
	    
	}
}
#input_period_week{
	width: 25%;
    position: absolute;
    left: 16%;
    top: 1px;
    display:none;
}
@media (max-width: 1200px) {
   #input_period_week{
	width: 25%;
    position: absolute;
    left: 20%;
    top: 1px;
    display:none;
}
}
#input_period_month{
	    position: absolute;
	    left: 16%;
	    top: -1px;
	    display:none;
}
@media (max-width: 1200px) {
   #input_period_month{
	    position: absolute;
	    left: 20%;
	    top: -1px;
	    display:none;
	}
}
.partJava{
	position: absolute;
	right: 84%;
}
@media (max-width: 1200px) {
   .partJava{
	position: absolute;
	right: 69%;
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
						<h1 style="display:block">新增参与规则</h1>
					</center>	
					<div class="part" >
						<span>名称：</span><input type="text" id="promotionRuleName" name="promotionRuleName" placeholder="非必填（运营人员使用）"><br/>
					</div>
					
					<hr style="width:60%;">	
					
					<div class="part" >						
						<span>出发地：</span><input type="text" id="departure" name="departure">
						<span>目的地：</span><input type="text" id="arrival" name="arrival">
					</div>
					
					<div class="part" >						
						<span>产品线：</span>
						<select id="limitSource" name="limitSource">
							<option value="FLIGHT">国内机票</option>
							<option value="TRAIN">国内火车票</option>
						</select>
					</div>
					
					<div class="part" >						
						<span>航班：</span>
						<select id="trafficNo_flag" name="trafficNo_flag">
							<option value="仅限">仅限</option>
							<option value="除去">除去</option>
						</select>
						<input type="text" id="trafficNo" name="trafficNo" placeholder="航班号，可多个">
						
						<span>车次：</span>
						<select id="trafficNo_flag" name="trafficNo_flag">
							<option value="仅限">仅限</option>
							<option value="除去">除去</option>
						</select>
						<input type="text" id="trafficNo" name="trafficNo" placeholder="车次号">
					</div>
					<div class="part" >						
						<span>舱位：</span>
						<select id="trafficLevel_flag" name="trafficLevel_flag">
							<option value="仅限">仅限</option>
							<option value="除去">除去</option>
						</select>
						<input type="text" id="trafficLevel" name="trafficLevel" placeholder="商务舱，经济舱">
						
						<span>坐席：</span>
						<select id="trafficLevel_flag" name="trafficLevel_flag">
							<option value="仅限">仅限</option>
							<option value="除去">除去</option>
						</select>
						<input type="text" id="trafficLevel" name="trafficLevel" placeholder="坐席类别">
					</div>
					<div class="part" >						
						<span>航空公司：</span>
						<select id="airplaneCompany_flag" name="airplaneCompany_flag">
							<option value="仅限">仅限</option>
							<option value="除去">除去</option>
						</select>
						<input type="text" id="airplaneCompany" placeholder="四川航空，吉祥航空">
					</div>
					<div class="part">
						<span>航程类型</span>
						<select id="tripType" name="tripType">
							<option value="ALL">不限</option>
							<option value="OW">单程</option>
							<option value="RT">往返</option>
						</select>
					</div>
					<div class="part">
						<span>出行时间</span>&nbsp;&nbsp;时间段&nbsp;&nbsp;
						<input type="text" id="timeQuantum_departure" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:140px;" 
						class="Wdate" readonly="readonly" >
						-
						<input type="text" id="timeQuantum_arrival" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:140px;" 
						class="Wdate" readonly="readonly" >
					</div>
					<div class="part" style="position:relative">
						<span><input type="checkbox" id="period_flag" style="">周期</span>&nbsp;&nbsp;
						<select style="width:60px" id="period">
							<option value="day">每天</option>
							<option value="week">每周</option>
							<option value="month">每月</option>
						</select>&nbsp;&nbsp;
						
						<div id="input_period_day" >
							<input type="text" id="day_period_start" style="width:60px">-<input id="day_period_end" type="text" style="width:60px">
						</div>
						<div id="input_period_week" style="width: 40%;">
							<input type="checkbox" name="week_period" value="Monday">周一
							<input type="checkbox" name="week_period" value="Tuesday">周二
							<input type="checkbox" name="week_period" value="Wednesday">周三
							<input type="checkbox" name="week_period" value="Thursday">周四
							<input type="checkbox" name="week_period" value="Friday">周五
							<input type="checkbox" name="week_period" value="Saturday">周六
							<input type="checkbox" name="week_period" value="Sunday">周日
						</div>
						<div id="input_period_month">
							<input type="text" id="month_period_start" style="width:60px" >-<input id="month_period_end" type="text" style="width:60px" >
						</div>
					</div>
					
					<div class="part" style="position:relative;margin-top:15px;">						
						<span style="position: absolute;left:0;">规则描述：</span>
						<textarea style="width:300px;height:130px;margin-left: 10%;" id="descripton" placeholder="(运营人员使用)"></textarea>
					</div>
					<div class="part" style="position: relative;left: 20%;">
						<a href="javascript:;"><div class="button" onclick="add()">保存</div></a>
						<input type="hidden" id="pmid" value="${(pmid)!''}">
						<a href="javascript:;" class="partJava" onclick="window.history.go(-1);" ><div class="button">返回</div></a>
					</div>
				</div>
			</div>
		</div>
</body>
<script type="text/javascript">
 	$(function(){
		var flag = $("#period_flag").prop('checked');
		if(!flag){
			$("#period").attr("disabled","true");
			$("#day_period_start").attr("disabled","disabled");
			$("#day_period_end").attr("disabled","disabled");
			$("#month_period_start").attr("disabled","disabled");
			$("#month_period_end").attr("disabled","disabled");
			var week_periods = $("input[name='week_period']");
			for(var i=0; i<week_periods.length; i++){
				week_periods.eq(i).attr("disabled","disabled");
			}
		}
 	});
	
	$("#period_flag").click(function(){
		var flag = $("#period_flag").prop('checked');
		if(!flag){
			$("#period").attr("disabled","true");
			$("#day_period_start").attr("disabled","disabled");
			$("#day_period_end").attr("disabled","disabled");
			$("#month_period_start").attr("disabled","disabled");
			$("#month_period_end").attr("disabled","disabled");
			var week_periods = $("input[name='week_period']");
			for(var i=0; i<week_periods.length; i++){
				week_periods.eq(i).attr("disabled","disabled");
			}
		}else{
			$("#period").removeAttr("disabled");
			$("#day_period_start").removeAttr("disabled");
			$("#day_period_end").removeAttr("disabled");
			$("#month_period_start").removeAttr("disabled");
			$("#month_period_end").removeAttr("disabled");
			var week_periods = $("input[name='week_period']");
			for(var i=0; i<week_periods.length; i++){
				week_periods.eq(i).removeAttr("disabled");
			}
		}
		
	});


	$("#period").change(function(){
		var biaozhi = $("#period").val();
		if(biaozhi == "day"){
			$("#input_period_day").css("display","block");
			$("#input_period_week").css("display","none");
			$("#input_period_month").css("display","none");
		}else if(biaozhi == "week"){
			$("#input_period_day").css("display","none");
			$("#input_period_week").css("display","block");
			$("#input_period_month").css("display","none");
		}else if(biaozhi == "month"){
			$("#input_period_day").css("display","none");
			$("#input_period_week").css("display","none");
			$("#input_period_month").css("display","block");
		}
	});


	function add(){
		var promotionRuleName = $("#promotionRuleName").val();
		var departure = $("#departure").val();
		var arrival = $("#arrival").val();
		var limitSource = $("#limitSource").val();
		var trafficNo_flag = "";
		var trafficLevel_flag = "";
		var trafficNo = "";
		var trafficLevel = "";
		var airplaneCompany_flag = "";
		var airplaneCompany = "";
		if(limitSource == "FLIGHT"){
			trafficNo_flag = $(".part").find("#trafficNo_flag").eq(0).val();                 
			trafficNo = $(".part").find("#trafficNo").eq(0).val();   
			trafficLevel_flag = $(".part").find("#trafficLevel_flag").eq(0).val();
			trafficLevel = $(".part").find("#trafficLevel").eq(0).val();
			airplaneCompany_flag = $("#airplaneCompany_flag").val();
			airplaneCompany = $("#airplaneCompany").val();
		}else if(limitSource == "TRAIN"){
			trafficNo_flag = $(".part").find("#trafficNo_flag").eq(1).val();                 
			trafficNo = $(".part").find("#trafficNo").eq(1).val();   
			trafficLevel_flag = $(".part").find("#trafficLevel_flag").eq(1).val();
			trafficLevel = $(".part").find("#trafficLevel").eq(1).val();
		}
		var tripType = $("#tripType").val();
		var timeQuantum_departure = $("#timeQuantum_departure").val();
		var timeQuantum_arrival = $("#timeQuantum_arrival").val();
		
		var period_flag = $("#period_flag").prop("checked");
		var periodValue = "";
		var period = "";
		if(period_flag == true){
			var biaozhi = $("#period").val();
			if(biaozhi == "day"){
				var day_period_start = $("#day_period_start").val();
				var day_period_end = $("#day_period_end").val();
				period = biaozhi;
				periodValue = day_period_start + "-" + day_period_end; 
			}else if(biaozhi == "week"){
				var week_periods = $("input[name='week_period']");
				for(var i=0; i<week_periods.length; i++){
					if(week_periods.eq(i).prop('checked')){
						periodValue += week_periods.eq(i).val(); 	
						periodValue += "-";
					}
				}
				period = biaozhi;
				periodValue = periodValue.substring(0,periodValue.lastIndexOf("-"));
			}else if(biaozhi == "month"){
				var month_period_start = $("#month_period_start").val();
				var month_period_end = $("#month_period_end").val();
				period = biaozhi;
				periodValue = month_period_start + "-" + month_period_end; 
			}
		}
		
		var descripton = $("#descripton").val();
		
		
		if($("#period_flag").prop('checked')==true){
		 if($("#period").val()=="day"){
		 	if($("day_period_start").val()==""||$("day_period_end").val()==""){
 				alert("数据不能为空！");
	            return ;
		 	}
		 }else if($("#period").val()=="month"){
		 	if($("month_period_start").val()==""||$("month_period_end").val()==""){
 				alert("数据不能为空！");
	            return ;
		 	}
		 
		 }else if($("#period").val()=="week"){		 
		 		var week_periods = $("input[name='week_period']");
		 		var weekflag = 0;
				for(var i=0; i<week_periods.length; i++){
					if(week_periods.eq(i).prop('checked')){
			              weekflag = 1;
                          break;
					}
				}
		       if(weekflag == 0){
		       		alert("数据不能为空！");	                
	                return ;
		       }
		 }
	    }
				
		if(promotionRuleName==''||departure==''||arrival==''||timeQuantum_departure==''||timeQuantum_arrival==''){
			alert("数据不能为空！");
			return ;
		}
		
		if(trafficNo == ''){
			trafficNo = '';
		}else{
			trafficNo = trafficNo_flag +"-"+ trafficNo;
		} 
		
		if(trafficLevel == ''){
			trafficLevel = '';
		}else{
			trafficLevel = trafficLevel_flag +"-"+ trafficLevel;
		}
		
		if(airplaneCompany == ''){
			airplaneCompany = '';
		}else{
			airplaneCompany = airplaneCompany_flag +"-"+ airplaneCompany;
		}
		var pmid = $("#pmid").val();
		
		$.ajax({
				url : "${request.contextPath}/rule/insertRule",
				//dataType : "json",
				//contentType : "application/json;",
				type : "POST",
				data : {
					promotionRuleName:promotionRuleName,
					departure:departure,
					arrival:arrival,
					limitSource:limitSource,
					trafficNo:trafficNo,
					trafficLevel:trafficLevel,
					airplaneCompany:airplaneCompany,
					tripType:tripType,
					timeQuantum:timeQuantum_departure +"~"+ timeQuantum_arrival,
					period:period,
					periodValue:periodValue,
					descripton:descripton,
					pmid : pmid
				}, 
				success : function(data) {
					if (data.flag == 'SUCCESS') {
						alert("新增成功！");
						window.location.href="${request.contextPath}/promotionMain/changeValid/"+data.pmid;
					} else {
						alert("数据插入失！"+data.message);
					}
				}
			}); // ajax-end
	}
</script>
</html>