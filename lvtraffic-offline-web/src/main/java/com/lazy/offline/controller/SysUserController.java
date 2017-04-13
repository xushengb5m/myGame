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
	
	@RequestMapping(value = "/toSysUserList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/sys_user";
	}
	
	@RequestMapping(value = "/loadSysUserData")
	@ResponseBody
	private BaseResultDto<Object> loadResourceData(User user,Pagination pg,Model model) {
		BaseQueryDto<Object> baseQuery = new BaseQueryDto<Object>(pg,user);
		List<Object> userList= baseCommonService.selectList("systemUserMapper.selectSysUserListPage",baseQuery);
		BaseResultDto<Object> baseResult = new BaseResultDto<Object>(userList);
		
		return baseResult;
	}

	
	@RequestMapping(value = "/querySysUserDetail/{id}")
	public String querySysUserDetail(Model model, @PathVariable("id")Long id) {
		BaseQueryDto<Long> baseQuery = new BaseQueryDto<Long>(id);
		User user= (User)baseCommonService.selectOne("systemUserMapper.selectSysUserDetail",baseQuery);
		List<Object> roles = baseCommonService.selectListAll("roleMapper.selectRoles");
		model.addAttribute("roles", roles);
		model.addAttribute("user", user);
		return "/system/sys_user_update";
	}
	
	
	@RequestMapping("/toAddSysUserPage")
	public String toAddInsurance(Model model,Pagination pg) {
		List<Object> roles = baseCommonService.selectListAll("roleMapper.selectRoles");
		model.addAttribute("roles", roles);
		return "/system/sys_user_add";
	}
	
	@RequestMapping(value = "addSysUser")
    @ResponseBody
	public ErrorMessage updateInsuranceDefaultRule(User user) {
		ErrorMessage em = new ErrorMessage();
		try {
			BaseQueryDto<User> baseQuery = new BaseQueryDto<User>(user);
			int userExist = (Integer) baseCommonService.selectOne("systemUserMapper.selectEmailExist",baseQuery);
			if(userExist>=1){
				em.setMessage("用户邮箱已存在!");
			}else{
				int success = 0;
				int insertSuccess = (Integer) baseCommonService.insert("systemUserMapper.insertOneUser", baseQuery);
				if(insertSuccess>0){
					int userId = (Integer) baseCommonService.selectOne("cpsxUserMapper.selectUserIdByEmail", baseQuery);
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
		int success = (int) baseCommonService.update("systemUserMapper.updateOneUser", user);
		if(success>0){
			em.setMessage("保存成功!");
		}else{
			em.setMessage("保存失败!");
		}
	    return em;
	}
	
}
