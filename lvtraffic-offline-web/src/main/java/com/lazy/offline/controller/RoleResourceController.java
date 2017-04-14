package com.lazy.offline.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.RoleMapper;
import com.lazy.offline.model.Role;
import com.lazy.offline.model.base.BaseQueryDto;
import com.lazy.offline.model.base.BaseResultDto;
import com.lazy.offline.model.base.Pagination;

@Controller
@RequestMapping("system")
public class RoleResourceController {
	
	@Autowired
	private RoleMapper roleMapper;
	
	@RequestMapping(value = "/toAccessList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/sys_role_resource";
	}
	

}
