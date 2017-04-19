package com.lazy.offline.controller;

import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.constant.CacheConstant;
import com.lazy.offline.constant.CookieKeyConstant;
import com.lazy.offline.dao.mapper.SystemUserMapper;
import com.lazy.offline.model.User;
import com.lazy.offline.service.cache.CacheMapService;
import com.lazy.offline.service.impl.InitDmpServiceImpl;
import com.lazy.offline.utils.CPCDigestUtils;
import com.lazy.offline.utils.WebCookieComponent;


@Controller
@RequestMapping("")
public class LoginController {
	
	@Autowired
	private CacheMapService cacheMapService;
	
	@Autowired
	private SystemUserMapper systemUserMapper;
	
	@Autowired
	private InitDmpServiceImpl initDmpService;
	
	protected Logger logger = Logger.getLogger(LoginController.class);
	
	
	@RequestMapping(value = "/searchUserLogin")
	private String checkLogin(HttpServletRequest request,HttpServletResponse response) {
		boolean isLogin = getLoginUser(request,response);
		if(isLogin){
			return "index";
		}else{
			return "user_login";
		}
	}
	
	public boolean getLoginUser(HttpServletRequest request,
			HttpServletResponse response) {
		Cookie cookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER, request);
		if (cookie != null && StringUtils.isNotBlank(cookie.getValue())) {
			Object userObject = cacheMapService.getCache(CacheConstant.USER_PREFIX + cookie.getValue());
			if (userObject != null && userObject instanceof User) {
				User user = (User) userObject;
				String last_login_cookie = (String)cacheMapService.getCache(CacheConstant.USER_PREFIX + user.getId());
				if (StringUtils.isNotBlank(last_login_cookie)
						&& StringUtils.equalsIgnoreCase(last_login_cookie,cookie.getValue())) {
					return true;
				}
			}
		}
		return false;
	}
	
	@RequestMapping("/userLogin")
	@ResponseBody
	private String checkInfo(HttpServletRequest request,HttpServletResponse response, Model model, User loginUser) {
				String msg = "fail";
				try {
					if (loginUser != null) {
						if (StringUtils.isBlank(loginUser.getUserName()) || StringUtils.isBlank(loginUser.getPassword()) ) {
							msg="输入信息有误！";
						} else {
								User sysUser = systemUserMapper.selectOneUser(loginUser);
								if (sysUser != null) {
									sysUser.rolesHandling();
									Cookie loginUserCookie = WebCookieComponent.createCookie(CookieKeyConstant.CPSX_LOGIN_USER,
											CPCDigestUtils.getMD5Hex(UUID.randomUUID().toString()),-1);
									response.addCookie(loginUserCookie);

									// 向缓存放入用户对象
									cacheMapService.putCache(CacheConstant.USER_PREFIX+loginUserCookie.getValue(), sysUser);

									// 向缓存放入安全密匙码
									cacheMapService.putCache(CacheConstant.USER_PREFIX+sysUser.getId(),loginUserCookie.getValue());
									
									initDmpService.loadMenu(sysUser.getRoleId());

									model.addAttribute("loginUser", sysUser);
									// 加载可用菜单
//								initService.loadMenu(sysUser.getRoleIds());
									msg = "success";
								} else {
									msg = "用户名密码错误";
								}
						}
					}else{
						msg="重新登录";
					}
				} catch (Exception e) {
					logger.error("登录异常", e);
				}
				return msg;
	}
	
	@RequestMapping(value = "/userLogout")
	private String userLogout(HttpServletRequest request,HttpServletResponse response) {
		Cookie cookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER, request);
		if (cookie != null && StringUtils.isNotBlank(cookie.getValue())) {
			Object userObject = cacheMapService.getCache(CacheConstant.USER_PREFIX + cookie.getValue());
			if (userObject != null && userObject instanceof User) {
				User user = (User) userObject;
				cacheMapService.removeCache(CacheConstant.USER_PREFIX + user.getId());
			}
			cacheMapService.removeCache(CacheConstant.USER_PREFIX + cookie.getValue());
		}
		return "user_login";
	}
	
	
	@RequestMapping("/home")
	public String index(HttpServletRequest request, HttpServletResponse response) {
			return "index";
	}

}
