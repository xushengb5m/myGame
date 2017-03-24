<!DOCTYPE html>
<html>
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
	
	
    
    <script type="text/javascript">
    
	    $(function (){
	    	var pid = '${pid}';
	    	if(pid != ''){
	    		$("#promId").val(pid);
	    	}
			initGrid();
		});
			
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}    
		
		//查询列表信息   
		function query() { 
       		
			$("#countList").jqGrid('setGridParam', {
				url : "${request.contextPath}/promotionStatis/queryCountList",
				datatype : "json",
				mtype : "POST",
				postData : getCountParams()
			}).trigger("reloadGrid");
		}
		
		function getCountParams() {
			var promId = $("#promId").val();
			var promName = $("#promName").val();
			var promMainId = $("#promMainId").val();
			var promMainName = $("#promMainName").val();
			var orderStart = $("#orderStart").val();
			var orderEnd = $("#orderEnd").val();
			
			return {
				'promId' : promId,
				'promName' : promName,
				'promMainId' : promMainId,
				'promMainName' : promMainName,
				'orderStart' : orderStart,
				'orderEnd' : orderEnd
			}
		}
		
		function initGrid() {
			$("#countList").jqGrid({
				url : "${request.contextPath}/promotionStatis/queryCountList",
				datatype : "json",
				mtype : "POST",
				colNames : ['订单号', '子活动ID', '子活动名', '主活动ID','主活动名','下单时间','会员ID','联系手机','活动方式' ],
				colModel : [ {
					name : 'orderMainId',
					index : 'orderMainId',
					align : 'center',
					width :200,
					sortable:false
				}, {
					name : 'promId',
					index : 'promId',
					align : 'center',
					sortable:false
				}, {
					name : 'promName',
					index : 'promName',
					align : 'center',
					sortable:false
				}, {
					name : 'promMainId',
					index : 'promMainId',
					align : 'center',
					sortable:false
				}, {
					name : 'promMainName',
					index : 'promMainName',
					align : 'center',
					sortable:false
				},{
					name : 'createOrderTimeStr',
					index : 'createOrderTimeStr',
					align : 'center',
					hidden : false,
					sortable:false
				},{
					name : 'userId',
					index : 'userId',
					align : 'center',
					sortable:false
				},{
					name : 'tel',
					index : 'tel',
					align : 'center',
					sortable:false
				},{
					name : 'promTypeStr',
					index : 'promTypeStr',
					align : 'center',
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
			    sortname: 'orderMainId',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : '子活动列表',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#countList").jqGrid('setGridParam', {
						postData : getCountParams ()
					});
				},
				postData : getCountParams (),
				//gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                  //  var ids=jQuery("#countList").jqGrid('getDataIDs');
                  //  for(var i=0; i<ids.length; i++){
                    	//var id=ids[i];
                    	//var rowData = $('#countList').jqGrid('getRowData',id);
                    	//var insuranceType = rowData.insuranceType;
                        //TASK#36006
                    	//var productTypes = rowData.productTypes;
                        //operateClick= '<a href="javascript:;" style="color:blue" onclick="operateLog('+id+')" >日志</a> <a href="javascript:;" style="color:blue" onclick="update('+id+')" >修改</a> <a href="#" style="color:blue" onclick="deleteInsurance('+id+')" >删除</a> <a href="javascript:;" style="color:blue" onclick="updateInsuranceDefaultRule('+"'"+id+"' ,'"+ insuranceType +"'"+')" >默认</a>';
                      //  operateClick= ' <a href="javascript:;" style="color:blue" onclick="copy('+id+')" >复制</a> <a href="#" style="color:blue" onclick="edit('+id+')" >修改</a> ';
                       // lookClick = '<a href="javascript:;" style="color:blue" onclick="cat('+id+')">查看</a>';
                       // jQuery("#countList").jqGrid('setRowData', id , {look:lookClick});
                      //  jQuery("#countList").jqGrid('setRowData', id , {operate:operateClick});
                    //}
                //}
			});
		}
		
		//导出Csv
		function exportCsv(){
			//conditionToExportCsvForm();
			$('#exportCsvForm').submit();
		}
		
		//将条件set到Form
		//function conditionToExportCsvForm(){
			
		//}

  </script>
    
  </head>
  <body>
  
	<div class="content content1">
	  <div class="breadnav"><span>首页</span> > 活动统计</div>
	  <form id="exportCsvForm" autocomplete="off" action="${request.contextPath}/promotionStatis/exportCsv" method="post" target="_blank" >
	  <div class="infor1">
		 <div class="product message">
			<div class="main">
				<div class="part">
					<span>子活动ID：</span><input type="text" id="promId" name="promId">
					<span>子活动名称：</span><input type="text" id="promName" name="promName">
				</div>
				<div class="part">						
					<span>主活动ID：</span><input type="text" id="promMainId" name="promMainId">
					<span>主活动名称：</span><input type="text" id="promMainName" name="promMainName">	
				</div>
				<div class="part">
					<span>下单时间：</span><input type="text" id="orderStart" name="orderStart" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/>
					 - 
					<input type="text" id="orderEnd" name="orderEnd" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
					 	class="Wdate" readonly="readonly"/>
				</div>
			</div>
		</div>
	</div>
	  
  	<div class="click">
  		<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
	    <a href="javascript:;"><div class="button" onclick="exportCsv()">导出CSV</div></a>
	</div>
	</form>
	
 	<div class="content1" style="margin-top:50px;">
		<table id="countList"></table>
        <div id="pager"></div>
    </div>
	
    </div>
     <br>
	 <!--<form id="exportCsvForm" action="${request.contextPath}/promotionStatis/exportCsv" method="post" target="_blank">
		<input type="hidden" id="promIdForm" >
		<input type="hidden" id="promNameForm" >
		<input type="hidden" id="promMainIdForm" >
		<input type="hidden" id="promMainNameForm" >
		<input type="hidden" id="orderStartForm" >
		<input type="hidden" id="orderEndForm" >
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form>-->
	 
</body>
</html>
