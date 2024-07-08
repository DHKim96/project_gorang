package com.kh.gorang.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.gorang.member.model.dto.NotifyDto;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MemberService;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Value("${coolsms.clientId}")
	private String apiKey;
	@Value("${coolsms.clientSecret}")
	private String apiSecret;
	@Value("${admin.phone}")
	private String adminPhone;
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, ModelAndView mv, HttpSession session) {	
		
		Member loginUser = memberService.loginMember(m);
	
		// 아이디가 없는 경우
		if (loginUser == null) { 
			session.setAttribute("alertMsg", "아이디가 일치하지 않습니다.");
			mv.setViewName("member/loginPage");
			
			//비밀번호가 다른경우
		} else if (!bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())){ 
			session.setAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			mv.setViewName("member/loginPage");
			
		} else { // 성공
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");
		}
		
		return mv;
	}
	
	// 로그아웃
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session){
		//로그아웃 -> session에서 loginUser 삭제, 만료
		//session.invalidate();
		session.removeAttribute("loginUser");
		
		return "redirect:/";
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping("idCheck.me")
	public String idCheck(String checkId) {
		return memberService.idCheck(checkId) > 0 ? "NNNNN" : "NNNNY";
	}
	
	// 닉네임 중복 체크
	@ResponseBody
	@RequestMapping("nameCheck.me")
	public String nameCheck(String checkName) {
		return memberService.nameCheck(checkName) > 0 ? "NNNNN" : "NNNNY";
	}
	

	//회원 정보 저장
	@RequestMapping("insert.me")
	public String insertMember(Member m, HttpSession session, Model model) {
		//암호화작업
		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
		
		m.setMemberPwd(encPwd);
		
		int result = memberService.insertMember(m);
		
		if (result > 0) {
			session.setAttribute("alertMsg", "성공적으로 회원가입이 완료되었습니다.");
			return "redirect:/";
		} else {
			session.setAttribute("alertMsg", "회원가입이 실패하였습니다.");
			return "member/register.me";
		}
	}
	
	// 핸드폰 중복 체크
	@ResponseBody
	@RequestMapping("checkPhoneNum.me")
	public String phoneCheck(String phone) {
		return memberService.phoneCheck(phone) > 0 ? "NNNNY" : "NNNNN";
	}
	
	
	@ResponseBody
	@RequestMapping("authPhone.me")
	public String authorizationPhone(String authNo, String phone) {
		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.coolsms.co.kr");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
		Message message = new Message();
		message.setFrom(adminPhone); //계정에서 등록한 발신번호 입력
		message.setTo(phone);
		message.setText("고랭GORANG 인증번호는 [" + authNo + "] 입니다.");
		String str = "";
		try {
			messageService.send(message);
			str = "success";
		} catch (NurigoMessageNotReceivedException exception) {
			  // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
			  System.out.println(exception.getFailedMessageList());
			  System.out.println(exception.getMessage());
			  str = "fail";
			} catch (Exception exception) {
			  System.out.println(exception.getMessage());
			  str = "fail";
			}
		return str;
	}
	
	@ResponseBody
	@PostMapping("insertNotifyByAjax.me")
	public String insertNotification(NotifyDto notificationData) {
		System.out.println(notificationData);
		return memberService.insertNotification(notificationData) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="getAlarmsByAjax.me", produces = "application/json; charset=utf8" ) 
	public ArrayList<NotifyDto> getAlarmsByAjax(int memberNo) {
		System.out.println(memberNo);
		return memberService.selectNotificationsByMemberNo(memberNo);
	}
}


