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
			initGrid();
			//getInsurance();
		});
			
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}    
		
		//查询列表信息   
		function query() { 
       		
			$("#promotionMainList").jqGrid('setGridParam', {
				url : "${request.contextPath}/promotionMain/queryPromotionMainList",
				datatype : "json",
				mtype : "POST",
				postData : getPromotionMainParams()
			}).trigger("reloadGrid");
		}
		
		function getPromotionMainParams() {
			var id = $('#id').val();
			var createTimeStart = $("#createTime_start").val();
			var createTimeEnd = $("#createTime_end").val();
			var activityTimeStart = $("#activityTime_start").val();
			var activityTimeEnd = $("#activityTime_end").val();
			var validity = $("#validity").val();
			var createUser = $("#createUser").val();
			if((activityTimeStart != "" && activityTimeEnd == "") || (activityTimeStart == "" && activityTimeEnd != "") ){
				alert("活动时间不能有一边为空");
				return;
			}
			
			return {
				'id' : id,
				'createTimeStart' : createTimeStart,
				'createTimeEnd' : createTimeEnd,
				'activityTimeStart' : activityTimeStart,
				'activityTimeEnd' : activityTimeEnd,
				'validity' : validity,
				'createUser' : createUser
			}
		}
		
		function initGrid() {
			$("#promotionMainList").jqGrid({
				url : "${request.contextPath}/promotionMain/queryPromotionMainList",
				datatype : "json",
				mtype : "POST",
				colNames : ['活动ID号', '活动名称', '活动时间', '有效性','创建时间','最近更新时间','创建人','最后操作人', '操作' ],
				colModel : [ {
					name : 'id',
					index : 'id',
					align : 'center',
					width :200,
					sortable:false
				}, {
					name : 'promotionMianName',
					index : 'promotionMianName',
					align : 'center',
					sortable:false
				}, {
					name : 'validTime',
					index : 'validTime',
					align : 'center',
					sortable:false
				}, {
					name : 'validityStr',
					index : 'validityStr',
					align : 'center',
					sortable:false
				}, {
					name : 'createTimeStr',
					index : 'createTimeStr',
					align : 'center',
					sortable:false
				},{
					name : 'operateTimeStr',
					index : 'operateTimeStr',
					align : 'center',
					sortable:false
				},{
					name : 'createUser',
					index : 'createUser',
					align : 'center',
					sortable:false
				},{
					name : 'opterator',
					index : 'opterator',
					align : 'center',
					hidden : false,
					sortable:false
				}, {
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
				caption : '活动列表',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#promotionMainList").jqGrid('setGridParam', {
						postData : getPromotionMainParams ()
					});
				},
				postData : getPromotionMainParams (),
				gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#promotionMainList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                    	var rowData = $('#promotionMainList').jqGrid('getRowData',id);
                    	var validValue = rowData.validityStr;
                    	//var insuranceType = rowData.insuranceType;
                        //TASK#36006
                    	//var productTypes = rowData.productTypes;
                        //operateClick= '<a href="javascript:;" style="color:blue" onclick="operateLog('+id+')" >日志</a> <a href="javascript:;" style="color:blue" onclick="update('+id+')" >修改</a> <a href="#" style="color:blue" onclick="deleteInsurance('+id+')" >删除</a> <a href="javascript:;" style="color:blue" onclick="updateInsuranceDefaultRule('+"'"+id+"' ,'"+ insuranceType +"'"+')" >默认</a>';
                        if(validValue == '无效'){
                        	operateClick= '<a href="javascript:;" style="color:blue" onclick="copy('+id+')" >复制</a> <a href="javascript:;" style="color:blue" onclick="edit('+id+')" >编辑</a> ';
                        }else{
	                        operateClick= '<a href="javascript:;" style="color:blue" onclick="setUnvalid('+id+')" >设为无效</a> <a href="javascript:;" style="color:blue" onclick="copy('+id+')" >复制</a> <a href="javascript:;" style="color:blue" onclick="edit('+id+')" >编辑</a> ';
                        }
                        jQuery("#promotionMainList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		} 
		
		//设为无效
		function setUnvalid(id){
			window.location.href = "${request.contextPath}/promotionMain/setUnvalid/"+id;
		}		
		
		//复制
		function copy(id){
			window.location.href = "${request.contextPath}/promotionMain/copyAndEditPromotionMain/"+id+"/c";
		}
		
		//编辑
		function edit(id){
			window.location.href = "${request.contextPath}/promotionMain/copyAndEditPromotionMain/"+id+"/e";
		}
		
		
		//新增
		function add(){
			window.location.href="${request.contextPath}/promotionMain/addPromotionMain";
		}
		
		
  </script>
    
  </head>
  <body>
  
	<div class="content content1">
	  <div class="breadnav"><span>首页</span> > 主活动列表</div>
	  <form id="myForm" autocomplete="off" >
	  <div class="infor1">
		 <div class="product message">
			<div class="main">
				<div class="part">
					<span>活动号：</span><input type="text" id="id" name="id">
 					
					<span>创建时间：</span><input type="text" id="createTime_start" name="createTime_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/>
					 - 
					<input type="text" id="createTime_end" name="createTime_end" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
					 	class="Wdate" readonly="readonly"/>
					 	
					<span>活动时间：</span><input type="text" id="activityTime_start"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/>
					 - 
					<input type="text" id="activityTime_end" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/>
						
					</div>
					
					<div class="part">						
						<span>活动状态：</span><select id="validity" name="validity">
							<#list valids as val>  
							  <#if val !="NULL">
							  	<#if val == 'NONE'>
							  		 <option value="" selected='selected'>${val.cnName}</option>
							  		 <#else>
									 <option value="${val}">${val.cnName}</option>
							  	</#if>
							  </#if> 
							</#list>
						</select>
						<span>创建人</span><input type="text" id="createUser" name="createUser" >		
					</div>
					
			</div>
		</div>
	</div>
	  
  	<div class="click">
  		<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
	    <a href="javascript:;"><div class="button" onclick="add()">新增</div></a>
	</div>
		
	</form>
	
 	<div class="content1" style="margin-top:50px;">
		<table id="promotionMainList"></table>
        <div id="pager"></div>
    </div>
	
    </div>
     <br>
     <br>
	 
</body>
</html>
