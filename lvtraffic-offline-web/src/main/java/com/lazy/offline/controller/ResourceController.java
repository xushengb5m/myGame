package com.lazy.offline.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.ResourceMapper;
import com.lazy.offline.model.Resource;

@Controller
@RequestMapping("system")
public class ResourceController {
	
	@Autowired
	private ResourceMapper resourceMapper;
	
	@RequestMapping(value = "/toResourceList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/resource";
	}
	
	@RequestMapping(value = "/loadResourceData")
	@ResponseBody
	private List<Resource> loadResourceData(HttpServletRequest request,HttpServletResponse response) {
		
		List<Resource> resList = resourceMapper.queryAll();
		List<Resource> resources = new ArrayList<Resource>();
		
		if(resList.size()>0){
			for(Resource resource:resList){
				resource.setText(resource.getResourceName()); //填充树形结构的资源名称
				resources.add(resource);
			}
		}
		List<Resource> resourcesResult = new ArrayList<Resource>();
		Map<Integer, Resource> resourceIdMap = new HashMap<Integer, Resource>();
		for (Resource dmpResource : resources) {
			resourceIdMap.put(dmpResource.getId(), dmpResource);
		}

		for (Resource dmpResource : resources) {
			Integer parentId = dmpResource.getTopid();
			if (resourceIdMap.containsKey(parentId)) {
				Resource temp = resourceIdMap.get(parentId);
				temp.getChildren().add(dmpResource);
			} else {
				resourcesResult.add(dmpResource);
			}
		}
		String selectedResourceIds = request
				.getParameter("selectedResourceIds");
		if (StringUtils.isNotBlank(selectedResourceIds)) {
			selectedResourceIds = selectedResourceIds.trim();
			String[] resourceIdArray = selectedResourceIds.split(",");
			for (Resource resource : resourcesResult) {
				List<Resource> children = resource.getChildren();
				if (children.size() > 0) {
					for (Resource child : children) {
						Long id = Long.valueOf(child.getId());
						for (String resourceid : resourceIdArray) {
							if (id.equals(Long.valueOf(resourceid))) {
								resource.setDefinedState(true);
								resource.setState("open");
							}
						}
					}
				}
			}
		}
		
		return resourcesResult;
	}

}
