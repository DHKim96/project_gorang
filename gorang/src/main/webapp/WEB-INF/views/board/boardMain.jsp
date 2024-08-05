<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath }/resources/css/board/boardMain.css">
            
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>    
            <script src="${contextPath}/resources/js/board/boardMain.js"></script>
        </head>

        <body>
            <jsp:include page="../common/header.jsp" />

            <c:if test="${not empty alertMsg }">
                <script>
                    alert("${alertMsg }");
                </script>
                <c:remove var="alertMsg" scope="session"/>
            </c:if>

            <main id="board-main" class="scale-container display-flex-column-center">
                <div id="CommonBoardContents">
                    <div id="BoardTagBox">
                        <div id="BoardTagBoxTop">
                            <div class="SpanBox">
                                <span>인기 태그</span>
                            </div>
                        </div>
                        <div id="BoardTagBoxBottom">
                            <div id="PapularTagBox">
                                <div id="PapularTags">
                                    <a id="TagDaily" href="${pageContext.request.contextPath}/main.bo?category=all">#전체</a>
                                </div>
                                <div id="PapularTags">
                                    <a id="TagDaily" href="${pageContext.request.contextPath}/main.bo?category=일상">#일상</a>
                                </div>
                                <div id="PapularTags">
                                    <a id="TagQuestion" href="${pageContext.request.contextPath}/main.bo?category=질문">#질문</a>
                                </div>
                                <div id="PapularTags">
                                    <a id="TagKnowHow" href="${pageContext.request.contextPath}/main.bo?category=노하우">#노하우</a>
                                </div>
                                <div id="PapularTags">
                                    <a id="TagTip" href="${pageContext.request.contextPath}/main.bo?category=꿀팁">#꿀팁</a>
                                </div>
                                <div id="PapularTags">
                                    <a id="TagMethod" href="${pageContext.request.contextPath}/main.bo?category=보관법">#보관법</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="BoardContents">
                        <div id="BoardSortings">
                            <div id="BoardSortingsBox">
                                <a id="SortingsLatest" href="${pageContext.request.contextPath}/main.bo?category=${category}&sort=latest">최신순</a>
                                <a id="SortingsViews" href="${pageContext.request.contextPath}/main.bo?category=${category}&sort=view">조회수순</a>
                                <a id="SortingsScrap" href="${pageContext.request.contextPath}/main.bo?category=${category}&sort=scrap">스크랩순</a>
                            </div>
                        </div>
                        <div class="commonContainer">
                            <c:forEach var="board" items="${boardList}">
                                <div class="common-item" data-board-no="${board.boardNo}">
                                    <div class="common-content-item">
                                        <div id="boardThumbnail">
                                            <img src="${pageContext.request.contextPath}/resources/uploadfile/board/boardMainContentFile/${board.boardThumbnail}" alt="썸네일">
                                        </div>
                                        <div id="commonContentInfoBox">
                                            <div id="boardTitle"><span>${board.boardTitle}</span></div>
                                            <div id="commonContentWriter">
                                                <div id="commonContentWriterImg">
                                                    <img src="<%= request.getContextPath() %>/resources/uploadfile/memberProfile/${board.boardWriterProfileImg}">
                                                </div>
                                                <span>${board.boardWriterNickname}</span>
                                            </div>
                                            <div id="commonContentBoardInfo">
                                                <div id="commonBoardInfoScrap">스크랩 <span>${board.scrapCount}</span></div>
                                                <div id="boardCount">조회수 <span>${board.viewCount}</span></div>
                                                <div id="commonBoardInfoRec">추천수 <span>${board.likeCount}</span></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="BoardPageBarBox">
                            <div id="pagingArea">
                                <div id="pagination">

                                    <c:choose>
                                        <c:when test="${pi.currentPage ne 1 }">
                                            <a href="main.bo?content=${content}&cpage=${pi.currentPage -1 }&category=${category}&sort=${sort}">&lt;</a>
                                        </c:when>
                                    </c:choose>
                    
                                    <c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
                                        <c:choose>
                                            <c:when test="${pi.currentPage eq p}">
                                                <a href="main.bo?content=${content}&cpage=${p}&category=${category}&sort=${sort}"><strong style="color:#1E90FF;">${p}</strong></a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="main.bo?content=${content}&cpage=${p}&category=${category}&sort=${sort}">${p}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                    
                                    <c:choose>
                                        <c:when test="${pi.currentPage lt pi.maxPage}">
                                            <a href="main.bo?content=${content}&cpage=${pi.currentPage +1 }&category=${category}&sort=${sort}">&gt;</a>
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