package com.lazy.offline.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.model.base.BaseQueryDto;
import com.lazy.offline.model.base.BaseResultDto;
import com.lazy.offline.model.base.Pagination;
import com.lazy.offline.service.IBaseCommonService;

@Controller
@RequestMapping("system")
public class SysUserController {
	
	@Autowired
	private IBaseCommonService baseCommonService;
	
	@RequestMapping(value = "/toSysUserList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/sys_user";
	}
	
	@RequestMapping(value = "/loadSysUserData")
	@ResponseBody
	private BaseResultDto<Object> loadResourceData(HttpServletRequest request,HttpServletResponse response) {
		BaseQueryDto<Object> baseQuery = new BaseQueryDto<Object>(new Pagination());
		List<Object> userList= baseCommonService.selectList("systemUserMapper.selectSysUserListPage",baseQuery);
		BaseResultDto<Object> baseResult = new BaseResultDto<Object>(userList);
		
		return baseResult;
	}

}
