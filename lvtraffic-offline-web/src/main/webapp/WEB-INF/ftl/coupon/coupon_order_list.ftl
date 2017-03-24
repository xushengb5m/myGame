<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
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
	<style>
        
     
    </style>
	<script type="text/javascript">
	$(document).ready(function() { 
			$('input[valid]').each(function(){ 
			var $this = $(this); 
			var valid = $this.attr('valid'); 
			if(valid=='email'){ 
				$this.blur(function(){ 
				mailValid($this); 
			});  
			}else if(valid=='num'){ 
					$this.keyup(function(){ 
					onlyNum($this[0]); 
				}); 
			} else if(valid=='decimal'){ 
					$this.keyup(function(){ 
					onlyDecimal($this[0]); 
				}); 
			} 
			}); 
		}); 

		function onlyNum(obj){  
		  obj.value=obj.value.replace(/\D/gi,""); 
		}  
		
		function onlyDecimal(obj){  
		  obj.value=obj.value.replace(/[^\.0-9_]/gi,""); 
		}  
		
	      $(function(){
            initGrid();
            
            $(".o_close").click(function(){
				$(".office").css("display","none");  
                $("#orderId").val("");
			}); 
        });
        
        
         //查询列表信息
        function query() {
            $("#vasOrderList").jqGrid('setGridParam', {
                url : "${request.contextPath}/vasOrder/queryCouponOrderList",
                datatype : "json",
                mtype : "POST",
                postData : getVasOrderQueryParams()
            }).trigger("reloadGrid");
            
        }

		//查询表格
       function getVasOrderQueryParams() {
            var orderNo=$("#orderNo").val();
            var purchaseSubOrderNo = $("#buyOrderNo").val();
            var orderStatus = $("#orderStatus").val();
            
            var bookingStartTime = $("#startUpdateTime").val();
            var bookingEndTime =$("#endUpdateTime").val();
            var productType =$("#productType").val();
            var productName = $("#productName").val();
            var supp =  $("#supp").val();
			var customerName =  $("#customerName").val(); 
            var mobile =  $("#mobile").val();
            var customerAccount =  $("#customerAccount").val();
            var productLine =  $("#productLine").val();
			var channel =  $("#channel").val();
			var subProductCode =  $("#subProductCode").val(); 
			var productId =  $("#productId").val();
			var issuingStatus =  $("#issuingStatus").val(); 
            var voucherStatus = $("#voucherStatus").val();  
            return {
                    'orderNo' : orderNo,
					'purchaseSubOrderNo' : purchaseSubOrderNo,
					'orderStatus' : orderStatus,
					'bookingStartTime' : bookingStartTime,
					'bookingEndTime' : bookingEndTime,
					'productType' : productType,
					'productName' : productName,
					'suppInfo' : supp,
					'mobile' : mobile,
					'customerAccount' : customerAccount,
					'customerName' : customerName,
					'productLine' : productLine,
					'channel' : channel,
					'subProductCode' : subProductCode,
					'productId' : productId,
					'issuingStatus' : issuingStatus,
					'voucherStatusStr':voucherStatus
            }
        }

        function initGrid() { 
            $("#vasOrderList").jqGrid({
                url : "${request.contextPath}/vasOrder/queryCouponOrderList",
                datatype : "json",
                mtype : "POST",
                colNames : [ '采购订单号', '优惠券产品订单号', '下单时间','子类型','产品名称', '销售价','联系人姓名','驴妈妈账号','发放状态',
				'优惠券码','订单金额','产品线'
				,'渠道',  '订单状态', '发放时间',  '手机号码', '操作','产品Id','发布状态code','产品线code'],
                colModel : [{
                    name : 'purchaseSubOrderNo',formatter:formatLink,
                    index : 'purchaseSubOrderNo',
                    align : 'center',
                    width :200,
                    sortable:false
                },{
                    name : 'orderNo',//添加
                    index : 'orderNo',
                    align : 'center',
                    width :200,
                    sortable:false
                }, {
                    name : 'bookingTime',
                    index : 'bookingTime',
                    align : 'center',
                    sortable:false
                  }, {
                    name : 'subTypeName', //添加
                    index : 'subTypeName',width :80,
                    align : 'center',
                    sortable:false
                  },{
                    name : 'productName',
                    index : 'productName',
                    align : 'center',
                    sortable:false
                },{
                    name : 'salePrice',
                    index : 'salePrice',
                    align : 'center',
					width :70,
                    sortable:false
                 },
				 {
                    name : 'customerName',
                    index : 'customerName',
                    align : 'center',width :60,
                    sortable:false
                },
				  {
                    name : 'customerAccount',
                    index : 'customerAccount',
                    align : 'center',width :60,
                    sortable:false
                },	
				{
                    name : 'issuingStatus',
                    index : 'issuingStatus',
                    align : 'center',
                    sortable:false
                },					
				  {
                    name : 'couponCodes',
                    index : 'couponCodes',
                    align : 'center',
                    sortable:false
                  },
				  {
                    name : 'salePrice',
                    index : 'salePrice',
                    align : 'center',width :70,
                    sortable:false
					},                
				  {
                    name : 'productLine',
                    index : 'productLine',
                    align : 'center',width :70,
                    sortable:false
				 }, 
				{
                    name : 'channel',
                    index : 'channel',width :90,
                    align : 'center',
                    sortable:false},
				  {
                    name : 'orderStaus',
                    index : 'orderStaus',width :80,
                    align : 'center',
                    sortable:false
                  },  
				  {
                    name : 'issuingTime',
                    index : 'issuingTime',
                    align : 'center',
                    sortable:false
                 }, {
                    name : 'mobile',
                    index : 'mobile',
                    align : 'center' ,
					hidden:true
                 }, 
                 {
                    name : 'operate',
                    index : 'operate',
                    align : 'center',
                    width :350,
                    sortable:false
                }, {
                    name : 'productId',
                    index : 'productId',
                    align : 'center' ,
					hidden:true
                 }, {
                    name : 'issuingCode',
                    index : 'issuingCode',
                    align : 'center' ,
					hidden:true
                 }, {
                    name : 'productLineCode',
                    index : 'productLineCode',
                    align : 'center' ,
					hidden:true
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
                sortname: 'purchaseSubOrderNo',  //排序字段名
                sortorder: "desc",    //排序方式：倒序
                caption : '优惠券产品订单管理',
                jsonReader : {
                    root : "results",               // json中代表实际模型数据的入口
                    page : "pagination.page",       // json中代表当前页码的数据
                    records : "pagination.records", // json中代表数据行总数的数据
                    total:'pagination.total',       // json中代表页码总数的数据
                    repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
                },
                onPaging : function(pgButton) {
                    $("#vasOrderList").jqGrid('setGridParam', {
                         postData : getVasOrderQueryParams()
                    });
                },        
                postData : getVasOrderQueryParams(),              
                gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#vasOrderList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var rowData = $('#vasOrderList').jqGrid('getRowData',id);
                        var operateClick = '';
						
						
						    
						if('正常'==rowData.orderStaus){
							if('未发放'==rowData.issuingStatus || '部分发放'==rowData.issuingStatus){
								operateClick +='  <a href="javascript:;" style="color:blue" onclick="publishCouponToUser('+rowData.orderNo+','+ 
								rowData.productId+')" >发放优惠券</a> '; 
	                    	}
						}
						
						var purchaseSubOrderNo = $(rowData.purchaseSubOrderNo).html();
						if('全部发放'==rowData.issuingStatus || '部分发放'==rowData.issuingStatus)
						    operateClick+='  <a href="javascript:;" style="color:blue" onclick=sync_status("'+rowData.orderNo+'","'+purchaseSubOrderNo+'","'+  
						    rowData.couponCodes+'","'+rowData.issuingCode+'","'+rowData.productLineCode+'","'+
						    rowData.productId+'") >同步状态</a> ';
						    
						operateClick+='  <a href="javascript:;" style="color:blue" onclick="view_log('+rowData.orderNo+','+rowData.productId+')" >日志</a> ';
						jQuery("#vasOrderList").jqGrid('setRowData', id , {operate:operateClick});  
                    }
                }
            });
        }
        
        function formatLink(cellvalue, options, rowObject) {
	        //主订单Id到后台自动查询
	        var result ="";
	        if("火车票"==rowObject.productLine){
	            var   url = "http://super.lvmama.com/train/offline-web/order/orderdetail/queryOrderDetail/"+rowObject.purchaseSubOrderNo+"/NULL";
	            result =  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>"
	        }else if("机票"==rowObject.productLine){
	           var orderMainId = -1;
	           var   url = "http://super.lvmama.com/offline-web/order/queryOrderDetail/"+orderMainId+"/"+rowObject.purchaseSubOrderId+"/NULL";
	           result =  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>"
	        }else{ result = cellvalue;}
	        
	        return  result;
	    }
       
	   /**查看日志
	    */
	   //查看日志
		function view_log(orderNo,id){
	        window.open("${request.contextPath}/vasLog/toVasOrderLogList/"+id+"/VAS_ORDER/"+orderNo);
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
		
		//同步状态
		function sync_status(orderNo,purchaseSubOrderNo,couponCodes,issuingCode,productLine,productId){
		
		   $.ajax({
		            url : '${request.contextPath}/vasOrder/syncCouponPublishStatus',
		            type : 'POST',
		            data : {"couponCodes":couponCodes,"status":issuingCode,"vasOrderNo":orderNo,"productLine":productLine,"productId":productId,"purchaseSubOrderNo":purchaseSubOrderNo},
		            success : function(data){
		
		                if(data.status == 'SUCCESS'){
		                    alert("状态同步成功！");
		                    query();
		                }else{
		                    alert("状态同步失败");
		                }
		            }
		        });
		}
		
		function publishCouponToUser(orderNo,productId)
		{
		 	$.ajax({
		            url : '${request.contextPath}/vasProduct/sendCouponCodeToUser',
		            type : 'POST',
		            data : {"orderNo":orderNo,"productId":productId},
		            success : function(data){
		                if(data.state=='SUCCESS'){
		                    alert("发放状态:"+data.publish);
		                    query();
		                }else{
		                    alert("调用发放优惠券失败!");
		                }
		            }
		        });
		}
    </script>
</head>




<body>
<div class="content content1">
    <div class="breadnav"><span>增值服务</span>>优惠券产品订单管理</div>
    <form id="myForm" autocomplete="off" >
        <div class="infor1"  style= "margin-right: 0%;"  id="conditionDiv">
            <div class="product message">
                <div class="main">

                    <div class="part">

                        <span style="width: 11%;">优惠券产品订单号：</span> <input type="text" id="orderNo" name="orderNo" style="width:10%;"  />
                        <span style="width: 8%;">采购订单号：</span><input type="text" id="buyOrderNo" name="buyOrderNo"  style="width:10%;"  />                       
                        <span style="width: 8%;">下单日期：</span>
					    <input type="text" id="startUpdateTime"  name="startUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"  
						class="Wdate" readonly="readonly"/> - 
			            <input type="text" id="endUpdateTime"   
						name="endUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/>    
                    </div>
					 <div class="part"> 
					    <span style="width: 8%;">订单状态：</span> <select id="orderStatus" name="orderStatus" >
                        <option value="">全部</option>
                        <#list orderStatus as status><option value="${status}">${(status.cnName)!''}</option></#list>
                        </select>
                        <span style="width: 11%;">发放状态：</span>  <select id="issuingStatus" name="issuingStatus"   >
                        <option value="">全部</option>
                         <#list couponPublishStatus as status><option value="${status}">${(status.cnName)!''}</option></#list>
                        </select>
						<span style="width: 8%;">产品线：</span> <select id="productLine" name="productLine" >
                        <option value="">全部</option>
                         <#list vasCouponProductLine as p><option value="${p}">${p.cnName}</option></#list>
                        </select> 
                    </div>

                    <div class="part">        
                        <span style="width: 8%;">渠道：</span> <select id="channel" name="channel" >
                        <option value="">全部</option>
                        <#list vasSaleChannel as c><option value="${c}">${c.cnName}</option></#list>
                        </select>
						<span style="width: 8%;">产品id：</span> <input type="text" id="productId" name="productId" valid='num' style="width:12%;" />      
						<span style="width: 8%;">产品名称：</span>
                        <input type="text" id="productName" name="productName"  style="width:12%;"   /> 
                        
                    </div>
                     <div class="part">               
                        <span style="width: 8%;">子类型：</span>
                        <select style="" id="productType" name="productType"  >
                        <option value="">全部</option>
                        <#list productTypeInfo as typeInfo><option value="${(typeInfo.subProductCode)!''}">${(typeInfo.subProductName)!''}</option></#list>
                        </select> 
                        <span style="width: 8%;">联系人姓名：</span><input style="width:8%;" type="text" id="customerName" name="customerName"   />
                        <span style="width: 8%;">联系电话：</span><input style="width:8%;" type="text" id="mobile" name="mobile"   />
                        <span style="width: 8%;">驴妈妈账号：</span><input style="width:8%;" type="text" id="customerAccount" name="customerAccount"   /> 
                        <div class="click">
                        <div id="query"class="button" style='cursor:pointer' onclick="query()">查询</div> <div id="exportCsv" class="button"  style='cursor:pointer' onclick="exportCsv()">导出</div>
                        </div>
                        
                    </div>
				
                </div>
            </div>
        </div>
    </form>

    <div class="content1" style="margin-top:50px;">
        <table id="vasOrderList"></table>
        <div id="pager"></div>
    </div>

</div>
<br>
</br>

<form id="exportCsvForm" action="${request.contextPath}/vasOrder/exportVasCouponOrderListCsv" method="post" target="_blank">
					<div id="exportCsvDiv" style="display:none;">
					</div>
				</form> 
	<!-- 核销码操作弹框显示
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
    
		 
		
		<div class="office" style="align:center;top:300px;" id="disableVryCodeDialog">
		    <div class="o_title">
		        禁用核销码<span class="o_close">X</span>
		    </div>
		    <br/>
		    <div class="get_value">
		        <span></span>
		    </div>
		    <div class="o_submit">
		        <a href="#"><span class="sure" onclick="sureDisableVryCode()">确定</span></a>
		        <a href="#"><span class="cancle" onclick="cancelDisableVryCode()">取消</span></a>
		    </div>
		</div>
		
		<div class="office" style="align:center;top:300px;" id="activeVryCodeDialog">
		    <div class="o_title">
		        激活核销码<span class="o_close">X</span>
		    </div>
		    <br/>
		    <div class="get_value">
		        <span></span>
		    </div>
		    <div class="o_submit">
		        <a href="#"><span class="sure" onclick="sureActiveVryCode()">确定</span></a>
		        <a href="#"><span class="cancle" onclick="cancelActiveVryCode()">取消</span></a>
		    </div>
		</div>
		
		<div class="office" style="align:center;top:300px;" id="rebindVryCodeDialog">
		    <div class="o_title">
		        重新绑定核销码<span class="o_close">X</span>
		    </div>
		    <br/>
		    <div class="get_value">
		        <span></span>
		    </div>
		    <div class="o_submit">
		        <a href="#"><span class="sure" onclick="sureRebindVryCode()">确定</span></a>
		        <a href="#"><span class="cancle" onclick="cancelRebindVryCode()">取消</span></a>
		    </div>
		</div>
		 
	 <input id="voucherCode" name="voucherCode" type="hidden"/>
	<input id="voucherId" name="voucherId" type="hidden"/>
	
	--> 
</body>
</html>

