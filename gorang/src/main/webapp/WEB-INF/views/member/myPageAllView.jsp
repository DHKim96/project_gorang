<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/default.css">
<link rel="stylesheet"
	href="${contextPath }/resources/css/member/MyPage-View.css">
<script src="${contextPath}/resources/js/member/myPageAllView.js"></script>
</head>
<body>

	<jsp:include page="../common/header.jsp" />


	<div id="body-area">
		<!-- 좌측 마이페이지 영역 -->
		<jsp:include page="myPageMenubar.jsp" />
		<!-- 우측 메인영역 -->
		<div id="right-body-area">
			<div id="right-body-banner">

				<!-- 버튼 영역(레시피/게시판) -->
				<div id="banner-btn-area">
					<button id="recipe-btn" class="cl-btn" onclick="recipeImg()">레시피</button>
					<button id="board-btn" class="cl-btn" onclick="BoardImg()">게시판</button>
				</div>

				<!-- 배너 게시판 인기 이미지영역 -->
				<div id="banner-imgs">
					<c:choose>
						<c:when test="${empty resultBoardList  }">
							데이터가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="board" items="${resultBoardList }" varStatus="status">
								<c:if test="${status.index < 3 }">
									<div class="banner-best-img" data-type="board" data-no="${board.boardNo }" onclick="moveDetailPage(this)">
										<img src="${contextPath}/resources/uploadfile/board/boardMainContentFile/${board.boardThumbnail}">
									</div>	
								</c:if>						
							</c:forEach>
						</c:otherwise>
					</c:choose>		
				</div>

				<!-- 배너 레시피 인기 이미지영역 -->
				<div id="banner-imgs-recipe">
					<c:choose>
						<c:when test="${empty mostViewRecipeList}">
							데이터가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="recipe" items="${mostViewRecipeList }" varStatus="status">
								<c:if test="${status.index < 3 }">
									<div class="banner-best-img" data-type="recipe" data-no="${recipe.recipeNo }" onclick="moveDetailPage(this)">
										<img src="${contextPath}/resources/uploadfile/recipe/recipemain/${recipe.recipeMainPhoto}">
									</div>
								</c:if>
								
							</c:forEach>						
						</c:otherwise>				
					</c:choose>
				</div>

				<!-- 게시글 사진 더보기 영역(4개) -->
				<div class="best-board-four">
					<div class="best-board-text">
						<span class="best-title"><b>게시글</b></span> <span class="more-vw"><a href="${contextPath}/recipe.me">더보기</a></span>
					</div>
					<div class="best-board-img">
						<c:choose>
							<c:when test="${empty resultBoardList }">	
								데이터가 없습니다.	
							</c:when>
							<c:otherwise>
								<c:forEach var="board" items="${resultBoardList }" varStatus="status">
									<c:if test="${status.index < 4 }">
										<div class="best-img" data-type="board" data-no="${board.boardNo }" onclick="moveDetailPage(this)">
											<img src="${contextPath}/resources/uploadfile/board/boardMainContentFile/${board.boardThumbnail}">
										</div>
									</c:if>								
								</c:forEach>	
							</c:otherwise>
						</c:choose>
						
					</div>
				</div>

				<!-- 스크랩 사진 더보기 영역(4개) -->
				<div class="best-board-four">
					<div class="best-board-text">
						<span class="best-title"><b>스크랩</b></span> <span class="more-vw"><a href="${contextPath}/scrapBoard.me">더보기</a></span>
					</div>
					<div class="best-board-img">
						<c:choose>
							<c:when test="${empty processedScrapList }">
								데이터가 없습니다.
							</c:when>
							<c:otherwise>
								<c:forEach var="scrapMap" items="${processedScrapList }" varStatus="status">
									<c:if test="${status.index < 4 }">
										<c:choose>
											<c:when test="${scrapMap.type == 'Board'}">
												<div class="best-img" data-type="board" data-no="${scrapMap.object.boardNo}" onclick="moveDetailPage(this)">
													<img src="${contextPath}/resources/uploadfile/board/boardMainContentFile/${scrapMap.object.boardThumbnail}">
												</div>
											</c:when>
											<c:when test="${scrapMap.type == 'Recipe'}">
												<div class="best-img" data-type="recipe" data-no="${scrapMap.object.recipeNo}" onclick="moveDetailPage(this)">
													<img src="${contextPath}/resources/uploadfile/recipe/recipemain/${scrapMap.object.recipeMainPhoto}">
												</div>
											</c:when>
											<c:when test="${scrapMap.type == 'Product'}">
												<div class="best-img" data-type="product" data-no="${scrapMap.object.productNo}" onclick="moveDetailPage(this)">
													<img src="${contextPath}/resources/uploadfile/product/productimg/${scrapMap.object.mainImg}">
												</div>
											</c:when>
										</c:choose>	
									</c:if>									
								</c:forEach>	
							</c:otherwise>					
						</c:choose>	
					</div>
				</div>

				<!-- 좋아요 사진 더보기 영역(4개) -->
				<div class="best-board-four">
					<div class="best-board-text">
						<span class="best-title"><b>좋아요</b></span> <span class="more-vw"><a href="${contextPath}/likeRecipe.me">더보기</a></span>
					</div>
					<div class="best-board-img">
						<c:choose>
							<c:when test="${empty processedLikedList }">
								데이터가 없습니다.
							</c:when>
							<c:otherwise>
								<c:forEach var="likedMap" items="${processedLikedList }" varStatus="status">
									<c:if test="${status.index < 4 }">
										<c:choose>
											<c:when test="${likedMap.type == 'Board'}">
												<div class="best-img" data-type="board" data-no="${likedMap.object.boardNo}" onclick="moveDetailPage(this)">
													<img src="${contextPath}/resources/uploadfile/board/boardMainContentFile/${likedMap.object.boardThumbnail}">
												</div>
											</c:when>
											<c:when test="${likedMap.type == 'Recipe'}">
												<div class="best-img" data-type="recipe" data-no="${likedMap.object.recipeNo}" onclick="moveDetailPage(this)">
													<img src="${contextPath}/resources/uploadfile/recipe/recipemain/${likedMap.object.recipeMainPhoto}">
												</div>
											</c:when>
										</c:choose>
									</c:if>	
								</c:forEach>
							</c:otherwise>					
						</c:choose>
						
					</div>
				</div>
                
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>