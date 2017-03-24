<!DOCTYPE html>

<html lang="en">
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

    <style>
        table tr td input {
            width: 150px;
            height: 20px;
        }
    </style>
</head>


     <script type="text/javascript">
     $(function(){
		    getSalePrice();
		    savePrice();
		    editPrice();	
		    cancel();    
		    $("#allChBox").change(function(){
		   		 //alert($(this).attr("checked"))
		   		 if('checked' == $(this).attr("checked")){
		   		 	$(".saledata input[type=checkbox]").attr("checked",'true');
		   		 }else{
		   		 	$(".saledata input[type=checkbox]").removeAttr("checked");
		   		 }
				
				});	
				  	  		        
		   })
		    
		    function getSalePrice(){
		     var saleControl=new Object;
		     saleControl.productType=$("#productType").val();
		     saleControl.insuranceClassCode =$("#code").val();
		     saleControl.id=$("#id").val();		      	      
			    $.ajax({
				url: "${request.contextPath}/SaleControl/queryPrice",
			    dataType : "html",
				contentType : "application/json",
				type : "POST",
				data : JSON.stringify(saleControl),
				    success: function(result){
				    	$(".data").html(result);
				    	//alert($(".saledata input[type=checkbox]").length);
				    	$(".saledata input[type=checkbox]").each(function(){
							$(this).change(function(){
								//alert($(this).attr("checked"));
								var checkedNum = 0;
								var uncheckedNum = 0;
								$(".saledata input[type=checkbox]").each(function(){
									if("checked" == $(this).attr("checked")){
										checkedNum ++;
									}else{
										uncheckedNum ++;
									}
								});
								//alert("checkedNum:"+checkedNum+"  "+"uncheckedNum:"+uncheckedNum);
								if(checkedNum == $(".saledata input[type=checkbox]").length){
									$("#allChBox").attr("checked",'true');
								}else{
									$("#allChBox").removeAttr("checked");
								}
								/*if(uncheckedNum == $(".saledata input[type=checkbox]").length){
									$("#allChBox").removeAttr("checked");
								}*/
							});
						});
				    	if($("#status").val()=="FAIL"){
				    	alert("查询销售价格错误");
				       }
				      }
			    });
		    }
		    
		    
		    function editPrice(){
		     $(".data").delegate(".addPrice","blur",function(){
		     
		      var addprice = $(this).find($("input[type='text']")).val();		
		      var costprice = $(this).siblings(".costPrice").val();
		      var insuranceprice = $(this).siblings(".insurancePrice").html();
		      var initaddprice = parseInt(insuranceprice)-parseInt(costprice);
		      var processinsuranceprcice = parseInt(costprice)+parseInt(addprice);
		      if(processinsuranceprcice<0){
				 $(this).find($("input[type='text']")).val(initaddprice);
		          alert("扣价不能超过结算价");    
		       }else{
		       $(this).siblings(".insurancePrice").html(processinsuranceprcice);		       
		       } 
		   });		   
		 }



		   
		   function savePrice(){
		     $(".data").delegate("#save","click",function(){
		   	   var input=new Array();
		          $(".saledata").each(function(){
		          var data= new Object();
		          data.productType=$("#productType").val();
		          data.insuranceClassCode = $("#code").val();
		          data.insurancePrice = $(this).find(".insurancePrice").html();
		          data.platForm=$(this).find(".platForm").val();
		          data.costPrice  = $("#insuranceCostPrice").val();
		          
		          if("checked" == $(this).find(".saleCtlStatus ").find("input[type=checkbox]").attr("checked")){
					  data.saleCtlStatus = 'VALID';
				  }else{
					  data.saleCtlStatus = 'INVALID';
				  }
				  //console.log($(this).find(".saleCtlStatus ").find("input[type=checkbox]").attr("checked"));
		          input.push(data);	
		           
		          });	
		          
		          //console.log(JSON.stringify(input));
				    $.ajax({
				    type: "POST",
				    url: "${request.contextPath}/SaleControl/updatePrice",    
				    contentType : "application/json",
				    data : JSON.stringify(input),
				    dataType : "json",
				    success: function(result){	    	
				           	if(result.status=="SUCCESS"){
				    	      alert("保存成功");
				            }else{
				              alert("保存失败");
				            }
				            window.close();			       
				          }	      
				   });
		   
		   });
		    
		   }
		   
		   
		   
		   function cancel(){
		    $(".data").delegate("#cancel","click",function(){
		         getSalePrice();
		    
		    });
		   
		   
		   }
	   
		   
    
    </script>   
  </head>
  
  
  
<body>	
<div class="content">
    <div class="breadnav"><span>销售调控</span>>保险销售调控</div>
    <div class="infor1" id="conditionDiv">
        <div class="order message">
            <div class="main">
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >产品基本信息</label></div>





                <div class="vas_add">
                
		             <input type="hidden" id="productType" name="ProductType" value="${(ProductType)!''}"/>
			         <input type="hidden" id="code" name="code" value="${(InsuranceClass.code)!''}"/>      
			         <input type="hidden" id="id" name="id" value="${id!''}"/>
			         <input type="hidden" id="insuranceCostPrice" name="insuranceCostPrice" value="${costPrice!''}"/>
			         
				     <span>产品类型:${ProductType.cnName}</span>&nbsp;&nbsp;&nbsp;&nbsp;				
				     <span>险种名称:${InsuranceClass.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;		
				     <span>产品编码：${InsuranceClass.code}</span>&nbsp;&nbsp;&nbsp;&nbsp;		
				     <span>供应商：${Supp.name}</span>	

                </div>
                <div style="background-color: #88b6d9 ;width: 120px; text-align:center"><label >销售调控信息</label></div>
         
                <div class="ad">
                    <br/>
                    <input type="radio"  checked="checked"/><span>基于结算价固定加价</span>
                    <table style="width: 600px">
                        <tr>
                        	<th><input type="checkbox" id="allChBox"/></th>
                            <th>渠道</th>
                            <th>加价</th>
                            <th>销售价</th>
                            
                        </tr>                 
                    </table>                  
                </div>
                <div class="data"></div>
            </div>
        </div>
    </div>
</div>

</body>

</html>
