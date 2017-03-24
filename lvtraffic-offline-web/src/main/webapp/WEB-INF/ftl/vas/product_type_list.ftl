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
    <div class="breadnav"><span>增值服务</span>>产品类型</div>
    <form id="myForm" autocomplete="off" >
        <div class="infor1">
            <div class="product message">
                <div class="main">

                    <div class="part">
                        <span style="width:15%;">产品主类型code：</span> <input type="text" id="mainCode" name="mainCode" value="" />
                        <span>产品类型:</span>&nbsp;&nbsp;
                        <select id="mainName" name="mainName" >
                        <option value="">全部</option>
					  	 <#list typeList as type>
							 <option value="${type}">${type}</option>
					  	 </#list> 							  	
                        </select><br>
                        <!--<span style="width:15%;">产品主类型名称：</span> <input type="text" id="mainName" name="mainName" value="" />-->   
                         <span style="width:15%;">产品子类型code：</span> <input type="text" id="subCoce" name="subCoce"  value=""/>
                        <span style="width:15%;">产品子类型名称：</span> <input type="text" id="subName" name="subName"  value=""/>                        
                    </div>

                </div>
            </div>
        </div>

        <div class="click">
            <a href="javascript:;"><div class="button" onclick="query()">查询</div></a>
            <a href="javascript:;"><div class="button" onclick="add()">新增</div></a>
        </div>

    </form>

    <div class="content1" style="margin-top:50px;">
        <table id="vasProductTypeList"></table>
        <div id="pager"></div>
    </div>

</div>
</body>
<script type="text/javascript">

    $(function (){
        initGrid();
        //getInsurance();
    });

    //清空查询信息
    function reset() {
        document.getElementById("myForm").reset();
    }

    //查询列表信息
    function query() {
		//alert(123);
        $("#vasProductTypeList").jqGrid('setGridParam', {
            url : "${request.contextPath}/vasProductType/queryVasProductTypeList",
            datatype : "json",
            mtype : "POST",
            postData : getVasProductTypeQueryParams()
        }).trigger("reloadGrid");
    }

    //新增
    function add(){
       // window.location.href="${request.contextPath}/vasProductType/toAddVasProductType";
       window.open("${request.contextPath}/vasProductType/toAddVasProductType");    
    }
    
    //编辑
    function edit(id){
       // window.location.href="${request.contextPath}/vasProductType/toAddVasProductType";
       window.open("${request.contextPath}/vasProductType/toEditVasProductType/"+id);    
    }

   function getVasProductTypeQueryParams() {
  
      return  {
            'mainProductCode':$("#mainCode").val(),
            'mainProductName':$("#mainName").val(),
            'subProductCode':$("#subCoce").val(),
            'subProductName':$("#subName").val() }
    }

    function initGrid() {
        $("#vasProductTypeList").jqGrid({
            url : "${request.contextPath}/vasProductType/queryVasProductTypeList",
            datatype : "json",
            mtype : "POST",
            colNames : ['产品类型ID','产品主类型code', '产品主类型名称', '产品子类型code', '产品子类型名称','状态','操作' ],
            colModel : [ {
                name : 'id',
                index : 'id',
                align : 'center',
                width :200,
                sortable:false
            }, {
                name : 'mainProductCode',
                index : 'mainProductCode',
                align : 'center',
                sortable:false
            }, {
                name : 'mainProductName',
                index : 'mainProductName',
                align : 'center',
                sortable:false
            }, {
                name : 'subProductCode',
                index : 'subProductCode',
                align : 'center',
                sortable:false
            }, {
                name : 'subProductName',
                index : 'subProductName',
                align : 'center',
                sortable:false
            }, {
                name : 'activeStatus_Str',
                index : 'activeStatus_Str',
                align : 'center',
                sortable:false
            }, {
                name : 'operate',
                index : 'operate',
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
            caption : '增值服务产品类型列表',
            jsonReader : {
                root : "results",               // json中代表实际模型数据的入口
                page : "pagination.page",       // json中代表当前页码的数据
                records : "pagination.records", // json中代表数据行总数的数据
                total:'pagination.total',       // json中代表页码总数的数据
                repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
            },
            onPaging : function(pgButton) {
                $("#vasProductTypeList").jqGrid('setGridParam', {
                    postData : getVasProductTypeQueryParams()
                });
            },
            postData : getVasProductTypeQueryParams(),
            gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                var ids=jQuery("#vasProductTypeList").jqGrid('getDataIDs');
                for(var i=0; i<ids.length; i++){
                    var id=ids[i];
                    var rowData = $('#vasProductTypeList').jqGrid('getRowData',id);
					var operateClick = '<a href="javascript:;" style="color:blue" onclick="edit('+id+')" >编辑</a> ';
                    jQuery("#vasProductTypeList").jqGrid('setRowData', id , {operate:operateClick});
                }
            }
        });
    }
    
    </script>
    
</html>