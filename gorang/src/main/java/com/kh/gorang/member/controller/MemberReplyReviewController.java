package com.kh.gorang.member.controller;

//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberReplyReviewController {
	
	@RequestMapping("myPageReplyReview.me")
	public String myPageReplyReviewView(){
		return "member/myPageReplyReview";
	}
	
}


