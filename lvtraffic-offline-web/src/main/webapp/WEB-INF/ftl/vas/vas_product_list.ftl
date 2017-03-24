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

         .numDialog{
            width:300px;
            height:100px;
            border:1px solid;
            border-color:#70A8D2;
            align: center;
            top: 50%;
            left:50%;
            position: fixed;
            background-color:#FFF;
            margin:-141px 0 0 -201px;
            text-align: center;
            line-height: 45px;
            display: none;
        }
    </style>
	<script type="text/javascript">

        $(function (){
            initGrid();
            //getInsurance();
            //
            $("#cancel_dialog").on("click",function(){
		        $("#verifyCode_dialog").css("display","none");
   			});
   			//
		   $("#bt_sure_get_verify_code").on("click",function(){

		        var productIds = $("#productIds").val();
		        var verifyCodeNum = $("#verifyCodeNum").val();
		        
		        var reg = new RegExp("^[0-9]*$");
		        if(!reg.test(verifyCodeNum)){
		            alert("请输入正确数字!");
		            return ;
		        }
                
		        if(verifyCodeNum == "" || verifyCodeNum == 0){
		            alert("请填写核销码数量!"); return ;
		        }
		        if("-" == verifyCodeNum.substring(0,1)){
		            alert("请填写正确的核销码数量!"); return ;
		        }
				$('#bt_sure_get_verify_code').attr('disabled',"true");
		        $.ajax({
		            url : '${request.contextPath}/vasProduct/acquireVerifyCodes',
		            type : 'POST',
		            data : {
		                productIds : productIds,
		                verifyCodeNum : verifyCodeNum
		            },
		            success : function(data){
		
		                if(data.flag == 'SUCCESS'){
		                    alert("数据新增成功. \n"+data.retMsg);
		                    $('#bt_sure_get_verify_code').removeAttr("disabled");
		                     $("#verifyCode_dialog").css("display","none");
		                     
		                     query();
		                     
		                }else{
		                     alert("数据新增失败");
		                     $('#bt_sure_get_verify_code').removeAttr("disabled");
		                     $("#verifyCode_dialog").css("display","none");
		                }
		            }
		        });
		    });
		    //conditionHtmlToExportCsvForm();
        });

        //清空查询信息
        function reset() {
            document.getElementById("myForm").reset()
        }

        //查询列表信息
        function query() {

            $("#vasProductList").jqGrid('setGridParam', {
                url : "${request.contextPath}/vasProduct/queryVasProductList",
                datatype : "json",
                mtype : "POST",
                postData : getVasProductQueryParams()
            }).trigger("reloadGrid");
            
           // conditionHtmlToExportCsvForm();
        }

      function getVasProductQueryParams() {
            var suppCode = $('#suppCode').val();
            var productName = $('#productName').val();
            var subProductCode = $('#subProductCode').val();
            var activeStatu = $('#activeStatu').val();
            var includeDeptAirports = $('#includeDeptAirports').val();
            var includeDeptTerminals = $('#includeDeptTerminals').val();
            var remainingStock = "";
            //alert($("#remainingStock").attr("checked"));
            if("checked" == $("#remainingStock").attr("checked")){
                remainingStock = $("#remainingStock").attr("value");
                //alert(remainingStock);
            }

            return {
                'suppCode' : suppCode,
                'productName' : productName,
                'subProductCode' : subProductCode,
                'activeStatu' : activeStatu,
                'includeDeptAirports' : includeDeptAirports,
                'includeDeptTerminals' : includeDeptTerminals,
                'remainingStock' : remainingStock
            }
        }

        function initGrid() {
            $("#vasProductList").jqGrid({
                url : "${request.contextPath}/vasProduct/queryVasProductList",
                datatype : "json",
                mtype : "POST",
                colNames : ['产品ID', '子类型', '供应商', 'code','产品名称','机场','航站楼','总库存', '剩余库存', '产品状态', '推荐级别', '创建时间', '操作' ],
                colModel : [ {
                    name : 'id',
                    index : 'id',
                    align : 'center',
                    width :200,
                    sortable:false
                }, {
                    name : 'subProductName',
                    index : 'subProductName',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'suppName',
                    index : 'suppName',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'subProductCode',
                    index : 'subProductCode',
                    align : 'center',
                    sortable:false
                }, 
                 {
                    name : 'productName',
                    index : 'productName',
                    align : 'center',
                    sortable:false
                },{
                    name : 'includeDeptAirports',
                    index : 'includeDeptAirports',
                    align : 'center',
                    sortable:false
                },{
                    name : 'includeDeptTerminals',
                    index : 'includeDeptTerminals',
                    align : 'center',
                    sortable:false
                },{
                    name : 'totalStock',
                    index : 'totalStock',
                    align : 'center',
                    sortable:false
                },{
                    name : 'remainingStock',
                    index : 'remainingStock',
                    align : 'center',
                    hidden : false,
                    sortable:false
                },{
                    name : 'activeStatus',
                    index : 'activeStatus',
                    align : 'center',
                    hidden : false,
                    sortable:false
                },{
                    name : 'recommendLevel',
                    index : 'recommendLevel',
                    align : 'center',
                    hidden : false,
                    sortable:false
                 },{
                    name : 'createTime_Str',
                    index : 'createTime_Str',
                    align : 'center',
                    hidden : false,
                    sortable:false
                 },{
                    name : 'operate',
                    index : 'operate',
                    width:800,
                    align : 'center',
                    hidden : false,
                    sortable:false
                  }],
                rowNum: 10,            //每页显示记录数
                autowidth: true,      //自动匹配宽度
                shrinkToFit:true,
                pager: '#pager',      //表格数据关联的分页条，html元素
                rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
                viewrecords: true,    //显示总记录数
                height:'auto',//高度，表格高度。可为数值、百分比或'auto'
                // autoheight: true,     //设置高度
                gridview:true,        //加速显示
                viewrecords: true,    //显示总记录数
                multiselect: true, 
                sortable:true,        //可以排序
                sortname: 'id',  //排序字段名
                sortorder: "desc",    //排序方式：倒序
                caption : '增值服务产品列表',
                jsonReader : {
                    root : "results",               // json中代表实际模型数据的入口
                    page : "pagination.page",       // json中代表当前页码的数据
                    records : "pagination.records", // json中代表数据行总数的数据
                    total:'pagination.total',       // json中代表页码总数的数据
                    repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
                },
                onPaging : function(pgButton) {
                    $("#vasProductList").jqGrid('setGridParam', {
                        postData : getVasProductQueryParams ()
                    });
                },
                postData : getVasProductQueryParams (),
              
                gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#vasProductList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        console.log("id:"+id);
                        
                        var rowData = $('#vasProductList').jqGrid('getRowData',id);
                        //设置 checkbox 的属性 值
                        var curChk = $("#"+id+"").find(":checkbox");
                        curChk.attr('name', 'checkboxname');
                        curChk.attr('value', rowData.id);
                        var detailProductName = rowData.productName;
                        
                        var productIdDetail =  '<a href="javascript:;" style="" onclick="edit('+id+')" >'+id+'</a>';  
                        var productNameDetail =  '<a href="javascript:;" style="" onclick="edit('+id+')" >'+detailProductName+'</a>'; 
                        //库存红色显示
                        var remainingStockRed = '<span style="color: red">'+rowData.remainingStock+'</span>';  
                                        
                        var operateClick= '<a href="javascript:;" style="color:blue; text-decoration:underline" onclick="view_log('+id+')" >日志</a>  ';
                        
                        if('有效'==rowData.activeStatus){
                        	operateClick = operateClick + '<a href="javascript:;" style="color:blue; text-decoration:underline" onclick="setUnvalid('+id+',1)" >设为无效</a>  '
                        }else{
                        	operateClick = operateClick + '<a href="javascript:;" style="color:blue; text-decoration:underline" onclick="setUnvalid('+id+',2)" >设为有效</a>  '
                        }
                        operateClick = operateClick + 
                        					'<a href="javascript:;" style="color:blue; text-decoration:underline" onclick="edit_sale_control('+id+')" >销售调控</a>  '+
							                '<a href="javascript:;" style="color:blue; text-decoration:underline" onclick="edit('+id+')" >编辑</a>  '+
							                '<a href="javascript:;" style="color:blue; text-decoration:underline" onclick="getVerifyCode('+id+')" >获取核销码</a>  '+
							                '<a href="javascript:;" style="color:blue; text-decoration:underline" onclick="view_verify_code('+id+')" >查看核销码</a>';
                        
                        jQuery("#vasProductList").jqGrid('setRowData', id , {operate:operateClick});
                        jQuery("#vasProductList").jqGrid('setRowData', id , {id:productIdDetail});
                        jQuery("#vasProductList").jqGrid('setRowData', id , {productName:productNameDetail});
                        if(rowData.remainingStock < 5){
                        
                        	jQuery("#vasProductList").jqGrid('setRowData', id , {remainingStock:remainingStockRed});
                        }
                    }
                    //下面的代码顺序不能变(这是页面上所有行被真选中[所有行被黄色])
	                //$("#cb_vasProductList").attr("checked", true);
	                //$("#cb_vasProductList").click();   //input框
	                //$("#jqgh_vasProductList_cb").click();   //div标签
	                //$("#vasProductList_cb").click();   //th标签
                }
            });
        }
        
        //查看日志
		function view_log(id){
	        window.open("${request.contextPath}/vasLog/toVasLogList/"+id+"/VAS_PRODUCT");
	    }
        //设为无效
        function setUnvalid(id,status){
        	//alert(status);
        	if(status == 2){
        		 if(confirm("确定设为有效状态?")){
               
	            }else{
					return false;
	            }
        	}
        	if(status == 1){
        		 if(confirm("确定设为无效状态?")){
               
	            }else{
					return false;
	            }
        	}
          
	        $.ajax({
		            url : '${request.contextPath}/vasProduct/updateProductInvalid',
		            type : 'POST',
		            data : {"productId":id,"statusFlag":status},
		            success : function(data){
		
		                if(data.flag == 'SUCCESS'){
		                    alert("状态设置成功！");
		                    query();
		                    /*if(data.flag == 'false'){
		                     window.location.href="${request.contextPath}/promotionMain/changeValid/"+data.pmid;
		                     }else if(data.flag == 'true'){
		                     window.location.href="${request.contextPath}/promotion/toPromotionList";
		                     }*/
		                }else{
		                    alert("状态设置失败");
		                }
		            }
		        });
	   	 }


  		//销售调控
        function edit_sale_control(id){
        
            window.open("${request.contextPath}/vasProduct/toEditProductSaleControl/"+id);
        }
        
        //编辑
        function edit(id){
        
            window.open("${request.contextPath}/vasProduct/toEditVasProduct/"+id);
        }

        //新增
        function add(){
        
       			 window.open("${request.contextPath}/vasProduct/toAddVasProduct");   
        }
        //产品详情
        function product_detail(id){
        
       			 window.open("${request.contextPath}/vasProduct/toVasProductDetail/"+id);   
        }
        
        //查看核销码
	    function view_verify_code(id){
	
	        window.open("${request.contextPath}/vasVoucher/toVoucherList?productId="+id);
	    }
        
		//
		function batchGetVerifyCode(id){
		
		    var ids = "";
		    if(id==null || id==""){
		        ids = $("#vasProductList").jqGrid('getGridParam','selarrrow');
		        if(ids.length == 0){
		            alert("请选择要获得核销码的产品!")
		            return false;
		        }
		    }else{
		        ids = id;
		    }
		    $("#productIds").val(ids);
		    $("#verifyCode_dialog").css("display","block");
		}
		
		//获取核销码
		function getVerifyCode(currentId){
		
		    batchGetVerifyCode(currentId);
		}
   	
     //将条件插入到导出exportCsvForm
		function conditionHtmlToExportCsvForm()
		{
			$('#exportCsvDiv').html($('#conditionDiv').clone());
			$.each($('#conditionDiv').find('select'), function(index, obj)
			{
				var objName = $(obj).attr('name');
				$('#exportCsvDiv').find('select[name="'+objName+'"]').attr('value', $(obj).val());
			});
			
		}
		
		//导出Csv
		function exportCsv()
		{
			conditionHtmlToExportCsvForm();
			$('#exportCsvForm').submit();
		}
		
    </script>
       
