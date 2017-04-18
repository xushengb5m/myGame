package com.lazy.offline.service.impl;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;

import com.lazy.offline.constant.CacheConstant;
import com.lazy.offline.dao.mapper.RoleResourceMapper;
import com.lazy.offline.model.Resource;
import com.lazy.offline.service.InitDmpService;

@Service
public class InitDmpServiceImpl implements InitDmpService,ServletContextAware {
	
	private ServletContext sc;
	
	@Autowired
	private RoleResourceMapper roleResourceMapper;

	public void loadMenu(int roleId) {
		List<Resource> menus = new LinkedList<Resource>();
		Map<String, List<Resource>> menuMap = new HashMap<String, List<Resource>>();
		List<Resource> topMenu = new LinkedList<Resource>();
		
		//boolean needorder = false;//先不做排序
		try {
			menus = roleResourceMapper.selectResourceByRoleId(roleId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		for (Resource item : menus) {
			String key = String.valueOf(item.getTopid());
			if (!menuMap.containsKey(key)) {
				menuMap.put(key, new LinkedList<Resource>());
			}

			menuMap.get(key).add(item);

			if (item.getTopid() == 0) {
				topMenu.add(item);
			}
		}

		Collections.sort(topMenu, new Comparator<Resource>() {
			public int compare(Resource o1, Resource o2) {
				return o1.getPosorder() < o2.getPosorder() ? -1 : 1;
			}
		});

		if (menuMap.size() > 0) {
			sc.setAttribute(CacheConstant.CPSX_MENU, menuMap);
			sc.setAttribute(CacheConstant.CPSX_MENU_TOP, topMenu);
		}
	}

	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.sc = servletContext;
	}

}
