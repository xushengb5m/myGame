package com.lazy.offline.dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.lazy.offline.dao.mapper.base.BaseMapper;
import com.lazy.offline.model.Resource;
import com.lazy.offline.model.base.BaseQueryDto;

public interface ResourceMapper extends BaseMapper<Resource, BaseQueryDto<?>>{
	
	List<Resource> getAllMenus();
	
	int selectHasChildren(@Param("id")int id);
}
