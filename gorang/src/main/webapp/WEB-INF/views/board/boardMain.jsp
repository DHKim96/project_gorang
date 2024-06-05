<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>

            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath }/resources/css/board/boardMain.css">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                crossorigin="anonymous">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>    
            <script src="${contextPath}/resources/js/board/boardMain.js"></script>
        </head>

        <body>
            <jsp:include page="../common/header.jsp" />
            <main id="board-main">
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
                                    <span>#일상</span>
                                </div>
                                <div id="PapularTags">
                                    <span>#질문</span>
                                </div>
                                <div id="PapularTags">
                                    <span>#노하우</span>
                                </div>
                                <div id="PapularTags">
                                    <span>#꿀팁</span>
                                </div>
                                <div id="PapularTags">
                                    <span>#보관법</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="BoardContents">
                        <div id="BoardSortings">
                            <div id="BoardSortingsBox">
                                <a id="SortingsLatest" href="${pageContext.request.contextPath}/main.bo">최신순</a>
                                <a id="SortingsViews" href="${pageContext.request.contextPath}/mainSortView.bo">조회수순</a>
                                <a id="SortingsScrap" href="">스크랩순</a>
                            </div>
                        </div>
                        <div class="commonContainer">
                            <c:forEach var="board" items="${list}">
                                <div class="common-item" data-board-no="${board.boardNo}">
                                    <div class="common-content-item">
                                        <div id="boardThumbnail">
                                            <img src="${pageContext.request.contextPath}/resources/uploadfile/board/boardMainContentFile/${board.boardThumbnail}" alt="썸네일">
                                        </div>
                                        <div id="commonContentInfoBox">
                                            <div id="boardTitle"><span>${board.boardTitle}</span></div>
                                            <div id="commonContentWriter">
                                                <div id="commonContentWriterImg">
                                                    <img src="<%= request.getContextPath() %>/resources/uploadfile/boardMainContentUserProfile/user1.png">
                                                </div>
                                                <span>${member.memberNo}</span>
                                            </div>
                                            <div id="commonContentBoardInfo">
                                                <div id="commonBoardInfoScrap">스크랩 <span>0</span></div>
                                                <div id="boardCount">조회수 <span>${board.boardViews}</span></div>
                                                <div id="commonBoardInfoRec">추천수 <span>${board.boardVote}</span></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="BoardPageBarBox">
                            <div id="pagingArea">
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <c:choose>
                                            <c:when test="${pi.currentPage eq 1}">
                                                <li class="page-item disabled">
                                                    <a class="page-link" href="#">Previous</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="main.bo?cpage=${pi.currentPage - 1}">Previous</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                        
                                        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                                            <li class="page-item">
                                                <a class="page-link" href="main.bo?cpage=${p}">${p}</a>
                                            </li>
                                        </c:forEach>
                        
                                        <c:choose>
                                            <c:when test="${pi.currentPage eq pi.maxPage}">
                                                <li class="page-item disabled">
                                                    <a class="page-link" href="#">Next</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="main.bo?cpage=${pi.currentPage + 1}">Next</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        

                    </div>
                </div>
                </div>
            </main>

            <jsp:include page="../common/footer.jsp" />
        </body>

        </html>