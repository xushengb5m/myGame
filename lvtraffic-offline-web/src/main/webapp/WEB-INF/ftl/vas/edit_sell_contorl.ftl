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
    <div class="breadnav"><span>增值服务</span>>销售调控</div>
    <div class="infor1" id="conditionDiv">
        <div class="order message">
            <div class="main">
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >产品基本信息</label></div>

                <div class="vas_add">
                	 <br/>
                    <span >产品类型:</span>&nbsp;<span>${vasProductInfo.productType.subProductName}</span>&nbsp;&nbsp;&nbsp;
                    <span >产品ID:</span>&nbsp;<span>${vasProductInfo.id}</span>&nbsp;&nbsp;&nbsp;
                    <span >产品名称：</span>&nbsp;<span>${vasProductInfo.productName}</span>&nbsp;&nbsp;&nbsp;
                    <span >产品编码:</span>&nbsp;<span>${vasProductInfo.productType.subProductCode}</span>&nbsp;&nbsp;&nbsp;
                    <span >供应商:</span>&nbsp;<span>${vasProductInfo.suppInfoDto.suppName}</span>&nbsp;&nbsp;&nbsp;
                    <input id="settlementPrice" name="settlementPrice" type="hidden" value="${vasProductInfo.settlementPrice}" />
                     <input id="ruleId" name="ruleId" type="hidden" value="${vasProductInfo.productSaleRuleDto.id}" />
                     <input id="productId" name="productId" type="hidden" value="${vasProductInfo.id}" />
                   
                </div>
                 <br/>
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >销售调控信息</label></div>
                <div class="vas_add">

                    <span>出发日期：</span><input type="text" id="deptstartDate" name="deptstartDate" value="${vasProductInfo.productSaleRuleDto.deptDateRange.startDate_Str}" onfocus="var deptendDate=$dp.$('deptendDate');WdatePicker({onpicked:function(){deptendDate.focus();},maxDate:'#F{$dp.$D(\'deptendDate\')}'})" style="width:100px;" class="Wdate" />
                    &nbsp; &nbsp;至 &nbsp; &nbsp;
                    <input type="text" id="deptendDate" name="deptendDate" value="${vasProductInfo.productSaleRuleDto.deptDateRange.endDate_Str}" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'deptstartDate\')}'})" style="width:100px;" class="Wdate"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span>销售日期：</span><input type="text" id="salestartDate" name="salestartDate" value="${vasProductInfo.productSaleRuleDto.saleDateRange.startDate_Str}" onfocus="var saleendDate=$dp.$('saleendDate');WdatePicker({onpicked:function(){saleendDate.focus();},maxDate:'#F{$dp.$D(\'saleendDate\')}'})" style="width:100px;" class="Wdate" />
                    &nbsp; &nbsp;至 &nbsp; &nbsp;
                    <input type="text" id="saleendDate" name="saleendDate" value="${vasProductInfo.productSaleRuleDto.saleDateRange.endDate_Str}" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'salestartDate\')}'})" style="width:100px;" class="Wdate" />
                </div>
                <div>
                    <br/>
                    <input type="radio"  checked="checked"/><span>基于结算价固定加价</span>
                    <table style="width: 600px">
                        <tr>
                            <th>渠道</th>
                            <th>加价</th>
                            <th>销售价</th>
                        </tr>

                        <#list vasProductInfo.saleChannelPrices as saleChanPrice>
                            <tr>
                                <td>${saleChanPrice.parentSaleChannel}
                                	<input type="hidden" name="saleChanName" value="${saleChanPrice.parentSaleChannel}" />
                                </td>
                                <td><input type="text"  name="plusPrice" value="${saleChanPrice.plusPrice}"/>
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

     $(function(){
     
        //
        
        $("input[name='plusPrice']").each(
                function(){
                    $(this).on('blur',function(){
                        var settlementPrice = $("#settlementPrice").val();
                        $(this).parent().next('td').text($(this).val()*1 + settlementPrice*1);            
                    })
                }
        )

       $("#bt_edit_sale_control").on("click",function(){
		
			var flag = false;
			$("input[name='plusPrice']").each(
                function(){
                    if("-" == $(this).val().substring(0,1)){
                        if(Math.abs($(this).val()) > $("#settlementPrice").val()){
                            alert("加价金额:"+$(this).val()+", 绝对值不能大于结算价");
                            flag = true;
                            return false;
                        }
                    };

                }
            )
            if(flag){
	            
	            return false;
            };
          
            
            //return false;
            $("#frm_edit_sale_control").ajaxForm({
                url:"${request.contextPath}/vasProduct/editProductSaleControl",
                type:"post",
                beforeSubmit:function(){
					//alert(11);
					
                },
                success:function(data){
					if(data.flag == 'SUCCESS'){
						alert("编辑销售调控成功!");
					}else{
						alert("编辑销售调控失败!");
					}
                },
                clearForm:false,
                restForm:false,
                timeout:6000
            });
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