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

    <script type="text/javascript">
            $(function(){
                initGrid();
            });

            //查询列表信息
            function query() {
                $("#smsLogList").jqGrid('setGridParam', {
                    url : "${request.contextPath}/ccs/sms/querySmsLogList",
                    datatype : "json",
                    mtype : "POST",
                    postData : getSmsLogQueryParams()
                }).trigger("reloadGrid");

            }
            
            function re_send(obj){
                var uuid= $(obj).find("input[name='uuid']").val();
	            var mobile= $(obj).find("input[name='mobile']").val();
	            var smsContent= $(obj).find("input[name='smsContent']").val();
	            var sendTime= $(obj).find("input[name='sendTime']").val();
	           // alert("uuid:"+uuid+",mobile:"+mobile+",smsContent:"+smsContent+",sendTime:"+sendTime);
                //return ;
	            $.ajax({
	                url : '${request.contextPath}/ccs/sms/reSendSms',
	                type : 'POST',
	                dataType:'json',
	                data : {"uuid":uuid,"mobile":mobile,"smsContent":smsContent,"sendTimeStr":sendTime},
	                success : function(data1){
	                    if(data1.status == 'SUCCESS'){
	                        alert("发送成功！");
	                        query();
	                    }else{
	                    	
	                        alert("发送失败");
	                    }
	                }
	            });
       		 }


            function getSmsLogQueryParams() {

                var mobile = $("#mobile").val();
                var startDate = $("#startDate").val();
                var endDate =$("#endDate").val();
                var result = $("#result").val();
           	    var smsSource = $("#smsSource").val();

                var a= {
                    'mobile' : mobile,
                    'startDate' : startDate,
                    'endDate' : endDate,
                    'result':result,
                    'smsSource':smsSource
                }
                return a;
            }

            function initGrid() {
                $("#smsLogList").jqGrid({
                    url : "${request.contextPath}/ccs/sms/querySmsLogList",
                    datatype : "json",
                    mtype : "POST",
                    colNames : ['ID','手机号','短信内容', '发送时间', '渠道', '是否成功','发送次数','创建时间','操作'],
                    colModel : [{
                        name : 'uuid',
                        index : 'uuid',
                        align : 'center',
                        width :200,
                        sortable:false
                    }, {
                        name : 'mobile',
                        index : 'mobile',
                        align : 'center',
                        width :200,
                        sortable:false
                    },{
                        name : 'smsContent',
                        index : 'smsContent',
                        align : 'center',
                        width :200,
                        sortable:false
                    },{
                        name : 'sendTimeStr',
                        index : 'sendTimeStr',
                        align : 'center',
                        width :200,
                        sortable:false
                    }, {
                        name : 'smsSourceStr',
                        index : 'smsSourceStr',
                        align : 'center',
                        sortable:false
                    }, {
                        name : 'resultStr',
                        index : 'resultStr',
                        align : 'center',
                        sortable:false
                    }, {
                        name : 'sendCount',
                        index : 'sendCount',
                        align : 'center',
                        sortable:false
                    },{
                        name : 'createTimeStr',
                        index : 'createTimeStr',
                        align : 'center',
                        sortable:false
                    },{
	                    name : 'operate',
	                    index : 'operate',
	                    align : 'center',
	                    sortable:false
	                  }],
                    rowNum: 10,            //每页显示记录数
                    autowidth: true,      //自动匹配宽度
                    shrinkToFit:true,
                    pager: '#pager',      //表格数据关联的分页条，html元素
                    rowList:[10,20,50,500],   //分页选项，可以下拉选择每页显示记录数
                    viewrecords: true,    //显示总记录数
                    height:'auto',//高度，表格高度。可为数值、百分比或'auto'
                    // autoheight: true,     //设置高度
                    gridview:true,        //加速显示
                    viewrecords: true,    //显示总记录数
                    multiselect: false,
                    sortable:true,        //可以排序
                    sortname: 'creatTime',  //排序字段名
                    sortorder: "desc",    //排序方式：倒序
                    caption : '短信列表',
                    jsonReader : {
                        root : "results",               // json中代表实际模型数据的入口
                        page : "pagination.page",       // json中代表当前页码的数据
                        records : "pagination.records", // json中代表数据行总数的数据
                        total:'pagination.total',       // json中代表页码总数的数据
                        repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
                    },
                    onPaging : function(pgButton) {
                        $("#smsLogList").jqGrid('setGridParam', {
                            postData : getSmsLogQueryParams()
                        });
                    },
                    postData : getSmsLogQueryParams(),
                    gridComplete:function(){  //在此事件中循环为每一行添加日志
                        var ids=jQuery("#smsLogList").jqGrid('getDataIDs');
                        for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var rowData = $('#smsLogList').jqGrid('getRowData',id);
                           var mobile = rowData.mobile;
                           var uuid = rowData.uuid;
                           var smsContent = rowData.smsContent;
                           var sendTime = rowData.sendTimeStr;
                          // sendTime = sendTime.substring(0,10);
                           console.log("id:"+id+",mobile:"+mobile+",uuid:"+uuid);
                           var operateClick = '';
                           operateClick='<a href="javascript:void(0);" style="color:blue" onclick=re_send(this) >重发' +
                                        '<input  name="uuid" type="hidden" value="'+uuid+'"/><input  name="mobile" type="hidden" value="'+mobile+'"/>' +
                                '<input  name="smsContent" type="hidden" value="'+smsContent+'"/><input  name="sendTime" type="hidden" value="'+sendTime+'"/>'
                                '</a> <span class="operation"></span>';
                           jQuery("#smsLogList").jqGrid('setRowData', id , {operate:operateClick});

                    	}
                    }
                });
            }
    </script>
</head>




<body>
<div class="content content1">
    <div class="breadnav"><span>公共组件服务</span>>短信列表</div>
    <form id="myForm" autocomplete="off" >
        <div class="infor1" id="conditionDiv">
            <div class="product message">
                <div class="main">
                    <div class="part">
                        <span>手机号：</span><input type="text" id="mobile" name="mobile"/>
                        <span>日期范围：</span><input type="text" id="startDate" name="startDate"  onfocus="var endDate=$dp.$('endDate');WdatePicker({dateFmt:'yyyyMMdd',onpicked:function(){endDate.focus();},maxDate:'#F{$dp.$D(\'endDate\')}'})" style="width:100px;" class="Wdate" />
                        &nbsp; &nbsp;至 &nbsp; &nbsp;
                        <input type="text" id="endDate" name="endDate"  onfocus="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'startDate\')}'})" style="width:100px;" class="Wdate"/>
                       
                        <span>是否成功:</span>
                        <select id="result" name="result" >
                            <option value="">全部</option>
                            <option value="SUCCESS">成功</option>
                            <option value="FAIL">失败</option>
                        </select>
                    <div class="part">
                        <span >渠道:</span>
                        <select id="smsSource" name="smsSource">
                            <option value="">全部</option>
                            <#list smsSource as ss>
                                <!--<option value="${status}">${(status.cnName)!''}</option>-->
                                <#if ss != "DEFAULT">
                                    <option value="${ss}">${(ss.cnName)!''}</option>
                                </#if>
                            </#list>
                        </select>
                    </div>
                    </div>
                    <div class="part">
                        <div class="click">
                            <a href="javascript:;"><div id="query" class="button" onclick="query()">查询</div></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="content1" >
        <table id="smsLogList"></table>
        <div id="pager"></div>
    </div>

</div>
<br>
</br>

</body>
</html>

