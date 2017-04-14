package com.lazy.offline.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lazy.offline.dao.mapper.SystemUserMapper;
import com.lazy.offline.model.User;
import com.lazy.offline.model.base.BaseQueryDto;
import com.lazy.offline.service.SystemUserService;

@Service
public class SystemUserServiceImpl implements SystemUserService{
	
	@Autowired
	private SystemUserMapper systemUserMapper;
	
	public List<User> selectSysUserListPage(BaseQueryDto<User> baseQuery){
		return systemUserMapper.query(baseQuery);
	}

}
