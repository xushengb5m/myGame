package com.play.lazy.offline.web.controller;

import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.play.lazy.offline.web.constant.CacheConstant;
import com.play.lazy.offline.web.constant.CookieKeyConstant;
import com.play.lazy.offline.web.model.User;
import com.play.lazy.offline.web.service.cache.CacheMapService;
import com.play.lazy.offline.web.utils.CPCDigestUtils;
import com.play.lazy.offline.web.utils.WebCookieComponent;


@Controller
@RequestMapping("cpsx")
public class LoginController {
	
	@Autowired
	private CacheMapService cacheMapService;
	
	@RequestMapping(value = "/toLogin")
	private ModelAndView checkLogin(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		mav.setViewName("redirect:/cpsx/login");
		Cookie cookie = WebCookieComponent.getCookie(CookieKeyConstant.CPSX_LOGIN_USER, request);
		if (cookie != null && StringUtils.isNotBlank(cookie.getValue())) {
			Object userObject = cacheMapService.getCache(CacheConstant.USER_PREFIX + cookie.getValue());
			if (userObject != null && userObject instanceof User) {
				User user = (User) userObject;
				String last_login_cookie = (String)cacheMapService.getCache(CacheConstant.USER_PREFIX + user.getId());
				if (StringUtils.isNotBlank(last_login_cookie)
						&& StringUtils.equalsIgnoreCase(last_login_cookie,cookie.getValue())) {
					mav.setViewName("redirect:/index");
				}
			}
		}
		return mav;
	}
	
	@RequestMapping("/checkUserLogin")
	private String checkInfo(HttpServletRequest request,HttpServletResponse response, Model model, User loginUser) {
		String msg = "fail";
		try {
				if (loginUser != null) {
					if (loginUser.getPassword() == null || loginUser.getEmail() == null) {
						msg="输入信息有误！";
					} else {
							User sysUser = new User();
							sysUser.setId(110);
							sysUser.setUserName("阿帕奇");
							if (sysUser != null) {
								sysUser.rolesHandling();
								Cookie loginUserCookie = WebCookieComponent.createCookie(CookieKeyConstant.CPSX_LOGIN_USER,
										CPCDigestUtils.getMD5Hex(UUID.randomUUID().toString()),-1);
								response.addCookie(loginUserCookie);

								// 向缓存放入用户对象
								cacheMapService.putCache(CacheConstant.USER_PREFIX+loginUserCookie.getValue(), sysUser);

								// 向缓存放入安全密匙码
								cacheMapService.putCache(CacheConstant.USER_PREFIX+sysUser.getId(),loginUserCookie.getValue());

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
			Map<String, Object> asMap = model.asMap();
			asMap.clear();
			msg = "登录异常";
		}
		return msg;
	}
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request, HttpServletResponse response) {
			return "index";
	}

}
