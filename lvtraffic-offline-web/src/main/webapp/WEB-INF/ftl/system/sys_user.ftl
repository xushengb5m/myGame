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
		});
	    
		 // 对Date的扩展，将 Date 转化为指定格式的String
		 // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
		 // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
		 // 例子： 
		 // (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
		 // (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
		 Date.prototype.Format = function (fmt) { //author: meizz 
		     var o = {
		         "M+": this.getMonth() + 1, //月份 
		         "d+": this.getDate(), //日 
		         "h+": this.getHours(), //小时 
		         "m+": this.getMinutes(), //分 
		         "s+": this.getSeconds(), //秒 
		         "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
		         "S": this.getMilliseconds() //毫秒 
		     };
		     if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		     for (var k in o)
		     if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		     return fmt;
		 }
			
		//清空查询信息   
		function reset() { 
			document.getElementById("myForm").reset()
		}    
		
		function addSysUser() {  
				window.open("${request.contextPath}/system/toAddInsurancePage"); 
		}   

		//打开销售调控
		function saleControle(insuranceId) {  
			window.open("${request.contextPath}/SaleControl/toPage/INSURANCE/"+insuranceId); 
		} 		
		
		//查询列表信息   
		function query() { 
       		
			$("#sysUserList").jqGrid('setGridParam', {
				url : "${request.contextPath}/system/loadSysUserData",
				datatype : "json",
				mtype : "POST",
				postData : getQueryParams()
			}).trigger("reloadGrid");
		}
		
		function getQueryParams() {
			return {
				'userName' : $('#userName').val(),
				'email' : $('#email').val(),
				'status' : $("#status").val()
			}
		}
		
		function initGrid() {
			$("#sysUserList").jqGrid({
				url : "${request.contextPath}/system/loadSysUserData",
				datatype : "json",
				mtype : "POST",
				colNames : ['用户名','邮箱','真实姓名','用户类型','账户类型','创建时间','操作'],
				colModel : [ {
					name : 'userName',
					index : 'userName',
					align : 'center',
					width :150
				}, {
					name : 'email',
						width :100,
					index : 'email',
					align : 'center'
				}, {
					name : 'realName',
					width :100,
					index : 'realName',
					align : 'center'
				}, {
					name : 'userType',
					width :100,
					index : 'userType',
					align : 'center'
				}, {
					name : 'accountType',
					width :100,
					index : 'accountType',
					align : 'center'
				},{
					name : 'createTime',
					width :100,
					index : 'createTime',
					align : 'center'
				},{
					name : 'operate',
					width :100,
					index : 'operate',
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
					$("#sysUserList").jqGrid('setGridParam', {
						postData : getQueryParams ()
					});
				},
				postData : getQueryParams (),
				gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#sysUserList").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                    	var id=ids[i];
                    	var rowData = $('#sysUserList').jqGrid('getRowData',id);
						var insStatus = rowData.status;
						console.info(insStatus)
                         if(insStatus=='有效')
                        {
							operateClick= '<a href="javascript:;" style="color:blue" onclick="update('+id+')" >修改</a> <a href="#" style="color:blue" onclick="deleteInsurance('+id+')" >设为无效</a> ';
						}
						else
						{	
							operateClick= '<a href="javascript:;" style="color:blue" onclick="update('+id+')" >修改</a> <a href="#" style="color:blue" onclick="effectInsurance('+id+')" >设为有效</a> ';
						}
                        jQuery("#sysUserList").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
			});
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
					<span>用户名：</span><input type="text" name="userName" id="userName">
					<span>邮箱：</span><input name="email" id="email">
					<span>是否有效：</span>
					<select name="status" id="status">
							<option value="1" selected="selected">有效</option>
							<option value="0">无效</option>
							<option value="">全部</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	  
  	<div class="click">
  		<a href="javascript:;"><div class="button" onclick="query()">查询</div></a> 
  		<a href="javascript:;"><div class="button" onclick="addSysUser()">新增</div></a> 
	    <a href="javascript:;"><div class="button" onclick="reset()">清空</div></a>
	</div>
		
	</form>
	
 	<div class="content1" style="margin-top:50px;">
		<table id="sysUserList"></table>
        <div id="pager"></div>
    </div>
	
    </div>
     <br>
     <br>
	 
</body>
</html>
