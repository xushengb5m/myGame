package com.lazy.offline.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lazy.offline.dao.mapper.RoleResourceMapper;
import com.lazy.offline.model.Resource;
import com.lazy.offline.model.RoleAccess;
import com.lazy.offline.service.RoleAccessService;

@Service
public class RoleAccessServiceImpl implements RoleAccessService{
	
	@Autowired
	private RoleResourceMapper roleResourceMapper;

	public boolean hasAccess(RoleAccess ra) {
		
		List<Resource> accessResource = roleResourceMapper.selectResourceByRoleId(ra.getRoleId());
		for(Resource resource : accessResource){
			if(ra.getAccessurl().indexOf(resource.getResourceUrl())!=-1){
				return true;
			}
		}
		return false;
	}

}
