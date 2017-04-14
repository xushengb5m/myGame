package com.lazy.offline.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.RoleMapper;
import com.lazy.offline.dao.mapper.SystemUserMapper;
import com.lazy.offline.model.Role;
import com.lazy.offline.model.User;
import com.lazy.offline.model.base.BaseQueryDto;
import com.lazy.offline.model.base.BaseResultDto;
import com.lazy.offline.model.base.ErrorMessage;
import com.lazy.offline.model.base.Pagination;
import com.lazy.offline.service.IBaseCommonService;

@Controller
@RequestMapping("system")
public class SysUserController {
	
	@Autowired
	private IBaseCommonService baseCommonService;
	
	@Autowired
	private SystemUserMapper systemUserMapper;
	
	@Autowired
	private RoleMapper roleMapper;
	
	@RequestMapping(value = "/toSysUserList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/sys_user";
	}
	
	@RequestMapping(value = "/loadSysUserData")
	@ResponseBody
	private BaseResultDto<User> loadResourceData(User user,Pagination pg,Model model) {
		BaseQueryDto<User> baseQuery = new BaseQueryDto<User>(pg,user);
		List<User> userList= systemUserMapper.selectSysUserListPage(baseQuery);
		BaseResultDto<User> baseResult = new BaseResultDto<User>(userList);
		return baseResult;
	}

	
	@RequestMapping(value = "/querySysUserDetail/{id}")
	public String querySysUserDetail(Model model, @PathVariable("id")int id) {
		User user= systemUserMapper.getById(id);
		List<Role> roles = roleMapper.queryAll();
		model.addAttribute("roles", roles);
		model.addAttribute("user", user);
		return "/system/sys_user_update";
	}
	
	
	@RequestMapping("/toAddSysUserPage")
	public String toAddInsurance(Model model,Pagination pg) {
		List<Role> roles = roleMapper.queryAll();
		model.addAttribute("roles", roles);
		return "/system/sys_user_add";
	}
	
	@RequestMapping(value = "addSysUser")
    @ResponseBody
	public ErrorMessage updateInsuranceDefaultRule(User user) {
		ErrorMessage em = new ErrorMessage();
		try {
			BaseQueryDto<User> baseQuery = new BaseQueryDto<User>(user);
			int userExist = systemUserMapper.selectEmailExist(user);
			if(userExist>=1){
				em.setMessage("用户邮箱已存在!");
			}else{
				int success = 0;
				int insertSuccess = systemUserMapper.insert(user);
				if(insertSuccess>0){
					int userId = systemUserMapper.selectUserIdByEmail(user);
					if(userId>0){
						user.setId(userId);
						success = (Integer)baseCommonService.insert("userRoleMapper.insertUserRole", baseQuery);
					}
				}
				
				if(success>0){
					em.setMessage("保存成功!");
				}else{
					em.setMessage("保存失败!");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return em;
	}
	
	@RequestMapping(value = "updateSysUser")
    @ResponseBody
	public ErrorMessage updateSysUser(User user) {
		ErrorMessage em = new ErrorMessage();
		int success = systemUserMapper.updateById(user.getId(), user);
		if(success>0){
			em.setMessage("保存成功!");
		}else{
			em.setMessage("保存失败!");
		}
	    return em;
	}
	
}
