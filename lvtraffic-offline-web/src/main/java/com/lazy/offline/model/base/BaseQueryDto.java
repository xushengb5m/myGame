package com.lazy.offline.model.base;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.codehaus.jackson.annotate.JsonIgnore;

/**
 * 查询泛型对象
 * 
 * @author mashengwen
 * @date 2015-3-13
 */
@XmlRootElement
public class BaseQueryDto<T> implements Serializable{
	
	private static final long serialVersionUID = -689667730283333557L;

	private Pagination pagination;

	private T condition;
	
	private String queryKey;	
	
	public BaseQueryDto() {
		
	}
	
	public BaseQueryDto(T condition) {
		super();
		this.pagination=new Pagination(0,50000,null,null);
		this.condition = condition;
	}

	public BaseQueryDto(Pagination pagination, T condition) {
		this.pagination = pagination;
		this.condition = condition;
	}
	
	public String getQueryKey() {
		return queryKey;
	}

	public void setQueryKey(String queryKey) {
		this.queryKey = queryKey;
	}

	@XmlElement
	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}

	public T getCondition() {
		return condition;
	}

	public void setCondition(T condition) {
		this.condition = condition;
	}
	@JsonIgnore
	public int getStartRow() {
		return pagination.getStartRow();
	}
	@JsonIgnore
	public int getEndRow() {
		return pagination.getEndRow();
	}
	@JsonIgnore
	public String getSidx() {
		return pagination.getSidx();
	}
	@JsonIgnore
	public String getSord() {
		return pagination.getSord();
	}

}
