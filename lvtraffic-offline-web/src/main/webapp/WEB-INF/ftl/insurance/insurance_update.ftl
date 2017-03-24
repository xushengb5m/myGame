<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>保险产品修改</title>
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
					url : "${request.contextPath}/insurance/saveInsuranceInfo",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						insuranceInfoDto : setInsuranceInfoDto()
					}),
					success : function(data) {
						alert(data.message);
						window.close();
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据
			function setInsuranceInfoDto() {
			
				//var productTypeStr="";
        		//$("input[tempName='productType']:checkbox").each(function(){ 
            	//	if($(this).attr("checked")){
                //		productTypeStr += $(this).val()+",";
            	//	}
        		//});
        		//productTypeStr=productTypeStr.substring(0,productTypeStr.length-1);
			
				if($("#costPrice").val() == ''){
					alert("销售成本不能为空！");
				}else{
					var insuranceInfoDto = new Object;
					var supp = new Object;
					supp.id = $('#suppId').val();
					insuranceInfoDto.supp = supp;
					insuranceInfoDto.id = $("#id").val();
					insuranceInfoDto.insurancePrice = $("#insurancePrice").val();
					insuranceInfoDto.maxInsureNum = $("#maxInsureNum").val();
					insuranceInfoDto.insuranceDesc = $("#insuranceDesc").val();
					insuranceInfoDto.status = $("#insStatus").val();
					//insuranceInfoDto.productTypes = productTypeStr;
					//insuranceInfoDto.productTypes = $("input[name='productType']:checked").val();
					insuranceInfoDto.productTypes = getProductTypeStr();
					insuranceInfoDto.insuranceType = $("#insuranceType").val();
					insuranceInfoDto.insuranceRemark = $("#insuranceRemark").val();
					insuranceInfoDto.costPrice = $("#costPrice").val();
					//insuranceInfoDto.defaultRule = $("#defaultProduct").val();
					var insuranceClass = new Object;
					insuranceClass.code = $("#insuranceCode").val();
					insuranceClass.name = $("#insuranceClassName").val();
					insuranceInfoDto.insuranceClass = insuranceClass;
					insuranceInfoDto.insuranceAmount = $("#insuranceAmount").val();
					return insuranceInfoDto;
				}
			}
			
		})
	function getProductTypeStr(){
	
	    var productTypeStr = "";
		$("input[name=productType]").each(function() {  
            if ($(this).attr("checked")) {  
                productTypeStr += ","+$(this).val();  
            }  
        }); 
			        
        productTypeStr=productTypeStr.substring(1,productTypeStr.length);
        return productTypeStr;
	}	
	//$(document).ready(function (){
	// 	var productTypes = $("input[type='hidden'][name='productTypes']");
	// 	$.each(productTypes,function (){
	//    	var val=$(this).val();
	//    	var str = val.split(",");
	//		for (var i=0;i<str.length;i++){
	//			var checkboxs =  $("input[type='checkbox'][name='productType'][value="+str[i]+"]");   
	//	    	$.each(checkboxs,function (){
	//		   		this.checked=true;
	//			});
	//		}
	//    });
	//});
	
	  $(document).ready(function (){
	     var productTypes = $("input[type='hidden'][name='productTypes']");
	     $.each(productTypes,function (){
	        var val=$(this).val();
	        var str = val.split(",");
	      	for (var i=0;i<str.length;i++){
	        	var radios =  $("input[type='radio'][name='productType'][value="+str[i]+"]");   
	          	$.each(radios,function (){
	             	this.checked=true;
	        	});
	        }
	     });
	  });
	function fixPrice(obj){
	   var price = parseFloat($(obj).val()).toFixed(2);
	   if(isNaN(price)){
	      $(obj).val("");
	   }else{
	      $(obj).val(price);
	   }
	   
	}
	</script>
	
</head>
  
