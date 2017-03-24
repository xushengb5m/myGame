<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="${request.contextPath}/css/order-details.css" type="text/css"/>
    <link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
    <link type="text/css" rel="stylesheet" href="${request.contextPath}/js/resources/jqGrid/css/ui.jqgrid.css"/>
    <script src="${request.contextPath}/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
    <script src="${request.contextPath}/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
    <script src="${request.contextPath}/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
    <script src="${request.contextPath}/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="${request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>


    <script type="text/javascript">

        $(function (){
            initGrid();
            getInsurance();
            conditionHtmlToExportCsvForm();
        });

        //查询列表信息
        function query() {

            $("#insuranceOrders").jqGrid('setGridParam', {
                url : "queryInsuranceOrders",
                datatype : "json",
                mtype : "POST",
                postData : getInsuranceOrderParams()
            }).trigger("reloadGrid");
            conditionHtmlToExportCsvForm();
        }

        function getInsuranceOrderParams() {
        	var insuranceClassNameStr=$('#insuranceName').find("option:selected").text();
        	if(insuranceClassNameStr=='全部'){
        		insuranceClassNameStr='';
        	} 
        	var insuranceNameVal = $("select#insuranceName option:selected").val()==undefined?"":$("select#insuranceName option:selected").val();
        	return {
                'orderNo' : $("#orderNo").val(),
                'ticketNo' : $("#ticketNo").val(),
                'insuranceNo' : $("#insuranceNo").val(),
                'insuredName' : $("#insuredName").val(),
                'insuranceStatus' : $("#insuranceStatus").val(),
                'idCardNo' : $("#idCardNo").val(),
			    'insuranceType' : $("#insuranceType").val(), 
                'startEffectDate' : $("#startEffectDate").val(),
                'endEffectDate' : $("#endEffectDate").val(),
                'startInsureDate' : $("#startInsureDate").val(),
                'endInsureDate' : $("#endInsureDate").val(),
                'startHesitateDate' : $("#startHesitateDate").val(),
                'endHesitateDate' : $("#endHesitateDate").val(),
                //'insuranceInfoDto.id' : $('#insuranceName').val(),
                'insuranceInfoDto.id' : insuranceNameVal,
                'insuranceClassName' : insuranceClassNameStr,
                'insuranceInfoDto.supp.id' : $('#suppName').val(),
                'productTypes' : $("#productType").val(),
                'search':false
            }
            
        }
		//将条件插入到导出exportCsvForm
		function conditionHtmlToExportCsvForm()
		{
			$('#exportCsvDiv').html($('#conditionDiv').clone());
			$.each($('#conditionDiv').find('select'), function(index, obj)
			{
				var objName = $(obj).attr('name');
				$('#exportCsvDiv').find('select[name="'+objName+'"]').attr('value', $(obj).val());
			});
		}
        function initGrid() {
            $("#insuranceOrders").jqGrid({
                url : "queryInsuranceOrders",
                datatype : "json",
                mtype : "POST",
                colNames : ['订单号','票号','保单ID','保单号','险种名称','产品类型','保险类型','产品类型','供应商','用户姓名','证件号码','投保时间','投保时间','生效时间','废保时间','投保状态','是否关联','操作'],
                colModel : [ {
                    name : 'orderNo',formatter:formatLink,
                    index : 'orderNo',
                    align : 'center',
                    //width :220,
                    sortable:false
                }, {
                    name : 'ticketNo',
                    index : 'ticketNo',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'insuranceOrderId',
                    index : 'insuranceOrderId',
                    align : 'center',
                    sortable : false,
                    hidden : true
                },{
                    name : 'insuranceNo',
                    index : 'insuranceNo',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'insuranceClassName',
                    index : 'insuranceClassName',
                    align : 'center',
                    sortable:false
                },  {
                    name : 'productStr',
                    index : 'productStr',
                    align : 'center',
                    sortable:false
                },{
					name : 'insuranceTypeStr',
					index : 'insuranceTypeStr',
					align : 'center', 
					sortable:false
				},{
					name : 'productTypes',
					index : 'productTypes',
					align : 'center',
					hidden : true,
					sortable:false
				},{
                    name : 'suppName',
                    index : 'suppName',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'insuredName',
                    index : 'insuredName',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'idCardNo',
                    index : 'idCardNo',
                    align : 'center',
                    //width : 250,
                    sortable:false
                }, {
                    name : 'insureTime',
                    index : 'insureTime',
                    align : 'center',
                    //width : 250,
                    sortable : true
                },{
                    name : 'insureDate',
                    index : 'insureDate',
                    align : 'center',
                    //width : 250,
                    sortable : false,
                    hidden : true
                }, {
                    name : 'effectTime',
                    index : 'effectTime',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'hesitateTime',
                    index : 'hesitateTime',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'insuranceStatusName',
                    index : 'insuranceStatusName',
                    align : 'center',
                    sortable:false
                }, {
                    name : 'isRelated',
                    index : 'isRelated',
                    align : 'center',
                    sortable:false,
					hidden:true
                }, {
                    name : 'operate',
                    index : 'operate',
                    align : 'center',
                    sortable:false
                }],
                rowNum:10,            //每页显示记录数
                autowidth: true,      //自动匹配宽度
                pager: '#pager',      //表格数据关联的分页条，html元素
                rowList:[10,20,50,200],   //分页选项，可以下拉选择每页显示记录数
                viewrecords: true,    //显示总记录数
                height:'auto',//高度，表格高度。可为数值、百分比或'auto'
                //autoheight: true,     //设置高度
                gridview:true,        //加速显示
                viewrecords: true,    //显示总记录数
                multiselect : false,
                sortable:true,        //可以排序
                sortname: 'createDate',  //排序字段名
                sortorder: "desc",    //排序方式：倒序
                caption : "保险列表",
                jsonReader : {
                    root : "results",               // json中代表实际模型数据的入口
                    page : "pagination.page",       // json中代表当前页码的数据
                    records : "pagination.records", // json中代表数据行总数的数据
                    total:'pagination.total',       // json中代表页码总数的数据
                    repeatitems : false             // 如果设为false，则jqGrid在解析json时，会根据name来搜索对应的数据元素（即可以json中元素可以不按顺序）；而所使用的name是来自于colModel中的name设定。
                },
                postData : getInsuranceOrderParams(),
                onPaging : function(pgButton) {
                    $("#insuranceOrders").jqGrid('setGridParam', {
                        postData : getInsuranceOrderParams()
                    });
                },
                gridComplete:function(){  //在此事件中循环为每一行添加日志、废保和查看链接
                    var ids=jQuery("#insuranceOrders").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++){
                        var id=ids[i];
                        var rowData = $('#insuranceOrders').jqGrid('getRowData',id);
                        var insuranceNo = rowData.insuranceNo;
                        var insureDate = rowData.insureDate;
                        var insuranceId = rowData.insuranceOrderId;
                        var productTypes = rowData.productTypes;
                        operateClick= '<a href="#" style="color:blue" onclick="hesitateCancel('+"'"+insuranceNo+"' ,'"+ insureDate +"' ,'"+ productTypes +"'"+')" >废保</a>';
                        jQuery("#insuranceOrders").jqGrid('setRowData', id , {operate:operateClick});
                    }
                }
            });
        }


        
          function formatLink(cellvalue, options, rowObject) {
		    var url = ""; 
        	var productTypes = rowObject.productTypes;
        	var oldCellvalue = cellvalue;
        	if(productTypes=="I_TRAIN"){//火车票
        		cellvalue = cellvalue.substring(0,cellvalue.length-3);
        		url = "${trainOrderDetailUrl}/"+cellvalue;
        	}else{
        		//主订单Id到后台自动查询
				var orderMainId = -1;
		    	url = "http://super.lvmama.com/offline-web/order/queryOrderDetail/"+orderMainId+"/"+rowObject.orderId+"/NULL";
        	}       	 
		       return  "<a href='"+url+"' style='color:blue;' target='_blank'>" + oldCellvalue + "</a>";       
    	}

        //废保
        function hesitateCancel(insuranceNo, insureDate,productTypes) {
            var gnl=confirm("确认废除保单？");
            var desc;
            if(gnl==true){
                desc = window.prompt("请输入废保原因","请输入废保原因");
                if(desc){
                    $.ajax({
                        url : 'hesitateCancel',
                        type:'post',
                        dataType : "json",
                        contentType : "application/json;",
                        data : JSON.stringify({
                            insuranceNo : insuranceNo,
                            insureDate : insureDate,
                            productTypes:productTypes,
                            desc : desc
                        }),
                        success: function(data){
                            alert(data.message);
                            window.location.reload();
                        }
                    });
                }


            }
        }

		

        //根据supp查询保险产品
        function getInsurance() {
            var str="";
            var suppId = $("#suppName").val();
            $.ajax({
                url : 'getInsuranceBySupp',
                type:'post',
                dataType : "json",
                data:{'suppId':suppId},
                success: function(data){
                    $("#insuranceName option").remove();
                    str="<option value=''>全部</option>";
                    jQuery.each(data, function(i,item){
                        str+="<option value='"+item.id+"'>"+item.insuranceClass.name+"</option>";
                    });

                    $("#insuranceName").append(str);
                }
            });
        }
        //导出Csv
        function exportCsv() {
	        /**$("#insuranceInfoDto_id").val($('#insuranceName').val());
            $("#insuranceInfoDto_insuranceClass_name").val($('#insuranceName').find("option:selected").text());
            $("#insuranceInfoDto_supp_id").val($('#suppName').val());
            $("#search").val('false');
            $('#myForm').submit(); */
            $('#exportCsvForm').submit();
        }

    </script>

