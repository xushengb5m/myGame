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
    </style>
</head>
<body>
<div class="content content1">
    <form id="edit_vas_product_form" name="edit_vas_product_form" enctype="multipart/form-data">
        <div class="breadnav"><span>增值服务</span>>产品管理>新增产品</div>
        <div class="infor1" id="conditionDiv">
            <div class="order message">
                <div class="main">
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >基本信息</label></div>

                    <div class="vas_add">
                        <span >产品ID:</span>&nbsp;&nbsp;<input readonly="true"  name="" value="${vasProductInfo.id}" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>子类型:</span>&nbsp;&nbsp;<input readonly="true"  name="" value="${vasProductInfo.productType.subProductName}" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <br>
                        <span >供应商:</span>&nbsp;&nbsp;
                        <input readonly="true"  name="" value="${vasProductInfo.suppInfoDto.suppName}" />
                         <!--<select id="suppCode" name="suppCode" >
                            <option value ="${vasProductInfo.suppInfoDto.suppCode}">${vasProductInfo.suppInfoDto.suppName}</option>    
                           <#list suppList as val>  
							  <#if val !="NULL">
							  	<#if "${val.code}"=="${vasProductInfo.suppInfoDto.suppCode}">
							  		 <option value="${val.code}" selected='selected'>${val.name}</option>
							  	<#else>
									 <option value="${val.code}">${val.name}</option>
							  	</#if>
							  </#if> 
							</#list>            
                        </select>-->
                        <br>
                        <span >code:</span>&nbsp;&nbsp;<input readonly="true" style="" id="subProductCode" name="subProductCode" value="${vasProductInfo.productType.subProductCode}" /><br>
                        
                        
                        
                        
                        <span ><span style="color: red">*</span>产品名称:</span>&nbsp;&nbsp;
                        <input type="text" id="productName" name="productName"  value="${vasProductInfo.productName}"/><br>
                        <span ><span style="color: red">*</span>提前销售天数:</span>&nbsp;&nbsp;
                        <input id ="advancedDays" name="advancedDays" value="${vasProductInfo.productSaleRuleDto.advancedDays}" /><br>
                        <span ><span style="color: red">*</span>推荐级别:</span>&nbsp;&nbsp;
                        <input readonly="true"  name="" value="${vasProductInfo.recommendLevel}" />
                        <!--<select id="recommendLevel" name="recommendLevel" >
                            <option value ="${vasProductInfo.recommendLevel}">${vasProductInfo.recommendLevel}</option>
                           
                        </select>-->
                        <br>
                    </div>
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >适用机场及信息说明</label></div>
                    <div class="vas_add">
                        <span>适用机场:</span>&nbsp;&nbsp;
                        <input id="includeDeptAirports" name="includeDeptAirports" value="${vasProductInfo.productSaleRuleDto.includeDeptAirports_Str}" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <span>适用航站楼:</span>&nbsp;&nbsp;
                        <input id="includeDeptTerminals" name="includeDeptTerminals" value="${vasProductInfo.productSaleRuleDto.includeDeptTerminals_Str}" /><br>
                        <span>营业时间：</span>
                        <input type="text" id="startTime" name="startTime" value="${vasProductInfo.workTimeRange.startTime_Str}" onfocus="WdatePicker({dateFmt:'HH:mm'})" style="width:100px;" class="Wdate" readonly="readonly"/>
                        &nbsp; &nbsp;至 &nbsp; &nbsp;
                        <input type="text" id="endTime" name="endTime" value="${vasProductInfo.workTimeRange.endTime_Str}" onfocus="WdatePicker({dateFmt:'HH:mm'})" style="width:100px;" class="Wdate" readonly="readonly"/><br/>
                        <span>位置指引:</span>&nbsp;&nbsp;<textarea id="location" name="location"  style="width: 400px;height: 80px">${vasProductInfo.location}</textarea><br>
                        <span>服务内容:</span>&nbsp;&nbsp;<textarea id="serviceContent" name="serviceContent"  style="width: 400px;height: 80px">${vasProductInfo.serviceContent}</textarea><br>
                        <span>退改规定:</span>&nbsp;&nbsp;<textarea id="tgqRule" name="tgqRule"  style="width: 400px;height: 80px">${vasProductInfo.tgqRule}</textarea><br>
                    </div>
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >产品图片</label></div>
                    <div class="vas_add">
                        <!--<span>选择图片:</span>&nbsp;&nbsp;<input id="vas_img_upload" multiple  type="file" name="vas_img_upload"/> &nbsp;&nbsp;&nbsp;-->
                        <br/><br/>
	                      
	                        <#list vasProductInfo.productImgs as imge>
	                        		<img id="vas_img_${imge_index}" name="vas_img" style="width:200px;height:160px;" src="${imge.imgPath}" />
	                        		<input id="vas_img_id_${imge_index}" name="vas_img_id" type="hidden" value="${imge.id}">
	                       	</#list>
                      
                    </div>
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >库存/价格</label></div>
                    <div class="vas_add">
                        <span>总库存:</span>&nbsp;&nbsp;<input readonly="true" id ='totalStock' name="totalStock" value="${vasProductInfo.totalStock}" /><br/>
                        <span>剩余库存:</span>&nbsp;&nbsp;<input readonly="true" id="remainingStock" name="remainingStock" value="${vasProductInfo.remainingStock}" /><br/>
                        <span><span style="color: red">*</span>结算价:</span>&nbsp;&nbsp;<input id="settlementPrice" name="settlementPrice" value="${vasProductInfo.settlementPrice}" /><br/>
                        <span><span style="color: red">*</span>市场价:</span>&nbsp;&nbsp;<input readonly="true" id="marketPrice" name="marketPrice" value="${vasProductInfo.marketPrice}" /><br/>
                    </div>
                    <!--<div style="margin-left: 30%;margin-top: 30px">
                        <input id="" style="width: 90px;height: 30px" type="button" name="" value="保存">
                    </div>-->
                    <input id="productId" name="productId" type="hidden" value="${vasProductInfo.id}">
                    <input id="productSaleRuleId" name="productSaleRuleId" type="hidden" value="${vasProductInfo.productSaleRuleDto.id}">
                </div>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    $(function(){
    
    	var imgsrcs = new Array();
        var ori_vas_imgs = $("img[name='vas_img']");
        for(var i = 0, len = ori_vas_imgs.length;i < len ; i++){
            imgsrcs[i] = $(ori_vas_imgs[i]).attr('src');
        }

        var imgids = new Array();
        var ori_vas_img_ids = $("input[name='vas_img_id']");
        for(var i = 0, len = ori_vas_img_ids.length;i < len ; i++){
            imgids[i] = $(ori_vas_img_ids[i]).val();
        }
        console.log("imgsrcs:"+imgsrcs);
        console.log("imgids:"+imgids);
              
         //
          $("#bt_edit_vas_product").on("click",function(){
            //console.log($(this));
            
            $("#edit_vas_product_form").ajaxSubmit({
                type: "post",
                url: "${request.contextPath}/vasProduct/editVasProduct",
                beforeSubmit: function(arr, $form, options) {
                    // The array of form data takes the following form:
                    console.log("beforeSubmit:"+arr[0]);
                    console.log("beforeSubmit:"+arr[1]);
                    console.log("beforeSubmit:"+arr[2]);
                    //判断选择的文件与要更新的图片数是否相等
                   if($("#vas_img_upload")[0].files.length != $("img[name='vas_img_selected']").length){
                       alert('所选图片数量不一致 !');
                       return false;
                   }
                    
                    return true;
                },
//              data:{ key1: 'value1', key2: 'value2' },
                data:getneedEditImgsIds(),
                success: function (data) {
                    if(data.flag == 'SUCCESS'){
                        alert("编辑产品成功！");                       
                    }else{
                        alert("编辑产品失败！");
                    }
                },
                error: function (msg) {
                    alert("编辑产品失败:"+msg);
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
        <!-- $('img').on("click",function(){
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
        });-->
    	//
    	$("#vas_img_upload").on("change",function(){

            var vas_imgs = $("img[name='vas_img_selected']");
            if(vas_imgs.length != this.files.length){

                alert('the number of selected imgs not matched ， thanks !');
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
                alert('three limited ， thanks !');
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
          	
    });
</script>
</html>



