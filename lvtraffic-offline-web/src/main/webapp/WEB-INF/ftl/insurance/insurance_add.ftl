<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>保险产品新增</title>
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
					url : "addInsurance",
					dataType : "json",
					contentType : "application/json;",
					type : "POST",
					data : JSON.stringify({
						insuranceInfoDto : setInsuranceInfoDto()
					}),
					success : function(data) {
						alert(data.message);
					}
				}); //ajax-end
			});//.button-end
			
			//组装数据
			function setInsuranceInfoDto() {
			
				 
				if($.trim($('#insuranceCode').val()) == ''){
					alert("产品编码不能为空！");
				}else if($.trim($('#insuranceName').val()) == ''){
					alert("险种名称不能为空！");
				}else if($('#insuranceAmount').val() == ''){
					alert("保额不能为空！");
				}else if($("#insurancePrice").val() == ''){
					alert("市场参考销售价不能为空！");
				}else if($("#costPrice").val() == ''){
					alert("销售成本价不能为空！");
				}else{
					var insuranceInfoDto = new Object;
					var supp = new Object;
					supp.id = $('#suppName').val();
					insuranceInfoDto.supp = supp;
					var insuranceClass = new Object;
					insuranceClass.code = $.trim($('#insuranceCode').val());
					insuranceClass.name = $.trim($('#insuranceName').val());
					//insuranceClass.name = $('#insuranceName').find("option:selected").text();
					insuranceInfoDto.insuranceClass = insuranceClass;
					insuranceInfoDto.insurancePrice = $.trim($("#insurancePrice").val());
					insuranceInfoDto.maxInsureNum = $.trim($("#maxInsureNum").val());
					insuranceInfoDto.insuranceDesc = $.trim($("#insuranceDesc").val());
					insuranceInfoDto.productTypes =getProductTypeStr();
					insuranceInfoDto.insuranceType = $.trim($("#insuranceType").val());
					insuranceInfoDto.insuranceRemark = $.trim($("#insuranceRemark").val());
					insuranceInfoDto.costPrice = $.trim($("#costPrice").val());
					insuranceInfoDto.defaultRule = "NOT_DEFAULT";
					insuranceInfoDto.status = $("#status").val();
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
	//判断如果选择全部，则取消其他选择
	function opeateClick(opeateName,opeateVal){
	     if(opeateVal!="" &&　opeateVal=="ALL"){
		     $("input[tempName='"+opeateName+"']:checkbox").each(function(id) {
		         var index=parseInt(id)+1;
				$("#"+opeateName+index).attr("checked",false);
			});
	     }else{
             $("#"+opeateName+"0").attr("checked",false);;
	     }
	}
	
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
		<div class="infor1">
			
			<div class="product ms">
				
				<div class="main">
					<div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >基本信息</label></div>
					<div class="part" style="">
						<span style="margin-left:10px;">&nbsp;&nbsp;&nbsp;供应商：</span>
						<select name="suppName" id="suppName">
							<#list supps as supp>
								<option value="${(supp.id)!''}">${(supp.name)!''}</option>
							</#list>
						</select>
						<span style="margin-left:10px;">产品编码：</span><input type="text" id="insuranceCode" name="insuranceCode" style="width:80px" />
						<span style="margin-left:10px;">保险类型：</span>
						<select name="insuranceType" id="insuranceType">
							<#list insuranceTypeEnum as val>
					        	<option value="${val}">${val.cnName}</option>
					        </#list> 
				        </select>
				        
						<span style="margin-left:10px;">产品状态：</span>
						<select name="status" id="status">
								<option value="INVALID">无效</option>
					        	<option value="VALID">有效</option>
				        </select>
				        </br>
				         <span style="margin-left:10px;"><span style="color: red">*</span>险种名称：</span><input type="text" id="insuranceName" name="insuranceName" style="width:120px" />
				         </br>
						 <span style="margin-left:10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red">*</span>保额：</span><input type="text" id="insuranceAmount" name="insuranceAmount" style="width:120px" />
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>适用产品类型：</span>
						<#list productEnum as productType>
						   	<!--<input type="checkbox" class="choose" tempName="productType" onclick="opeateClick('productType',this.value)" id="productType${productType_index+1}" name="productType${productType_index+1}" 
						   		value="${productType}" /> ${productType.cnName}-->
						   	<input type="checkbox" name="productType" id="productType${productType_index+1}" value="${productType}"  /> <label for="productType${productType_index+1}">${productType.cnName}</label>
						</#list>
						</br>
						<span style="margin-left:10px;">保险简介：</span><input type="text" id="insuranceRemark" name="insuranceRemark" maxlength="10" style="width:680px" />
						</br>
						<span>保险说明：</span><textarea id="insuranceDesc" name="insuranceDesc" style="width:702px" rows="6" ></textarea>
						
					</div>	
					
					<div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >销售信息</label></div>
					<div class="part" style="">		
						<span style="margin-left:10px;">最多销售份数：</span>
						<input type="text" id="maxInsureNum" name="maxInsureNum" maxlength="2" style="IME-MODE: disabled;"
						onblur="value=value.replace(/[^\d]/g,'')"  />
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>市场参考销售价：</span>
						<input type="text" id="insurancePrice" name="insurancePrice" maxlength="3" style="width:90px;IME-MODE: disabled;" 
						onblur="fixPrice(this)"  />
						</br>
						<span style="margin-left:10px;"><span style="color: red">*</span>销售成本价：</span>
						<input type="text" id="costPrice" name="costPrice" maxlength="3" style="width:90px;IME-MODE: disabled;" 
						onblur="fixPrice(this)"  />
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