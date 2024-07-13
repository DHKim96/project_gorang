package com.kh.gorang.oauth;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.gorang.common.OauthTemplate;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MemberService;

@Controller
@PropertySource("classpath:application.properties")
public class LoginController {
	
	@Autowired
	private MemberService memberService;
	
	//naver
	@Value("${naver.clientId}")
	private String naverClientId;
	
	@Value("${naver.clientSecret}")
	private String naverClientSecret;
	
	@RequestMapping("/naver-login")
	public String naverLoginCallback(HttpServletRequest request) {
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		try {
			String redirectURI = URLEncoder.encode("http://localhost:8111/gorang/naver-login", "UTF-8");
			String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
			apiURL += "&client_id=" + naverClientId;
			apiURL += "&client_secret=" + naverClientSecret;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			
			//HTTP요청에 대한 응답코드 확인
			int responseCode = con.getResponseCode();
			
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			
			//응답데이터를 읽어온다.
			String inputLine;
			StringBuffer res = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			
			if (responseCode == 200) {
				//정상적으로 정보를 받아왔을 때 result에 정보를 저장
				String result = res.toString();
	//			System.out.println(result);
				
				JsonObject totalObj = JsonParser.parseString(result).getAsJsonObject();
	//			System.out.println(totalObj.get("access_token"));
				
				String token = totalObj.get("access_token").getAsString(); //정보접근을 위한 토큰
				String header = "Bearer " + token;
				
				apiURL = "https://openapi.naver.com/v1/nid/me";
				Map<String, String> requestHeaders = new HashMap<String, String>();
				requestHeaders.put("Authorization", header);
				
				String responseBody = OauthTemplate.get(apiURL, requestHeaders);
				
				JsonObject memberInfo = JsonParser.parseString(responseBody).getAsJsonObject();
				JsonObject resObj = memberInfo.getAsJsonObject("response");
				
				//받아온 email과 데이터베이스의 email을 비교하여 가입유무 확인 후
				//가입되어있다면 로그인, 아니라면 회원가입창으로 정보를 가지고 이동
				
				String email = resObj.get("email").getAsString();
				
				Member loginUser = memberService.selectMemberByEmail(email);
				
				if(loginUser == null) { // 기존 회원 아닐 시
					request.setAttribute("alertMsg", "기존 회원이 아니므로 회원가입을 진행해야 합니다.");
					// 네이버로부터 받아 온 정보를 회원가입 페이지에 넘김
					// JsonObject 중 email, mobile, birthyear, birthday, gender, profile_image 정보를 넘기기
					request.setAttribute("email", resObj.get("email").getAsString());
                    request.setAttribute("mobile", resObj.get("mobile").getAsString());
                    request.setAttribute("birthyear", resObj.get("birthyear").getAsString());
                    request.setAttribute("birthday", resObj.get("birthday").getAsString());
                    request.setAttribute("gender", resObj.get("gender").getAsString());
                    request.setAttribute("profile_image", resObj.get("profile_image").getAsString());
                    
                    return "member/registerPage";
                    
				} else {
					// 로그인 실시
					request.getSession().setAttribute("loginUser", loginUser);
					return "redirect:/";
				}
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		} return "member/loginPage";
	}
	
	
	//google
	@Value("${google.clientId}")
	private String googleClientId;
	
	@Value("${google.clientSecret}")
	private String googleClientSecret;
	
	@RequestMapping("/google-login")
	public String googleLoginCallback(HttpServletRequest request) {
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		try {
			String redirectURI = URLEncoder.encode("http://localhost:8111/gorang/google-login", "UTF-8");
			String apiURL = "https://oauth2.googleapis.com/token?grant_type=authorization_code";
			// POST 파라미터 설정
	        String postParams = "grant_type=authorization_code"
	                + "&client_id=" + googleClientId
	                + "&client_secret=" + googleClientSecret
	                + "&redirect_uri=" + redirectURI
	                + "&code=" + code
	                + "&state=" + state;

	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("POST");
	        con.setDoOutput(true);
	        
	        // Content-Length 헤더 설정
	        byte[] postDataBytes = postParams.getBytes("UTF-8");
	        con.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
	        
	        // POST 데이터 전송
	        con.getOutputStream().write(postDataBytes);
	        
			//HTTP요청에 대한 응답코드 확인
			int responseCode = con.getResponseCode();
						
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			
			//응답데이터를 읽어온다.
			String inputLine;
			StringBuffer res = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			
			if (responseCode == 200) {
				//정상적으로 정보를 받아왔을 때 result에 정보를 저장
				String result = res.toString();
				System.out.println(result);
				
				JsonObject totalObj = JsonParser.parseString(result).getAsJsonObject();
				
				String token = totalObj.get("access_token").getAsString(); //정보접근을 위한 토큰
				String header = "Bearer " + token;
				
				apiURL = "https://oauth2.googleapis.com/tokeninfo";
				Map<String, String> requestHeaders = new HashMap<String, String>();
				requestHeaders.put("Authorization", header);
				
				System.out.println(requestHeaders);
				
				String responseBody = OauthTemplate.get(apiURL, requestHeaders);
				
				System.out.println(responseBody);
	
				JsonObject resObj = JsonParser.parseString(responseBody).getAsJsonObject();
				
				System.out.println(resObj);
				//받아온 email과 데이터베이스의 email을 비교하여 가입유무 확인 후
				//가입되어있다면 로그인, 아니라면 회원가입창으로 정보를 가지고 이동
				
				
				String email = resObj.get("email").getAsString();
				
				Member loginUser = memberService.selectMemberByEmail(email);
				
				if(loginUser == null) { // 기존 회원 아닐 시
					request.setAttribute("alertMsg", "기존 회원이 아니므로 회원가입을 진행해야 합니다.");
					request.setAttribute("email", resObj.get("email").getAsString());
                    
                    return "member/registerPage";
                    
				} else {
					// 로그인 실시
					request.getSession().setAttribute("loginUser", loginUser);
					return "redirect:/";
				}
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		} return "member/loginPage";
	}
	
	
	//kakao
	@Value("${kakao.clientId}")
	private String kakaoClientId;
	
	@Value("${kakao.clientSecret}")
	private String kakaoClientSecret;
	
	@RequestMapping("/kakao-login")
	public String kakaoLoginCallback(HttpServletRequest request) {
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		try {
			String redirectURI = URLEncoder.encode("http://localhost:8111/gorang/kakao-login", "UTF-8");
			String apiURL = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code";
			apiURL += "&client_id=" + kakaoClientId;
			apiURL += "&client_secret=" + kakaoClientSecret;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			
			//HTTP요청에 대한 응답코드 확인
			int responseCode = con.getResponseCode();
			
			System.out.println(responseCode);
			
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			
			//응답데이터를 읽어온다.
			String inputLine;
			StringBuffer res = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			
			if (responseCode == 200) {
				//정상적으로 정보를 받아왔을 때 result에 정보를 저장
				String result = res.toString();
				System.out.println(result);
				
				JsonObject totalObj = JsonParser.parseString(result).getAsJsonObject();
				
				String token = totalObj.get("access_token").getAsString(); //정보접근을 위한 토큰
				String header = "Bearer " + token;
				
				apiURL = "https://kapi.kakao.com/v2/user/me";
				Map<String, String> requestHeaders = new HashMap<String, String>();
				requestHeaders.put("Authorization", header);
				
				String responseBody = OauthTemplate.get(apiURL, requestHeaders);
				
				JsonObject memberInfo = JsonParser.parseString(responseBody).getAsJsonObject();
				
				JsonObject resObj = memberInfo.getAsJsonObject("kakao_account");
				
				JsonObject profileInfo = resObj.getAsJsonObject("profile");
								
				
				//받아온 email과 데이터베이스의 email을 비교하여 가입유무 확인 후
				//가입되어있다면 로그인, 아니라면 회원가입창으로 정보를 가지고 이동
				
				
				String email = resObj.get("email").getAsString();
				
				Member loginUser = memberService.selectMemberByEmail(email);
				
				if(loginUser == null) { // 기존 회원 아닐 시
					request.setAttribute("alertMsg", "기존 회원이 아니므로 회원가입을 진행해야 합니다.");
					// 네이버로부터 받아 온 정보를 회원가입 페이지에 넘김
					// JsonObject 중 email, profile_image 정보를 넘기기
					request.setAttribute("email", resObj.get("email").getAsString());
                    request.setAttribute("profile_image", profileInfo.get("profile_image_url").getAsString());
                    
                    return "member/registerPage";
                    
				} else {
					// 로그인 실시
					request.getSession().setAttribute("loginUser", loginUser);
					return "redirect:/";
				}
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		} return "member/loginPage";
	}
}
