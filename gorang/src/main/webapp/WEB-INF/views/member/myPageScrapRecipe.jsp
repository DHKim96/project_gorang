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
    <link rel="stylesheet" href="${contextPath }/resources/css/member/myPageScrapRecipe.css">
    <!--js-->
<script src="${pageContext.request.contextPath}/resources/js/member/myPageScrap/myPageScrapRecipe.js"></script>
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
                    <span>스크랩 > 레시피</span>
                    <span id="scrap-recipe-count">(${scrapRecipeList.size() })</span>
                </div>
                <div id="delete-area">
                    <div id="delete-edit" onclick="editBtn()">편집</div>           
                    <div id="delete-like" onclick="deleteBtn()">삭제</div>
                </div>
                
            
                <div id="scrap-area-content">
                	<c:choose>
                		<c:when test="${empty scrapRecipeList }">
                			스크랩한 레시피가 없습니다.
                		</c:when>
                		<c:otherwise>
                			<c:forEach var="recipe" items="${scrapRecipeList }">
								<div class="scrap-content">
		                            <div class="scrap-img" data-no="${recipe.recipeNo}" onclick="movePage(this)">
		                                <img src="${contextPath}/resources/uploadfile/recipe/recipemain/${recipe.recipeMainImg}" alt="">
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