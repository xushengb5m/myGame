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
			getInsurance();
		});
			
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}    
		
		function addInsurance() {  
				window.open("${request.contextPath}/insurance/toAddInsurancePage"); 
		}   

		//打开销售调控
		function saleControle(insuranceId) {  
			window.open("${request.contextPath}/SaleControl/toPage/INSURANCE/"+insuranceId); 
		} 		
		
		//查询列表信息   
		function query() { 
       		
			$("#insuranceInfoList").jqGrid('setGridParam', {
				url : "queryinsuranceInfoList",
				datatype : "json",
				mtype : "POST",
				postData : getInsuranceInfoParams()
			}).trigger("reloadGrid");
		}
		
		function getInsuranceInfoParams() {
			var insuranceName = $('#insuranceName').find("option:selected").text();
			if($('#insuranceName').find("option:selected").text()=='全部'){
				insuranceName = '';
			}
			return {
				'insuranceClass.code' : $('#insuranceCode').val(),
				'insuranceClass.name' : insuranceName,
				'supp.id' : $('#suppName').val(),
				'startUpdateTime' : $("#startUpdateTime").val(),
				'defaultRule' : $("#defaultRule").val(), 
				'endUpdateTime' : $("#endUpdateTime").val(),
				'status' : $("#status").val(),
				'productTypes' : $("#productType").val(),
				'insuranceType' : $("#insuranceType").val(),
				'search':false
			}
		}
		
		function initGrid() {
			$("#insuranceInfoList").jqGrid({
				url : "queryinsuranceInfoList",
				datatype : "json",
				mtype : "POST",
				colNames : ['供应商','产品编码','险种名称','市场参考销售金额','成本金额','保额','保险类型','保险类型','适用产品类型','适用产品类型','产品状态','是否默认','修改时间','操作'],
				colModel : [ {
					name : 'supp.name',
					index : 'suppName',
					align : 'center',
					width :150
				}, {
					name : 'insuranceClass.code',
						width :100,
					index : 'insuranceCode',
					align : 'center'
				}, {
					name : 'insuranceClass.name',
					index : 'insuranceName',
					align : 'center'
				}, {
					name : 'insurancePrice',
					index : 'insurancePrice',
					align : 'center'
				}, {
					name : 'costPrice',
					index : 'costPrice',
						width :100,
					align : 'center'
				},{
					name : 'insuranceAmount',
						width :100,
					index : 'insuranceAmount',formatter:formatAmount,
					align : 'center'
				},{
					name : 'insuranceType',
					index : 'insuranceType',
					align : 'center',
					hidden : true
				},{
					name : 'insuranceTypeStr',
					index : 'insuranceTypeStr',
					align : 'center'
				},{
					name : 'productTypes',
					index : 'productTypes',
					align : 'center',
					hidden : true
				},{
					name : 'productStr',
					index : 'productStr',
					align : 'center'
				},{
					name : 'insStatus',
					index : 'insStatus',
					width :100,
					align : 'center'
				}, {
					name : 'defaultProductStr',
					index : 'defaultProductStr',
					width :100,
					align : 'center'
				}, {
					name : 'updateDate',
					index : 'updateDate',
					width :180,
					align : 'center'
				}, {
					name : 'operate',
					index : 'operate',
					width :400,
					align : 'center'
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
			    sortname: 'updateDate',  //排序字段名
		        sortorder: "desc",    //排序方式：倒序
				caption : '保险产品列表',
				jsonReader : {
				root : "results",               // json中代表实际模型数据的入口  
				page : "pagination.page",       // json中代表当前页码的数据   
				records : "pagination.records", // json中代表数据行总数的数据   
				total:'pagination.total',       // json中代表页码总数的数据 
				repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。   
			    },
				onPaging : function(pgButton) {
					$("#insuranceInfoList").jqGrid('setGridParam', {
						postData : getInsuranceInfoParams ()
					});
				},
				postData : getInsuranceInfoParams (),
				gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#insuranceInfoList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                    	var rowData = $('#insuranceInfoList').jqGrid('getRowData',id);
                    	var insuranceType = rowData.insuranceType;
						var insStatus = rowData.insStatus;
                        var isdefault = rowData.defaultProductStr;
                        //TASK#36006
                    	var productTypes = rowData.productTypes;
                         if(insStatus=='有效')
                        {
							operateClick= '<a href="javascript:;" style="color:blue" onclick="operateLog('+id+')" >日志</a> <a href="javascript:;" style="color:blue" onclick="update('+id+')" >修改</a> <a href="#" style="color:blue" onclick="deleteInsurance('+id+')" >设为无效</a> ';
							if(isdefault=='默认'){
								operateClick+='<a href="javascript:;" style="color:blue" onclick="updateInsuranceNoDefaultRule('+"'"+id+"' ,'"+ insuranceType+"' ,'"+ productTypes +"'"+')" >不默认</a>';
							}else{
								operateClick+='<a href="javascript:;" style="color:blue" onclick="updateInsuranceDefaultRule('+"'"+id+"' ,'"+ insuranceType+"' ,'"+ productTypes +"'"+')" >默认</a>';
							} 
							operateClick+=' <a href="javascript:;" onclick="saleControle('+id+')" style="color:blue">销售调控</a>';
						}
						else
						{	
							operateClick= '<a href="javascript:;" style="color:blue" onclick="operateLog('+id+')" >日志</a> <a href="javascript:;" style="color:blue" onclick="update('+id+')" >修改</a> <a href="#" style="color:blue" onclick="effectInsurance('+id+')" >设为有效</a> ';
							if(isdefault=='默认'){
								operateClick+='<a href="javascript:;" style="color:blue" onclick="updateInsuranceNoDefaultRule('+"'"+id+"' ,'"+ insuranceType+"' ,'"+ productTypes +"'"+')" >不默认</a>';
							}else{
								operateClick+='<a href="javascript:;" style="color:blue" onclick="updateInsuranceDefaultRule('+"'"+id+"' ,'"+ insuranceType+"' ,'"+ productTypes +"'"+')" >默认</a>';
							} 
							operateClick+=' <a href="javascript:;" onclick="saleControle('+id+')" style="color:blue">销售调控</a>';
						}
                        jQuery("#insuranceInfoList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
		} 
		
		//查看操作日志
		function operateLog(id) {
		   	window.open("${request.contextPath}/toOpLogListPage/"+id+"/INSURANCE_PRO");
		}
		
		//修改
		function update(id) {
		   	window.open("${request.contextPath}/insurance/queryInsuranceInfoDetail/"+id);
		}
		 
		function qianfenwei(num) {
			return (num.toFixed(0) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
		}

		//千分位显示金额
		function formatAmount(cellvalue, options, rowObject) { 
			var insuranceAmount = rowObject.insuranceAmount;
        	if(insuranceAmount!=null&&insuranceAmount!=''&&!isNaN(insuranceAmount)){ 
        		insuranceAmount =  qianfenwei(insuranceAmount);
        	}else{
				return '';
			}      	 
		    return  insuranceAmount;       
    	}
		
		  //设置为有效
		function effectInsurance(id) {
		   	$.ajax({
				url : 'effectInsurance/'+id,
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				data : JSON.stringify({
					id : id
				}),
				success: function(data){
					if(data.status == 'VALID'){
						alert("保险产品设置有效成功");
						query();
					}
	   			}
		    });
		 }		
		 
		//删除
		function deleteInsurance(id) {
		   	$.ajax({
				url : 'deleteInsurance/'+id,
				type:'post',
		        dataType : "json",
				contentType : "application/json;",
				data : JSON.stringify({
					id : id
				}),
				success: function(data){
					if(data.status == 'INVALID'){
						alert("保险产品设置无效成功");
						query();
					}
	   			}
		    });
		 }		
		 
		//根据supp查询保险产品
		function getInsurance() {
			var str="";
			var suppId = $("#suppName").val();
		    $.ajax({
				url : 'getInsuranceBySupp',
				type:'post',
				//contentType : "application/json",
		        data:{'suppId':suppId},
		        dataType : "json",
				success: function(data){
					$("#insuranceName option").remove();
					jQuery.each(data, function(i,item){    
						str+="<option value='"+item.id+"'>"+item.insuranceClass.name+"</option>"; 
			        }); 
			        $("#insuranceName").append('<option value="">全部</option>');
					$("#insuranceName").append(str);
				}	
		    });
		 }
		 
		 //修改默认产品
		function updateInsuranceDefaultRule(id,insuranceType,productTypes) {
		
			var gnl=confirm("确定改为默认产品？"); 
			if(gnl==true){
			   	$.ajax({
					url : 'updateInsuranceDefaultRule/'+id+'/'+insuranceType+'/'+productTypes,
					type:'post',
			        dataType : "json",
					contentType : "application/json;",
					data : JSON.stringify({
						id : id,
						insuranceType : insuranceType
					}),
					success: function(data){
						alert(data.message);
						query();
		   			}
			    });
			}
		 }	
		 
		  //修改产品为不默认
		function updateInsuranceNoDefaultRule(id,insuranceType,productTypes) {
		
			var gnl=confirm("确定改为不默认产品？"); 
			if(gnl==true){
			   	$.ajax({
					url : 'updateInsuranceNoDefaultRule/'+id+'/'+insuranceType+'/'+productTypes,
					type:'post',
			        dataType : "json",
					contentType : "application/json;",
					data : JSON.stringify({
						id : id,
						insuranceType : insuranceType
					}),
					success: function(data){
						alert(data.message);
						query();
		   			}
			    });
			}
		 }	
	
  </script>
    
  </head>
  <body>
  
	<div class="content content1">
	  <div class="breadnav"><span>首页</span> > 保险产品列表</div>
	  <form id="myForm" autocomplete="off" >
	  <div class="infor1">
		 <div class="product message">
			<div class="main">
				<div class="part">
					<span>供应商：</span>
					<select name="suppName" id="suppName" onblur="getInsurance()">
					<option value="">全部</option>
						<#list supps as supp>
							<option value="${(supp.id)!''}">${(supp.name)!''}</option>
						</#list>
					</select>
					<span style="margin-left:10px;">适用产品类型：</span>
					<select name="productType" id="productType">
						<option value="all">全部</option>
						<#list productEnum as val>
							<option value="${val}">${val.cnName}</option>
						</#list>
					</select>
					<span>产品编码：</span><input type="text" name="insuranceCode" id="insuranceCode">
					<span>险种名称：</span><select name="insuranceName" id="insuranceName"></select>
				</div>
				<div class="part">
					<span style="margin-left:10px;">保险类型：</span>
						<select name="insuranceType" id="insuranceType">
							<option value="">全部</option>
							<#list insuranceTypeEnum as val>
					        	<option value="${val}">${val.cnName}</option>
					        </#list> 
				        </select>
					<span>产品状态：</span>
					<select name="status" id="status">
						<#list statusEnum as val>
							<option value="${val}">${val.cnName}</option>
						</#list>
					</select>
					<span style="margin-left:10px;">是否默认：</span>
					<select name="defaultRule" id="defaultRule">
						<option value="">全部</option>
						 <option value="DEFAULT">是</option>
						 <option value="NOT_DEFAULT">否</option>
					</select>
				    <span>修改时间：</span>
					<input type="text" id="startUpdateTime"  name="startUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/> - 
			        <input type="text" id="endUpdateTime"  name="endUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" 
						class="Wdate" readonly="readonly"/>
					
				</div>
			</div>
		</div>
	</div>
	  
  	<div class="click">
  		<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
  		<a href="javascript:;"><div class="button" onclick="addInsurance()">新增</div></a> 
	    <a href="javascript:;"><div class="button" onclick="reset()">清空</div></a>
	</div>
		
	</form>
	
 	<div class="content1" style="margin-top:50px;">
		<table id="insuranceInfoList"></table>
        <div id="pager"></div>
    </div>
	
    </div>
     <br>
     <br>
	 
</body>
</html>
