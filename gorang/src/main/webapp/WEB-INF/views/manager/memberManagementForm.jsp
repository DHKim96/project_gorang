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
    <link rel="stylesheet" href="${contextPath }/resources/css/manager/memberManagement.css">
    <link rel="stylesheet" href="${contextPath }/resources/css/manager/commonManager.css">

    <script src="${contextPath }/resources/js/manager/memberManagement.js"></script>
    
     <!-- font awesome kit -->
     <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>
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
                    <div id="find-update-product" onclick="location.href='${contextPath }/updateproduct.ma'">상품 조회/수정</div>
                </div>
            </div>

            <div id="board-management-list" class="management-list" onclick="location.href='${contextPath }/boards.ma'">
                <div class="title">
                    게시판 관리
                </div>
            </div>

            <div id="user-management-list" class="management-list">
                <div class="title" style="color: #1e90ff;">
                    회원 관리
                </div>
            </div>
        </div>

        <!-- 오른쪽 div -->
        <div id="right-container">
            
            <div id="right-title">회원 관리</div>

            <!-- 서치바 -->
            <div class="searchbar-container">
                <div class="searchbar">
                    <div class="search-input-container">
                        <div class="i-container">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                        <input id="search-member-input" class="search-input" type="text" placeholder="ID 입력">
                    </div>
                    <div class="search-btn-container">
                        <button id="search-member-btn" class="search-btn" onclick="searchMember()">검색</button>
                    </div>
                </div>
            </div>

            <!-- 상품 검색결과 -->
            <div class="search-member-result-table">
                <div class="member-table-container">
                    <table id="member-table">
                        <thead>
                            <tr>
                                <td align="center" class="checkbox-td">선택</td>
                                <td align="center" class="user-id-td">사용자 ID</td>
                                <td align="center" class="member-nickname-td">사용자 닉네임</td>
                                <td align="center" class="member-createdate-td">가입일</td>
                                <td align="center" class="member-status-td">회원상태</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="member-tr">
                                <td align="center" colspan="5">
                                    사용자의 닉네임이나 계정으로 검색해주세요.
                                </td>
                            </tr>
                            <!-- <tr class="member-tr">
                                <td align="center">
                                    <input type="checkbox" class="check-member">
                                </td>
                                <td align="center" class="member-email">
                                    user01
                                </td>
                                <td align="center" class="member-nickname">
                                    user01
                                </td>
                                <td align="center" class="member-enroll-date">
                                    2024-04-21
                                </td>
                            </tr> -->
                        </tbody>
                    </table> 
                </div>
                <div id="pagination-area" align="center">
                    <div id="pagination">
                    </div>
                </div>
                <div class="delete-member-btn-container">
                    <button id="delete-member-btn" class="myBtn" onclick="updateMember()">상태변경</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>