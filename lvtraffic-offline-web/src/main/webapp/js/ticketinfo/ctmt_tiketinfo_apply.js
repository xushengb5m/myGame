/**
 * 申请航班补全
 * 
 * @param obj
 */
function checkit(obj, afUrl) {
	$.ajax({
			url : afUrl + '/' + $('#depCityCode').val() + '/' + $('#arrCityCode').val(),
			dataType : "json",
			contentType : "application/json;",
			type : "POST",
			data : JSON.stringify({
				flightNo : $('#flightNo').val()
			}),
			success : function(data) {
				if (data.status == 'SUCCESS') {
					// 组装舱位
					var seatClassList = eval(data.results);
					var seatStart = '<select id="seatClassCode" name="seatClassCode">';
					var seatEnd = '</select>';
					var seat = '';
					for ( var i = 0; i < seatClassList.length; i++) {
						seat += '<option value="' + seatClassList[i].code
								+ '">' + seatClassList[i].code
								+ '</option>';
					}
					$('#select_1').html(seatStart + seat + seatEnd);
				} else {
					$('#select_1').html("航班信息不存在");
				}
			}
		});
}

$(function() {
	// 全选
	$("#checkedAll").click(function() {
		// 如果当前点击的多选框被选中
		if ($(this).attr('checked')) {
			$('.check-sub').each(function(i, obj) {
				if (!$(obj).attr('disabled')) {
					$(obj).attr('checked', true);
				}
			});
		} else {
			$(".check-sub").attr('checked', false);
		}
	});

	// 选择子项点击事件
	$('.check-sub').click(function() {
		var flag = true;
		$('.check-sub').each(function(i, obj) {
			if (!$(this).attr('checked') && !$(this).attr("disabled")) {
				flag = false;
				return;
			}
		});
		if (flag) {
			$('#checkedAll').attr('checked', true);
		} else {
			$('#checkedAll').attr('checked', false);
		}
	});
});
