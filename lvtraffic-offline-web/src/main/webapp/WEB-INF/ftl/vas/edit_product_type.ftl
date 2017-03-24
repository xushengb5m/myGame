<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
 
	<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
    <link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>

    <style>
        .vas_add{

        }
        div.vas_add > span {
            display: inline-block;
            width: 100px;
            text-align:right;
        }
        div.vas_add  input {
            height: 20px;
            width: 250px;
        }
        div.vas_add  select {
            height: 20px;
            width: 250px;
        }
    </style>
</head>
<body>
<div class="content content1">
    <form id="add_vas_product_form" name="add_vas_product_form" >
        <div class="breadnav"><span>增值服务</span>>产品管理>新增产品</div>
        <div class="infor1" id="conditionDiv">
            <div class="order message">
                <div class="main">
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >产品类型基本信息</label></div>

                    <div class="vas_add">
                    	<input type="hidden" name="id" id="id" value="${vasProductType.id}"/>
                        <span >产品主类型code:</span>&nbsp;&nbsp;<input name="mainProductCode" id="mainProductCode" value="${vasProductType.mainProductCode}"/><br>
                        <span>产品类型:</span>&nbsp;&nbsp;
                        <select id="mainProductName" name="mainProductName" >
					  	 <option value="">全部</option> 
					  	 <#list typeList as type>
					  	 	<#if vasProductType.mainProductName == type>
					  	 		<option value="${type}" selected='selected'>${type}</option>
					  	 		<#else>
					  	 		<option value="${type}">${type}</option>
					  	 	</#if>
					  	 </#list> 							  	
                        </select><br>
                        <!--<span >产品主类型名称:</span>&nbsp;&nbsp;<input  name="mainProductName" id="mainProductName" value="${vasProductType.mainProductName}"/><br>-->
                        <span >产品子类型code:</span>&nbsp;&nbsp;<input name="subProductCode" id="subProductCode" value="${vasProductType.subProductCode}"/><br>
                        <span >产品子类型名称:</span>&nbsp;&nbsp;<input name="subProductName" id="subProductName" value="${vasProductType.subProductName}"/><br>
                        <span >有效状态:</span>
						<select id="activeStatus_Str" name="activeStatus_Str" >
                            <#list productStatus as val>  
							  <#if val !="NULL">
							  	<#if "${val}"=="${vasProductType.activeStatus.activeStatus}">
								  	        <#if "ACTIVE" == "${val}">				  					  		 							  		 
												<option value="${val}" selected='selected' >有效</option>	
											</#if>
											<#if "INACTIVE" == "${val}">				  					  		 							  		 
												<option value="${val}" selected='selected' >无效</option>	
											</#if>
							  		 <#else>
									        <#if "ACTIVE" == "${val}">				  					  		 							  		 
												<option value="${val}">有效</option>	
											</#if>	
											<#if "INACTIVE" == "${val}">				  					  		 							  		 
												<option value="${val}">无效</option>	
											</#if>	
							  	</#if>
							  </#if> 
							</#list>
                        </select>
                    </div>
                    <div style="margin-left: 30%;margin-top: 30px">
                        <input id="bt_edit_vas_product_type" style="width: 90px;height: 30px" type="button" name="" value="修改">
                    </div>
                </div>
            </div>
        </div>
    </form>
    </div>
</body>
<script>

    $(function(){

        $("#bt_edit_vas_product_type").on("click",function(){

            var mainProductCodeVal = $("#mainProductCode").val();
            var mainProductNameVal = $("#mainProductName").val();
            var subProductCodeVal = $("#subProductCode").val();
            var subProductName = $("#subProductName").val();
            var activeStatus_Str = $("#activeStatus_Str").val();
            var id = $("#id").val();
            
            if(mainProductCodeVal == ''){
				alert("产品主类型code 不能空");
				return false;
			}
			if(mainProductNameVal == ''){
				alert("产品主类型名称 不能空");
				return false;
			}
			if(subProductCodeVal == ''){
				alert("产品子类型code 不能空");
				return false;
			}
			if(subProductName == ''){
				alert("产品子类型名称 不能空");
				return false;
			}
			
            $.ajax({
                url : '${request.contextPath}/vasProductType/editVasProductType',
                type : 'POST',
                data : {
                    mainProductCode : mainProductCodeVal,
                    mainProductName : mainProductNameVal,
                    subProductCode : subProductCodeVal,
                    subProductName : subProductName,
                    activeStatus_Str :activeStatus_Str,
                    id:id
                },
                success : function(data){
 
                    if(data.flag == 'SUCCESS'){
                        alert("产品类型修改成功！");
                        /*if(data.flag == 'false'){
                            window.location.href="${request.contextPath}/promotionMain/changeValid/"+data.pmid;
                        }else if(data.flag == 'true'){
                            window.location.href="${request.contextPath}/promotion/toPromotionList";
                        }*/
                    }else{
                        alert("产品类型修改失败");
                    }
                }
            });
        });
    });
</script>
</html>

















