<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
    <link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
    <link rel="stylesheet" href="${request.contextPath}/css/bootstrap-modal-bs3patch.min.css" type="text/css"/>
    <link rel="stylesheet" href="${request.contextPath}/css/bootstrap-modal.min.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script src="${request.contextPath}/js/bootstrap-modal.min.js"></script>
	<script src="${request.contextPath}/js/bootstrap-modalmanager.min.js"></script>	
	<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
	<scripts >

	<script type="text/javascript">
	      $(function(){
             initGrid();
             showmodal();
        });
  
        //查看日志 
       	function view_log(voucherCode){
	        window.open("${request.contextPath}/vasLog/toVasLogList/"+voucherCode+"/VAS_VOUCHER");
	    }
  

         //查询列表信息
        function query() {
            $("#vasVoucherList").jqGrid('setGridParam', {
                url : "${request.contextPath}/vasVoucher/queryVoucherList",
                datatype : "json",
                mtype : "POST",
                postData : getVasVoucherQueryParams()
            }).trigger("reloadGrid");
            
        }
        
       
            function getVasVoucherQueryParams() {            
		            var supp=$("#suppCode").val();
		            var productId="";
		            /**if($("#linkProductId").val()==""||$("#linkProductId").val()==null){
		             productId = $("#productId").val();            
		            }else{
		             productId =$("#linkProductId").val();
		            }*/
		            
		            productId = $("#productId").val(); 
		            var productCode = $("#productCode").val();
		            var departureAirPort = $("#departureAirPort").val();
		            var departureTerminal =$("#departureTerminal").val();
		            var voucherCode =$("#voucherCode").val();
		            
		            var voucherStatus = $("#voucherStatus").val();
		            var orderNo =  $("#orderNo").val();
		            var purchaseOrderNo =  $("#purchaseOrderNo").val();
		            var isRelated = $("#relateOrder").prop("checked");
		            //var isRelated = $("input[type='checkbox']").is(':checked');
		                 
		            var a= {
		                    'productInfo.suppInfoDto.suppCode' : supp,
							'productInfo.id' : productId,
							'productInfo.productType.subProductCode' : productCode,
							'productInfo.productSaleRuleDto.includeDeptAirports_Str' : departureAirPort,
							'productInfo.productSaleRuleDto.includeDeptTerminals_Str' : departureTerminal,
							'voucherCode' : voucherCode,
							'voucherStatus' : voucherStatus,
							'orderInfo.orderNo' : orderNo,
							'orderInfo.vasOrderPurchaseOrderRDto.purchaseSubOrderNo' : purchaseOrderNo,
							'isRelatedOrder' : isRelated 
		            }
		            return a;
        }

        function initGrid() {
            $("#vasVoucherList").jqGrid({
                url : "${request.contextPath}/vasVoucher/queryVoucherList",
                datatype : "json",
                mtype : "POST",
                colNames : ['采购订单ID','订单Id','核销码Id','ID', '产品ID', '产品名称', 'code','供应商','核销码','核销码状态','增值服务订单号', '采购订单号', '创建时间','操作'],
                colModel : [{
		            name : 'purchaseSubOrderIdStr',
		            index : 'purchaseSubOrderIdStr',
		            align : 'center',
		            width :200,
		            sortable:false,
		            hidden:true
		         }, {
                    name : 'orderId',
                    index : 'orderId',
                    align : 'center',
                    width :200,
                    sortable:false,
                    hidden:true
                },{
                    name : 'voucherId',
                    index : 'voucherId',
                    align : 'center',
                    width :200,
                    sortable:false,
                    hidden:true
                },{
                    name : 'voucherOrderNo',
                    index : 'voucherOrderNo',
                    align : 'center',
                    width :200,
                    sortable:false
                }, {
                    name : 'productIdStr',
                    index : 'productIdStr',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'productNameStr',
                    index : 'productNameStr',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'codeStr',
                    index : 'codeStr',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'suppNameStr',
                    index : 'suppNameStr',
                    align : 'center',
                    sortable:false
                },{
                    name : 'voucherCode',
                    index : 'voucherCode',
                    align : 'center',
                    sortable:false
                },{
                    name : 'voucherStatusStr',
                    index : 'voucherStatusStr',
                    align : 'center',
                    sortable:false
                },{
                    name : 'orderNoStr',
                    index : 'orderNoStr',
                    align : 'center',
                    sortable:false
                },{
                    name : 'purchaseSubOrderNoStr',formatter:formatLink,
                    index : 'purchaseSubOrderNoStr',
                    align : 'center',
                    sortable:false
                },{
                    name : 'createTimeStr',
                    index : 'createTimeStr',
                    align : 'center',
                    sortable:false
                 },{
                    name : 'operate',
                    index : 'operate',
                    align : 'center',
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
                multiselect: false, 
                sortable:true,        //可以排序
                sortname: 'creatTime',  //排序字段名
                sortorder: "desc",    //排序方式：倒序
                caption : '增值服务核销码列表',
                jsonReader : {
                    root : "results",               // json中代表实际模型数据的入口
                    page : "pagination.page",       // json中代表当前页码的数据
                    records : "pagination.records", // json中代表数据行总数的数据
                    total:'pagination.total',       // json中代表页码总数的数据
                    repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
                },
                onPaging : function(pgButton) {
                    $("#vasVoucherList").jqGrid('setGridParam', {
                         postData : getVasVoucherQueryParams()
                    });
                },        
                postData : getVasVoucherQueryParams(),              
                gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#vasVoucherList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var rowData = $('#vasVoucherList').jqGrid('getRowData',id);  
                        var voucherStatus = rowData.voucherStatus;
                        var voucherCode = rowData.voucherCode;
                        var voucherId =rowData.voucherId;
                        var orderId=rowData.orderId;
                        var operateClick = '';
                        if($("input[type='checkbox']").is(':checked')==true){
	                       /** if(voucherStatus == '可使用'){                  
	                            operateClick= '<span class="opLog" style="color:blue" onclick="view_log('+voucherCode+')">日志 </span><span class="operation" style="color:blue">禁用核销码<input name="voucherCode" type="hidden" /><input name="voucherId" type="hidden" /><input name="orderId" type="hidden" /></span>';
	                        }else if(voucherStatus =='未激活'){                       
	                            operateClick= '<a href="javascript:;" style="color:blue" onclick="view_log('+voucherCode+')" >日志</a> <span class="operation" style="color:blue">激活核销码<input name="voucherCode" type="hidden" /><input name="voucherId" type="hidden" /><input name="orderId" type="hidden" /></span>';                    
	                        }else if(voucherStatus=='已禁用'){                       
	                            operateClick= '<a href="javascript:;" style="color:blue" onclick="view_log('+voucherCode+')" >日志</a> <span class="operation" style="color:blue">重新绑定核销码<input name="voucherCode" type="hidden" /><input name="voucherId" type="hidden" /><input name="orderId" type="hidden" /></span>';                      
	                        }else{*/
	                            operateClick='<a href="javascript:;" style="color:blue" onclick="view_log('+voucherId+')" >日志</a> <span class="operation"></span>';
	                        /**}*/
                        }else{
                           operateClick='<a href="javascript:;" style="color:blue" onclick="view_log('+voucherId+')" >日志</a> <span class="operation"></span>';
                        }
                        jQuery("#vasVoucherList").jqGrid('setRowData', id , {operate:operateClick});                         
                      /** $(".operation").eq(id-1).find("input[name=voucherCode]").val(voucherCode);
                        $(".operation").eq(id-1).find("input[name=voucherId]").val(voucherId);
                         $(".operation").eq(id-1).find("input[name=orderId]").val(orderId);*/
           
                    }
                }
            });
        }
        
        function formatLink(cellvalue, options, rowObject) {
	        //主订单Id到后台自动查询
	        var orderMainId = -1;
	        var   url = "http://super.lvmama.com/offline-web/order/queryOrderDetail/"+orderMainId+"/"+rowObject.purchaseSubOrderIdStr+"/NULL";
	        return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
	    }
        
        function showmodal(){
                $("#vasVoucherList").delegate(".operation","click",function(){   
                   var now = $(this);
                   var voucherOperation=$(this).html();
                   if(voucherOperation.indexOf('禁用核销码')==0){
                    disabelModal(now);
                   }else if(voucherOperation.indexOf('激活核销码')==0){
                   activeModal(now);
                   }else if(voucherOperation.indexOf('重新绑定核销码')==0){
                    rebindModal(now);
                   }
                
                })
        
        }
        
        

        
        
        
        function disabelModal(now){        
              var voucherCode= now.find("input[name='voucherCode']").val();
              var voucherId=now.find("input[name='voucherId']").val();
              var orderId=now.find("input[name='orderId']").val();
              $(".disContainer-fonts").html("确认禁用核销码"+voucherCode+"?");
              $("#disableVoucherModal").modal("show");
              $("#disabelVoucher").click(function(){
              	    $.ajax({
              	    url: "${request.contextPath}/vasVoucher/disabled/"+voucherCode+"/"+voucherId+"/"+orderId,  
				    type: "post",				    
				    dataType : "json",
				    contentType : "application/json",
				    success: function(result){	    	
				           	if(result.status=="SUCCESS"){			
				           	 $("#disableVoucherModal").modal("hide");
				           	  window.location.href=window.location.href;	    	      
				            }else{
				              $("#disableVoucherModal").modal("hide");
				              alert(result.message+",禁用核销码失败");
				              window.location.href=window.location.href;
				            }			       
				          }	      
				   });         
              });      
        }
        
        
        
        function activeModal(now){
        	  var voucherCode=now.find("input[name='voucherCode']").val();
        	  var voucherId=now.find("input[name='voucherId']").val();
              var orderId=now.find("input[name='orderId']").val();
              $(".activeContainer-fonts").html("确认激活核销码"+voucherCode+"?");
        	 $("#activeVoucherModal").modal("show");
        	 $("#activeVoucher").click(function(){
              	$.ajax({
              	    url: "${request.contextPath}/vasVoucher/active/"+voucherCode+"/"+voucherId+"/"+orderId,    
				    type: "post",				    
				    dataType : "json",
				    contentType : "application/json",
				    success: function(result){	    	
				           	if(result.status=="SUCCESS"){			
				           	 $("#activeVoucherModal").modal("hide");
				           	  window.location.href=window.location.href;	    	      
				            }else{
				              $("#activeVoucherModal").modal("hide");
				              alert(result.message+",激活核销码失败");
				                window.location.href=window.location.href;
				            }			       
				          }	      
				   });       
              });  	
        }
        
        
        
        function rebindModal(now){
        	var voucherCode=now.find("input[name=voucherCode]").val();
        	var voucherId=now.find("input[name='voucherId']").val();
            var orderId=now.find("input[name='orderId']").val();
            $(".rebindContainer-fonts").html("确认重新绑定核销码"+voucherCode+"?");
        	$("#rebindVoucherModal").modal("show"); 	
        	 $("#rebindVoucher").click(function(){  
              	$.ajax({
              	    url: "${request.contextPath}/vasVoucher/rebind/"+voucherCode+"/"+voucherId+"/"+orderId, 
				    type: "post",				    
				    dataType : "json",
				    contentType : "application/json",
				    success: function(result){	    	
				           	if(result.status=="SUCCESS"){			
				           	 $("#rebindVoucher").modal("hide");	 
				           	  window.location.href=window.location.href;   	      
				            }else{
				              $("#rebindVoucher").modal("hide");
				              alert(result.message+",重新绑定核销码失败");
				                window.location.href=window.location.href;
				            }			       
				          }	      
				   });       	         
              });  
        }




         //根据产品类型获得产品名称
         function getProductName(){
          $.ajax({
				    type: "POST",
				    url: "${request.contextPath}/vasOrder/getProductNameByType",    
				    contentType : "application/json",
				    data : {'id':id},
				    dataType : "json",
				    success: function(result){	    	
				           	if(result.status=="SUCCESS"){
				    	      alert("保存成功");
				            }else{
				              alert("保存失败");
				            }			       
				          }	      
				   });
         
         
         }





	function getProductName() {
			var productType = $("#productType").val();
			var str="";
		    $.ajax({
				url: "${request.contextPath}/vasOrder/getProductNameByType",    
				type:'post',
				//contentType : "application/json",
		        data:{'productType':productType},
		        dataType : "json",
				success: function(data){
					$("#productName option").remove();
					jQuery.each(data, function(i,item){    
						str+="<option value='"+item+"'>"+item+"</option>"; 
			        }); 
			        $("#productName").append('<option value="">全部</option>');
					$("#productName").append(str);
				}	
		    });
		 }
   
        
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
    <div class="breadnav"><span>增值服务</span>>核销码列表</div>
    <form id="myForm" autocomplete="off" >
        <div class="infor1" id="conditionDiv">
            <div class="product message">
                <div class="main">

                    <div class="part">

                        <span>供应商：</span> <select id="suppCode" name="productInfo.suppInfoDto.suppCode">
                        <option value="">全部</option>
                        <#list suppList as supp>
                        	<option value="${(supp.code)!''}">${(supp.name)!''}</option>
                        </#list> 
                        </select>
                        
                        <span>产品ID：</span><input type="text" id="productId" name="productInfo.id" value="${productId}"/>
                        <input type="hidden" id="linkProductId" name="linkProductId" value="${productId}"/>
                        
                        <span>code：</span><input type="text" id="productCode" name="productInfo.productType.subProductCode"/>
                   
                    </div>

                    <div class="part">              
                        <span>出发机场：</span><input type="text" id="departureAirPort" name="productInfo.productSaleRuleDto.includeDeptAirports_Str"/>
                        
                        <span>航站楼：</span><input type="text" id="departureTerminal" name="productInfo.productSaleRuleDto.includeDeptTerminals_Str"/>
                        
                    </div>
                    
                    <div class="part">
                        <span>核销码：</span><input type="text" id="voucherCode" name="voucherCode"/>
                        
                        <span>核销码状态：</span> <select id="voucherStatus" name="voucherStatus">
                        <option value="">全部</option>
                        <#list voucherStatus as status>
                        	<!--<option value="${status}">${(status.cnName)!''}</option>-->
                        	<#if status != "UPDATE_FAIL">
			                	<option value="${status}">${(status.cnName)!''}</option>
		                    </#if>
                        </#list> 
                        </select>
                    </div>
                    
                    
                    <div class="part">
                    <span style="width: 11%;">增值服务订单号：</span><input type="text" id="orderNo" name="orderInfo.orderNo"/>
                    <span>采购订单号：</span><input type="text" id="purchaseOrderNo" name="orderInfo.vasOrderPurchaseOrderRDto.purchaseSubOrderNo"/>
                    <input type="checkbox" id="relateOrder" name="isRelatedOrder" />是否已关联订单
                    </div>

                    
                    <div class="part">        
                        <div class="click">
                        <a href="javascript:;"><div id="query" class="button" onclick="query()">查询</div></a>
                        <a href="javascript:;"><div id="exportCSV" class="button" onclick="exportCsv()">导出CSV</div></a>                
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <div class="content1" style="margin-top:50px;">
        <table id="vasVoucherList"></table>
        <div id="pager"></div>
    </div>

