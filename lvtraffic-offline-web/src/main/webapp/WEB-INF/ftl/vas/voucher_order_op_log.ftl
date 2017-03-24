<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link rel="stylesheet" href="${request.contextPath}/css/trip-list.css">
<link rel="stylesheet" type="text/css" href="${request.contextPath}/css/area_tankuang.css">
<link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
<link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
<script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
<script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<scripts >

<script type="text/javascript">
$(function(){
    initGrid();
});


//查询列表信息
function query() {
    $("#vasExceptionOrderList").jqGrid('setGridParam', {
        url : "${request.contextPath}/vasOrder/queryVasExpOrderList",
        datatype : "json",
        mtype : "POST",
        postData : getVasExceptionOrderQueryParams()
    }).trigger("reloadGrid");

}

function getVasExceptionOrderQueryParams() {
    var voucherOrderNo=$("#voucherOrderNo").val();
    var purchaseSubOrderNo = $("#buyOrderNo").val();
    var departureStartTime = $("#startUpdateTime").val();
    var departureEndTime =$("#endUpdateTime").val();

    var exceptionType =$("#exceptionType").val();
    var supp = $("#supp").val();
    var creatStartTime =  $("#createStartTime").val();
    var createEndTime =  $("#createEndTime").val();

    return {
        'orderNo' : voucherOrderNo,
        'purchaseSubOrderNo' : purchaseSubOrderNo,
        'departureStartTime' : departureStartTime,
        'departureEndTime' : departureEndTime,

        'exceptionType' : exceptionType,
        'suppCode' : supp,
        'creatStartTime' : creatStartTime,
        'createEndTime' : createEndTime
    }
}

function initGrid() {
    $("#vasExceptionOrderList").jqGrid({
        url : "${request.contextPath}/vasOrder/queryVasExpOrderList",
        datatype : "json",
        mtype : "POST",
        colNames : ['采购订单ID','核销码', '增值服务订单号', '采购订单号', '供应商','产品名称','乘客姓名','异常说明','业务异常信息','异常类型',  '创建时间'],
        colModel : [ {
            name : 'purchaseSubOrderId',
            index : 'purchaseSubOrderId',
            align : 'center',
            width :200,
            sortable:false,
            hidden:true
         },{
            name : 'voucherCode',
            index : 'voucherCode',
            align : 'center',
            width :200,
            sortable:false
        }, {
            name : 'voucherOrderNo',
            index : 'voucherOrderNo',
            align : 'center',
            sortable:false
        }, {
            name : 'purchaseSubOrderNo',formatter:formatLink,
            index : 'purchaseSubOrderNo',
            align : 'center',
            sortable:false
        }, {
            name : 'suppName',
            index : 'suppName',
            align : 'center',
            sortable:false
        }, {
            name : 'productName',
            index : 'productName',
            align : 'center',
            sortable:false
        },{
            name : 'passengerName',
            index : 'passengerName',
            align : 'center',
            sortable:false
        },{
            name : 'errDesc',
            index : 'errDesc',
            align : 'center',
            sortable:false
        }
        ,{
            name : 'suppRetunInfo',
            index : 'suppRetunInfo',
            align : 'center',
            sortable:false
        },{
            name : 'exceptionType',
            index : 'exceptionType',
            align : 'center',
            sortable:false
        },{
            name : 'creatTime',
            index : 'creatTime',
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
        caption : '增值服务异常订单日志',
        jsonReader : {
            root : "results",               // json中代表实际模型数据的入口
            page : "pagination.page",       // json中代表当前页码的数据
            records : "pagination.records", // json中代表数据行总数的数据
            total:'pagination.total',       // json中代表页码总数的数据
            repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
        },
        onPaging : function(pgButton) {
            $("#vasExceptionOrderList").jqGrid('setGridParam', {
                postData : getVasExceptionOrderQueryParams()
            });
        },
        postData : getVasExceptionOrderQueryParams(),
        gridComplete:function(){

        }
    });
}

	function formatLink(cellvalue, options, rowObject) {
	        //主订单Id到后台自动查询
	        var orderMainId = -1;
	        var   url = "http://super.lvmama.com/offline-web/order/queryOrderDetail/"+orderMainId+"/"+rowObject.purchaseSubOrderId+"/NULL";
	        return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + cellvalue + "</a>";
	    }
</script>
</head>




<body>
<div class="content content1">
    <div class="breadnav"><span>增值服务</span>>异常订单列表</div>
    <form id="myForm" autocomplete="off" >
        <div class="infor1">
            <div class="product message">
                <div class="main">

                    <div class="part">

                        <span style="width: 11%">增值服务订单号：</span> <input type="text" id="voucherOrderNo" name="voucherOrderNo"/>
                        <span style="width: 11%">采购订单号：</span><input type="text" id="buyOrderNo" name="buyOrderNo"/>
                        <span style="width: 11%">出发日期：</span>
                        <input type="text" id="startUpdateTime"  name="startUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:100px;"
                               class="Wdate" readonly="readonly"/> -
                        <input type="text" id="endUpdateTime"  name="endUpdateTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:100px;"
                               class="Wdate" readonly="readonly"/>
                    </div>

                    <div class="part">

                        <span style="width: 11%">异常类型：</span><select id="exceptionType" name="exceptionType">
                        <option value="">全部</option>
                        <#list exceptionType as type>

                            <#if "VAS_VOUCHER_DISABLE" == "${type!''}">
                                <option value="${type!''}">${(type.cnName)!''}</option>
                            </#if>
                            <#if "VAS_VOUCHCER_REBIND" == "${type!''}">
                                <option value="${type!''}">${(type.cnName)!''}</option>
                            </#if>
                            <#if "VAS_VOUCHER_ACTIVE" == "${type!''}">
                                <option value="${type!''}">${(type.cnName)!''}</option>
                            </#if>

                        </#list>
                    </select>

                        <span style="width: 11%">供应商：</span>
                        <select id="supp" name="supp" >
                            <option value="">全部</option>
                            <#list suppList as supp><option value="${(supp.code)!''}">${(supp.name)!''}</option></#list>
                        </select>

                        <span style="width: 11%">创建日期：</span>
                        <input type="text" id="createStartTime"  name="createStartTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:100px;"
                               class="Wdate" readonly="readonly"/> -
                        <input type="text" id="createEndTime"  name="createEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:100px;"
                               class="Wdate" readonly="readonly"/>

                    </div>

                    <div class="part">

                        <div class="click">
                            <div id="query"class="button" onclick="query()">查询</div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </form>

    <div class="content1" style="margin-top:50px;">
        <table id="vasExceptionOrderList"></table>
        <div id="pager"></div>
    </div>

</div>
</body>
</html>

