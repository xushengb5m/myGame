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
    
	    $(function (){
			initTree();
	    });    
		
		function initTree(nodeId) {
			$.ajax({
    			url : "${request.contextPath}/system/loadResourceData",
    			dataType:"json",
    			type : "GET",
    			success : function(data) {
    				$("#menuTree").tree({
    					data : data,
    					animate:true,
    					lines:true
    				});
    				if(nodeId){
    					expandTo(nodeId);
    				}
    			} 
    		});
		}
		
		function collapseAll(){
            $('#menuTree').tree('collapseAll');
        }
        function expandAll(){
            $('#menuTree').tree('expandAll');
        }
        function expandTo(id){
            var node = $('#menuTree').tree('find',id);
            $('#menuTree').tree('expandTo', node.target).tree('select', node.target);
        }
        
        function toAdd(){
        		clearDialog()
        		$("#addNode").show();
        		$("#editNode").hide();
	            var node = $('#menuTree').tree('getSelected');
	            if (!node){
	                $("#dlg").dialog("open");
	                
	            }
	            if(node.ismenu=='y'){
                	$("#parentId").combobox('select', node.id);
                }
                $("#dlg").dialog("open");
	    }
			
		function toEdit(){
				clearDialog();
				$("#editNode").show();
        		$("#addNode").hide();
	            var node = $('#menuTree').tree('getSelected');
	            if (!node){
	                alert("请选择一个节点!");
	            }
	            $("#resourceId").text(node.id);
	            $("#cName").textbox("setValue", node.resourceName);
	            $("#url").textbox("setValue", node.resourceUrl);
	            $("#engName").textbox("setValue", node.engName);
	            $("#isMenu").combobox("select", node.ismenu);
	            $("#parentId").combobox("select", node.topid);
	           	$("#clsname").textbox("setValue", node.clsname);
	            $("#posorder").textbox("setValue",node.posorder);
	            $("#dlg").dialog("open");
	          
	    }
	    
	    function saveAddNode(){
	    	$.ajax({
    			url : "${request.contextPath}/system/addResource",
    			data:getParams(),
    			type : "POST",
    			success : function(data) {
    					if(data.errCode=="SUCCESS"){
	    					$("#dlg").dialog("close");
	    					initTree($("#parentId").val());
    					}else{
    						alert("保存失败!");
    					}
    					
    			} 
    		});
	    }
	    
	    function getParams(){
	    	return {
	    		"resourceName":$("#cName").val(),
	    		"resourceUrl":$("#url").val(),
	    		"engName":$("#engName").val(),
	    		"ismenu":$("#isMenu").val(),
	    		"topid":Number($("#parentId").val()),
	    		"clsname":$("#clsName").val(),
				"posorder":Number($("#posorder").val())
	    	};
	    
	    }
	    
	    function saveEditNode(){
	    	var nodeId = $("#resourceId").text();
	    	$.ajax({
    			url : "${request.contextPath}/system/editResource/"+nodeId,
    			data:getParams(),
    			type : "POST",
    			success : function(data) {
    					if(data.errCode=="SUCCESS"){
	    					$("#dlg").dialog("close");
	    					initTree(nodeId);
    					}else{
    						alert("保存失败!");
    					}
    			} 
    		});
	    
	    }
	    
	    function cancel(){
	    	clearDialog();
	    	$("#dlg").dialog("close");
	    }
	    
	    function clearDialog(){
	    		$("#resourceId").text("");
	            $("#cName").textbox("setValue","");
	            $("#url").textbox("setValue", "");
	            $("#engName").textbox("setValue", "");
	            $("#isMenu").combobox("select", "");
	            $("#parentId").combobox("select", "");
	           	$("#clsname").textbox("setValue", "");
	            $("#posorder").textbox("setValue","");
	    }
	    
	    function toRemove(){
	    	var node = $('#menuTree').tree('getSelected');
            if (!node){
                alert("请选择一个节点!");
            	return;
            }
	    	$.ajax({
    			url : "${request.contextPath}/system/deleteResource/"+node.id,
    			data:{},
    			type : "POST",
    			success : function(data) {
    					if(data.errCode=="SUCCESS"){
	    					$("#dlg").dialog("close");
	    					initTree();
    					}else{
    						alert("删除失败!");
    					}
    			} 
    		});
	    
	    }
  </script>
    
  </head>
  <body>
	<div class="content content1">
	
		 <div style="margin:20px 0;">
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="collapseAll()">全部收起</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="expandAll()">全部展开</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="toAdd()">新增</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="toEdit()">编辑</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="toRemove()">删除</a>
	    </div>
	
		<div class="easyui-panel" style="padding:5px">
       		<ul id="menuTree" class="easyui-tree"></ul>
   		</div>
   		
   		
   		<div id="dlg" class="easyui-dialog" title="Basic Dialog" data-options="closed:true" style="width:400px;height:500px;padding:10px">
			<div style="margin-bottom:20px">
				<div>中文名称:</div>
				<input id="resourceId" name="resourceId" type="hidden">
				<input id="cName" name="cName" class="easyui-textbox" style="width:100%;height:32px">
			</div>
			<div style="margin-bottom:20px">
				<div>URL:</div>
				<input id="url" name="url" class="easyui-textbox" style="width:100%;height:32px">
			</div>
			<div style="margin-bottom:20px">
				<div>英文名称:</div>
				<input id="engName" name="engName" class="easyui-textbox" style="width:100%;height:32px">
			</div>
			<div style="margin-bottom:20px">
				<div>是否菜单:</div>
				<select id="isMenu" name="isMenu" class="easyui-combobox" style="width:100%;height:32px">
					<option value="y">是</option>
					<option value="n">否</option>
				</select>
			</div>
			<div style="margin-bottom:20px">
				<div>父节点:</div>
				<select id="parentId" name="parentId" class="easyui-combobox" style="width:100%;height:32px">
					<option value="0">根节点</option>
					<#if menus??>
						<#list menus as menu>
							<option value="${menu.id}">${menu.resourceName}</option>
						</#list>
					</#if>
				</select>
			</div>
			<div style="margin-bottom:20px">
				<div>图标(icon):</div>
				<input id="clsName" name="clsName" class="easyui-textbox" style="width:100%;height:32px">
			</div>
			<div style="margin-bottom:20px">
				<div>次序:</div>
				<input id="posorder" name="posorder" class="easyui-numberbox" data-options="min:0,max:999" style="width:100%;height:32px">
			</div>
			
			<div id="sub" align="center">
				<a href="#" id="addNode" onclick="saveAddNode();" class="easyui-linkbutton">保存</a>
				<a href="#" id="editNode" style="display:none" onclick="saveEditNode();"  class="easyui-linkbutton">保存</a>
				<a href="#" onclick="cancel();" class="easyui-linkbutton">关闭</a>
			</div>
		</div>
		
		
		
	</div>
</body>
</html>
