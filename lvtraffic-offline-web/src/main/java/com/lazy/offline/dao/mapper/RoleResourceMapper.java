package com.lazy.offline.dao.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.lazy.offline.dao.mapper.base.BaseMapper;
import com.lazy.offline.model.Role;
import com.lazy.offline.model.base.BaseQueryDto;

public interface RoleResourceMapper extends BaseMapper<Role, BaseQueryDto<?>>{
	
	List<Map<String,Integer>> selectResourceIdByRoleId(@Param("id")int id);

}
