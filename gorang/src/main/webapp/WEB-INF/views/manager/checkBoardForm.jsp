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
<link rel="stylesheet" href="${contextPath}/resources/css/manager/checkBoardForm.css">
<link rel="stylesheet" href="${contextPath }/resources/css/manager/commonManager.css">


<script src="${contextPath}/resources/js/manager/checkBoardForm.js"></script>
</head>
<body>
    <!-- 헤더 -->
    <jsp:include page="../common/header.jsp" />
    <div id="main-container">

        <!-- 왼쪽 div -->
        <div id="left-container">
            <div id="product-management-list" class="management-list">
                <div class="title">
                    상품 관리
                </div>
                <div class="list">
                    <div id="enroll-product" onclick="location.href='${contextPath }/enrollproduct.ma'">상품 등록</div>
                    <div id="find-update-product"  onclick="location.href='${contextPath }/updateproduct.ma'">상품 조회/수정</div>
                </div>
            </div>

            <div id="board-management-list" class="management-list" onclick="location.href='${contextPath }/boards.ma'">
                <div class="title" style="color: #1e90ff;">
                    게시판 관리
                </div>
            </div>

            <div id="user-management-list" class="management-list" onclick="location.href='${contextPath }/members.ma'">
                <div class="title">
                    회원 관리
                </div>
            </div>
        </div>

        <!-- 오른쪽 div -->
        <div id="right-container">
            <div id="right-title">게시판 관리</div>

            <!-- 서치바 -->
            <div class="searchbar-container">
                <div class="searchbar">
                    <div class="search-input-container">
                        <div class="i-container">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                        <input id="search-board-name-input" class="search-input" type="text" placeholder="게시글 제목 입력">
                    </div>
                    <div class="search-btn-container">
                        <button id="search-board-name-btn" class="search-btn" onclick="searchBoard()">검색</button>
                    </div>
                </div>
            </div>

            <!-- 게시글 목록 -->
            <div id="admin-board-list-area">
                <div id="admin-board-title">총 <span id="board-count"></span>개의 게시글</div>
                <div id="admin-board-list-blocks">
                    <table border="1" id="admin-board-list">
                        <thead>
                            <tr id="admin-thead-tr">
                                <td class="thead-td1">선택</td>
                                <td class="thead-td2">게시글 ID</td>
                                <td class="thead-td3">종류</td>
                                <td class="thead-td4">게시글 명</td>
                                <td class="thead-td5">작성자</td>
                                <td class="thead-td6">작성일</td>
                                <td class="thead-td7">누적 신고 수</td>
                                <td class="thead-td8">게시글 상태</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="admin-tbody-tr">
                               <td colspan="8">게시글을 검색해주세요</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="pagination-area" align="center">
                    <div id="pagination">
                    </div>
                </div>
            </div>
            <!-- 페이징 바 영역(미정) -->
            <!-- <div></div> -->
            <!-- 숨기기 버튼 -->
            <div id="hidden-board-btn">
                <button onclick="updateBoardStatus()">상태변경</button>
            </div>
        </div>
    </div>
</body>
</html>