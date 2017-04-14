package com.lazy.offline.dao.mapper;

import java.util.List;

import com.lazy.offline.dao.mapper.base.BaseMapper;
import com.lazy.offline.model.User;
import com.lazy.offline.model.base.BaseQueryDto;

public interface SystemUserMapper extends BaseMapper<User, BaseQueryDto<?>>{
	
	List<User> selectSysUserListPage(BaseQueryDto<?> q);
	
	User selectOneUser(User q);
	
	int selectEmailExist(User q);
	
	int selectUserIdByEmail(User q);

}
