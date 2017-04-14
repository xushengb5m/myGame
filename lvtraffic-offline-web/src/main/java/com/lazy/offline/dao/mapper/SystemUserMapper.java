package com.lazy.offline.dao.mapper;

import com.lazy.offline.dao.mapper.base.BaseMapper;
import com.lazy.offline.model.User;
import com.lazy.offline.model.base.BaseQueryDto;

public interface SystemUserMapper extends BaseMapper<User, BaseQueryDto<?>>{
	
	User selectOneUser(User q);
	
	int selectEmailExist(User q);
	
	int selectUserIdByEmail(User q);

}
