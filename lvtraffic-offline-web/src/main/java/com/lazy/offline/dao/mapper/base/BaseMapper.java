package com.lazy.offline.dao.mapper.base;

import java.util.List;

import org.apache.ibatis.annotations.Param;


public interface BaseMapper<I,Q> {
	/**
	 * @param i
	 * insert
	 */
	public int insert(I i);

	/**
	 * @param i
	 * getById
	 */
	public I getById(@Param("id")int id);

	/**
	 * @param i
	 * deleteById
	 */
	public int deleteById(@Param("id")int id);

	/**
	 * @param i
	 * updateById
	 */
	public int updateById(@Param("id")int id,@Param("i")I i);
	
	/**
	 * @param
	 * @return
	 * 查询所有对象
	 */
	public List<I> queryAll();

	/**
	 * @param q
	 * @return
	 * 查询返回多个对象
	 */
	public List<I> query(Q q);
	
	/**
	 * @param q
	 * @return
	 * 返回总数
	 */
	public int count(Q q);
	
	
}
