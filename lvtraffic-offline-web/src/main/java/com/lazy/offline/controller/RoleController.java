package com.lazy.offline.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.RoleMapper;
import com.lazy.offline.dao.mapper.RoleResourceMapper;
import com.lazy.offline.model.Role;
import com.lazy.offline.model.base.BaseQueryDto;
import com.lazy.offline.model.base.BaseResultDto;
import com.lazy.offline.model.base.ErrorMessage;
import com.lazy.offline.model.base.Pagination;
import com.lazy.offline.model.base.ResultStatus;

@Controller
@RequestMapping("system")
public class RoleController {
	
	@Autowired
	private RoleMapper roleMapper;
	
	@Autowired
	private RoleResourceMapper roleResourceMapper;
	
	@RequestMapping(value = "/toRoleList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/sys_role";
	}
	
	@RequestMapping(value = "/loadRoleData")
	@ResponseBody
	private BaseResultDto<Role> loadResourceData(Role role,Pagination pg,Model model) {
		BaseQueryDto<Role> baseQuery = new BaseQueryDto<Role>(pg,role);
		List<Role> resList = roleMapper.query(baseQuery);
		int records = roleMapper.count(baseQuery);
		pg.setRecords(records);
		pg.countRecords(records);
		BaseResultDto<Role> baseResult = new BaseResultDto<Role>(pg,resList);
		return baseResult;
	}
	
	@RequestMapping(value = "/toAddRolePage")
	private String toAddRolePage(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/sys_role_add";
	}
	
	@RequestMapping(value = "/addRoleAndResource")
	@ResponseBody
	private ErrorMessage addRoleAndResource(HttpServletRequest request,HttpServletResponse response,Role role) {
		ErrorMessage em = new ErrorMessage();
		int insertSuccess = roleMapper.insert(role);
		if(insertSuccess>0){
			int idNew = roleMapper.queryIdByRole(role);
			String idString = request.getParameter("resourceIdList");
			if(StringUtils.isNotBlank(idString)){
				String[] idArray = idString.split(",");
				List<String> param = new ArrayList<String>();
				for(int i=0;i<idArray.length;i++){
					param.add(idArray[i]);
				}
				int updateSuccess = roleResourceMapper.batchInsertRoleResource(idNew,param);
				if(updateSuccess>0){
					em.setErrCode(ResultStatus.SUCCESS.name());
				}else{
					em.setErrCode(ResultStatus.FAIL.name());
				}
			}else{
				em.setErrCode(ResultStatus.SUCCESS.name());
			}
		}
		return em;
	}
	

}
