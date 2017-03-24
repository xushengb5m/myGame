<!DOCTYPE html>
<html lang="en">
<head>

    <link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
    <link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
    <link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
    <link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
    <script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
    <script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
    <script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
    <script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${request.contextPath}/js/jquery.form.js"></script>

    <style>
        table tr td input {
            width: 150px;
            height: 20px;
        }
    </style>
</head>
<body>
<div class="content content1">
<form id="frm_edit_sale_control" name="frm_edit_sale_control" >
      <input id="saleChannelStatus" name="saleChannelStatus" type="hidden" value="" />
    <div class="breadnav"><span>增值服务</span>>销售调控</div>
    <div class="infor1" id="conditionDiv">
        <div class="order message">
            <div class="main">
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >产品基本信息</label></div>

                <div class="vas_add">
                	 <br/>
                    <span >子类型:</span>&nbsp;<span>${vasProductInfo.productType.subProductName}</span>&nbsp;&nbsp;&nbsp;
                    <span >产品名称：</span>&nbsp;<span>${vasProductInfo.productName}</span>&nbsp;&nbsp;&nbsp;
                    <span >供应商:</span>&nbsp;<span>${vasProductInfo.suppInfoDto.suppName}</span>&nbsp;&nbsp;&nbsp;
                    <input id="settlementPrice" name="settlementPrice" type="hidden" value="${vasProductInfo.settlementPrice}" />
                     <input id="ruleId" name="ruleId" type="hidden" value="${vasProductInfo.productSaleRuleDto.id}" />
                     <input id="productId" name="productId" type="hidden" value="${vasProductInfo.id}" />
                   
                </div>
                 <br/>
                 <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >可售产品线</label></div>

                <div class="vas_add">
                	 <br/>
                    <#list vasCouponProductLine as su> 
							<input type="checkbox" name="vasCouponProductLineNames"  id="${su}"
							
							<#if vasProductInfo.productSaleRuleDto.vasCouponProductLineNames?? && vasProductInfo.productSaleRuleDto.vasCouponProductLineNames?index_of(su)!=-1> checked="checked" </#if> 
							value="${su}" /> <span>${su.cnName}</span>
							
					</#list>
                   
                </div>
                 <br/>
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >销售日期</label></div>
                <div class="vas_add">

                    <span></span><input type="text" id="salestartDate" name="salestartDate" value="${vasProductInfo.productSaleRuleDto.saleDateRange.startDate_Str}" onfocus="var saleendDate=$dp.$('saleendDate');WdatePicker({onpicked:function(){saleendDate.focus();},maxDate:'#F{$dp.$D(\'saleendDate\')}'})" style="width:100px;" class="Wdate" />
                    &nbsp; &nbsp;至 &nbsp; &nbsp;
                    <input type="text" id="saleendDate" name="saleendDate" value="${vasProductInfo.productSaleRuleDto.saleDateRange.endDate_Str}" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'salestartDate\')}'})" style="width:100px;" class="Wdate" />
                </div>
                <div>
                    <br/>
                    <span>批量加价</span><input type="text"  value = "" name="batchPlusPrice" id="batchPlusPrice" onblur="batchPlusSalePrice(this)"/>
                    <table style="width: 600px">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="allChBox"/></th>
                            <th>渠道</th>
                            <th>加价</th>
                            <th>销售价</th>
                        </tr>

                        <#list vasProductInfo.saleChannelPrices as saleChanPrice>
                             
                            <tr class="salePriceTable">
	                            <#if "VALID" == "${saleChanPrice.saleChannelStatus}">
				                    <th><input type="checkbox"  checked="checked" /> </th>
				                    <#else>
				                        <th><input type="checkbox"  /> </th>
				                </#if>
                                <td>${saleChanPrice.parentSaleChannel.cnName}
                                	<input type="hidden" name="saleChanName" value="${saleChanPrice.parentSaleChannel.cnName}" />
                                </td>
                                <td><input type="text"  name="plusPrice" value="${saleChanPrice.plusPrice}" />
                                    <input type="hidden" name="saleChanPriceId" value="${saleChanPrice.id}" />
                                </td>
                                <td>${saleChanPrice.channelSalePrice}</td>
                            </tr>
                        </#list>
                        

                    </table>
                </div>
                <div style="margin-left: 30%;margin-top: 30px">
                    <input style="width: 90px;height: 30px" type="submit" id="bt_edit_sale_control" name="bt_edit_sale_control" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input style="width: 90px;height: 30px" type="button" id="bt_cancel_edit" name="bt_cancel_edit" value="取消">
                </div>
            </div>
        </div>
    </div>
