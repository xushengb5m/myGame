package com.lazy.offline.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.lazy.offline.model.Page;
import com.lazy.offline.dao.IBaseCommonMapper;


public class BaseCommonMapper implements IBaseCommonMapper {

	private SqlSessionFactory sqlSessionFactory;

	public SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		this.sqlSessionFactory = sqlSessionFactory;
	}

	public Object selectOne(String namespace, Object param) {
		SqlSession sqlsession = sqlSessionFactory.openSession();
		Object ob = sqlsession.selectOne(namespace, param);
		sqlsession.close();
		return ob;
	}
	
	public Object selectOne(String namespace) {
		SqlSession sqlsession = sqlSessionFactory.openSession();
		Object ob = sqlsession.selectOne(namespace);
		sqlsession.close();
		return ob;
	}

	public List<Object> selectList(String namespace, Object param) {
		SqlSession sqlsession = sqlSessionFactory.openSession();
		List<Object> ob = sqlsession.selectList(namespace, param);
		sqlsession.close();
		return ob;
	}
	public<T> List<T> selectList(String namespace,Object param,Class<T> resultType){
		SqlSession sqlsession = sqlSessionFactory.openSession();
		List<T> ob = sqlsession.selectList(namespace, param);
		sqlsession.close();
		return ob;
	}
	public Page selectListPage(String namespace, Page param) {
		// TODO Auto-generated method stub
		SqlSession sqlsession = sqlSessionFactory.openSession();
		List<Object> ob = sqlsession.selectList(namespace, param);
		sqlsession.close();
		param.setRows(ob);
		return param;
	}
	public List<Object> selectList(String namespace) {
		SqlSession sqlsession = sqlSessionFactory.openSession();
		List<Object> ob = sqlsession.selectList(namespace);
		sqlsession.close();		
		return ob;
	}
	

	public int insert(String namespace, Object param) {
		return insert(namespace, param, false);
	}

	public int delete(String namespace, Object param) {
		return delete(namespace, param, false);
	}

	public int update(String namespace, Object param) {
		return update(namespace, param, false);
	}

	public int insert(String namespace, Object param,boolean auto) {
		// TODO Auto-generated method stub
		SqlSession sqlsession = sqlSessionFactory.openSession();
		int ob = sqlsession.insert(namespace, param);
		if(auto)sqlsession.close();
		return ob;
	}

	public int delete(String namespace, Object param,boolean auto) {
		SqlSession sqlsession = sqlSessionFactory.openSession();
		int a = sqlsession.delete(namespace, param);
		if(auto)sqlsession.close();
		return a;
	}

	public int update(String namespace, Object param,boolean auto) {
		SqlSession sqlsession = sqlSessionFactory.openSession();
		int a = sqlsession.update(namespace, param);
		if(auto)sqlsession.close();
		return a;
	}

	
}
