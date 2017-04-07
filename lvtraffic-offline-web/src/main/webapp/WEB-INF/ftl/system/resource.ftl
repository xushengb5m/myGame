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
    				console.info(data);
    				$("#menuTree").tree({
    					data : data,
    					animate:true,
    					lines:true
    				});
    			} 
    		})
		}
			
		
  </script>
    
  </head>
  <body>
	<div class="content content1">
		<div class="easyui-panel" style="padding:5px">
       		<ul id="menuTree" class="easyui-tree"></ul>
   		</div>
	</div>
</body>
</html>
