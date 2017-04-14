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
    			dataType:"json",
    			type : "GET",
    			success : function(data) {
    				$("#menuTree").tree({
    					data : data,
    					animate:true,
    					lines:true
    				});
    			} 
    		})
		}
		
		function collapseAll(){
            $('#menuTree').tree('collapseAll');
        }
        function expandAll(){
            $('#menuTree').tree('expandAll');
        }
        function expandTo(){
            var node = $('#tt').tree('find',113);
            $('#menuTree').tree('expandTo', node.target).tree('select', node.target);
        }
			
		function toEditDialog(){
	            var node = $('#menuTree').tree('getSelected');
	            console.info(node);
	            if (!node){
	                alert("请选择一个节点!");
	            }
	            var s = node.text;
                if (node.attributes){
                    s += ","+node.attributes.p1+","+node.attributes.p2;
                }
                alert(s);
	    }
		
  </script>
    
  </head>
  <body>
	<div class="content content1">
	
		 <div style="margin:20px 0;">
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="collapseAll()">全部收起</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="expandAll()">全部展开</a>
	        <a href="#" class="easyui-linkbutton" style="width: 90px;height: 30px" onclick="toEditDialog()">编辑</a>
	    </div>
	
		<div class="easyui-panel" style="padding:5px">
       		<ul id="menuTree" class="easyui-tree"></ul>
   		</div>
	</div>
</body>
</html>
