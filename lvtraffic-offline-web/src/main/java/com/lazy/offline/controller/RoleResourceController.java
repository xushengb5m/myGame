package com.lazy.offline.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.lazy.offline.dao.mapper.RoleMapper;

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
