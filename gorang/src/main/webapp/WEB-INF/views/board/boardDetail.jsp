<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>


            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath }/resources/css/board/boardDetail.css">
            <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>
            <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
            <script src="${contextPath}/resources/js/board/boardDetail.js"></script>
        </head>

        <body>
            <jsp:include page="../common/header.jsp" />
            <c:if test="${not empty msg }">
                <script>
                    alert("${msg }");
                </script>
                <c:remove var="msg" scope="session"/>
            </c:if>
            
            <main id="board-detail">
                <div id="boardDetailContents">
                    <div id="writerProfile">
                        <div id="profileImg"><img src="${contextPath}/resources/uploadfile/memberProfile/${board.memberThumbnail}"></div>
                        <div id="profileInfo">
                            <div id="profileId"><span>${board.memberNickname}</span></div>
                            <div id="boardCount">
                                <div id="viewCount">조회수<span>${board.boardViews}</span></div>
                                <div id="likeCount">좋아요<span>${board.boardVote}</span></div>
                            </div>
                            <div id="uploadDate"><span>${board.boardCreateDate}</span></div>
                        </div>
                    </div>
                    <div id="contentTitle" data-boardNo="${board.boardNo}">
                        <span id="board-title">${board.boardTitle}</span>
                    </div>
                    <div id="contentDetail">
                    	<div id="contentDetailImg">
                            <img src="${pageContext.request.contextPath}/resources/uploadfile/board/boardMainContentFile/${board.boardThumbnail}"
                                alt="썸네일">
                        </div>
                        <div id="contentDetailWrite"><span>${board.boardContent}</span></div>
                        
                    </div>
                    <div id="contentService">
                        <div id="tagWrapper">
                            <div id="contentTag"><span>${board.boardTag}</span></div>
                        </div>
                        <div id="contentBtnWrapper">

                            <div id="scrap-div"data-userNo="${loginUser.memberNo}">
                                <c:if test="${isScrapBoard == 0}">
                                    <i class="fa-regular fa-bookmark"></i>
                                </c:if>
                                <c:if test="${isScrapBoard == 1}">
                                    <i class="fa-solid fa-bookmark" style="color: #1e90ff;"></i>
                                </c:if>
                                
                                <span style="margin-left: 10px;">${scrapBoardCount}</span>
                            </div>


                            <button id="contentLike" data-userNo="${loginUser.memberNo}">
                                <c:if test="${isLikedBoard == 0}">
                                    <i class="fa-regular fa-heart"></i>
                                </c:if>
                                <c:if test="${isLikedBoard == 1}">
                                    <i class="fa-solid fa-heart" style="color: #d00101;"></i>
                                </c:if>
                                <span>${likeBoardCount}</span>
                            </button>
                            <button id="contentReport" data-userNo="${loginUser.memberNo}">
                                <svg xmlns="http://www.w3.org/2000/svg" data-userNo="${loginUser.memberNo}" width="30" height="30" fill="none"
                                    viewBox="0 0 24 24" stroke-width="1" stroke="currentColor" class="w-6 h-6">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M12 9v3.75m0-10.036A11.959 11.959 0 0 1 3.598 6 11.99 11.99 0 0 0 3 9.75c0 5.592 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.57-.598-3.75h-.152c-3.196 0-6.1-1.25-8.25-3.286Zm0 13.036h.008v.008H12v-.008Z" />
                                </svg>
                                <span data-userNo="${loginUser.memberNo}">신고하기</span>
                            </button>
                            <!-- The Modal -->
                            <div id="myModal" class="modal">
                                <div class="modal-content" style="width: fit-content; height: fit-content;">
                                    <span class="close">&times;</span>
                                    <br>
                                    <p>게시글 신고하기</p>
                                    <div class="modal-content-top">
                                        <span>신고 게시글</span>
                                        <br>
                                        <input type="text" class="contentTitleInput" id="report-board-title" placeholder="게시글 제목" readonly>
                                    </div>
                                    <div class="modal-content-body">
                                        <span>신고 사유</span>
                                        <br>
                                        <div class="reportReasonSelectBox">
                                            <div class="reason-div">
                                                <input type="checkbox" id="spam" class="reason" onclick="checkSelectedOneOption(event)">
                                                <label for="spam">스팸/홍보 도배 게시글입니다.</label><br>
                                            </div>
                                            <div class="reason-div"><input type="checkbox" id="19" class="reason" onclick="checkSelectedOneOption(event)">
                                                <label for="19">음란물입니다.</label><br>
                                            </div>
                                            <div class="reason-div">
                                                <input type="checkbox" id="illegal" class="reason" onclick="checkSelectedOneOption(event)">
                                                <label for="illegal">불법 정보를 포함하고 있습니다.</label><br>
                                            </div>

                                            <div class="reason-div"><input type="checkbox" id="teen" class="reason" onclick="checkSelectedOneOption(event)">
                                                <label for="teen">청소년에 유해한 내용을 포함하고 있습니다.</label><br>
                                            </div>
                                            <div class="reason-div"><input type="checkbox" id="blame" class="reason" onclick="checkSelectedOneOption(event)">
                                                <label for="blame">욕설/혐오/차별적 표현을 포함하고 있습니다.</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-content-bottom">
                                        <span>상세 내용</span>
                                        <br>
                                        <input type="text" class="contentReasonDetail" id="report-content" placeholder="상세 내용을 입력해주세요">
                                    </div>
                                    <div class="modal-content-reportBtn">
                                        <button type="button" id="modal-reportBtn">신고하기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="replyCountWrap">
                        <div id="replyCount-area">댓글
                            <span id="reply-count">(${commentList.size()})</span>
                        </div>
                    </div>
                    <div id="board-reply-form" class="board-reply-input">
                        <div id="replyWriteWrap">
                            <div id="replyWriterInfo">
                            	<c:if test="${not empty loginUser }">
                            		<img
                                    src="<%= request.getContextPath() %>/resources/uploadfile/memberProfile/${loginUser.profile}">
                            	</c:if>
                            </div>
                            <c:choose>
                                <c:when test="${empty loginUser}">
                                    <textarea class="reply-input" rows="3" placeholder="로그인 후 이용 가능합니다." disabled
                                        style="background-color: transparent;"></textarea>
                                    <button class="reply-button hover-curser" disabled>댓글 쓰기</button>
                                </c:when>
                                <c:otherwise>
                                    <textarea class="reply-textarea" id="commentContent" rows="3" placeholder="댓글 내용을 적어주세요." name="commentContent" maxlength="500"></textarea>
                                    <button class="reply-button" type="button" id="board-reply-button">댓글 쓰기</button>
                                </c:otherwise>
                            </c:choose> 
                        </div>
                    </div>
                    <div id="ReplyArea">
                    </div>
                </div>
                <div id="boardMainReturnWrap">
                    <c:if test="${board.memberNo eq loginUser.memberNo}">
                        <div id="update-btn-area">
                            <button type="button"
                            onclick="moveLocation('${pageContext.request.contextPath}/update-form.bo?boardNo=${board.boardNo}')">수정하기</button>
                        </div>
                    </c:if>

                    <div id="ReturnBtnWrap">
                        <button type="button"
                            onclick="moveLocation('${pageContext.request.contextPath}/main.bo')">목록으로</button>
                    </div>

                    <c:if test="${board.memberNo eq loginUser.memberNo}">
                        <div id="delete-btn-area">
                            <button type="button" id="board-delete-btn">삭제하기</button>
                        </div>
                    </c:if>
                </div>
            </main>
            <jsp:include page="../common/footer.jsp" />
        </body>

        </html>