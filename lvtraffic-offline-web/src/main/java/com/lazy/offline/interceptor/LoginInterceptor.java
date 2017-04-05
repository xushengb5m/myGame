package com.lazy.offline.interceptor;


import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lazy.offline.constant.CacheConstant;
import com.lazy.offline.constant.CookieKeyConstant;
import com.lazy.offline.model.User;
import com.lazy.offline.service.cache.CacheMapService;
import com.lazy.offline.utils.WebCookieComponent;


/**
 * @author janwen Apr 16, 2013 10:04:41 AM
 * 
 */
public class LoginInterceptor extends HandlerInterceptorAdapter implements ServletContextAware {
	
	
	private ServletContext sc;
	
	@Autowired
	private CacheMapService cacheMapService;


	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cpc.interceptors.CPCBaseInterceptor#preHandle(javax.servlet.http
	 * .HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
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
		response.getWriter().write(
				"<script>top.location='" + request.getContextPath()
						+ "/searchUserLogin';</script>");
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cpc.interceptors.CPCBaseInterceptor#postHandle(javax.servlet.
	 * http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, org.springframework.web.servlet.ModelAndView)
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cpc.interceptors.CPCBaseInterceptor#afterCompletion(javax.servlet
	 * .http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, java.lang.Exception)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	public void setServletContext(ServletContext servletContext) {
		this.sc = servletContext;
	}

}
