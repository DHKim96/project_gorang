<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

	<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
	<link rel="stylesheet" href="${contextPath }/resources/css/common/searchResultPage.css">

    <script src="${pageContext.request.contextPath}/resources/js/common/searchResultPage.js"></script>

</head>

<body>
	<jsp:include page="../common/header.jsp" />
	<main id="search-result">
		<div id="searchResultContents">
			<div id="search-item-result">
				<c:choose>
					<c:when test="${content eq '*'}">
						<div id="search-item"><span>모든</span></div><span>&nbsp;검색결과</span>
					</c:when>
					<c:otherwise>
						<div id="search-item"><span>${content }</span></div><span>의 검색결과</span>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="search-item-shopping">
				<div class="search-item-top">
					<div id="search-item-shopping-span"><span>쇼핑</span>
						<div id="shoppingCount"><span>${searchProductResult.size() }</span>개</div>
					</div>
					<div id="see-more-btn">
						<c:if test="${searchProductResult.size() gt 5}">
							<input type="button" value="더보기" onclick="location.href='list.po?content=${content}'">
						</c:if>
					</div>
				</div>
				<div class="product-container">
					<c:choose>
						<c:when test="${empty searchProductResult }">
							검색 결과가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="product" items="${searchProductResult }" varStatus="status">
								<c:if test="${status.index < 5}">
									<div class="item" data-no="${product.productNo}" data-type="product" onclick="moveDetailPage(this)">
										<div class="item-thumbnail-area">
											<img class="item-thumbnail"
												src="${contextPath }/resources/uploadfile/product/productimg/${product.productImg}" alt="상품">
										</div>
										<div class="item-text-area">
											<div class="item-title">
												<div class="item-brand">${product.productBrand }</div>
												<div class="item-name">${product.productName }</div>
											</div>
											<div class="item-price">
												<span class="item-origin-price">${product.normalPrice }</span><span class="origin-won">원</span>
												<div>
													<span class="discount-percent">${product.discount }%</span>
													<span class="discounted-price">${product.salePrice }</span><span>원</span>
												</div>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>


			<div id="search-item-recipe">
				<div class="search-item-top">
					<div id="search-item-recipe-span"><span>레시피</span>
						<div id="recipeCount"><span>${searchRecipeResult.size() }</span>개</div>
					</div>
					<div id="see-more-btn">
						<c:if test="${searchRecipeResult.size() gt 8}">
							<input type="button" value="더보기" onclick="location.href='list.re?content=${content}'">
						</c:if>
					</div>
				</div>
				<div class="recipeContainer">
					<c:choose>
						<c:when test="${empty searchRecipeResult }">
							검색 결과가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="recipe" items="${searchRecipeResult }" varStatus="status">
								<c:if test="${status.index < 8}">
									<div class="recipe-item" data-no="${recipe.recipeNo}" data-type="recipe" onclick="moveDetailPage(this)">
										<div class="recipe-content-item">
											<div class="recipeContentImg">
												<img
													src="<%= request.getContextPath() %>/resources/uploadfile/recipe/recipemain/${recipe.recipeImg}">
											</div>
											<div class="recipeContentInfoBox">
												<div class="recipeContentTitle"><span>${recipe.recipeTitle }</span></div>
												<div class="recipeContentWriter">
													<div class="recipeContentWriterImg">
														<img
															src="<%= request.getContextPath() %>/resources/uploadfile/memberProfile/${recipe.recipeWriterProfileImg}">
													</div>
													<span>${recipe.recipeWriter }</span>
												</div>
												<div class="recipeContentBoardInfo">
													<div class="recipeBoardInfoScrap">스크랩 <span>${recipe.scrapCount }</span></div>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div id="search-item-common">
				<div class="search-item-top">
					<div id="search-item-common-span"><span>게시글</span>
						<div id="commonCount"><span>${searchBoardResult.size() }</span>개</div>
					</div>
					<div id="see-more-btn">
						<c:if test="${searchBoardResult.size() gt 8 }">
							<input type="button" value="더보기" onclick="location.href='main.bo?content=${content}'">
						</c:if>

					</div>
				</div>
				<div class="commonContainer">
					<c:choose>
						<c:when test="${empty searchBoardResult }">
							검색결과가 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="board" items="${searchBoardResult }" varStatus="status">
								<c:if test="${status.index < 8}">
									<div class="common-item" data-no="${board.boardNo}" data-type="board" onclick="moveDetailPage(this)">
										<div class="common-content-item">
											<div class="commonContentImg">
												<img
													src="<%= request.getContextPath() %>/resources/uploadfile/board/boardMainContentFile/${board.boardThumbnail}">
											</div>
											<div class="commonContentInfoBox">
												<div class="commonContentTitle"><span>${board.boardTitle }</span></div>
												<div class="commonContentWriter">
													<div class="commonContentWriterImg"><img
															src="<%= request.getContextPath() %>/resources/uploadfile/memberProfile/${board.memberProfileImg}">
													</div>
													<span>${board.memberNickname }</span>
												</div>
												<div class="commonContentBoardInfo">
													<div class="commonBoardInfoScrap">스크랩 <span>${board.scrapCount }</span></div>
													<div class="commonBoardInfoView">조회수
														<span>${board.viewCount }</span>
													</div>
													<div class="commonBoardInfoRec">추천수
														<span>${board.likeCount }</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>

</html>