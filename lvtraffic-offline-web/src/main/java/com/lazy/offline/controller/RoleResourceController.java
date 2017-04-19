package com.lazy.offline.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.RoleMapper;
import com.lazy.offline.dao.mapper.RoleResourceMapper;
import com.lazy.offline.model.Role;
import com.lazy.offline.model.base.ErrorMessage;
import com.lazy.offline.model.base.ResultStatus;

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
		List<Integer> idList = roleResourceMapper.selectResourceIdByRoleId(id);
		return idList;
	}
	
	@RequestMapping(value = "/saveRoleResource/{roleId}")
	@ResponseBody
	private ErrorMessage saveRoleResource(HttpServletRequest request,@PathVariable int roleId) {
		ErrorMessage em = new ErrorMessage();
		String idString = request.getParameter("resourceIdList");
		if(StringUtils.isNotBlank(idString)){
			int deleteSuccess = roleResourceMapper.deleteRoleResourceByRoleId(roleId);
				String[] idArray = idString.split(",");
				List<String> param = new ArrayList<String>();
				for(int i=0;i<idArray.length;i++){
					param.add(idArray[i]);
				}
				int updateSuccess = roleResourceMapper.batchInsertRoleResource(roleId,param);
				if(updateSuccess>0){
					em.setErrCode(ResultStatus.SUCCESS.name());
				}else{
					em.setErrCode(ResultStatus.FAIL.name());
				}
		}else{
			int deleteSuccess = roleResourceMapper.deleteRoleResourceByRoleId(roleId);
		}
		return em;
	}
	

}
