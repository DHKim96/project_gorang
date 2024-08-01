<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <!-- css -->
            <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recipe/recipeList.css">
            <script src="${pageContext.request.contextPath}/resources/js/recipe/recipeList.js"></script>
            
            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
        </head>

        <body onload="loadSideBar()">
            <jsp:include page="../common/header.jsp" />
            <!-- 사이드바 -->
			<jsp:include page="../common/sidebar.jsp" />
            <main id="recipe-list">		
                <div id="recipeListContents">
                    <div id="BoardTagBox">
                        <div id="BoardTagBoxTop">
                            <div id="SpanBox">
                                <span>인기 태그</span>
                            </div>
                        </div>
                        <div id="BoardTagBoxBottom">
                            <div id="PapularTagBox">
                                <div class="PapularTags" data-category="all" onclick="searchToCategory(this)">
                                    <span>#전체</span>
                                </div>
                                <div class="PapularTags" data-category="한식" onclick="searchToCategory(this)">
                                    <span>#한식</span>
                                </div>
                                <div class="PapularTags" data-category="중식" onclick="searchToCategory(this)">
                                    <span>#중식</span>
                                </div>
                                <div class="PapularTags" data-category="일식" onclick="searchToCategory(this)">
                                    <span>#일식</span>
                                </div>
                                <div class="PapularTags" data-category="양식" onclick="searchToCategory(this)">
                                    <span>#양식</span>
                                </div>
                                <div class="PapularTags" data-category="디저트" onclick="searchToCategory(this)">
                                    <span>#디저트</span>
                                </div>
                                <div class="PapularTags" data-category="기타" onclick="searchToCategory(this)">
                                    <span>#기타</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="recipeCountSpan">
                        <span>총 ${recipeCount}개의 레시피</span>
                    </div>
                    <div id="recipeContents">
                        <div id="recipeSortings">
                            <div id="recipeSortingsBox">
                                <div id="recipeSortingsLatest" class="hover-cursor" onclick="location.href='${contextPath}/list.re?content=${content}&category=${category}&sort=new'">최신순</div>
                                <div id="recipeSortingsNums" class="hover-cursor" onclick="location.href='${contextPath}/list.re?content=${content}&category=${category}&sort=view'">조회수순</div>
                                <div id="recupeSortingsScrap" class="hover-cursor" onclick="location.href='${contextPath}/list.re?content=${content}&category=${category}&sort=scrap'">스크랩순</div>
                            </div>
                        </div>
                        <div id="recipeContentsBox">
                            <c:if test="${empty list}">
                                아직 레시피가 존재하지 않습니다.


                            </c:if>


                            <c:forEach var="recipe" items="${list }">
                                <div class="recipe-content-box" onclick="location.href='detailForm.re?recipeNo=${recipe.recipeNo}'">
                                    <div class="recipe-content-item">
                                        <div id="recipeContentImg">
                                            <img src="${pageContext.request.contextPath}/resources/uploadfile/recipe/recipemain/${recipe.recipeImg}">
                                        </div>
                                        <div id="recipeContentInfoBox">
                                            <div id="recipeContentTitle"><span>${recipe.recipeTitle}</span></div>
                                            <div id="recipeContentWriter">
                                                <div id="recipeContentWriterImg"><img
                                                        src="${pageContext.request.contextPath}/resources/uploadfile/memberProfile/${recipe.recipeWriterProfileImg}">
                                                </div>
                                                <span>${recipe.recipeWriterNickname}</span>
                                            </div>
                                            <div id="recipeContentBoardInfo">
                                                <div id="recipeBoardInfoScrap">스크랩
                                                    <span>${recipe.scrapCount}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="recipeBoardPageBarBox">
                            <div id="pagination-area">
                                <div id="pagination">
                    
                                    <c:choose>
                                        <c:when test="${pi.currentPage ne 1 }">
                                            <a href="list.re?content=${content}&cpage=${pi.currentPage -1 }&category=${category}&sort=${sort}">&lt;</a>
                                        </c:when>
                                    </c:choose>
                    
                                    <c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
                                        <c:choose>
                                            <c:when test="${pi.currentPage eq p}">
                                                <a href="list.re?content=${content}&cpage=${p}&category=${category}&sort=${sort}"><strong style="color:#1E90FF;">${p}</strong></a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="list.re?content=${content}&cpage=${p}&category=${category}&sort=${sort}">${p}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                    
                                    <c:choose>
                                        <c:when test="${pi.currentPage lt pi.maxPage}">
                                            <a href="list.re?content=${content}&cpage=${pi.currentPage +1 }&category=${category}&sort=${sort}">&gt;</a>
                                        </c:when>
                                    </c:choose>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </main>
            <jsp:include page="../common/footer.jsp" />
        </body>

        </html>