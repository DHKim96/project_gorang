<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

	<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
	<link rel="stylesheet" href="${contextPath }/resources/css/member/myPageReplyReview.css">
	<script src="${pageContext.request.contextPath}/resources/js/member/myPageReplyReview.js"></script>

</head>

<body>

	<%@ include file="../common/header.jsp" %>


		<div id="body-area">
			<!-- 왼쪽 프로필 메뉴바영역 -->
			<jsp:include page="myPageMenubar.jsp" />
			<!-- 우측 메인영역 -->
			<div id="right-body-area">
				<!-- 나의 댓글 영역 -->
				<div id="reply-container">
					<div class="container-top">
						<span class="container-top-title">나의 댓글</span>
						<!-- <span class="container-top-more"><a href="">더보기</a></span> -->
					</div>
					<div id="reply-area" class="content-area">
						<div id="reply-area-top">
							<div class="content-area-title cl-6d">게시글</div>
							<div class="content-area-comment cl-6d">내용</div>
							<div class="content-area-date cl-6d">작성일</div>
						</div>

						<div id="reply-area-body" class="contents-area-body">
							<c:choose>
								<c:when test="${empty boardCommentList }">
									댓글이 없습니다.
								</c:when>
								<c:otherwise>
									<c:forEach var="comment" items="${boardCommentList }">
										<div class="contents-area-content" data-type="board-comment" data-boardNo="${comment.boardNo }"
											onclick="moveDetailPage(this)">
											<div class="content-area-title">
												<img class="content-img"
													src="${contextPath }/resources/uploadfile/board/boardMainContentFile/${comment.boardThumbnail}"
													alt="">
											</div>
											<div class="content-area-comment">${comment.commentContent }</div>
											<div class="content-area-date">${comment.commentDate }</div>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<!-- 페이징 바 -->
					<div class="pagination-area">
						<div id="pagination">
							<c:choose>
								<c:when test="${commentPI.currentPage ne 1 }">
									<a href="review.me?comment_cpage=${commentPI.currentPage -1 }">&lt;</a>
								</c:when>
							</c:choose>

							<c:forEach var="p" begin="${commentPI.startPage }" end="${commentPI.endPage }">
								<c:choose>
									<c:when test="${commentPI.currentPage eq p}">
										<a href="review.me?comment_cpage=${p}"><strong style="color:#1e90ff">${p}</strong></a>
									</c:when>
								</c:choose>
							</c:forEach>

							<c:choose>
								<c:when test="${commentPI.currentPage lt commentPI.maxPage}">
									<a href="review.me?comment_cpage=${commentPI.currentPage +1 }">&gt;</a>
								</c:when>
							</c:choose>
						</div>
					</div>
				</div>
				<!-- 나의 후기 영역 -->
				<div id="review-container">
					<div class="container-top">
						<span class="container-top-title">나의 후기</span>
						<!-- <span class="container-top-more"><a href="">더보기</a></span> -->
					</div>

					<div id="reply-area" class="content-area">
						<div id="reply-area-top">
							<div class="content-area-title cl-6d">게시글</div>
							<div class="content-area-comment cl-6d">내용</div>
							<div class="content-area-date cl-6d">작성일</div>
						</div>

						<div id="reply-area-body" class="contents-area-body">
							<c:choose>
								<c:when test="${empty reviewList}">
									후기가 없습니다.
								</c:when>
								<c:otherwise>
									<c:forEach var="review" items="${reviewList }">
										<c:if test="${review.reviewType eq 1}">
											<div class="contents-area-content" data-type="product-review"
												data-productNo="${review.refContentNo}" onclick="moveDetailPage(this)">
												<div class="content-area-title">
													<img class="content-img"
														src="${contextPath }/resources/uploadfile/product/productimg/${review.contentImg}"
														alt="">
												</div>
												<div class="content-area-comment">${review.reviewContent }</div>
												<div class="content-area-date">${review.reviewCreateDate }</div>
											</div>
										</c:if>
										<c:if test="${review.reviewType eq 2}">
											<div class="contents-area-content" data-type="recipe-review" data-recipeNo="${review.refContentNo}"
												onclick="moveDetailPage(this)">
												<div class="content-area-title">
													<img class="content-img"
														src="${contextPath }/resources/uploadfile/recipe/recipemain/${review.contentImg}"
														alt="">
												</div>
												<div class="content-area-comment">${review.reviewContent }</div>
												<div class="content-area-date">${review.reviewCreateDate }</div>
											</div>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>

					</div>
					<!-- 페이징 바 -->
					<div class="pagination-area">
						<div id="pagination">
							<c:choose>
								<c:when test="${reviewPI.currentPage ne 1 }">
									<a href="review.me?review_cpage=${reviewPI.currentPage -1 }">&lt;</a>
								</c:when>
							</c:choose>

							<c:forEach var="p" begin="${reviewPI.startPage }" end="${reviewPI.endPage }">
								<c:choose>
									<c:when test="${reviewPI.currentPage eq p}">
										<a href="review.me?review_cpage=${p}"><strong style="color: #1e90ff">${p}</strong></a>
									</c:when>
									<c:otherwise>
										<a href="review.me?review_cpage=${p}">${p}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<c:choose>
								<c:when test="${reviewPI.currentPage lt reviewPI.maxPage }">
									<a href="review.me?review_cpage=${reviewPI.currentPage +1 }">&gt;</a>
								</c:when>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../common/footer.jsp" %>
</body>

</html>