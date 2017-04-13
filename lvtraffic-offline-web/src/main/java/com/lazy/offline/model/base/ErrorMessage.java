package com.lazy.offline.model.base;

public class ErrorMessage {
	/** 结果状态枚举 */
	private ResultStatus status = ResultStatus.SUCCESS;
	
	/** 错误信息*/
	private String errCode;
	 
	/** 返回信息 */
	private String message;

	public ResultStatus getStatus() {
		return status;
	}

	public void setStatus(ResultStatus status) {
		this.status = status;
	}

	public String getErrCode() {
		return errCode;
	}

	public void setErrCode(String errCode) {
		this.errCode = errCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	

}
