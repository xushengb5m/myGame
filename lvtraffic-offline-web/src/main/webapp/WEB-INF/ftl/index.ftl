<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>XX管理系统</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link rel="stylesheet" href="${request.contextPath}/css/ui-common.css">
<link rel="stylesheet" href="${request.contextPath}/css/ui-components.css">
<link rel="stylesheet" href="${request.contextPath}/css/ui-panel.css">
<link rel="stylesheet" href="${request.contextPath}/css/dialog.css" type="text/css"/>
<script type="text/javascript" src="${request.contextPath}/js/resources/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jquery-ui.js"></script>

<style>
	.icon-tag_2 {
	    background-position: right -79px;
	    background: url(../../../images/tree_folder.gif) no-repeat;
	}
	.icon-tag_1 {
	    background-position: right -79px;
	    background: url(../../../images/tree_file.gif) no-repeat;
	}
</style>
</head>

<script type="text/javascript">
//重新登录系统
function registerLogin(){
 top.location = "${request.contextPath}/userLogout";
}
//重新登录系统
function exitLogin(){
if(confirm('确定要退出系统？')){
window.close();
window.parent.close();
top.location = "${request.contextPath}/userLogout";
  }
}
</script>
<body>
<!-- 顶部导航\\ -->
<div class="topbar">
	<a class="logo" href="/panel/"><h1>驴妈妈机票业务系统<small></small></h1></a>
	<p>操作员：<span>${(users.userName)!""} </span> [<a id="reLogin" class="B" href="javascript:void();" onclick="registerLogin()";>重新登陆</a>]　[
	<a href="#" class="B" target="_self" onclick="exitLogin()">退出系统</a>]</p>
</div>
<!-- //顶部导航 -->

<!-- 边栏\\ -->
<div id="panel_aside" class="panel_aside">
	<span id="oper_aside" class="icon-arrow-left"></span>
    <span id="oper_set" class="icon-set"></span>
	<div class="aside_box">
		<#if Application.cpsx_menu_top??>
			<#list Application.cpsx_menu_top as topMenu>
				<ul class="ul_oper_list">
	            	<li class="oper_item"><a target="iframeMain" href="${request.contextPath}/system/toResourceList"><span class="icon-tag_1"></span>${topMenu.resourceName}</a></li>
	            </ul>
				<ul id="aside_list" class="aside_list ul_oper_list">
				<#if Application.cpsx_menu??>
					<#list Application.cpsx_menu?keys as testKey>  
							<li class="oper_item"><a target="iframeMain" href=""><span class="icon-tag_1"></span>${testKey}...${topMenu.id}</a></li>
					</#list>
				</#if>
				</ul>
			</#list>
		</#if>
		
        <li class="oper_item"><a target="iframeMain" ><span class="icon-tag_2"></span>系统管理</a>
            <ul class="ul_oper_list">
            	<li class="oper_item"><a target="iframeMain" href="${request.contextPath}/system/toResourceList"><span class="icon-tag_1"></span>资源管理</a></li>
            	<li class="oper_item"><a target="iframeMain" href="${request.contextPath}/system/toSysUserList"><span class="icon-tag_1"></span>用户管理</a></li>
            	<li class="oper_item"><a target="iframeMain" href="${request.contextPath}/system/toRoleList"><span class="icon-tag_1"></span>角色管理</a></li>
            	<li class="oper_item"><a target="iframeMain" href="${request.contextPath}/system/toAccessList"><span class="icon-tag_1"></span>权限管理</a></li>
            </ul>
        </li>
		</ul>
	</div>
</div>
<!-- //边栏 -->
<div id="panel_control" class="panel_control"></div>
<!-- 工作区\\ -->
<div id="panel_main" class="panel_main">
	<iframe id="iframeMain" name="iframeMain" src="" frameborder="0" style=" height:100%; background:#fff"></iframe>
	<div class="scoll-mask"></div>
</div>
<!-- //工作区 -->


<!-- 底部\\ -->
<div class="footer"></div><!-- //底部 -->
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
<script src="${request.contextPath}/js/panel-custom.js"></script>
<script>
</script>

</body>
</html>