<!DOCTYPE html>
<html lang="en">
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
    <script type="text/javascript" src="${request.contextPath}/js/jquery.form.js"></script>

    <style>
        .vas_add{

        }
        div.vas_add > span {
            display: inline-block;
            width: 100px;
            text-align:right;
        }
        div.vas_add  input {
            height: 20px;
            width: 250px;
        }
        div.vas_add  select {
            height: 20px;
            width: 250px;
        }
        .no_border{
            border-left:0px;
            border-top: 0px;
            border-right: 0px;
            border-bottom: 0px;
        }
    </style>
</head>
<body>
<div class="content content1">
    <form id="edit_vas_product_form" name="edit_vas_product_form" enctype="multipart/form-data">
        <div class="breadnav"><span>用户管理</span>>编辑用户</div>
        <div class="infor1" id="conditionDiv">
            <div class="order message">
                <div class="main">
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >基本信息</label></div>
                    <div class="vas_add">
                        <span><span style="color: red">*</span>用户邮箱:</span>&nbsp;&nbsp;
                        <input type="text" id="email" name="email"  value="${user.email}"/><br>
                        <span><span style="color: red">*</span>密        码:</span>&nbsp;&nbsp;
                        <input type="text" id="password" type="password" name="password" value="******"/><br>
                        <span><span style="color: red">*</span>用户姓名:</span>&nbsp;&nbsp;
                        <input id ="userName" name="userName" value="${user.userName}"/><br>
                        <span><span style="color: red">*</span>用户角色:</span>&nbsp;&nbsp;
                        <select id ="roleName" name="roleName" value=""/>
                        	<#list roles as val>  
							  	<#if user.roleName==val.role>
									 <option value="${val.role}" selected="true">${val.remark}</option>
							  	<#else>
							  		 <option value="${val.role}" >${val.remark}</option>
							  	</#if>
							</#list>
						</select>
						<br>
                    </div>
					
                    <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label>可选信息</label></div>
                    <div class="vas_add">
                        <span><span style="color: red">*</span>账户类型:</span>&nbsp;&nbsp;
                        <input type="text" id="userType" name="userType"  value=""/><br>
                        <span><span style="color: red">*</span>QQ:</span>&nbsp;&nbsp;
                        <input type="text" id="qq" name="qq" value=""/><br>
                        <span><span style="color: red">*</span>住址:</span>&nbsp;&nbsp;
                        <input id ="address" name="address" value=""/><br>
                        <span><span style="color: red">*</span>手机号码:</span>&nbsp;&nbsp;
                        <input id ="mobTel" name="mobTel" value=""/>
						<br>
                    </div>
                    <input id="userId" name="userId" type="hidden" value="${user.id}">
                    
                    <div style="margin-left: 30%;margin-top: 30px">
                        <input id="bt_save_user" style="width: 90px;height: 30px" type="button" value="保存">
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
<script>
		$(document).ready(function() { 
			$('input[valid]').each(function(){ 
			var $this = $(this); 
			var valid = $this.attr('valid');  
			if(valid=='num'){ 
					$this.blur(function(){ 
					onlyNum($this[0]); 
				}); 
			} else if(valid=='decimal'){ 
					$this.blur(function(){ 
					onlyDecimal($this[0]); 
				}); 
			} 
			}); 
		}); 

		function onlyNum(obj){  
		if(obj.value!=''){
			 var desc = $(obj).attr('desc'); 
			 var reg = /^[1-9]*[1-9][0-9]*$/;
			 if(!reg.test(obj.value)){
				 alert(""+desc+"必须是正整数");
				 obj.value='';
				 obj.focus();
				 return ;
			 }
		 }
		}  
		
		function onlyDecimal(obj){  
		if(obj.value!=''){
			 var desc = $(obj).attr('desc'); 
			 var reg = /^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$/; 
			 if(!reg.test(obj.value)){
				 alert(""+desc+"必须是非负数");
				 obj.value='';
				 obj.focus();
				 return ;
			 }
		 }
		}  

		$("#bt_save_user").on("click",function(){ 
				if($("#email").val() == ""){
					alert("邮箱不能为空!");
					return;
				} 
				if($("#userName").val() == ""){
					alert("用户名不能为空!");
					return;
				} 
				if($("#roleName").val() == ""){
					alert("角色不能为空!");
					return;
				} 
				
		
	            $.ajax({
	                type: "post",
	                url: "${requestContextPath}/system/updateSysUser/"+Number($("#userId").val()),
	                data:getParameters(),
	                success: function (data) {
	                    alert(data.message);
	                },
	                error: function (msg) {
	                    console.info(msg);
	                }
	            });
		});
	
        
        //
        function getParameters(){
           return  {
               'email':$("#email").val(),
               'userName':$("#userName").val(),
               'password':$("#password").val(),
               'roleName':$("#roleName").val(),
               'userType':Number($("#userType").val()),
               'qq':$("#qq").val(),
               'address':$("#address").val(),
               'mobTel':$("#mobTel").val()
           };
        }
	
    
</script>
</html>



