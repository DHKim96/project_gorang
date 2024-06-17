package com.kh.gorang.recipe.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kh.gorang.common.model.vo.Media;
import com.kh.gorang.common.template.SaveFileController;
import com.kh.gorang.member.model.vo.Member;
import com.kh.gorang.member.model.vo.Review;
import com.kh.gorang.recipe.model.vo.CookOrder;
import com.kh.gorang.recipe.model.vo.CookTip;
import com.kh.gorang.recipe.model.vo.Division;
import com.kh.gorang.recipe.model.vo.IngredientsInfo;
import com.kh.gorang.recipe.model.vo.Recipe;
import com.kh.gorang.recipe.model.vo.RecipeInsertDTO;
import com.kh.gorang.recipe.service.RecipeService;

@Controller
public class RecipeController {
	@Autowired
	private RecipeService recipeService;
		
	@RequestMapping("main.re")
	public String recipeMainPage(){
		return "recipe/recipeMain";
	}
	
	//레시피 상세페이지로 이동
	@RequestMapping("detailForm.re")
	public String recipDetailPage(@RequestParam("recipeNo") int recipeNo,Model model){
		System.out.println("도착" + recipeNo);
		Member m =  recipeService.selectRecipeMember(recipeNo);
		Recipe rcp = recipeService.selectRecipe(recipeNo);
		String[] tagArr = rcp.getRecipeTag().split(",");
		RecipeInsertDTO recipeInsertDTO = new RecipeInsertDTO();
		recipeInsertDTO.setRcpDivList(recipeService.selectDivList(recipeNo));
		recipeInsertDTO.setCookOrderList(recipeService.selectCookOrderList(recipeNo));
		recipeInsertDTO.setCompleteFoodPhoto(recipeService.selectCompleteFoodPhotoList(recipeNo));
		recipeInsertDTO.setRwList(recipeService.selectRecipeReviewList(recipeNo));
		System.out.println(recipeInsertDTO);
		model.addAttribute("member",m);
		model.addAttribute("rcp",rcp);
		model.addAttribute("recipeInsertDTO",recipeInsertDTO);
		model.addAttribute("tagArr",tagArr);
		return "recipe/recipeDetail";
	}
	
	
	@RequestMapping("write.re")
	public String recipWritePage(){
		return "recipe/recipeWrite";
	}
	
	@RequestMapping("list.re")
	public String recipeListPage(){
		return "recipe/recipeList";
	}
	
	@RequestMapping("insert.re")
	public String insertRecipe(Recipe rcp, RecipeInsertDTO recipeInsertDTO ,HttpSession session, Model model){
		System.out.println("\n Recipe:" +  rcp +"\n");
		System.out.println("\n"+recipeInsertDTO+"\n");
			
		int result =recipeService.insertRecipeInsertDTO(rcp, recipeInsertDTO, session);
		if(result>0) {			
			return "recipe/recipeList";
		}
		else {
			model.addAttribute("errorMsg","게시글 작성 실패");
			return "recipe/write.re";
		}
	}
	

	
	//레시피 수정창으로 이동
	@RequestMapping("updateForm.re")
	public String updateFormRecipe(@RequestParam("recipeNo") int recipeNo,Model model) {
		Recipe rcp = recipeService.selectRecipe(recipeNo);
		
		RecipeInsertDTO recipeInsertDTO = new RecipeInsertDTO();
		recipeInsertDTO.setRcpDivList(recipeService.selectDivList(recipeNo));
		recipeInsertDTO.setCookOrderList(recipeService.selectCookOrderList(recipeNo));
		recipeInsertDTO.setCompleteFoodPhoto(recipeService.selectCompleteFoodPhotoList(recipeNo));
//		
		model.addAttribute("rcp",rcp);
		model.addAttribute("recipeInsertDTO",recipeInsertDTO);
		
		return "recipe/recipeUpdate";
	}
	
	
	//레시피 수정
	@RequestMapping("update.re")
	public String updateRecipe(Recipe rcp, RecipeInsertDTO recipeInsertDTO ,HttpSession session, Model model){
		System.out.println(recipeInsertDTO);
		int deleteAllResult =recipeService.deleteAllRecipe(rcp,session);
		System.out.println("deleteAllResult:"+deleteAllResult);
		int updateAllResult =recipeService.updateRecipeInsertDTO(rcp, recipeInsertDTO, session);
		if(deleteAllResult*updateAllResult >0) {			
			return "recipe/recipeList";
		}
		else {
			model.addAttribute("errorMsg","게시글 작성 실패");
			return "recipe/write.re";
		}
	}
	
