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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.gorang.common.OauthTemplate;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MemberService;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/naver-login")
	public String naverLoginCallback(HttpServletRequest request) {
		String clientId = "6D1ucwJgv10DLouX8avE";
		String clientSecret = "Bw7JtBzO4p";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		
		
		try {
			String redirectURI = URLEncoder.encode("http://localhost:8111/gorang/naver-login", "UTF-8");
			String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
			apiURL += "&client_id=" + clientId;
			apiURL += "&client_secret=" + clientSecret;
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
				
				System.out.println(resObj);
				//받아온 email과 데이터베이스의 email을 비교하여 가입유무 확인 후
				//가입되어있다면 로그인, 아니라면 회원가입창으로 정보를 가지고 이동
				
				
				String email = resObj.get("email").getAsString();
				
				Member loginUser = memberService.selectMemberByEmail(email);
				
				System.out.println(loginUser.toString());
				
				if(loginUser == null) { // 기존 회원 아닐 시
					// 네이버로부터 받아 온 정보를 회원가입 페이지에 넘김
//					{"id":"clZCIAwJUXyNrAaoiCFdfR21zbADrawS_eXS8y_iIyY","nickname":"옐로우피자땡긴다","profile_image":"https://phinf.pstatic.net/contact/20220116_170/16423399742620U7zU_JPEG/c0d0d928380213c0f71cf7fa4d16b561.jpg","age":"20-29","gender":"M","email":"dkansk4801@naver.com","mobile":"010-5374-8549","mobile_e164":"+821053748549","name":"김동현","birthday":"02-07","birthyear":"1996"}
					// JsonObject 중 email, mobile, birthyear, birthday, gender, profile_image 정보를 넘기기
					request.setAttribute("email", resObj.get("email").getAsString());
                    request.setAttribute("mobile", resObj.get("mobile").getAsString());
                    request.setAttribute("birthyear", resObj.get("birthyear").getAsString());
                    request.setAttribute("birthday", resObj.get("birthday").getAsString());
                    request.setAttribute("gender", resObj.get("gender").getAsString());
                    request.setAttribute("profile_image", resObj.get("profile_image").getAsString());
                    return "member/loginPage";
                    
				} else {
					// 로그인 실시
					request.getSession().setAttribute("loginUser", loginUser);
					return "redirect:/";
				}
		}
		
		} catch (Exception e) {
			e.printStackTrace();
		} return "loginPage";
	}
}
