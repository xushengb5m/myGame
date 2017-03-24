<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>保单列表</title>
	<script type="text/javascript" src="http://s2.lvjs.com.cn/js/new_v/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/baoxian_common.js"></script>
	<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>
	<link rel="stylesheet" href="${request.contextPath}/css/baoxianstyle.css">
	<link rel="stylesheet" href="${request.contextPath}/css/jquery-ui.css">
    <link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
	<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
	<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
	<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
	<script src="${request.contextPath}/js/Calendar.js"></script>
    
    
    <script type="text/javascript">
    
	    $(function (){
	    	var businessId = $("#businessId").val();
	    	var businessType = $("#businessType").val();
	    	var operType = $("#operType").val();
			initGrid(businessId,businessType,operType);
	    });  
	      
		function initGrid(businessId,businessType,operType) {
			
			$("#opLogList").jqGrid({
				url : '${request.contextPath}/queryOpLogPage/'+businessId+'/'+businessType+'/'+operType,
				datatype : "json",
				mtype : "GET",
				colNames : ['操作时间', '操作详情','操作人','描述'],
				colModel : [ {
					name : 'createDate',
					index : 'createDate',
					align : 'center',
					sortable:false
				}, {
					name : 'remark',
					index : 'remark',
					align : 'center',
					sortable:false
				}, {
					name : 'oper',
					index : 'oper',
					align : 'center',
					sortable:false
				}, {
					name : 'desc',
					index : 'desc',
					align : 'center',
					sortable:false
				}],
				autowidth : true,
				rowNum : 10,
				pager : '#pager',
				viewrecords : true,
				height:'auto',//高度，表格高度。可为数值、百分比或'auto'
				rowList:[10,20,50], //可调整每页显示的记录数 
				multiselect : false,
				caption : "操作日志",
				jsonReader : {
					root : "results",
					page : "pagination.page", //当前页
					records : "pagination.records", //总记录数
					total : "pagination.total",
					repeatitems : false
				}
			});
		} 
		
	
	
  </script>
    
  </head>
  <body>
    <div class="baodan">
    	<input type="hidden" id="businessId" name="businessId" value="${businessId}"/>
    	<input type="hidden" id="businessType" name="businessType" value="${businessType}"/>
    	<div class="content content1" style="margin-top:50px;">
    		<div> 
    			<span class="keyname">操作人类型：</span>
	    	   	<select name="operType" id="operType" onchange="window.location.reload()">
	    	   		<option value="ALL">全部</option>
	    	   		<#list operTypeEnum as val>
				        <option value="${val}">${val.cnName}</option>
				    </#list> 
				    
	    	   	</select>
	    	</div>
	       	<table id="opLogList"></table>
	       	<div id="pager"></div>
		</div>
	
    </div>
       
        
  </body>
</html>