	//레시피 분류삭제
	@PostMapping("deleteDivision.re")
	@ResponseBody
	public int deleteDivision(Division division, HttpSession session) {
		System.out.println(division);
			int result =recipeService.deleteDivision(division);
			return result;
	}
	
	//레시피 재료 행 삭제
	@PostMapping("deleteIngre.re")
	@ResponseBody
	public int deleteIngre(IngredientsInfo ingredientsInfo, HttpSession session) {
		System.out.println(ingredientsInfo);
			
		int result =recipeService.deleteIngre(ingredientsInfo);			
		System.out.println("result:"+result);
		return result;
		
	}
	
	
	//레시피 조리순서 삭제
	@PostMapping("deleteCookOrder.re")
	@ResponseBody
	public int deleteCookOrder(CookOrder cookOrder, HttpSession session) {
		System.out.println(cookOrder);
		if(!cookOrder.getCookOrdContent().equals("")) {
			int result =recipeService.deleteCookOrder(cookOrder);
			return result;
		}
		else
			return 0;
	}
	
	//레시피  팁 삭제
	@PostMapping("deleteCookTip.re")
	@ResponseBody
	public int deleteCookTip(CookTip cookTip, HttpSession session) {
		System.out.println(cookTip);
		if(!cookTip.getCookTipContent().equals("")) {
			int result =recipeService.deleteCookTip(cookTip);
			return result;
		}
		else
			return 0;
	}
	
	//레피시 완성사진 삭제
	@PostMapping("deleteCompletePhoto.re")
	@ResponseBody
	public int deleteCompletePhoto(Media media, HttpSession session) {
		System.out.println(media);
		if(!media.getOriginName().equals("")) {
			int result =recipeService.deleteCompletePhoto(media);
			return result;
		}
		else
			return 0;
	}
	
	//레시피 작성 썸네일(이미지)
	@PostMapping("upload")
	@ResponseBody
	public String upload(MultipartFile recipeMainPhoto, HttpSession session) {
		System.out.println("recipeMainPhoto: "+recipeMainPhoto.getOriginalFilename());
		String changeName = SaveFileController.saveFile(recipeMainPhoto, session,"/recipe/recipemain/");		
		return new Gson().toJson(changeName);
	}
	//레시피 작성 레시피 순서(이미지)
	@PostMapping("upload2")
	@ResponseBody
	public String upload2(MultipartFile cookOrdPhoto, HttpSession session) {
		System.out.println("cookOrdPhoto: "+cookOrdPhoto.getOriginalFilename());
		String changeName = SaveFileController.saveFile(cookOrdPhoto, session,"/recipe/recipeorder/");
		return new Gson().toJson(changeName);
	}	
	//레시피 작성 레시피 순서(완성사진)
	@PostMapping("upload3")
	@ResponseBody
	public String upload3(MultipartFile completeFoodPhoto, HttpSession session) {
		System.out.println("completeFoodPhoto: "+completeFoodPhoto.getOriginalFilename());
		String changeName = SaveFileController.saveFile(completeFoodPhoto, session,"/recipe/recipefinal/");
		return new Gson().toJson(changeName);
	}
	
	
	//레시피 리뷰조회(상세 페이지)
//	@PostMapping("ajaxRecipeReview.re")
//	@ResponseBody
//	public String ajaxRecipeReview(@RequestParam("recipeNo") String recipeNo ,HttpSession session) {
//		int rcpNo = Integer.parseInt(recipeNo);
//		ArrayList<Review> reviewList = (ArrayList<Review>) recipeService.selectRecipeReviewList(rcpNo);
//		return new Gson().toJson(reviewList);
//	}
	
	
	
	
	
	
	

	//레시피 후기 작성
	@PostMapping("insertReview.re")
	@ResponseBody
//	@GetMapping(value = "insertReview.re", produces = "application/json; charset=utf-8")
	public Review ajaxrecipeReview(@RequestParam("refMemberNo") int refMemberNo,
						            @RequestParam("refRecipeNo") int refRecipeNo,
						            @RequestParam("rating") int rating,
						            @RequestParam("reviewContent") String reviewContent,
						            @RequestParam(value = "reviewPhoto", required = false) MultipartFile reviewPhoto,
						            HttpSession session) {
		Review review = new Review();
		review.setRefMemberNo(refMemberNo);
		review.setRefRecipeNo(refRecipeNo);
		review.setRating(rating);
		review.setReviewContent(reviewContent);
		System.out.println("reviewPhoto:"+reviewPhoto);
		String changeName = SaveFileController.saveFile(reviewPhoto, session, "/recipe/recipeReview/");
		review.setReviewPhoto(changeName);
		System.out.println("review: "+review);
		return recipeService.insertReview(review) > 0 ? review : null;
	}
		
	
	
}


