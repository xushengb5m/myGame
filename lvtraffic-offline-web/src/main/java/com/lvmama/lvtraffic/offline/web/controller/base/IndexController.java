package com.lvmama.lvtraffic.offline.web.controller.base;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class IndexController {
	
	@RequestMapping("index")
	public String toIndex(){
		
		return "index";
	}
}