</head>
<body>
<div class="content content1">
    <div class="breadnav"><span>增值服务</span>>产品管理</div>
    <form id="myForm" autocomplete="off" >
        <div class="infor1" id="conditionDiv">
            <div class="product message">
                <div class="main">

                   <div class="part">

                        <span>供应商：</span>
                        <select id="suppCode" name="suppCode" >
                        <!--<option value ="112">空港易行</option>-->
                        <option value="" selected='selected'>全部</option>
                            <#list suppList as val>  
							  <#if val !="NULL">
								<option value="${val.code}">${val.name}</option>
							  </#if> 
							</#list>
                         	
                        </select>
                        <span>产品名称：</span> <input type="text" id="productName" name="productName"  />
                        <span>子类型：</span>
                        <select id="subProductCode" name="subProductCode" >
                        	 <option value="" selected='selected'>全部</option>
                             <#list productTypeList as val>  
								<option value="${val.subProductCode}">${val.subProductName}</option>
							</#list>
                        </select>
                        <span>产品状态：</span>
                        <select id="activeStatu" name="activeStatu" >
                       		 <option value="" selected='selected'>全部</option>
                            <#list productStatus as val>  	
                            	<#if "ACTIVE" == "${val}">				  					  		 							  		 
									<option value="${val}">有效</option>	
								</#if>	
								<#if "INACTIVE" == "${val}">				  					  		 							  		 
									<option value="${val}">无效</option>	
								</#if>						  	
							</#list>
                        </select>
						
                    </div>

                    <div class="part">
                        <span>机场：</span><input type="text" id="includeDeptAirports" name="includeDeptAirports" value="" />
                        <span>航站楼：</span><input type="text" id="includeDeptTerminals" name="includeDeptTerminals" value="" />
                        <span>小于安全库存</span>
                        <input type="checkbox"  id="remainingStock" name="remainingStock" style="width:20px" value="1000" />
                    </div>

                </div>
            </div>
        </div>

        <div class="click">
            <a href="javascript:;"><div class="button" onclick="query()">查询</div></a>
            <a href="javascript:;"><div class="button" onclick="add()">新增</div></a>
            <a href="javascript:;"><div class="button" onclick="batchGetVerifyCode()">批量获取核销码</div></a>
            <a href="javascript:;"><div class="button" onclick="exportCsv()">导出csv</div></a>
        </div>

    </form>

    <div class="content1" style="margin-top:50px;">
        <table id="vasProductList"></table>
        <div id="pager"></div>
    </div>
    <div class="numDialog" id="verifyCode_dialog" >
        <span>券码数量：</span>
        <input type="text" id="verifyCodeNum" name="verifyCodeNum" />
        <br/>
        <input id="bt_sure_get_verify_code" style="width: 70px;height: 23px" type="button"  name="" value="确定" />&nbsp;&nbsp;&nbsp;&nbsp;
        <input id="cancel_dialog" style="width: 70px;height: 23px" type="button"  name="" value="取消" />
        <input id="productIds" name="productIds" value="" type="hidden" />		
    </div>
    
    <form id="exportCsvForm" action="${request.contextPath}/vasProduct/exportVasCsv" method="post" target="_blank">
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form> 

</div>
<br>
<br>
</body>
</html>