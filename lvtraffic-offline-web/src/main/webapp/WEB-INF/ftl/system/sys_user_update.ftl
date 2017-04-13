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
    <form id="edit_vas_product_form" name="edit_vas_product_form" enctype="multipart/form-data">
        <div class="breadnav"><span>用户管理</span>>编辑用户</div>
        <div class="infor1" id="conditionDiv">
            <div class="order message">
                <div class="main">
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >基本信息</label></div>
                    <div class="vas_add">
                        <span><span style="color: red">*</span>用户邮箱:</span>&nbsp;&nbsp;
                        <input type="text" id="email" name="email"  value="${user.email}"/><br>
                        <span><span style="color: red">*</span>密        码:</span>&nbsp;&nbsp;
                        <input type="text" id="password" type="password" name="password" value="******"/><br>
                        <span><span style="color: red">*</span>用户姓名:</span>&nbsp;&nbsp;
                        <input id ="userName" name="userName" value="${user.userName}"/><br>
                        <span><span style="color: red">*</span>用户角色:</span>&nbsp;&nbsp;
                        <select id ="roleName" name="roleName" value=""/>
                        	<#list roles as val>  
							  	<#if val!="NULL">
									 <option value="${val.role}">${val.remark}</option>
							  	</#if>
							</#list>
						</select>
						<br>
                    </div>
					
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label>可选信息</label></div>
                    <div class="vas_add">
                        <span><span style="color: red">*</span>账户类型:</span>&nbsp;&nbsp;
                        <input type="text" id="userType" name="userType"  value=""/><br>
                        <span><span style="color: red">*</span>QQ:</span>&nbsp;&nbsp;
                        <input type="text" id="qq" name="qq" value=""/><br>
                        <span><span style="color: red">*</span>住址:</span>&nbsp;&nbsp;
                        <input id ="address" name="address" value=""/><br>
                        <span><span style="color: red">*</span>手机号码:</span>&nbsp;&nbsp;
                        <input id ="mobTel" name="mobTel" value=""/>
						<br>
                    </div>
                    <input id="productId" name="productId" type="hidden" value="${vasProductInfo.id}">
                    <input id="productSaleRuleId" name="productSaleRuleId" type="hidden" value="${vasProductInfo.productSaleRuleDto.id}">
                    
                    <div style="margin-left: 30%;margin-top: 30px">
                        <input id="bt_save_vas_product" style="width: 90px;height: 30px" type="button" value="保存">
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
<script>
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

		
    $(function(){ 
		//初始化进入页面的时候,设置已经销售的库存数量
		$('#soldStock').val($('#totalStock').val()-$('#remainingStock').val());
		var imgsrcs = new Array();
        var imgids = new Array();
        if(isCouponProduct){
			var num = $('div[tag=batch]').size();
			if(num>1){
				$('div[tag=batch]:last').append('<button tag="delbtn" onclick="removebatch(this)">删除</button> </div>');
			}
		}	
    	 var ori_vas_imgs = $("img[name='vas_img']");
        for(var i = 0, len = ori_vas_imgs.length;i < len ; i++){
            imgsrcs[i] = $(ori_vas_imgs[i]).attr('src');
        }

        var ori_vas_img_ids = $("input[name='vas_img_id']");
        for(var i = 0, len = ori_vas_img_ids.length;i < len ; i++){
            imgids[i] = $(ori_vas_img_ids[i]).val();
        }
          
          $("#bt_save_vas_product").on("click",function(){ 
			if(isCouponProduct){ 
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
            }
            $('#bt_save_vas_product').attr('disabled',"true");
           
		    var requestUrl = '${request.contextPath}/vasProduct/editVasProduct';
			
			if(isCouponProduct){ 
				requestUrl = '${request.contextPath}/vasProduct/editVasCouponProduct';
			}
            $("#edit_vas_product_form").ajaxSubmit({
                type: "post",
                url: requestUrl,
                beforeSubmit: function(arr, $form, options) {
                    // The array of form data takes the following form:
                    console.log("beforeSubmit:"+arr[0]);
                    console.log("beforeSubmit:"+arr[1]);
                    console.log("beforeSubmit:"+arr[2]);                    
					if(!isCouponProduct){ 
					    //判断选择的文件与要更新的图片数是否相等
					   if($("#vas_img_upload")[0].files.length != $("img[name='vas_img_selected']").length){
						   alert('所选图片数量不一致 !');
						   return false;
					   }
                    }
                    return true;
                }, 
                data:getneedEditImgsIds(),
                success: function (data) {
                    if(data.flag == 'SUCCESS'){
                        alert("编辑产品成功！");     
                        $('#bt_save_vas_product').removeAttr("disabled");                  
                    }else{
                        alert("编辑产品失败！");
                        $('#bt_save_vas_product').removeAttr("disabled");
                    }
                },
                error: function (msg) {
                    alert("编辑产品失败:"+msg);
                    $('#bt_save_vas_product').removeAttr("disabled");
                }
            });
        });
		//
        $("#productTypeId").on("change",function(){

            $.ajax({
                url:"${request.contextPath}/vasProductType/queryProductTypeById",
                data:{productTypeId:$(this).val()},
                type:'post',
                dataType:'json',
                success:function(data){
                   //                    alert(data);
                    $("#subProductCode").val(data.subProductCode);
                }
            }
            )
        });
        
        //
         function getneedEditImgsIds(){
            var  needEditImgsIds = "";

            var selected_imgs =  $("img[name='vas_img_selected']");
            for(var i = 0, len = selected_imgs.length;i < len ; i++){

                var selectedImgId = $(selected_imgs[i]).attr('id');
                var index =  selectedImgId.substr(selectedImgId.length-1,1);
                if(imgids[index] == ''){
                    needEditImgsIds = needEditImgsIds+"NEW"+",";
                }else{
                    needEditImgsIds = needEditImgsIds+imgids[index]+",";
                }
            }
            return {'needEditImgsIds':needEditImgsIds};
        }
        //
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
        };
		//
         $('img').on("click",function(){
            var width = $(this).width();
            var ori_this = $(this);
            if(width==200)
            {
                $(this).css({"width":"220px","height":"170px","border":"3px #f9f85d solid"}).attr('name','vas_img_selected');
            }
            else
            {
                var imgid = $(this).attr('id');
               $(this).css({"width":"200px","height":"160px","border":""}).attr('name','vas_img').attr('src',imgsrcs[imgid.substr(imgid.length-1,1)]);
               // $(this).val(ori_this);
              
               if($("img[name='vas_img_selected']").length == 0){
                    $("#vas_img_upload").val("");
                }
            }
        });
    	//
    	$("#vas_img_upload").on("change",function(){

            var vas_imgs = $("img[name='vas_img_selected']");
            if(vas_imgs.length != this.files.length){

                alert('所选图片数量不匹配 !');
                //恢复原始样式
                for(var i = 0, len = vas_imgs.length;i < len ; i++){
                    var imgid = $(vas_imgs[i]).attr('id');
                    $(vas_imgs[i]).css({"width":"200px","height":"160px","border":""}).attr('name','vas_img').attr('src',imgsrcs[imgid.substr(imgid.length-1,1)]);
                }
                this.value = "";
                return false ;
            }
            // 3 limit
            if(this.files.length > 3){
                this.value = "";
                alert('只允许三张图片 !');
                return false;
            }
            var files = getPath(this);
            for(var i = 0, len = files.length;i < len ; i++){
                $(vas_imgs[i]).fadeIn("fast").attr('src',files[i]);
//                console.log($(vas_imgs[i]).fadeIn("fast").attr('src'));
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
        //
        function ImgId(){};
        
        //
        function getneedDeleteImgsIds(){
            var  needEditImgsIds = "";

            var selected_imgs =  $("img[name='vas_img_selected']");
            for(var i = 0, len = selected_imgs.length;i < len ; i++){

                var selectedImgId = $(selected_imgs[i]).attr('id');
                var index =  selectedImgId.substr(selectedImgId.length-1,1);
                if(imgids[index] == ''){
                    needEditImgsIds = needEditImgsIds+"NEW"+",";
                }else{
                    needEditImgsIds = needEditImgsIds+imgids[index]+",";
                }
            }
            return {'needEditImgsIds':needEditImgsIds,'productId':$("#productId").val()};
        }
        
        //删除图片信息
        $("#deleteSelectedImgs").on("click",function(){
            //console.log($(this));
            var bFlag = false;
            var selected_imgs =  $("img[name='vas_img_selected']");
            if(selected_imgs.length == 0){
                alert("请选择要删除的图片!");
                return false;
            }
            for(var i = 0, len = selected_imgs.length;i < len ; i++){

                var selectedImgId = $(selected_imgs[i]).attr('id');
                var index =  selectedImgId.substr(selectedImgId.length-1,1);
                if(imgids[index] == ''){

                }else{
                    bFlag = true;
                }
            }
            if(!bFlag){
                alert("请选择已关联的图片!");
                for(var i = 0, len = selected_imgs.length;i < len ; i++){

                    var selectedImgId = $(selected_imgs[i]).attr('id');
                    var index =  selectedImgId.substr(selectedImgId.length-1,1);
                    $(selected_imgs[i]).css({"width":"200px","height":"160px","border":""}).attr('name','vas_img').attr('src',imgsrcs[index]);
                }
                return false;
            }
            if(confirm("确定删除选中的图片?")){
               
	           }else{
	            for(var i = 0, len = selected_imgs.length;i < len ; i++){

                    var selectedImgId = $(selected_imgs[i]).attr('id');
                    var index =  selectedImgId.substr(selectedImgId.length-1,1);
                    $(selected_imgs[i]).css({"width":"200px","height":"160px","border":""}).attr('name','vas_img').attr('src',imgsrcs[index]);
                }
				return false;
	        }

            $.ajax({
                url : '${request.contextPath}/vasProduct/deleteVasProductImg',
                type : 'POST',
                data :getneedDeleteImgsIds(),
                success : function(data){

                    if(data.flag == 'SUCCESS'){
                        alert("图片删除成功！");
                        //更新缓存
                        var selected_imgs =  $("img[name='vas_img_selected']");
                        for(var i = 0, len = selected_imgs.length;i < len ; i++){

                            var selectedImgId = $(selected_imgs[i]).attr('id');
                            var index =  selectedImgId.substr(selectedImgId.length-1,1);
                            imgsrcs[index] = "";
                            imgids[index] = "";
                            $(selected_imgs[i]).css({"width":"200px","height":"160px","border":""}).attr('name','vas_img').attr('src',imgsrcs[index]);
                        }
                    }else{
                        alert("图片删除失败");
                    }
                }
            });
        });
       
        
    	
    });
	
	function get(no){
		return '<div class="vas_add"  tag="batch"><span>批次号'+no+'</span>&nbsp;&nbsp;<input id="batchNo'+no+'" name="batchNo'+no+'"  onblur="checkno(this)"    /><button tag="delbtn" onclick="removebatch(this)">删除</button> </div> ';
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
					obj.focus();
					obj.value = '';
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
			alert('最多添加三个批次');
		} 
	}
	
	function changeStock(obj){ 
		var newStock = obj.value-$('#soldStock').val();
		if(!isNaN(newStock)){
			if(newStock<0){
				alert('新库存不可以小于已经销售的库存');
				$('#totalStock').val('');
				$('#totalStock').focus();
				return ;
			}
			$('#remainingStock').val(newStock); 
		}
	}
</script>
</html>



