<input type="hidden" name="status" id="status" value="${baseResult.status}">
<#if baseResult.status=="SUCCESS">
<table>
		<#list baseResult.results as result>
            <tr class ="saledata">
                <#if "VALID" == "${result.saleCtlStatus}">
                    <th class="saleCtlStatus"><input type="checkbox"  checked="checked"/> </th>
                    <#else>
                        <th class="saleCtlStatus"><input type="checkbox"   /> </th>
                </#if>
                <th style="width:33%" >${result.platForm.cnName}</th>
                <input class="platForm"  type="hidden" value="${result.platForm}"/>
                <th style="width:33%" class="addPrice"><input type="text" name = "addPrice" value="${result.addPrice}"/></th>
                <th class="insurancePrice">${result.insurancePrice}</th>
                <input type="hidden" class="costPrice" name="costPrice" value="${result.costPrice}"/>
            </tr>
        </#list>
</table>
    <div style="margin-left: 30%;margin-top: 30px">
  <input style="width: 90px;height: 30px" type="button" name="" id="save" value="保存">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input style="width: 90px;height: 30px" type="button" name="" id="cancel" value="取消">
  </div>
<#else>

</#if>