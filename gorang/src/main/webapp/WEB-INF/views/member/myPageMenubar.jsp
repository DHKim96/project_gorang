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
<link rel="stylesheet" href="${contextPath}/resources/css/member/myPageMenubar.css">

<script src="${contextPath}/resources/js/member/myPageMenubar.js"></script>

</head>
<body>
     <!-- 왼쪽 프로필 메뉴바영역 -->
     <div id="left-body-area">
        <div id ="user-info">
            <div id="user-profile-area">
                <div id="user-profile">
                    <img src="${contextPath}/resources/uploadfile/memberProfile/${loginUser.profile}" alt="화원 프로필">
                </div>
                <!-- <div id="user-profile-pencil">
                    <img src="${contextPath}/resources/images/member-img/Icon_Edit.png" alt="프로필 사진 버튼">
                </div> -->
            </div>
            <div id="user-nickgrade-area">
                <div>${loginUser.nickname }
                </div>
                <br>
                <div id="user-follow">
                    <div id="user-follower-area">팔로워 <span id="user-follower">${followerCount }</span></div> | 
                    <div id="user-following-area">팔로잉 <span id="user-following">${followingCount }</span></div>
                </div>
                <div id="user-grade">
                	${loginUser.grade }등급
                </div>
            </div>
            <div id="user-profile-area-line">
                <hr>  
            </div>
            <div id="user-profile-area-bottom">
                <div id="user-scrap">
                    <span class="user-scrap-like" data-type="scrap" onclick="movePage(this)">스크랩</span><br><div class="zero" id="user-scrap-count">${totalScrapCount }</div> 
                </div> 
                <div id="user-like">
                    <span class="user-scrap-like" data-type="like" onclick="movePage(this)">좋아요</span><br><div class="zero" id="user-like-count">${totalLikeCount }</div>
                </div>
                <!-- <div id="user-alarm">
                    <a href="">알림</a><br><div class="zero">0</div>
                </div> -->
            </div>
        </div>
        <div id="user-menu">
            <ul id="left-user-menu-list">
                <li><a href="${contextPath}/main.me">모두 보기</a></li>
                <li style="font-size: 18px;  font-weight: bold;" id="myboard">나의 게시글
                   <ul id="myboard-list">
                        <li><a  href="${contextPath}/recipe.me" class="myboard-list-in">나의 레시피 게시글</a></li>
                        <li><a  href="${contextPath}/board.me" class="myboard-list-in">나의 자유 게시글</a></li>
                    </ul>
                </li>
                <li><a  href="${contextPath}/review.me">댓글 & 후기</a></li>
                <li><a  href="${contextPath}/qna.me">문의</a></li>
                <li><a  href="${contextPath}/myRefrigerator.me">나의 냉장고</a></li>
                <li><a  href="${contextPath}/buyList.me">구매내역</a></li>
                <li style="font-size: 18px;  font-weight: bold;" id="user-scrap">스크랩
                    <ul id="myscrap-list">
                        <li><a  href="${contextPath}/scrapRecipe.me" class="myboard-list-in">레시피</a></li>
                        <li><a  href="${contextPath}/scrapBoard.me" class="myboard-list-in">게시글</a></li>
                        <li><a  href="${contextPath}/scrapProduct.me" class="myboard-list-in">상품</a></li>
                    </ul>
                </li>
                <li style="font-size: 18px;  font-weight: bold;" id="user-like">좋아요
                    <ul id="mylike-list">
                        <li><a  href="${contextPath}/likeRecipe.me" class="myboard-list-in">레시피</a></li>
                        <li><a  href="${contextPath}/likeBoard.me" class="myboard-list-in">게시글</a></li>
                    </ul>
                </li>
                <li><a  href="${contextPath}/edit.me">정보 수정</a></li>
            </ul>
        </div>
    </div>
</body>
</html>