package com.kh.gorang.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.gorang.board.model.vo.Board;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.service.MyPageService;
import com.kh.gorang.recipe.model.vo.Recipe;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MyPageController {
	
	private final MyPageService myPageService;

	//마이페이지 메인
	@RequestMapping("main.me")
	public String myPageViewAll(HttpSession session, Model model){
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		int memberNo = loginUser.getMemberNo();
		
		// 팔로잉 수
		int followingCount = myPageService.getFollowingCount(memberNo);
		
		// 팔로워 수
		int followerCount = myPageService.getFollowerCount(memberNo);
		
		// 총 스크랩 수
		int totalScrapCount = myPageService.getTotalScrapCount(memberNo);
		
		// 총 좋아요 개수
		int totalLikeCount = myPageService.getTotalLikeCount(memberNo);
		
		// 내 레시피 중 조회수 많은 순으로 레시피 리스트 가져오기
		ArrayList<Recipe> mostViewRecipeList = myPageService.getMostViewRecipeList(memberNo);
		
		// 내 게시글 중 조회수 많은 순으로 게시글 리스트 가져오기
		ArrayList<Board> mostViewBoardList = myPageService.getMostViewBoardList(memberNo);
		
		// 스크랩한 내용물들 리스트
		ArrayList<Object> scrapContentList = myPageService.getScrapList(memberNo);
				
		// 좋아요한 내용물들 리스트
		ArrayList<Object> likeContentList = myPageService.getLikeContentList(memberNo);

		
		log.info("likeContentList={}",likeContentList);
		
		
		model.addAttribute("followingCount", followingCount);
		model.addAttribute("followerCount", followerCount);
		model.addAttribute("totalScrapCount", totalScrapCount);
		model.addAttribute("totalLikeCount", totalLikeCount);
		model.addAttribute("mostViewRecipeList", mostViewRecipeList);
		model.addAttribute("mostViewBoardList", mostViewBoardList);
		model.addAttribute("scrapContentList", scrapContentList);
		model.addAttribute("likeContentList", likeContentList);
		
		
		return "member/myPageAllView";
	}
	
	//마이페이지 레시피게시판
	@RequestMapping("recipe.me")
	public String myRecipeBoard(){
		return "member/myRecipeBoard";
	}
	
	//마이페이지 자유게시판
	@RequestMapping("board.me")
	public String myBoard(){
		return "member/myPageBoard";
	}

	//마이페이지 나의냉장고
	@RequestMapping("myRefrigerator.me")
	public String myRefrigerator(){
		return "member/myRefrigerator";
	}
	
	//내 정보 수정
	@RequestMapping("edit.me")
	public String myPageInfoEdit(){
		return "member/myPageInfoEdit";
	}
	
	//구매내역
	@RequestMapping("buyList.me")
	public String myPageBuyList(){
		return "member/myPageBuyList";
	}
	
	//마이 페이지 질의응답
	@RequestMapping("qna.me")
	public String myPageQnAView(){
		return "member/myPageQnA";
	}
	
	//마이 페이지 리뷰
	@RequestMapping("review.me")
	public String myPageReplyReviewView(){
		return "member/myPageReplyReview";
	}
	
	//비밀번호 체크
	@RequestMapping("checkPwd.me")
	public String myPageCheckPwd(){
		return "member/myPageCheckPwd";
	}
	
	//좋아요
	@RequestMapping("likeRecipe.me")
	public String myPageLikeRecipe(){
		return "member/myPageLikeRecipe";
	}
	@RequestMapping("likeBoard.me")
	public String myPageLikeBoard(){
		return "member/myPageLikeBoard";
	}
	
	@RequestMapping("loginForm.me")
	public String login(){
		return "member/loginPage";
	}
	
	@RequestMapping("register.me")
	public String storeMainForm() {
		return "member/registerPage";
	}
	
	@RequestMapping("scrapBoard.me")
	public String myPageScrapBoard(){
		return "member/myPageScrapBoard";
	}
	
	@RequestMapping("scrapProduct.me")
	public String myPageScrapProduct(){
		return "member/myPageScrapProduct";
	}
	
	@RequestMapping("scrapRecipe.me")
	public String myPageScrapRecipe(){
		return "member/myPageScrapRecipe";
	}
	
	
}