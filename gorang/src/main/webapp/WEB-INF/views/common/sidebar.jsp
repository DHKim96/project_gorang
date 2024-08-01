<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- css -->
	 	<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/sidebar.css">
         <!-- slick-->
         <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
		<!--slick-->
        <script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
</head>
<body>
	<!-- 사이드 최근본 내역 -->
        <div id="sidebar" class="scale-container">
			<div id="recently-seen-div">
                <div class="recently-seen-div-button-box slick-prev">
                    <svg width="16" height="10" viewBox="0 0 16 10" fill="none" xmlns="http://www.w3.org/2000/svg">
						<rect x="2.31445" y="7.46094" width="7.72042" height="1.54408" transform="rotate(-45 2.31445 7.46094)" fill="#D9D9D9"/>
						<rect width="7.72042" height="1.54408" transform="matrix(-0.707107 -0.707107 -0.707107 0.707107 13.416 7.46094)" fill="#D9D9D9"/>
					</svg>
                </div>
				<div id="recently-seen-container">
					<span></span>
					<div id="recently-seen-list">
						<!-- 최근 본 아이템 목록 추가-->
					</div>
				</div>
                <div class="recently-seen-div-button-box slick-next">
                <svg width="16" height="10" viewBox="0 0 16 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <rect width="7.72042" height="1.54408" transform="matrix(0.707107 0.707107 0.707107 -0.707107 2.31445 2.53906)" fill="#D9D9D9"/>
                    <rect x="13.6855" y="2.53906" width="7.72042" height="1.54408" transform="rotate(135 13.6855 2.53906)" fill="#D9D9D9"/>
                </svg>
                </div>
			</div>
		</div>
    <!--sidebar-->
    <script src="${pageContext.request.contextPath}/resources/js/common/sidebar.js"></script>
</body>
</html>