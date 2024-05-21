<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
    <link rel="stylesheet" href="${contextPath }/resources/css/member/myPageCheckPwd.css">

</head>
<body>
    <%@ include file="../common/header.jsp"%>
    <div id="check_pwd_container">
        <div id="check_pwd_container_top">
            <span style="color: #737373;">마이</span>
        </div>
        <div id="check_pwd_container_title">
            회원정보 수정
        </div>
        <div id="check_pwd_container_infoTitle">
            기본정보
        </div>
        <div id="check_pwd_container_notice">
            <div>* 비밀번호 확인</div>
            <div>안전한 개인정보보호를 위해 비밀번호를 입력해 주세요.</div>
        </div>
        <div id="check_pwd_container_enroll_area">
            <div style="color: #626262; font-size: 18px; font-weight: bold;">비밀번호</div>
            <div>
                <div id="input_pwd_area">
                    <input id="input_pwd" type="password" name="" placeholder="비밀번호를 입력해주세요.">
                    <div id="lock_svg_area">
                        <svg width="26" height="28" viewBox="0 0 26 28" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M22.875 11.3307H24.25C25.0094 11.3307 25.625 11.9277 25.625 12.6641V25.9974C25.625 26.7338 25.0094 27.3307 24.25 27.3307H2.25C1.49062 27.3307 0.875 26.7338 0.875 25.9974V12.6641C0.875 11.9277 1.49062 11.3307 2.25 11.3307H3.625V9.9974C3.625 4.84274 7.93426 0.664062 13.25 0.664062C18.5658 0.664062 22.875 4.84274 22.875 9.9974V11.3307ZM3.625 13.9974V24.6641H22.875V13.9974H3.625ZM11.875 16.6641H14.625V21.9974H11.875V16.6641ZM20.125 11.3307V9.9974C20.125 6.3155 17.0469 3.33073 13.25 3.33073C9.45305 3.33073 6.375 6.3155 6.375 9.9974V11.3307H20.125Z" fill="#BCB4B4"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
        <!-- js 처리 부분 -->
        <div id="check_pwd_warning"
            style="margin-top: 10px; 
            margin-left: 90px;
            font-size: 11px; 
            color: #F35151;">
            <div>*입력하신 비밀번호가 일치하지 않습니다.</div>
            <div>*비밀번호를 입력해 주세요.(빈칸상태에서 누를경우)</div>
        </div>
        <div id="check_pwd_btn_area">
            <button id="check_pwd_btn">확인</button>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>