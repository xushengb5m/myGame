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

import com.lazy.offline.model.Resource;
import com.lazy.offline.service.IBaseCommonService;

@Controller
@RequestMapping("system")
public class ResourceController {
	
	@Autowired
	private IBaseCommonService baseCommonService;
	
	@RequestMapping(value = "/toResourceList")
	private String toResourceList(HttpServletRequest request,HttpServletResponse response) {
	
		return "system/resource";
	}
	
	@RequestMapping(value = "/loadResourceData")
	@ResponseBody
	private List<Resource> loadResourceData(HttpServletRequest request,HttpServletResponse response) {
		
		List<Object> resouces = baseCommonService.selectListAll("resourceMapper.selectResources");
		List<Resource> resources = new ArrayList<Resource>();
		
		if(resouces.size()>0){
			for(Object obj:resouces){
				Resource resource =(Resource)obj;
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

		
//		String resouceData = "[{\"id\":1,\"text\":\"My Documents\",\"children\":[{\"id\":11,\"text\":\"Photos\",\"state\":\"closed\",\"children\":[{\"id\":111,\"text\":" +
//				"\"Friend\"},{\"id\":112,\"text\":\"Wife\"},{\"id\":113,\"text\":\"Company\"}]}," +
//				"{\"id\":12,\"text\":\"Program Files\",\"children\":[{\"id\":121,\"text\":\"Intel\"},{\"id\":122,\"text\":\"Java\"," +
//				"\"attributes\":{\"p1\":\"Custom Attribute1\",\"p2\":\"Custom Attribute2\"}}," +
//				"{\"id\":123,\"text\":\"Microsoft Office\"},{\"id\":124,\"text\":\"Games\",\"checked\":true}]}," +
//						"{\"id\":13,\"text\":\"index.html\"},{\"id\":14,\"text\":\"about.html\"},{\"id\":15,\"text\":\"welcome.html\"}]}]";
		return resourcesResult;
	}

}