</form>
</div>
</body>
<script>

      $("#allChBox").change(function(){
		   		
		   		 if('checked' == $(this).attr("checked")){
		   		 	$(".salePriceTable input[type=checkbox]").attr("checked",'true');
		   		 }else{
		   		 	$(".salePriceTable input[type=checkbox]").removeAttr("checked");
		   		 }
				
				});	
				  	  		        
     function batchPlusSalePrice(obj){
	   if("-" == $(obj).val().substring(0,1)){
	        if(Math.abs($(obj).val()) > $("#settlementPrice").val()){
                            alert("销售价不能小于0，请重新调整加价金额");
                            return false;
                        }
	   }
	   
        $("input[name='plusPrice']").val($("#batchPlusPrice").val());
        $("tr").each(function () {
                obj = $(this).find("td:last").first();
                
                if($(obj).html()){
                  $(obj).html($("#settlementPrice").val()*1+$("#batchPlusPrice").val()*1);
                  
                }
                
            });
       return  true;      
	 }
	 
	 function getSaleChannelStatus(){
	   
	    var saleChannelStatusStr = ""
        $("tr").each(function () {
                var obj = $(this).find("td:last").first();
                
                var saleCheckBox = $(this).find("th:first").first().find("input");
                if($(obj).html()){
                  
                  if('checked' == $(saleCheckBox).attr("checked")){
                    saleChannelStatusStr = saleChannelStatusStr.concat("VALID,");
                  }else{
                    saleChannelStatusStr = saleChannelStatusStr.concat("INVALID,")
                  }
                }
                
            });
        $("#saleChannelStatus").val(saleChannelStatusStr);
       }     
     function validateInt(num){
      try{
          return !isNaN(parseInt(num));
      }catch(e){
        return false;
      }
       return true;
     }
     $(function(){
     
      $("input[name='plusPrice']").blur(function(){
           var settlementPrice = $("#settlementPrice").val();
           $(this).parent().next('td').text($(this).val()*1 + settlementPrice*1);  
           if("-" == $(this).val().substring(0,1)){
                        if(Math.abs($(this).val()) > $("#settlementPrice").val()){
                            alert("销售价不能小于0，请重新调整加价金额");
                            flag = true;
                            return false;
                        }
                    };
            if($(this).val()=="")$(this).val(0);        
            if(!validateInt($(this).val())){
                            alert("加价金额必须是数字");
                            flag = true;
                            return false;
                    }
       })
        //
       // if($("[name='vasCouponProductLine']").attr("checked")==false)return false;
        
       // $("input[name='plusPrice']").each(
       //         function(){
       //             $(this).on('blur',function(){
       //                 var settlementPrice = $("#settlementPrice").val();
        //                $(this).parent().next('td').text($(this).val()*1 + settlementPrice*1);            
        //            })
        //        }
      //  )

       $("#bt_edit_sale_control").on("click",function(){
		 if($("#LVFLIGHT").attr("checked")||$("#LVTRAIN").attr("checked")){
		     var flag = false;
			$("input[name='plusPrice']").each(
                function(){
                    if("-" == $(this).val().substring(0,1)){
                        if(Math.abs($(this).val()) > $("#settlementPrice").val()){
                            alert("销售价不能小于0，请重新调整加价金额");
                            flag = true;
                            return false;
                        }
                    };
                   if($(this).val()=="")$(this).val(0);   
                    if(!validateInt($(this).val())){
                            alert("加价金额必须是数字");
                            flag = true;
                            return false;
                    }

                }
            )
            if(flag){
	            
	            return false;
            };
           getSaleChannelStatus();
            $("#frm_edit_sale_control").ajaxForm({
                url:"${request.contextPath}/vasProduct/editCouponProductSaleControl",
                type:"post",
                beforeSubmit:function(){
					
                },
                success:function(data){
					if(data.flag == 'SUCCESS'){
						alert("编辑销售调控成功!");
					}else{
						alert("编辑销售调控失败!");
					}
                },
              
            });
		   }else{
		     alert("至少选择一个产品线");
		      return false;
		   }
			
        });

        $("#bt_cancel_edit").on('click',function(){
            if(confirm("确定取消编辑?")){
                window.close();
            }else{

            }
        });
    });
</script>
</html>