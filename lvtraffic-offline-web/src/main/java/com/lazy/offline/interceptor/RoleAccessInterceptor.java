package com.lazy.offline.interceptor;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lazy.offline.constant.HttpAttributeKey;
import com.lazy.offline.model.RoleAccess;
import com.lazy.offline.model.User;
import com.lazy.offline.service.impl.RoleAccessServiceImpl;


public class RoleAccessInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private RoleAccessServiceImpl roleAccessService;
	
	
	private List<String> path;
	
	/**
	 * @return the path
	 */
	public List<String> getPath() {
		return path;
	}

	/**
	 * @param path
	 *            the path to set
	 */
	public void setPath(List<String> path) {
		this.path = path;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cms.interceptors.CMSLoginInterceptor#preHandle(javax.servlet.
	 * http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object)
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		User cu = (User) request.getAttribute(HttpAttributeKey.CPSX_USER_INFO);
		if (cu != null) {
			if(cu.getRoleId()>0){
					RoleAccess ra = new RoleAccess();
					ra.setRoleId(cu.getRoleId());
					ra.setRolename(cu.getRoleName());
					ra.setAccessurl(request.getRequestURI());//设置被拦截的URL为RBACRoleAccess的URL
					if(roleAccessService.hasAccess(ra)){
						return true;
					}
				request.getRequestDispatcher("/noAccess").forward(request, response);
				return false;
			}else{
				return false;
			}
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.b5m.cms.interceptors.CMSLoginInterceptor#postHandle(javax.servlet
	 * .http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
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
	 * com.b5m.cms.interceptors.CMSLoginInterceptor#afterCompletion(javax.servlet
	 * .http.HttpServletRequest, javax.servlet.http.HttpServletResponse,
	 * java.lang.Object, java.lang.Exception)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}


}
