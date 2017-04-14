package com.lazy.offline.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.RoleMapper;
import com.lazy.offline.model.Role;
import com.lazy.offline.model.User;
import com.lazy.offline.model.base.BaseQueryDto;
import com.lazy.offline.model.base.BaseResultDto;
import com.lazy.offline.model.base.Pagination;

@Controller
@RequestMapping("system")
public class RoleController {
	
	@Autowired
	private RoleMapper roleMapper;
	
	@RequestMapping(value = "/toRoleList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/sys_role";
	}
	
	@RequestMapping(value = "/loadRoleData")
	@ResponseBody
	private BaseResultDto<Role> loadResourceData(Role role,Pagination pg,Model model) {
		BaseQueryDto<Role> baseQuery = new BaseQueryDto<Role>(pg,role);
		List<Role> resList = roleMapper.query(baseQuery);
		BaseResultDto<Role> baseResult = new BaseResultDto<Role>(resList);
		return baseResult;
	}

}
