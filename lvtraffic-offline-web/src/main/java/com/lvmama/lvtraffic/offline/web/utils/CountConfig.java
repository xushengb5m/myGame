package com.lvmama.lvtraffic.offline.web.utils;

/**
 * CSV文件信息枚举
 * @author majun
 * @date 2015-6-3
 */
public abstract class CountConfig{
	
	public static CountConfig COUNT_LIST = new CountConfig("活动统计列表")
	{
		@Override
		public String getHead() 
		{
			return "订单号,子活动ID,子活动名,主活动ID,主活动名,下单时间,会员ID,联系手机,活动方式";
		}
	};
	
	public static CountConfig FEEDBACK_LIST = new CountConfig("用户反馈列表")
	{
		@Override
		public String getHead() 
		{
			return "问题编号,产品线,类型,平台,页面入口,内容,提交时间,会员号,联系手机,处理人,问题类型,处理进度,备注";
		}
	};
	
	
	private String fileName;
	
	private CountConfig(String fileName) 
	{
		this.fileName = fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileName() {
		return fileName;
	}
	
	public abstract String getHead();
	
}
