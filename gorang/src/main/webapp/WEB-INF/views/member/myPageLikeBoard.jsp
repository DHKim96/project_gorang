<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<link rel="stylesheet" href="${contextPath }/resources/css/member/myPageLikeBoard.css">
<!--js-->
<script src="${pageContext.request.contextPath}/resources/js/member/myPageLike/myPageLikeBoard.js"></script>
</head>
<body>
    <%@ include file="../common/header.jsp"%>
    <div id="body-area">
        <!-- 왼쪽 프로필 메뉴바영역 -->
        <jsp:include page="myPageMenubar.jsp" />

        <!-- 우측 메인영역 -->
        <div id="right-body-area">
            <div id="scrap-area">
                <div id="scrap-area-top">
                    <span>좋아요 > 게시글</span>
                    <span>(${likeBoardList.size() })</span>
                </div>

                <div id="delete-area">
                    <div id="delete-edit" onclick="editBtn()">편집</div>           
                    <div id="delete-like" onclick="deleteBtn()">삭제</div>
                </div>
                
            
                <div id="scrap-area-content">
					<c:choose>
						<c:when test="${empty likeBoardList }">
							좋아요를 누른 게시글이 없습니다.
						</c:when>
						<c:otherwise>
							<c:forEach var="board" items="${likeBoardList }">
								<div class="scrap-content">
			                        <div class="scrap-img" data-no="${board.boardNo }" onclick="moveDetailPage(this)">
			                            <img src="${contextPath}/resources/uploadfile/board/boardMainContentFile/${board.boardThumbnail}" alt="">
			                        </div>
			                        <div class="scrap-checkbox">
			                            <input type="checkbox" name="" id="delete-check" class="delete-check">
			                        </div>
			                    </div>
							</c:forEach>    
						</c:otherwise>					
					</c:choose>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../common/footer.jsp"%>
</body>
</html>