</div>
<br>
</br>



<div class="modal fade" data-backdrop="static" data-keyboard="false" id="disableVoucherModal">
        <div class="modal-dialog" style="width:400px;height:215px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">核销码操作</h4>
                </div>
                <div class="modal-body">
                    <div class="popupContainer">
                        <span class="disContainer-fonts">确认禁用核销码?</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="commonButton red-fe6869Button" id="disabelVoucher">禁用</button>
                    <button type="button" class="commonButton blue-45c8dcButton" data-dismiss="modal" id="canceldisabel">取消</button>
                </div>
            </div>
        </div>
    </div>
    
    
    
    
         <div class="modal fade" data-backdrop="static" data-keyboard="false" id="activeVoucherModal">
        <div class="modal-dialog" style="width:400px;height:215px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">核销码操作</h4>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <span class="activeContainer-fonts">确认激活核销码?</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="activeVoucher">激活</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="cancelactive">取消</button>
                </div>
            </div>
        </div>
    </div>
    
    
    
       <div class="modal fade" data-backdrop="static" data-keyboard="false" id="rebindVoucherModal">
        <div class="modal-dialog" style="width:400px;height:215px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">核销码操作</h4>
                </div>
                <div class="modal-body">
                    <div class="popupContainer">
                        <span class="rebindContainer-fonts">确认重新绑定核销码?</span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="commonButton red-fe6869Button" id="rebindVoucher">重新绑定</button>
                    <button type="button" class="commonButton blue-45c8dcButton" data-dismiss="modal" id="cancelrebind">取消</button>
                </div>
            </div>
        </div>
    </div>
    
    
        
    <form id="exportCsvForm" action="${request.contextPath}/vasVoucher/exportVasCsv" method="post" target="_blank">
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form> 
    
</body>
</html>

