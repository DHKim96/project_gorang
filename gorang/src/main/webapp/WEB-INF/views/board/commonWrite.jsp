<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath }/resources/css/board/commonWrite.css">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
            <!-- 서머노트를 위해 추가해야할 부분 -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="${pageContext.request.contextPath}/resources/summernote/customsummernote.js"></script>
            <script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/customsummernote.css">

            <script src="${contextPath}/resources/js/board/commonWrite.js"></script>
        </head>

        <body>
            <c:if test="${not empty errorMsg}">
                <div class="error">${errorMsg}</div>
            </c:if>
            
            <form action="insert.bo" method="post" enctype="multipart/form-data"> 
                <input type="hidden" name="memberNo" value="${loginUser.memberNo}">
                <main id="common-write">
                    <div id="write-top">
                        <div>
                            <button type="button" class="write-btn" id="back-btn" onclick="turnMainPage()">메인으로</button>
                        </div>

                        <div id="writeBtnSection">
                            <div id="tempStorageBtn">
                                <button type="button" class="write-btn" id="saveContentBtn" >임시저장</button>
                                <!-- <input type="button" value="임시저장" id="saveContentBtn"> -->
                            </div>
                            <div id="writeSubmitBtn">
                                <button type="submit" class="write-btn" id="enroll-btn">등록하기</button>
                                <!-- <input type="submit" value="등록하기"> -->
                            </div>
                        </div>
                    </div>
                    <div id="write-container">
                        <div id="writeTitleSection">
                            <div id="selectCategory">
                                <select name="boardTag" id="boardTag">
                                    <option selected disabled hidden>카테고리</option>
                                    <option value="#일상" selected>#일상</option>
                                    <option value="#질문">#질문</option>
                                    <option value="#노하우">#노하우</option>
                                    <option value="#꿀팁">#꿀팁</option>
                                    <option value="#보관법">#보관법</option>
                                </select>
                            </div>
                            <div id="writeTitle">
                                <input type="text" placeholder="제목을 입력해주세요." id="boardTitle" name="boardTitle" maxlength="100">
                            </div>
                        </div>
                        <div id="writeUploadThumbnail">
                            <div id="uploadThumbnailSection">
                                <div id="thumbnail-container">
                                    <div id="uploadThumbnailSpan">
                                        <span>대표이미지를 업로드 해주세요.</span>
                                    </div>
                                    <div id="uploadThumbSizeSpan">
                                        <span>*권장 사이즈</span><br>
                                        <span>모바일: 1920 x 1920, 최소 1400 x 1400(1:1 비율)</span><br>
                                        <span>PC: 1920 x 1080, 최소 1400 x 787(16:9
                                            비율)</span>
                                    </div>
                                </div>
                                
                                <div id="uploadThumbBtn">
                                    <button type="button" class="boardThumbnail-button" onclick="fileInputClick()">
                                        대표이미지 넣기
                                    </button>
                                    <input type="file" id="file-input" accept="image/*" name="upfile" onchange="displaySelectedImg(event)">                                    
                                </div>
                            </div>
                        </div>
                        <textarea class="summernote" name="boardContent" id="boardContent"></textarea>
                    </div>
                </main>
            </form>
            <jsp:include page="../common/footer.jsp" />
        </body>

        </html>