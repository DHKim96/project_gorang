package com.kh.gorang.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	
	@RequestMapping("main")
	public String mainForm() {
		return "common/main";
	}
}