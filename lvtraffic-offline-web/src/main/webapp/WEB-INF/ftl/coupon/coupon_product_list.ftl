<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>优惠券产品列表</title>
    <link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
    <link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript">
    
	    $(function (){
			initGrid();
		});
			
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}    
		
		//查询列表信息   
		function query() { 
       		
			$("#couponProductList").jqGrid('setGridParam', {
				url : "queryCouponProductList",
				datatype : "json",
				mtype : "POST",
				postData : getCouponProductParams()
			}).trigger("reloadGrid");
		}
		
		function getCouponProductParams() {
			var suppCode = $('#suppCode').val();
            var productName = $('#productName').val();
            var subProductCode = $('#subProductCode').val();
            var activeStatu = $('#activeStatu').val();
            var productLine = $("#productLine").val();
            var remainingStock = "";
            if("checked" == $("#remainingStock").attr("checked")){
                remainingStock = $("#remainingStock").attr("value");
            }

            return {
                'suppCode' : suppCode,
                'productName' : productName,
                'subProductCode' : subProductCode,
                'activeStatu' : activeStatu,
                'productSaleRule.vasCouponProductLineNames' : productLine,
                'remainingStock' : remainingStock
            }
		}
		
		function initGrid() {
			$("#couponProductList").jqGrid({
				url : "${request.contextPath}/vasProduct/queryCouponProductList",
				datatype : "json",
				mtype : "POST",
				colNames : ['产品ID', '子类型', '供应商', 'code','产品名称','总库存', '剩余库存', '产品状态', '推荐级别', '创建时间','适用产品线','操作' ],
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
                    hidden:true,
                    sortable:false
                }, {
                    name : 'suppName',
                    index : 'suppName',
                    align : 'center',
                    hidden:true,
                    sortable:false
                }, {
                    name : 'subProductCode',
                    index : 'subProductCode',
                    align : 'center',
                    hidden:true,
                    sortable:false
                }, 
                 {
                    name : 'productName',
                    index : 'productName',
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
                    width:300,
                    hidden : false,
                    sortable:false
                 },{
                    name : 'productLine',
                    index : 'productLine',
                    width:200,
                    align : 'center',
                    hidden : false,
                    sortable:false
                  },{
                    name : 'operate',
                    index : 'operate',
                    width:600,
                    align : 'center',
                    hidden : false,
                    sortable:false
                  }],
				rowNum: 10,            //每页显示记录数
		 	    autowidth: true,      //自动匹配宽度
		 	    pager: '#pager',      //表格数据关联的分页条，html元素
		   	    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
		      	viewrecords: true,    //显示总记录数
		      	height:'auto',//高度，表格高度。可为数值、百分比或'auto'
			   // autoheight: true,     //设置高度
			    gridview:true,        //加速显示
				viewrecords: true,    //显示总记录数
				multiselect : false,
				sortable:true,        //可以排序
			    sortname: 'id',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : '优惠券产品管理',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#couponProductList").jqGrid('setGridParam', {
						postData : getCouponProductParams()
					});
				},
				postData : getCouponProductParams (),
				gridComplete:function(){  //在此事件中循环为每一行添加日志、操作链接
                    var ids=jQuery("#couponProductList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                    	var rowData = $('#couponProductList').jqGrid('getRowData',id);
                    	//库存红色显示
                        var remainingStockRed = '<span style="color: red">'+rowData.remainingStock+'</span>';  
                        
                    	operateClick= '<a href="javascript:;" style="color:blue" onclick="view_log('+id+')" >日志</a> '+
                    	' <a href="javascript:;" style="color:blue; " onclick="update('+id+')" >编辑</a> '+
                    	' <a href="javascript:;" style="color:blue; " onclick="edit_sale_control('+id+')" >销售调控</a> ';
                    	if('有效'==rowData.activeStatus){
                        	operateClick = operateClick + '<a href="javascript:;" style="color:blue; " onclick="setUnvalid('+id+',1)" >设为无效</a>  '
                        }else{
                        	operateClick = operateClick + '<a href="javascript:;" style="color:blue; " onclick="setUnvalid('+id+',2)" >设为有效</a>  '
                        }
                        
                        jQuery("#couponProductList").jqGrid('setRowData', id , {operate:operateClick});
                        
                         if(rowData.remainingStock < 5){
                        	jQuery("#couponProductList").jqGrid('setRowData', id , {remainingStock:remainingStockRed});
                        }
                    }
                }
			});
		} 
		//查看操作日志
		function operateLog(id) {
		   	window.open("${request.contextPath}/feedback/tofeedBackLogList/"+id);
		}
		//查看日志
		function view_log(id){
	        window.open("${request.contextPath}/vasLog/toVasLogList/"+id+"/VAS_PRODUCT");
	    }
		//修改
		function update(id) {
		   	window.open("${request.contextPath}/vasProduct/toEditVasCouponProduct/"+id);
		} 
		
		function add(){
       			 window.open("${request.contextPath}/vasProduct/toAddCouponProduct");   
        }
		
		//销售调控
        function edit_sale_control(id){
        
            window.open("${request.contextPath}/vasProduct/toEditCouponProductSaleControl/"+id);
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
	  <div class="breadnav"><span>增值服务</span>>优惠券产品管理</div>
	  <form id="myForm" autocomplete="off" method="post">
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
                    	<span>适用产品线：</span>
                    	<select id="productLine" name="productLine" >
                       		<option value="" selected='selected'>全部</option>
                            <#list productLine as val>  	
									<option value="${val}">${val.cnName}</option>	
							</#list>
                        </select>
                        <span>小于安全库存</span>
                        <input type="checkbox"  id="remainingStock" name="remainingStock" style="width:20px" value="1000" />
                    </div>
                </div>
            </div>
        </div>
	  
  	<div class="click">
  		<a href="javascript:;"><div class="button" onclick="query()">查询</div></a>
  		<a href="javascript:;"><div class="button" onclick="add()">新增</div></a>
	    <a href="javascript:;"><div class="button" onclick="exportCsv()">导出CSV</div></a>
	</div>
		
	</form>
	
 	<div class="content1" style="margin-top:50px;">
		<table id="couponProductList"></table>
        <div id="pager"></div>
    </div>
	 <form id="exportCsvForm" action="${request.contextPath}/vasProduct/exportVasCouponCsv" method="post" target="_blank">
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form> 
    </div>
     <br>
     <br>
	 
</body>
</html>
