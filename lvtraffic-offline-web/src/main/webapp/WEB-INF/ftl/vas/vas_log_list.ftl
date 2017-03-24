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

    <style>
        span{
            width: 15%;
        }
    </style>

</head>
<body>
<div class="content content1">
    <div class="breadnav"><span>增值服务</span>>操作日志</div>
    <form id="myForm" >
        <div class="infor1">
            <div class="product message">
                <div class="main">

                    <div>
                        <input type="hidden" name="sourceId" id="sourceId" value="${sourceId}"/>
                        <input type="hidden" name="operSouce" id="operSouce" value="${openSource}"/>
                        <input type="hidden" name="orderNo" id="orderNo" value="${orderNo}"/>
                    </div>

                </div>
            </div>
        </div>

    </form>

    <div class="content1" style="margin-top:50px;">
        <table id="vasLogList"></table>
        <div id="pager"></div>
    </div>

</div>
</body>
<script type="text/javascript">

    $(function (){
        initGrid();
    });

       //查询列表信息
    function query() {
        alert(123);
        $("#vasLogList").jqGrid('setGridParam', {
            url : "${request.contextPath}/vasLog/queryVasLogInfoList",
            datatype : "json",
            mtype : "POST",
            postData : getVasLogQueryParams()
        }).trigger("reloadGrid");
    }


    function getVasLogQueryParams() {

        return  {
            'sourceId':$("#sourceId").val(),
            'operSouce':$("#operSouce").val(),
            'orderNo':$("#orderNo").val()
            }
    }

    function initGrid() {
        $("#vasLogList").jqGrid({
            url : "${request.contextPath}/vasLog/queryVasLogInfoList",
            datatype : "json",
            mtype : "POST",
            colNames : ['操作时间','操作类型', '描述', '操作人'],
            colModel : [ {
                name : 'operTime_Str',
                index : 'operTime_Str',
                align : 'center',
                width :200,
                sortable:false
            }, {
                name : 'operType_Str',
                index : 'operType_Str',
                align : 'center',
                sortable:false
            }, {
                name : 'operDesc',
                index : 'operDesc',
                align : 'center',
                sortable:false
            }, {
                name : 'operAccount',
                index : 'operAccount',
                align : 'center',
                sortable:false
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
            sortname: 'id',  //排序字段名
            sortorder: "desc",    //排序方式：倒序
            caption : '增值服务操作日志列表',
            jsonReader : {
                root : "results",               // json中代表实际模型数据的入口
                page : "pagination.page",       // json中代表当前页码的数据
                records : "pagination.records", // json中代表数据行总数的数据
                total:'pagination.total',       // json中代表页码总数的数据
                repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
            },
            onPaging : function(pgButton) {
                $("#vasLogList").jqGrid('setGridParam', {
                    postData : getVasLogQueryParams()
                });
            },
            postData : getVasLogQueryParams(),
            gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                /*var ids=jQuery("#vasLogList").jqGrid('getDataIDs');
                for(var i=0; i<ids.length; i++){
                    var id=ids[i];
                    var rowData = $('#vasLogList').jqGrid('getRowData',id);
                    var operateClick = '<a href="javascript:;" style="color:blue" onclick="edit('+id+')" >编辑</a> ';
                    jQuery("#vasProductList").jqGrid('setRowData', id , {operate:operateClick});
                }*/
            }
        });
    }

</script>

</html>