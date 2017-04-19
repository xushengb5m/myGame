<!DOCTYPE html>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/css/icon.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/css/demo.css">
	
	<script src="${request.contextPath}/js/easyui/jquery.min.js"></script>
	<script src="${request.contextPath}/js/easyui/jquery.easyui.min.js"></script>
    
    <script type="text/javascript">
		function toSave(){
			$.ajax({
    			url : "${request.contextPath}/system/updateRole/"+$("#id").val(),
    			data:{
    				"role":$("#role").val(),
    				"remark":$("#remark").val()
    			},
    			type : "POST",
    			success : function(data) {
    				alert(data.errCode);
    			}
    		});
		}
		
  </script>
    
  </head>
  <body>
	<div class="content content1">
	 	 <div class="easyui-panel" title="角色信息" style="width:700px;height:400px;padding:10px;">
			<div style="margin-bottom:20px">
				<div>角色:</div>
				<input id="id" name="id" type="hidden" value="${role.id}">
				<input id="role" name="role" class="easyui-textbox" value="${role.role}" style="width:50%;height:32px">
			</div>
			<div style="margin-bottom:20px">
				<div>描述:</div>
				<input id="remark" name="remark" class="easyui-textbox" value="${role.remark}" style="width:50%;height:32px">
			</div>
			
			<div style="margin-bottom:20px">
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width:90px;height:30px" onclick="toSave()">保存</a>
			</div>
	     </div>
	     
	</div>
</body>
</html>
