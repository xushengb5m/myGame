<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>用户反馈列表</title>
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
       		
			$("#feedBackList").jqGrid('setGridParam', {
				url : "queryfeedBackList",
				datatype : "json",
				mtype : "POST",
				postData : getfeedBackParams()
			}).trigger("reloadGrid");
		}
		
		function getfeedBackParams() {
			return {
				'id' : $('#feedBackId').val(),
				'userName' : $('#userName').val(),
				'mobile' : $('#mobile').val(),
				'problemOwnership' : $('#problemOwnership').val(),
				'request.startUpdateTime' : $("#startUpdateTime").val(),
				'request.endUpdateTime' : $("#endUpdateTime").val(),
				'progress' : $("#progress").val(),
				'product' : $("#product").val(),
				'type' : $("#type").val(),
				'platform' : $("#platform").val()
			}
		}
		
		function initGrid() {
			$("#feedBackList").jqGrid({
				url : "queryfeedBackList",
				datatype : "json",
				mtype : "POST",
				colNames : ['问题编号','产品线','类型','平台','页面入口','内容','提交时间','会员号','联系手机','处理人','问题类型','处理进度','备注','操作'],
				colModel : [ {
					name : 'id',
					index : 'feedbackId',
					align : 'center',
					width :200,
					sortable:false
				}, {
					name : 'product',
					index : 'product',
					align : 'center',
					sortable:false
				}, {
					name : 'type',
					index : 'type',
					align : 'center',
					sortable:false
				}, {
					name : 'platform',
					index : 'platform',
					align : 'center',
					sortable:false
				}, 
				{
					name : 'problemFrom',
					index : 'problemFrom',
					align : 'center',
					sortable:false
				},{
					name : 'content',
					index : 'content',
					align : 'center',
					sortable:false
				}, {
					name : 'createTime',
					index : 'createTime',
					align : 'center',
					sortable:false
				}, {
					name : 'userName',
					index : 'userName',
					align : 'center',
					sortable:false
				},{
					name : 'mobile',
					index : 'mobile',
					align : 'center',
					sortable:false
				},{
					name : 'operator',
					index : 'operator',
					align : 'center',
					sortable:false
				},{
					name : 'problemOwnership',
					index : 'problemOwnership',
					align : 'center',
					sortable:false
				},{
					name : 'progress',
					index : 'progress',
					align : 'center',
					sortable:false
				},{
					name : 'remark',
					index : 'remark',
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
				caption : '用户反馈',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#feedBackList").jqGrid('setGridParam', {
						postData : getfeedBackParams()
					});
				},
				postData : getfeedBackParams (),
				gridComplete:function(){  //在此事件中循环为每一行添加日志、操作链接
                    var ids=jQuery("#feedBackList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                    	var rowData = $('#feedBackList').jqGrid('getRowData',id);
                    	var progress = rowData.progress;
                    	if("待处理" == progress || "处理中" == progress){
                    		operateClick= '<a href="javascript:;" style="color:blue" onclick="update('+id+')" >操作</a>     <a href="javascript:;" style="color:blue" onclick="operateLog('+id+')" >日志</a>';
                    	} else {
                    		operateClick= '            <a href="javascript:;" style="color:blue" onclick="operateLog('+id+')" >日志</a>';
                    	}
                        jQuery("#feedBackList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		} 
		//查看操作日志
		function operateLog(id) {
		   	window.open("${request.contextPath}/feedback/tofeedBackLogList/"+id);
		}
		
		//修改
		function update(id) {
		   	window.open("${request.contextPath}/feedback/toEditFeedBackPage/"+id);
		}	
		//导出报表
		//exportCsv
		function exportCSV(){
			$("#myForm").submit();
		}
  </script>
    
  </head>
  <body>
  
	<div class="content content1">
	  <div class="breadnav"><span>首页</span> > 用户反馈</div>
	  <form id="myForm" autocomplete="off" action="${request.contextPath}/feedback/exportCSV" method="post">
	  <div class="infor1">
		 <div class="product message">
			<div class="main">
				<div class="part">
					<span>会员号：</span>
					<input type="text" name="userName" id="userName">
					<span style="margin-left:10px;">联系手机：</span>
					<input type="text" name="mobile" id="mobile">
					<span style="margin-left:10px;">问题类型：</span>
					<select name="problemOwnership" id="problemOwnership">
					<option value="ALL">全部</option>
			        <option value="FLIGHT_FRONT">机票前端</option>
			        <option value="TRAIN_FRONT">火车票前端</option>
			        <option value="FLIGHT_BACK">机票后台</option>
			        <option value="TRAIN_BACK">火车票后台</option>
			        <option value="DISTRIBUTION_FLIGHR">分销机票</option>
			        <option value="DISTRIBUTION_TRAIN">分销火车票</option>
			        <option value="STORE">门店</option>
			        <option value="TRAFFIC_PUBLIC">公共</option>
			        </select>
			        <span>问题编号：</span>
					<input type="text" name="feedBackId" id="feedBackId">
		        </select>
				</div>
				<div class="part">
				<span>提交时间：</span>
				<input type="text" id="startUpdateTime"  name="startUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
					class="Wdate" readonly="readonly"/> - 
		        <input type="text" id="endUpdateTime"  name="endUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
					class="Wdate" readonly="readonly"/>
					
					<span style="margin-left:10px;width:100px;">处理进度：</span>
						<select name="progress" id="progress">
							<option value="ALL">全部</option>
							<option value="TO_BE_PROCESSED">待处理</option>
							<option value="PROCESSING">处理中</option>
							<option value="PROCESSED">已处理</option>
							<option value="OTHERS">忽略</option>
				        </select>
					<span style="margin-left:10px;width:100px;">产品线：</span>
					<select name="product" id="product">
					    <option value="ALL">全部</option>
						<option value="FLIGHT">飞机票</option>
						<option value="TRAIN">火车票</option>
						<option value="PACKAGE">打包</option>
						<option value="OTHERS">其它</option>
					</select>  
					<span style="margin-left:10px;width:100px;">类型：</span>
					<select name="type" id="type">
					    <option value="ALL">全部</option>
						<option value="STORY">需求单</option>
						<option value="FEEDBACK">吐槽</option>
						<option value="OTHERS">其它</option>
					</select>  
					<span style="margin-left:10px;width:100px;">平台：</span>
					<select name="platform" id="platform">
						<option value="ALL">全部</option>
					    <option value="IOS">移动IOS</option>
						<option value="ANDROID">移动Android</option>
						<option value="WAP">移动Wap</option>
						<option value="PC">PC</option>
						<option value="DISTRIBUTION">分销</option>
						<option value="STORE">门店</option>
						<option value="OTHERS">其它</option>
					</select>  
				</div>
			</div>
		</div>
	</div>
	  
  	<div class="click">
  		<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
	    <a href="javascript:;"><div class="button" onclick="exportCSV()">导出CSV</div></a>
	</div>
		
	</form>
	
 	<div class="content1" style="margin-top:50px;">
		<table id="feedBackList"></table>
        <div id="pager"></div>
    </div>
	
    </div>
     <br>
     <br>
	 
</body>
</html>
