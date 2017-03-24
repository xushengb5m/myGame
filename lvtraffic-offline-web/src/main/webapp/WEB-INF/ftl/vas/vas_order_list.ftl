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
	      $(function(){
            initGrid();
            
            $(".o_close").click(function(){
				$(".office").css("display","none");
				$("#voucherCode").val("");
                $("#voucherId").val("");
                $("#orderId").val("");
			});
             showmodal();
        });
        
        
         //查询列表信息
        function query() {
            $("#vasOrderList").jqGrid('setGridParam', {
                url : "${request.contextPath}/vasOrder/queryOrderList",
                datatype : "json",
                mtype : "POST",
                postData : getVasOrderQueryParams()
            }).trigger("reloadGrid");
            
        }
  
       function getVasOrderQueryParams() {
            var orderNo=$("#orderNo").val();
            var purchaseSubOrderNo = $("#buyOrderNo").val();
            var orderStatus = $("#orderStatus").val();
            
            var bookingStartTime = $("#startUpdateTime").val();
            var bookingEndTime =$("#endUpdateTime").val();
            var productType =$("#productType").val();
            var productName = $("#productName").val();
            var supp =  $("#supp").val();
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
					'voucherStatusStr':voucherStatus
            }
        }

        function initGrid() {
            $("#vasOrderList").jqGrid({
                url : "${request.contextPath}/vasOrder/queryOrderList",
                datatype : "json",
                mtype : "POST",
                colNames : ['是否状态同步机票','是否重新更新','出发时间','订单Id','核销码Id','是否有可用核销码标识','采购订单ID','采购订单号', '增值服务订单号', '产品名称', '供应商','核销码','乘客类型','姓名','证件类型', '证件号', '销售价', '结算价','下单时间','订单状态', '核销码状态', '有效期', '使用时间', '操作'],
                colModel : [ {
                    name : 'syncStatusFlag',
                    index : 'syncStatusFlag',
                    align : 'center',
                    width :200,
                    sortable:false,
                    hidden:true
                },{
                    name : 'vasVoucherUpdateInfoFlag',
                    index : 'vasVoucherUpdateInfoFlag',
                    align : 'center',
                    width :200,
                    sortable:false,
                    hidden:true
                },{
                    name : 'departure',
                    index : 'departure',
                    align : 'center',
                    width :200,
                    sortable:false,
                    hidden:true
                },{
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
                    name : 'canUseVasVoucherFlag',
                    index : 'canUseVasVoucherFlag',
                    align : 'center',
                    width :200,
                    sortable:false,
                    hidden:true
                 },{
                    name : 'purchaseSubOrderId',
                    index : 'purchaseSubOrderId',
                    align : 'center',
                    width :200,
                    sortable:false,
                    hidden:true
                 },{
                    name : 'purchaseSubOrderNo',formatter:formatLink,
                    index : 'purchaseSubOrderNo',
                    align : 'center',
                    width :200,
                    sortable:false
                }, {
                    name : 'orderNo',
                    index : 'orderNo',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'productName',
                    index : 'productName',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'suppCode',
                    index : 'suppCode',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'voucherCode',
                    index : 'voucherCode',
                    align : 'center',
                    sortable:false
                },{
                    name : 'passengerType',
                    index : 'passengerType',
                    align : 'center',
                    sortable:false
                },{
                    name : 'passengerName',
                    index : 'passengerName',
                    align : 'center',
                    sortable:false
                },{
                    name : 'cardType',
                    index : 'cardType',
                    align : 'center',
                    sortable:false
                },{
                    name : 'cardNo',
                    index : 'cardNo',
                    align : 'center',
                    sortable:false
                },{
                    name : 'salePrice',
                    index : 'salePrice',
                    align : 'center',
                    sortable:false
                 },{
                    name : 'settlementPrice',
                    index : 'settlementPrice',
                    align : 'center',
                    sortable:false
                 },
                  {
                    name : 'bookingTime',
                    index : 'bookingTime',
                    align : 'center',
                    sortable:false
                  },
                 {
                    name : 'orderStaus',
                    index : 'orderStaus',
                    align : 'center',
                    sortable:false
                  },{
                    name : 'voucherStatus',
                    index : 'voucherStatus',
                    align : 'center',
                    sortable:false
                  },{
                    name : 'expireTime',
                    index : 'expireTime',
                    align : 'center',
                    sortable:false
                  },{
                    name : 'usedTime',
                    index : 'usedTime',
                    align : 'center',
                    sortable:false
                  },{
                    name : 'operate',
                    index : 'operate',
                    align : 'center',
                    width : 250,
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
                sortname: 'purchaseSubOrderNo',  //排序字段名
                sortorder: "desc",    //排序方式：倒序
                caption : '增值服务订单列表',
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
                        var voucherStatus = rowData.voucherStatus;
                        var voucherCode = rowData.voucherCode;
                        console.log(voucherCode);
                        var voucherId=rowData.voucherId;
                        var orderId=rowData.orderId;
                        var canUseVasVoucherFlag = rowData.canUseVasVoucherFlag;
                        var purchaseSubOrderId = rowData.purchaseSubOrderId;
                        var vasVoucherUpdateInfoFlag = rowData.vasVoucherUpdateInfoFlag;
                        var syncStatusFlag = rowData.syncStatusFlag;
                        var departure = rowData.departure;
                        var operateClick = '';
                        if(voucherStatus == '可使用'){
                                /*
                                operateClick= '<span class="operation" style="color:blue">禁用核销码<input name="voucherCode" type="hidden"/><input name="voucherId" type="hidden"/><input name="orderId" type="hidden"/></span>'; */
                                
                                operateClick = '<a class="opp" href="javascript:;" style="color:blue; text-decoration:underline"  onclick="disableVryCode(this)" >禁用核销码'
                               +'<input name="voucherCode" type="hidden" value="'+voucherCode+'"/><input name="voucherId" type="hidden" value="'+voucherId+'"/><input name="orderId" type="hidden" value="'+orderId+'"/>'
                                +'</a>'

                            }else if(voucherStatus =='未激活'){
                                /*
                                operateClick= '<span class="operation" style="color:blue">激活核销码<input name="voucherCode" type="hidden"/><input name="voucherId" type="hidden"/><input name="orderId" type="hidden"/></span>'; */
                                operateClick = '<a class="opp" href="javascript:;" style="color:blue; text-decoration:underline"  onclick="activeVryCode(this)" >激活核销码'
                                +'<input name="voucherCode" type="hidden" value="'+voucherCode+'"/><input name="voucherId" type="hidden" value="'+voucherId+'"/><input name="orderId" type="hidden" value="'+orderId+'"/>'
                                +'</a>'

                            }else if(voucherStatus=='已禁用' && canUseVasVoucherFlag==0){
                                /*
                                operateClick= '<span class="operation" style="color:blue">重新绑定核销码<input name="voucherCode" type="hidden"/><input name="voucherId" type="hidden"/><input name="orderId" type="hidden"/></span>';*/
                                 operateClick = '<a class="opp" href="javascript:;" style="color:blue; text-decoration:underline"  onclick="rebindVryCode(this)" >重新绑定核销码'
                                +'<input name="voucherCode" type="hidden" value="'+voucherCode+'"/><input name="voucherId" type="hidden" value="'+voucherId+'"/><input name="orderId" type="hidden" value="'+orderId+'"/>'
                                +'</a>'
                            }else{
                               /*  operateClick='<span class="operation"></span>'; */
                                operateClick = "";
                            }
                            if(vasVoucherUpdateInfoFlag == "true"){
                            	operateClick += '   <a class="opp" href="javascript:;" style="color:blue; text-decoration:underline"  onclick="updateVryCodeExpire(this)" >重新更新日期'
                               +'<input name="voucherCode" type="hidden" value="'+voucherCode+'"/><input name="departure" type="hidden" value="'+departure+'"/></a>'
                            }
                            if(syncStatusFlag == "true"){
                            	operateClick += '   <a class="opp" href="javascript:;" style="color:blue; text-decoration:underline"  onclick="syncVryCodeStatus(this)" >同步状态'
                               +'<input name="voucherCode" type="hidden" value="'+voucherCode+'"/><input name="voucherStatus" type="hidden" value="'+voucherStatus+'"/><input name="orderId" type="hidden" value="'+orderId+'"/>'
                                +'</a>'
                            }
                            jQuery("#vasOrderList").jqGrid('setRowData', id , {operate:operateClick});
                           /* $(".opp").eq(id-1).find("input[name=voucherCode]").val(voucherCode);
                            $(".opp").eq(id-1).find("input[name=voucherId]").val(voucherId);
                            $(".opp").eq(id-1).find("input[name=orderId]").val(orderId);*/
                       
           
                    }
                }
            });
        }
        
        function formatLink(cellvalue, options, rowObject) {
	        //主订单Id到后台自动查询
	        var orderMainId = -1;
	        var   url = "http://super.lvmama.com/offline-web/order/queryOrderDetail/"+orderMainId+"/"+rowObject.purchaseSubOrderId+"/NULL";
	        return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
	    }
       
        function updateVryCodeExpire(opp){
        	var voucherCode= $(opp).find("input[name='voucherCode']").val();
        	var departure= $(opp).find("input[name='departure']").val();
	    	$.ajax({
                url: "${request.contextPath}/vasOrder/updateVasVoucherExpire",
                type: "post",
                dataType : "json",
                data : {
                	code : voucherCode,
                	departure : departure
                },
                //contentType : "application/json",
                success: function(data){
                    alert(data.message);
                    query();
                }
            });
        }
        
        function syncVryCodeStatus(opp){
        	if(confirm("确认状态同步到机票那边？")){
	        	var voucherCode= $(opp).find("input[name='voucherCode']").val();
	        	var voucherStatus= $(opp).find("input[name='voucherStatus']").val();
	        	var orderId= $(opp).find("input[name='orderId']").val();
	        	$.ajax({
	                url: "${request.contextPath}/vasOrder/syncVryCodeStatus",
	                type: "post",
	                dataType : "json",
	                data : {
	                	code : voucherCode,
	                	status : voucherStatus,
	                	orderId : orderId
	                },
	                success: function(data){
	                	if(data.status == 'FAIL'){
	                		alert("同步状态失败！");
	                	}else{
	                		alert("同步状态成功！");
	                	}
	                    //alert(data.message);
	                    query();
	                }
	            });
        	}
        }
        
        
        	 /* 添加核销码相关操作 start */
            function disableVryCode(opp){

			   var voucherCode= $(opp).find("input[name='voucherCode']").val();
               var voucherId= $(opp).find("input[name='voucherId']").val();
               var orderId= $(opp).find("input[name='orderId']").val();              
			  			
                $("#disableVryCodeDialog  .get_value span").html("确认禁用核销码:"+voucherCode);
                
                $("#voucherCode").val(voucherCode);               
                $("#voucherId").val(voucherId);
                $("#orderId").val(orderId);                       
                $("#disableVryCodeDialog").css("display","block");
            }
            function cancelDisableVryCode(){

                $("#voucherCode").val("");
                $("#voucherId").val("");
                $("#orderId").val("");
                $("#disableVryCodeDialog").css("display","none");
            }           
            function sureDisableVryCode(){
                var voucherCode = $("#voucherCode").val();
                var voucherId = $("#voucherId").val();
                var orderId = $("#orderId").val();
                $("#disableVryCodeDialog").css("display","none");
                $.ajax({
                    url: "${request.contextPath}/vasVoucher/disabled/"+voucherCode+"/"+voucherId+"/"+orderId,
                    type: "post",
                    dataType : "json",
                    contentType : "application/json",
                    success: function(result){
                        if(result.status=="SUCCESS"){
                            $("#disableVryCodeDialog").css("display","none");
                            alert("操作成功！");
                            //window.location.href=window.location.href;
                            query();
                        }else{
                            $("#disableVryCodeDialog").css("display","none");
                            alert("操作失败！"+result.message);
                            //window.location.href=window.location.href;
                            query();
                        }
                    }
                });
            }

            function activeVryCode(opp){

				var voucherCode= $(opp).find("input[name='voucherCode']").val();
               var voucherId= $(opp).find("input[name='voucherId']").val();
               var orderId= $(opp).find("input[name='orderId']").val();  
               
                $("#activeVryCodeDialog  .get_value span").html("确认激活核销码:"+voucherCode);
                $("#voucherCode").val(voucherCode);
                $("#voucherId").val(voucherId);
                $("#orderId").val(orderId);
                $("#activeVryCodeDialog").css("display","block");
            }
            function cancelActiveVryCode(){

                $("#voucherCode").val("");
                $("#voucherId").val("");
                $("#orderId").val("");
                $("#activeVryCodeDialog").css("display","none");
            }
            function sureActiveVryCode(){
                var voucherCode = $("#voucherCode").val();
                var voucherId = $("#voucherId").val();
                var orderId = $("#orderId").val();
				$("#activeVryCodeDialog").css("display","none");
				
                $.ajax({
                    url: "${request.contextPath}/vasVoucher/active/"+voucherCode+"/"+voucherId+"/"+orderId,
                    type: "post",
                    dataType : "json",
                    contentType : "application/json",
                    success: function(result){
                        if(result.status=="SUCCESS"){
                            $("#activeVryCodeDialog").css("display","none");
                            alert("操作成功！");
                            //window.location.href=window.location.href;
                            query();
                        }else{
                            $("#activeVryCodeDialog").css("display","none");
                            alert("操作失败！"+result.message);
                            //window.location.href=window.location.href;
                            query();
                        }
                    }
                });
            }

            function rebindVryCode(opp){
            
				var voucherCode= $(opp).find("input[name='voucherCode']").val();
               var voucherId= $(opp).find("input[name='voucherId']").val();
               var orderId= $(opp).find("input[name='orderId']").val();  
               
                $("#rebindVryCodeDialog  .get_value span").html("确认重新绑定核销码:"+voucherCode);
                $("#voucherCode").val(voucherCode);
                $("#voucherId").val(voucherId);
                $("#orderId").val(orderId);
                $("#rebindVryCodeDialog").css("display","block");
            }
            function cancelRebindVryCode(){

                $("#voucherCode").val("");
                $("#voucherId").val("");
                $("#orderId").val("");
                $("#rebindVryCodeDialog").css("display","none");
            }
            function sureRebindVryCode(){
                var voucherCode = $("#voucherCode").val();
                var voucherId = $("#voucherId").val();
                var orderId = $("#orderId").val();

				$("#rebindVryCodeDialog").css("display","none");
                if(!confirm("确定要重新绑定核销码吗？"))
                {
                   return;
                }
                $.ajax({
                    url: "${request.contextPath}/vasVoucher/rebind/"+voucherCode+"/"+voucherId+"/"+orderId,
                    type: "post",
                    dataType : "json",
                    contentType : "application/json",
                    success: function(result){
                        if(result.status=="SUCCESS"){
                            $("#rebindVryCodeDialog").css("display","none");
                            alert("操作成功！"+result.message);
                            //window.location.href=window.location.href;
                            query();
                        }else{
                            $("#rebindVryCodeDialog").css("display","none");
                            alert("操作失败！"+result.message);
                            //window.location.href=window.location.href;
                            query();
                        }
                    }
                });
            }

            /* 添加核销码相关操作 end */
        
        function showmodal(){
                $("#vasOrderList").delegate(".operation","click",function(){   
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
              console.log(voucherId);
              console.log(orderId);
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
                                alert("操作失败！"+result.message);
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
                                alert("操作失败！"+result.message);
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
                                alert("操作失败！"+result.message);
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









    </script>
</head>




<body>
<div class="content content1">
    <div class="breadnav"><span>增值服务</span>>订单列表</div>
    <form id="myForm" autocomplete="off" >
        <div class="infor1">
            <div class="product message">
                <div class="main">

                    <div class="part">

                        <span style="width: 11%;">增值服务订单号：</span> <input type="text" id="orderNo" name="orderNo"/>
                        <span style="width: 8%;">采购订单号：</span><input type="text" id="buyOrderNo" name="buyOrderNo"/>
                        <span style="width: 8%;">订单状态：</span> <select id="orderStatus" name="orderStatus" >
                        <option value="">全部</option>
                        <#list orderStatus as status><option value="${status!''}">${(status.cnName)!''}</option></#list>
                        </select>
                        <span style="width: 8%;">下单日期：</span>
					    <input type="text" id="startUpdateTime"  name="startUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/> - 
			            <input type="text" id="endUpdateTime"  name="endUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/>          
                    </div>

                    <div class="part">              
                        <span style="width: 8%;">产品类型：</span>
                        <select style="" id="productType" name="productType" onblur="getProductName()">
                        <option value="">全部</option>
                        <#list productTypeInfo as typeInfo><option value="${(typeInfo.subProductCode)!''}">${(typeInfo.subProductName)!''}</option></#list>
                        </select>
     
                        <!-- 产品调整为输入框 模糊
                        <span style="width: 8%;">产品名称：</span><select style="width:233.69px;" id="productName" name="productName" >
                         <option value="">全部</option>
                         <#list productNameList as productName><option value="${productName!''}">${productName!''}</option></#list>                        
                        </select>
                        -->
                        
                        <span style="width: 8%;">产品名称：</span><input style="width:203.69px;" type="text" id="productName" name="productName" />
                       
                        <span style="width: 8%;">供应商：</span> 
                        <select id="supp" name="supp" >
                         <option value="">全部</option>
                          <#list suppList as supp><option value="${(supp.code)!''}">${(supp.name)!''}</option></#list>                     
                        </select>
                        <span>核销码状态：</span>
	                        <select id="voucherStatus" name="voucherStatus">
		                        <option value="">全部</option>
		                        <#list voucherStatus as status>
		                        	<#if status != "UPDATE_FAIL">
			                        	<option value="${status}">${(status.cnName)!''}</option>
		                        	</#if>
		                        </#list> 
	                        </select>
                        <div class="click">
                        <div id="query"class="button" onclick="query()" style='cursor:pointer'>查询</div>
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
    
		    <!-- 核销码操作弹框显示 start -->
		
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
		
		<!-- 核销码操作弹框显示 end -->
    
	<input id="voucherCode" name="voucherCode" type="hidden"/>
	<input id="voucherId" name="voucherId" type="hidden"/>
	<input id="orderId" name="orderId" type="hidden"/>
</body>
</html>