</head>
<body>
<div class="content content1">
    <div class="breadnav"><span>首页</span> > 保险列表</div>
    <form id="myForm" autocomplete="off" action="exportInsuranceOrders" method="post" target="_blank">
        <div class="infor1" id="conditionDiv">
            <div class="product message">
                <div class="main">
                    <div class="part">
                        <span>订单号：</span><input type="text" id="orderNo" name="orderNo">
                        <span>供应商：</span><select name="insuranceInfoDto.supp.id" id="suppName" onblur="getInsurance()">
                        <option value="">全部</option>
					<#list supps as supp>
                        <option value="${(supp.id)!''}">${(supp.name)!''}</option>
					</#list>
                    </select>
                        <span>投保时间：</span><input type="text" id="startInsureDate"  name="startInsureDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"
                                                 class="Wdate" readonly="readonly"/> -
                        <input type="text" id="endInsureDate"  name="endInsureDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"
                               class="Wdate" readonly="readonly"/>
                    </div>
                    <div class="part">
                        <span>保单号：</span><input type="text" id="insuranceNo" name="insuranceNo">
                        <span>投保状态：</span><select name="insuranceStatus" id="insuranceStatus">
                        <option value="">全部</option>
					<#list insuranceStatusEnum as val>
                        <option value="${val}">${val.cnName}</option>
					</#list>
                    </select>
                        <span>生效时间：</span><input type="text" id="startEffectDate"  name="startEffectDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"
                                                 class="Wdate" readonly="readonly"/> -
                        <input type="text" id="endEffectDate"  name="endEffectDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"
                               class="Wdate" readonly="readonly"/>
                    </div>
                </div>
            </div>
            <div class="visitor message">

                <div class="main">
                    <div class="part">
                        <span>票号：</span><input type="text" id="ticketNo"  name="ticketNo"/>
                        <span>险种名称：</span><select name="insuranceInfoDto.id" id="insuranceName"></select>
						<span>保险类型：</span>
						 <select name="insuranceType" id="insuranceType">
							<option value="">全部</option>
							<#list insuranceTypeEnum as val>
								<option value="${val}">${val.cnName}</option>
							</#list>
						</select> 
                    </div>
                    <div class="part">
                        <span>姓名：</span><input type="text" id="insuredName"  name="insuredName"/>
                        <span>证件号码：</span><input type="text" id="idCardNo"  name="idCardNo"/>
						<span style="margin-left:10px;">适用产品类型：</span>
						<select name="productTypes" id="productType">
							<option value="">全部</option>
							<#list productEnum as val>
								<option value="${val}" <#if val=="I_FLIGHT">selected="true"</#if>>${val.cnName}</option>
							</#list>
						</select>
						  <span>废保时间：</span><input type="text" id="startHesitateDate"  name="startHesitateDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"
                                                 class="Wdate" readonly="readonly"/> -
                        <input type="text" id="endHesitateDate"  name="endHesitateDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;"
                               class="Wdate" readonly="readonly"/>
                    </div>
                </div>
            </div>

        </div>
        <div class="click">
            <a href="javascript:;"><div class="button" onclick="query()">查询</div></a>
            <a href="javascript:;"><div class="button" onclick="exportCsv()">导出</div></a>
        </div>
<!--         <input type="hidden" id="insuranceInfoDto_id" name="insuranceInfoDto.id"/>
        <input type="hidden" id="insuranceInfoDto_insuranceClass_name" name="insuranceInfoDto.insuranceClass.name"/>
        <input type="hidden" id="insuranceInfoDto_supp_id" name="insuranceInfoDto.supp.id"/>
        <input type="hidden" id="search" name="search"/> -->
    </form>
    <div class="content1" style="margin-top:50px;">
        <table id="insuranceOrders"></table>
        <div id="pager"></div>
    </div>
    <br>
    <br>
    <form id="exportCsvForm" action="${request.contextPath}/insurance/exportInsuranceOrders" method="post" target="_blank">
		<div id="exportCsvDiv" style="display:none;">
		</div>
	</form>  
</div>
</body>
</html>
