<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- 기본 파비콘 설정 -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/static/favicon/favicon-16x16.png" sizes="16x16" type="image/png">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/static/favicon/favicon-32x32.png" sizes="32x32" type="image/png">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/static/favicon/favicon.ico" type="image/x-icon">

    <!-- 애플 터치 아이콘 설정 -->
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/static/favicon/apple-touch-icon.png">

    <!-- 안드로이드 크롬 아이콘 설정 -->
    <link rel="icon" sizes="192x192" href="${pageContext.request.contextPath}/resources/static/favicon/android-chrome-192x192.png">
    <link rel="icon" sizes="512x512" href="${pageContext.request.contextPath}/resources/static/favicon/android-chrome-512x512.png">

    <!-- 웹 매니페스트 설정 -->
    <link rel="manifest" href="${pageContext.request.contextPath}/resources/static/favicon/site.webmanifest">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/main.jsp" />
</body>
</html>
