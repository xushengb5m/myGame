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
    <script type="text/javascript" src="${request.contextPath}/js/jquery.form.js"></script>

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
        .no_border{
            border-left:0px;
            border-top: 0px;
            border-right: 0px;
            border-bottom: 0px;
        }
    </style>
</head>
<body>
<div class="content content1">
    <form id="add_vas_product_form" name="add_vas_product_form" enctype="multipart/form-data">
        <div class="breadnav"><span>增值服务</span>>产品管理>新增产品</div>
        <div class="infor1" id="conditionDiv">
            <div class="order message">
                <div class="main">
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >基本信息</label></div>
					
					<#if isCouponProduct?? && isCouponProduct=="true">
					 <div class="vas_add">
                        <span >产品ID:</span>&nbsp;&nbsp;<input class="no_border" readonly="true"  name=""/>&nbsp;&nbsp;&nbsp;&nbsp;
                        <br> 
						<input type="hidden" id="productTypeId" name="productTypeId"  value="${productTypeId}"/> 
						<input type="hidden"  id="includeDeptAirports" name="includeDeptAirports" value="" />
                        <span >供应商:</span>&nbsp;&nbsp;
                        <select id="suppCode" name="suppCode" >
                            <!--<option value ="112">空港易行</option>-->
                   			<#list suppList as val>  							  
								<option value="${val.code}">${val.name}</option>
							</#list>
                        </select><br>  
                        <span ><span style="color: red">*</span>产品名称:</span>&nbsp;&nbsp;
                        <input type="text" id="productName" name="productName" /><br>
                        <span ><span style="color: red">*</span>产品简介:</span>&nbsp;&nbsp;
                        <input type="text" id="productDesc" name="productDesc"  /><br>
                        <span ><span style="color: red">*</span>推荐级别:</span>&nbsp;&nbsp;
                        <select id="recommendLevel" name="recommendLevel" >
                            <#list recmdLeveal as val>  							  
								<option value="${val.levealCode}">${val.levealCode}</option>
							</#list>
                        </select><br>
                    </div>
					<#else>
                    <div class="vas_add">
                        <span >产品ID:</span>&nbsp;&nbsp;<input class="no_border" readonly="true"  name=""/>&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>子类型:</span>&nbsp;&nbsp;
                        <select id="productTypeId" name="productTypeId" >
                             <#list productTypeList as val>  
							  <#if val !="NULL">							  	
								 <option value="${val.id}">${val.subProductName}</option>
							  </#if> 
							</#list>
                        </select><br>
                        <span >供应商:</span>&nbsp;&nbsp;
                        <select id="suppCode" name="suppCode" >
                            <!--<option value ="112">空港易行</option>-->
                   			<#list suppList as val>  							  
								<option value="${val.code}">${val.name}</option>
							</#list>
                        </select><br>
                        <span >code:</span>&nbsp;&nbsp;<input class="no_border" readonly="true" style="" id="subProductCode" name="subProductCode" value="" /><br>
                                            
                        <span ><span style="color: red">*</span>产品名称:</span>&nbsp;&nbsp;
                        <input type="text" id="productName" name="productName"  value=""/><br>
                        <span ><span style="color: red">*</span>提前销售天数:</span>&nbsp;&nbsp;
                        <input id ="advancedDays" name="advancedDays" value="0" /><br>
                        <span ><span style="color: red">*</span>推荐级别:</span>&nbsp;&nbsp;
                        <select id="recommendLevel" name="recommendLevel" >
                            <#list recmdLeveal as val>  							  
								<option value="${val.levealCode}">${val.levealCode}</option>
							</#list>
                        </select><br>
                    </div>
                    </#if>
                    
                    <#if isCouponProduct??  && isCouponProduct=="true">
                     <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >券码管理</label></div>
                    <div class="vas_add">
                         <div class="vas_add" tag='batch' ><span>批次号1</span>&nbsp;&nbsp;<input id="batchNo1" name="batchNo1" oldvalue=''  onblur="checkno(this)"   /></div>  
						 <div style='margin-left:60px' ><button  onclick='addbatch()'  type="button"  >新增批次</button></div>
                    </div>
					 <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >使用说明就和退改规则</label></div>
                    <div class="vas_add" style="margin-top:6px"> 
                        <span>详细说明:</span>&nbsp;&nbsp;<textarea id="serviceContent" name="serviceContent"  style="width: 400px;height: 80px"></textarea><br>
                        <span>退改规定:</span>&nbsp;&nbsp;<textarea id="tgqRule" name="tgqRule"  style="width: 400px;height: 80px"></textarea><br>
                    </div>
					 <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >库存/价格</label></div>
                    <div class="vas_add">
                        <span><span style="color: red">*</span>总库存:</span>&nbsp;&nbsp;<input  id ='totalStock' name="totalStock" valid='num'  desc='总库存' onchange="sameStock(this)"  value="0" /><br/>
                        <span><span style="color: red">*</span>剩余库存:</span>&nbsp;&nbsp;<input class="no_border" id="remainingStock" name="remainingStock" readonly="true" value="0" /><br/>
                        <span><span style="color: red">*</span>结算价:</span>&nbsp;&nbsp;<input id="settlementPrice" valid='decimal' desc='结算价' name="settlementPrice"/><br/>
                        <span><span style="color: red">*</span>市场价:</span>&nbsp;&nbsp;<input id="marketPrice" valid='decimal' desc='市场价' name="marketPrice"  /><br/>
                    </div> 
                    <#else>
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >适用机场及信息说明</label></div>
                    <div class="vas_add">
                        <span><span style="color: red">*</span>适用机场:</span>&nbsp;&nbsp;
                        <input id="includeDeptAirports" name="includeDeptAirports" value="请填写机场三字码，仅支持单个" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999" />
                         &nbsp;&nbsp;&nbsp;&nbsp;<span>适用航站楼:</span>&nbsp;&nbsp;
                        <input id="includeDeptTerminals" name="includeDeptTerminals" value="如T1，仅支持单个" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999" /><br>
                        <span>营业时间：</span>
                        <input type="text" id="startTime" name="startTime" onfocus="WdatePicker({dateFmt:'HH:mm',qsEnabled:false})" style="width:100px;" class="Wdate" />
                        &nbsp; &nbsp;
                       	 至 &nbsp; &nbsp;
                        <input type="text" id="endTime" name="endTime" onfocus="WdatePicker({dateFmt:'HH:mm',qsEnabled:false})" style="width:100px;" class="Wdate" readonly="readonly"/><br/>
                        <span>位置指引:</span>&nbsp;&nbsp;<textarea id="location" name="location"  style="width: 400px;height: 80px"></textarea><br>
                        <span>服务内容:</span>&nbsp;&nbsp;<textarea id="serviceContent" name="serviceContent"  style="width: 400px;height: 80px"></textarea><br>
                        <span>退改规定:</span>&nbsp;&nbsp;<textarea id="tgqRule" name="tgqRule"  style="width: 400px;height: 80px"></textarea><br>
                    </div>
                     <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >产品图片</label></div>
                    <div class="vas_add">
                        <span>选择图片:</span>&nbsp;&nbsp;<input id="vas_img_upload" multiple  type="file" name="vas_img_upload" /> &nbsp;&nbsp;&nbsp;
                        <input type="button" style="width: 80px;visibility: hidden"  value="上传" /><br/><br/>
                        <img  id="vas_img_1" name="vas_img" style="visibility: hidden" src="">
                        <img id="vas_img_2" name="vas_img"  style="visibility: hidden" src="">
                        <img id="vas_img_3" name="vas_img"  style="visibility: hidden" src="">
                    </div>
                    
					 <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >库存/价格</label></div>
                    <div class="vas_add">
                        <span>总库存:</span>&nbsp;&nbsp;<input class="no_border" id ='totalStock' name="totalStock" readonly="true" value="0" /><br/>
                        <span>剩余库存:</span>&nbsp;&nbsp;<input class="no_border" id="remainingStock" name="remainingStock" readonly="true" value="0" /><br/>
                        <span><span style="color: red">*</span>结算价:</span>&nbsp;&nbsp;<input id="settlementPrice" name="settlementPrice"/><br/>
                        <span><span style="color: red">*</span>市场价:</span>&nbsp;&nbsp;<input id="marketPrice" name="marketPrice"  /><br/>
                    </div> 
                    </#if>   
                    <div style="margin-left: 30%;margin-top: 30px">
                        <input id="bt_add_vas_product" style="width: 90px;height: 30px" type="button" name="" value="保存">
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
<script>
	var isCouponProduct = ${isCouponProduct};
    $(function(){
        //选中默认code 
        if($("#productTypeId").val() != ""){
            $.ajax({
                        url:"${request.contextPath}/vasProductType/queryProductTypeById",
                        data:{productTypeId:$("#productTypeId").val()},
                        type:'post',
                        dataType:'json',
                        success:function(data){
//                    alert(data);
                            $("#subProductCode").val(data.subProductCode);
                        }
                    }
            )
        }
        
        
        $("#bt_add_vas_product").on("click",function(){
            //console.log($(this)); 
            if(isCouponProduct){  
				//校验
				if($("#productName").val() == ""){
					alert("产品名称不能为空!"); 
					return;
				} 
				if($("#productDesc").val() == ""){
					alert("产品简介不能为空!");
					return;
				} 
				if($("#recommendLevel").val() == ""){
					alert("推荐级别不能为空!");
					return;
				} 
				if($("#settlementPrice").val() == ""){
					alert("结算价不能为空!");
					return;
				}
				if($("#marketPrice").val() == ""){
					alert("市场价不能为空!");
					return;
				} 
				
				var reg = new RegExp("^\\d+$");
			   
				if(!reg.test($("#totalStock").val())){
					alert("总库存请输入非负整数!");
					return ;
				}
				
				var num = $('div[tag=batch] input[value!=""]').size();
				if(num<1){
					alert("至少需输入一个优惠券批次号!");
					$('div[tag=batch] input:first').focus();
					return;
				}
				
				if($('input[id^=batchNo][value=]').size()>0){
					alert("优惠券批次号不得为空!");
					$('input[id^=batchNo][value=]:first').focus();
					return;
				}	

			}else{
				if($("#includeDeptAirports").val() == document.getElementById('includeDeptAirports').defaultValue){
					alert("适用机场信息不能为空!");
					return;
				}
				//校验
				if($("#productName").val() == ""){
					alert("产品名称不能为空!");
					return;
				}
				if($("#advancedDays").val() == ""){
					alert("提前销售天数不能为空!");
					return;
				}
				var reg = new RegExp("^\\d+$");
			   
				if(!reg.test($("#advancedDays").val())){
					alert("提前销售天数请输入非负整数!");
					return ;
				}
				if($("#recommendLevel").val() == ""){
					alert("推荐级别不能为空!");
					return;
				}
				if($("#includeDeptAirports").val() == ""){
					alert("适用机场信息不能为空!");
					return;
				}
				if($("#settlementPrice").val() == ""){
					alert("结算价不能为空!");
					return;
				}
				if($("#marketPrice").val() == ""){
					alert("市场价不能为空!");
					return;
				}
				
				if($("#includeDeptTerminals").val() == document.getElementById('includeDeptTerminals').defaultValue){

					$("#includeDeptTerminals").val("");
				}
            }
            $('#bt_add_vas_product').attr('disabled',"true");
            
			var requestUrl = '${request.contextPath}/vasProduct/insertVasProduct';
			
			if(isCouponProduct){ 
				requestUrl = '${request.contextPath}/vasProduct/insertCouponVasProduct';
			 } 
			 
            $("#add_vas_product_form").ajaxSubmit({
                type: "post",
                url: requestUrl,
                beforeSubmit: function(arr, $form, options) { 
                    console.log("beforeSubmit:"+arr[0]);
                    console.log("beforeSubmit:"+arr[1]);
                    console.log("beforeSubmit:"+arr[2]); 
               
                    return true;
                }, 
                success: function (data) {               
                    if(data.flag == 'SUCCESS'){
                        alert("新增产品成功！");
                        $('#bt_add_vas_product').removeAttr("disabled");
                        
                    }else{
                        alert("新增产品失败");
                        $('#bt_add_vas_product').removeAttr("disabled");
                    }
                },
                error: function (msg) {
                    alert("新增产品失败"+msg);
                    $('#bt_add_vas_product').removeAttr("disabled");
                } 
            });  
        });

        $("#productTypeId").on("change",function(){

            $.ajax({
                url:"${request.contextPath}/vasProductType/queryProductTypeById",
                data:{productTypeId:$(this).val()},
                type:'post',
                dataType:'json',
                success:function(data){ 
                    $("#subProductCode").val(data.subProductCode);
                }
            }
            )
        });
        
        function getParameters(){

           return  {
               'subProductCode':$("#subProductCode").val(),
               'suppCode':$("#suppCode").val(),
               'productName':$("#productName").val(),
               'advancedDays':$("#advancedDays").val(),
               'recommendLevel':$("#recommendLevel").val(),
               'includeDeptAirports':$("#includeDeptAirports").val(),
               'includeDeptTerminals':$("#includeDeptTerminals").val(),
               'startTime':$("#startTime").val(),
               'endTime':$("#endTime").val(),
               'location':$("#location").val(),
               'serviceContent':$("#serviceContent").val(),

               'tgqRule':$("#tgqRule").val(),
               'totalStock':$("#totalStock").val(),
               'remainingStock':$("#remainingStock").val(),
               'settlementPrice':$("#settlementPrice").val(),
               'marketPrice':$("#marketPrice").val()
           };
        }

        $("#vas_img_upload").on("change",function(){

            var vas_imgs = $("img[name='vas_img']");
            // 3 limit
            if(this.files.length > 3){
                this.value = "";
                for(var i = 0, len = vas_imgs.length;i < len ; i++){
                    $(vas_imgs[i]).css({"width":"0px","height":"0px","visibility":"hidden"}).attr('src',"");
                }
                alert('最多添加三张,谢谢 !');
                return false;
            }
            // init css
            for(var i = 0, len = vas_imgs.length;i < len ; i++){
                $(vas_imgs[i]).css({"width":"0px","height":"0px","visibility":"hidden"}).attr('src',"");
            }
            var files = getPath(this);
            for(var i = 0, len = files.length;i < len ; i++){
                $(vas_imgs[i]).css({"width":"200px","height":"160px","visibility":"visible"}).fadeIn("fast").attr('src',files[i]);
            }
        });
        //
        function getPath(obj)
        {
            if(obj){
                var imags = new Array();
                if(window.navigator.userAgent.indexOf("MSIE")>=1){
                    obj.select();
                    var ie_path = document.selection.createRange().text;
                    return ie_path.split(',');
                    //console.log(path1);
                }else if(window.navigator.userAgent.indexOf("Firefox")>=1){
                    if(obj.files){
                        // var path2 = obj.files.item(0).getAsDataURL(); //已失效
                        for(var i = 0, len = obj.files.length; i < len; i++){
                            imags[i] = window.URL.createObjectURL(obj.files[i]);
                        }
                        return imags;
                    }
                }else if(window.navigator.userAgent.indexOf("Chrome")>=1){
                    for(var i = 0, len = obj.files.length; i < len; i++){
                        imags[i] = window.URL.createObjectURL(obj.files[i]);
                    }
                    return imags;
                }else{
                    for(var i = 0, len = obj.files.length; i < len; i++){
                        imags[i] = window.URL.createObjectURL(obj.files[i]);
                    }
                    return imags;
                }
            }
        };
    });
	
	function get(no){
		return '<div class="vas_add"  tag="batch"><span>批次号'+no+'</span>&nbsp;&nbsp;<input id="batchNo'+no+'"   name="batchNo'+no+'"  onblur="checkno(this)"     /><button tag="delbtn" onclick="removebatch(this)">删除</button> </div> ';
	}
	
	function removebatch(obj){
		$(obj).parent().remove();
		var num = $('div[tag=batch]').size();  
		if(num>1){
			$('div[tag=batch]:last').append('<button tag="delbtn" onclick="removebatch(this)">删除</button> ');
		} 
	}
	
	//验证优惠券批次号
	function checkno(obj){ 
		if(obj.value!='' ){	
			if($.trim(obj.value)!=''){
				if($('input[name^=batchNo][value='+obj.value+']').size()>1){
					alert('批次号【'+obj.value+'】已经存在，请重新选择优惠');
					obj.value = '';
					obj.focus();
					return ;
				}		
				$.ajax({
	                url:"${request.contextPath}/promotion/queryCouponCodeByParam/"+obj.value,   
					async:false,
	                success:function(data){ 
	                    if(!data.flag||data.list[0].valid=='无效'){
							alert('批次号【'+obj.value+'】无效，请重新选择优惠券');
							obj.value = '';
							obj.focus();
						}
	                }, error: function (msg) {
						console.log(msg);
						alert('批次号【'+obj.value+'】无效，请重新选择优惠券');
						obj.value = '';
						obj.focus();
	                }
	            }); 
            }else{
        	    alert('批次号不得为空');
        	    obj.value = '';
				obj.focus();
				return ;
            }
		}
	}
	
	function addbatch(){
		var num = $('div[tag=batch]').size();  
		if(num<3){
			$('button[tag=delbtn]').remove();
			$('div[tag=batch]:last').after(get(num+1));
		} else{
			alert('最多添加三个优惠券批次号');
		} 
	}
	
	$(document).ready(function() { 
			$('input[valid]').each(function(){ 
			var $this = $(this); 
			var valid = $this.attr('valid');  
			if(valid=='num'){ 
					$this.blur(function(){ 
					onlyNum($this[0]); 
				}); 
			} else if(valid=='decimal'){ 
					$this.blur(function(){ 
					onlyDecimal($this[0]); 
				}); 
			} 
			}); 
		}); 

		function onlyNum(obj){  
		if(obj.value!=''){
			 var desc = $(obj).attr('desc'); 
			 var reg = /^[1-9]*[1-9][0-9]*$/;
			 if(!reg.test(obj.value)){
				 alert(""+desc+"必须是正整数");
				 obj.value='';
				 obj.focus();
				 return ;
			 }
		 }
		}  
		
		function onlyDecimal(obj){  
		if(obj.value!=''){
			 var desc = $(obj).attr('desc'); 
			 var reg = /^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$/; 
			 if(!reg.test(obj.value)){
				 alert(""+desc+"必须是非负数");
				 obj.value='';
				 obj.focus();
				 return ;
			 }
		 }
		}  
		
	function sameStock(obj){
		var newStock = obj.value*1;
		if(!isNaN(newStock)){
			$('#remainingStock').val(newStock);
		}
	}
</script>
</html>



