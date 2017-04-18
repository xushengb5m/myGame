package com.lazy.offline.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.RoleMapper;
import com.lazy.offline.dao.mapper.RoleResourceMapper;
import com.lazy.offline.model.Resource;
import com.lazy.offline.model.Role;
import com.lazy.offline.utils.JSONMapper;

@Controller
@RequestMapping("system")
public class RoleResourceController {
	
	@Autowired
	private RoleMapper roleMapper;
	
	@Autowired
	private RoleResourceMapper roleResourceMapper;
	
	
	@RequestMapping(value = "/toAccessList/{id}")
	private String toResourceList(Model model,@PathVariable int id) {
		Role role = roleMapper.getById(id);
		model.addAttribute("role", role);
		return "system/sys_role_resource";
	}
	
	@RequestMapping(value = "/toRoleResource/{id}")
	@ResponseBody
	private List<Integer> toRoleResource(@PathVariable int id) {
		List<Map<String,Integer>> mapList = roleResourceMapper.selectResourceIdByRoleId(id);
		List<Integer> idList = new ArrayList<Integer>();
		List<Integer> topIdList = new ArrayList<Integer>();
		for(Map<String,Integer> map : mapList){
			idList.add(map.get("id"));
			topIdList.add(map.get("topId"));
		}
		for(int i=0;i<idList.size();i++){
			Integer ide = idList.get(i);
			for(int j=0;j<topIdList.size();j++){
				if(topIdList.get(j)==ide){
					idList.remove(i);
					break;
				}
			}
		}
		return idList;
	}
	

}
