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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lazy.offline.dao.mapper.ResourceMapper;
import com.lazy.offline.model.Resource;
import com.lazy.offline.model.base.ErrorMessage;
import com.lazy.offline.model.base.ResultStatus;

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
		
		return resourcesResult;
	}
	
	@RequestMapping(value = "/addResource")
	@ResponseBody
	private ErrorMessage toResourceList(Resource resource) {
		ErrorMessage msg = new ErrorMessage();
		int isSuccess = resourceMapper.insert(resource);
		if(isSuccess>0){
			msg.setErrCode(ResultStatus.SUCCESS.name());
		}else{
			msg.setErrCode(ResultStatus.FAIL.name());
		}
		return msg;
	}
	
	@RequestMapping(value = "/editResource/{id}")
	@ResponseBody
	private ErrorMessage editResource(Resource resource,@PathVariable("id")int id) {
		ErrorMessage msg = new ErrorMessage();
		int isSuccess = resourceMapper.updateById(id, resource);
		if(isSuccess>0){
			msg.setErrCode(ResultStatus.SUCCESS.name());
		}else{
			msg.setErrCode(ResultStatus.FAIL.name());
		}
		return msg;
	}
	
	@RequestMapping(value = "/deleteResource/{id}")
	@ResponseBody
	private ErrorMessage deleteResource(@PathVariable("id")int id) {
		ErrorMessage msg = new ErrorMessage();
		int isHasChildren = resourceMapper.selectHasChildren(id);
		if(isHasChildren==0){
			int isSuccess = resourceMapper.deleteById(id);
			if(isSuccess>0){
				msg.setErrCode(ResultStatus.SUCCESS.name());
			}else{
				msg.setErrCode(ResultStatus.FAIL.name());
			}
		}else{
			msg.setErrCode(ResultStatus.FAIL.name());
			msg.setMessage("该节点仍存在子节点!");
		}
		return msg;
	}
	

	
	
}