<body>

	<div class="content content1">
	<div class="breadnav"><span>首页</span> > 保险产品维护</div>
        <input type="hidden" name="search" value="false">
        <input type="hidden" id="productTypes" name="productTypes" value="${(insuranceInfo.productTypes)!''}">
		<div class="infor1">
			
			<div class="product ms">
				<div class="main">
					<div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >基本信息</label></div>
					<div class="part" style="">
						<input type="hidden" id="id" name="id" value="${(insuranceInfo.id)!''}" />
						<input type="hidden" id="insuranceCode" name="insuranceCode" value="${(insuranceInfo.insuranceClass.code)!''}" />
						<input type="hidden" id="suppId" name="suppId" value="${(insuranceInfo.supp.id)!''}" />
						
						<span style="margin-left:10px;">供应商：</span><span style="margin-left:10px;">${(insuranceInfo.supp.name)!''}</span>
						
						<span style="margin-left:90px;">产品编码：</span><span style="margin-left:10px;">${(insuranceInfo.insuranceClass.code)!''}</span>
						<span style="margin-left:10px;">保险类型：</span>
						<select name="insuranceType" id="insuranceType">
							<#list insuranceTypeEnum as val>
					        	<option value="${val}" <#if val == insuranceInfo.insuranceType>selected </#if>>${val.cnName}</option>
					        </#list> 
				        </select>
				        <span style="margin-left:10px;">产品状态：</span>
						<select name="insStatus" id="insStatus">
							<option value="${(insuranceInfo.status)!''}">${(insuranceInfo.status.cnName)!''}</option>
							<#if insuranceInfo.status = "VALID">
								<option value="INVALID">无效</option>
							</#if>
							<#if insuranceInfo.status = "INVALID">
								<option value="VALID">有效</option>
							</#if>
						</select>
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>险种名称：</span><span style="margin-left:10px;">
						<input type="text" id="insuranceClassName" name="insuranceClassName" value="${(insuranceInfo.insuranceClass.name)!''}"/></span>
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>保额：</span>
						<input type="text" id="insuranceAmount" name="insuranceAmount" value="${(insuranceInfo.insuranceAmount)!''}" style="width:120px" />
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>适用产品类型：</span>
						<#list productEnum as productType>
								<input type="checkbox" name="productType" id="productType${productType_index+1}" value="${productType}" 
								<#if insuranceInfo.productTypes?? && insuranceInfo.productTypes?index_of(productType)!=-1> checked="checked" </#if> 
								 /> <label for="productType${productType_index+1}">${productType.cnName}</label>
						</#list>	
						</br>
						<span style="margin-left:10px;">保险简介：</span>
						<input type="text" id="insuranceRemark" maxlength="10" name="insuranceRemark" style="width:540px" value="${(insuranceInfo.insuranceRemark)!''}"/>
						</br>
						<span style="">保险说明：</span>
						<textarea id="insuranceDesc" name="insuranceDesc" style="width:660px" rows="10">${(insuranceInfo.insuranceDesc)!''}</textarea>
						
					</div>
					
					<div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >销售信息</label></div>
					<div class="part" style="">
						<span style="margin-left:10px;"> 最多销售份数：</span>
						<input type="text" id="maxInsureNum" name="maxInsureNum" value="${(insuranceInfo.maxInsureNum)!''}" 
						maxlength="2" style="width:40px;IME-MODE: disabled;" onblur="value=value.replace(/[^\d]/g,'')"  />
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>市场参考销售价：</span>
						<input type="text" id="insurancePrice" name="insurancePrice" value="${(insuranceInfo.insurancePrice)!''}" 
						maxlength="3" style="width:80px;IME-MODE: disabled;" onblur="fixPrice(this)"  />
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>销售成本价：</span>
						<input type="text" id="costPrice" name="costPrice"  value="${(insuranceInfo.costPrice)!''}"
						maxlength="3" style="width:80px;IME-MODE: disabled;" onblur="fixPrice(this)"  />
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