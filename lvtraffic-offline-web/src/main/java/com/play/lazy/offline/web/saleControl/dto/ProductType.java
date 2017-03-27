package com.play.lazy.offline.web.saleControl.dto;

public enum ProductType{
	
	INSURANCE("保险"),
    KGYX("空港易行");
	
	
	private String cnName;
	
	public String getCnName() {
		return cnName;
	}
	public void setCnName(String cnName) {
		this.cnName = cnName;
	}
	private ProductType(String cnName) {
		this.cnName = cnName;
	}

}