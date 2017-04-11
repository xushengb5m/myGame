package com.lazy.offline.model.base;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.codehaus.jackson.annotate.JsonIgnore;

/**
 * 结果集泛型对象
 * 
 * @author mashengwen
 * @date 2015-3-13
 */
@XmlRootElement
public class BaseResultDto<T> implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private List<T> results = new ArrayList<T>();

	private Pagination pagination = new Pagination();

	private String queryKey;
	
	/** 结果状态枚举 */
	private ResultStatus status = ResultStatus.SUCCESS;
	
	/** 错误信息*/
	private String errCode;
	 
	/** 返回信息 */
	private String message;
	
	/** 返回类型:true 同步 false 异步 */
	private Boolean isSync;

	public BaseResultDto() {
		pagination = new Pagination();
	}
	
	public BaseResultDto(List<T> results) {
		pagination = new Pagination();
		this.results = results;
	}

	public BaseResultDto(Pagination pagination, List<T> results) {
		this.pagination = pagination;
		this.results = results;

	}
	
	public String getQueryKey() {
		return queryKey;
	}

	public void setQueryKey(String queryKey) {
		this.queryKey = queryKey;
	}

	@XmlElement
	public List<T> getResults() {
		return results;
	}

	public void setResults(List<T> results) {
		this.results = results;
	}

	@XmlElement
	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	@JsonIgnore
	public int getPage() {
		return pagination.getPage();
	}
	@JsonIgnore
	public int getRows() {
		return pagination.getRows();
	}
	@JsonIgnore
	public int getRecords() {
		return pagination.getRecords();
	}
	@JsonIgnore
	public int getTotal() {
		return pagination.getTotal();
	}
	@JsonIgnore
	public String getSidx() {
		return pagination.getSidx();
	}
	@JsonIgnore
	public String getSord() {
		return pagination.getSord();
	}
	@JsonIgnore
	public Boolean isHasResults() {
		return getResults() != null ? true : false;
	}

	@JsonIgnore
	public Boolean getIsSync() {
		return isSync;
	}

	public void setIsSync(Boolean isSync) {
		this.isSync = isSync;
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

	public ResultStatus getStatus() {
		return status;
	}

	public void setStatus(ResultStatus status) {
		this.status = status;
	}
	
}
