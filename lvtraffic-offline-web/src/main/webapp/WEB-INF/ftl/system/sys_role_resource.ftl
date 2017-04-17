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
		
		function initTree() {
			$.ajax({
    			url : "${request.contextPath}/system/loadResourceData",
    			type : "POST",
    			success : function(data) {
    				$("#menuTree").tree({
    					data : data,
    					animate:true,
    					lines:true,
    					checkbox:true
    				});
    				initRoleResource();
    			}
    		});
		}
		
		function initRoleResource(){
			$.ajax({
    			url : "${request.contextPath}/system/toRoleResource/"+$("#id").val(),
    			dataType:"json",
    			type : "GET",
    			success : function(data) {
    				for(var i=0;i<data.length;i++){
    					var node = $("#menuTree").tree("find",data[i]);
    					console.info(node.ismenu);
    					if(node.ismenu=="n"){
    						$("#menuTree").tree("check",node.target);
    					}
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
        function expandTo(){
            $('#menuTree').tree('expandTo', node.target).tree('select', node.target);
        }
			
		function toEditDialog(){
	            if (!node){
	                alert("请选择一个节点!");
	            }
	            var s = node.text;
                if (node.attributes){
                    s += ","+node.attributes.p1+","+node.attributes.p2;
                }
                alert(s);
	    }
		
		function toHasChosen(){
			var allNodes = $('#menuTree').tree('getRoots');
			for(var i=0;i<allNodes.length;i++){
				console.info(allNodes[i].children);
				console.info(allNodes[i].children.length);
				console.info(allNodes[i].checkState);
			}
			
			
		}
		
  </script>
    
  </head>
  <body>
	<div class="content content1">
	 	 <div class="easyui-panel" title="角色信息" style="width:700px;height:200px;padding:10px;">
			<div style="margin-bottom:20px">
				<div>角色:</div>
				<input id="id" name="id" type="hidden" value="${role.id}">
				<input id="role" name="role" class="easyui-textbox" value="${role.role}" style="width:50%;height:32px">
			</div>
			<div style="margin-bottom:20px">
				<div>描述:</div>
				<input id="remark" name="remark" class="easyui-textbox" value="${role.remark}" style="width:50%;height:32px">
			</div>
			
			<input id="rData" type="hidden" value="${jsonData}">
	     </div>
	
		 <div style="margin:20px 0;">
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="collapseAll()">全部收起</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="expandAll()">全部展开</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="toEditDialog()">编辑</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="toHasChosen()">已选择的</a>
	        
	        <div class="easyui-panel" style="padding:5px">
       		<ul id="menuTree" class="easyui-tree"></ul>
   			</div>
	    </div>
	</div>
</body>
</html>
