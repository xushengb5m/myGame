<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="../../../../webapp/css/trip-list.css">
    <link rel="stylesheet" href="../../../../webapp/css/order-details.css" type="text/css"/>
    <link type="text/css" rel="stylesheet" href="../../../../webapp/js/resources/jquery-ui-1.8.11/css/redmond/jquery-ui-1.8.11.css"/>
    <link type="text/css" rel="stylesheet" href="../../../../webapp/js/resources/jqGrid/css/ui.jqgrid.css"/>
    <script src="../../../../webapp/js/resources/jqGrid/js/jquery-1.7.2.min.js"> </script>
    <script src="../../../../webapp/js/resources/jquery-ui-1.8.10.custom.min.js"></script>
    <script src="../../../../webapp/js/resources/jqGrid/src/i18n/grid.locale-cn.js"></script>
    <script src="../../../../webapp/js/resources/jqGrid/js/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="../../../../webapp/js/My97DatePicker/WdatePicker.js"></script>

    <style>
        table tr td input {
            width: 150px;
            height: 20px;
        }
    </style>
</head>
<body>
<div class="content content1">
    <div class="breadnav"><span>增值服务</span>>销售调控</div>
    <div class="infor1" id="conditionDiv">
        <div class="order message">
            <div class="main">
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >产品基本信息</label></div>

                <div class="vas_add">
                    <span >产品类型:</span>&nbsp;<span>机场服务</span>&nbsp;&nbsp;&nbsp;
                    <span >产品ID:</span>&nbsp;<span>123456</span>&nbsp;&nbsp;&nbsp;
                    <span >产品名称：</span>&nbsp;<span>全国国内休息室</span>&nbsp;&nbsp;&nbsp;
                    <span >产品编码:</span>&nbsp;<span>0615</span>&nbsp;&nbsp;&nbsp;
                    <span >供应商:</span>&nbsp;<span>空港易行</span>&nbsp;&nbsp;&nbsp;
                </div>
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >销售调控信息</label></div>
                <div class="vas_add">

                    <span>出发日期：</span><input type="text" id="" name="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" class="Wdate" readonly="readonly"/>
                    &nbsp; &nbsp;至 &nbsp; &nbsp;<input type="text" id="" name="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" class="Wdate" readonly="readonly"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span>销售日期：</span><input type="text" id="" name="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" class="Wdate" readonly="readonly"/>
                    &nbsp; &nbsp;至 &nbsp; &nbsp;<input type="text" id="" name="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" class="Wdate" readonly="readonly"/>
                </div>
                <div>
                    <br/>
                    <input type="radio"  checked="checked"/><span>基于结算价固定加价</span>
                    <table style="width: 600px">
                        <tr>
                            <th>渠道</th>
                            <th>加价</th>
                            <th>销售价</th>
                        </tr>
                        <tr>
                            <td>PC</td>
                            <td><input  name="" /></td>
                            <td>25</td>
                        </tr>
                        <tr>
                            <td>WAP</td>
                            <td><input name="" /></td>
                            <td>25</td>
                        </tr>
                        <tr>
                            <td>IOS</td>
                            <td><input name="" /></td>
                            <td>25</td>
                        </tr>
                        <tr>
                            <td>ANDROID</td>
                            <td><input name="" /></td>
                            <td>25</td>
                        </tr>
                        <tr>
                            <td>后台</td>
                            <td><input name="" /></td>
                            <td>25</td>
                        </tr>
                        <tr>
                            <td>分销</td>
                            <td><input name="" /></td>
                            <td>25</td>
                        </tr>
                    </table>
                </div>
                <div style="margin-left: 30%;margin-top: 30px">
                    <input style="width: 90px;height: 30px" type="button" name="" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input style="width: 90px;height: 30px" type="button" name="" value="取消">
                </div>
            </div>
        </div>
    </div>
</body>
</html>