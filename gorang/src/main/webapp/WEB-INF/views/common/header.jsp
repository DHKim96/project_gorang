<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Document</title>
                <!-- pretendard 폰트 -->
                <link rel="stylesheet" as="style" crossorigin
                    href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css" />

                <!-- css -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                    crossorigin="anonymous">

                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">

                <!--js-->
                <!-- jQuery library -->
                <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
                <!-- Popper JS -->
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

                <!-- font awesome kit -->
                <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                    crossorigin="anonymous"></script>

                <script src="${pageContext.request.contextPath}/resources/js/common/header.js"></script>

                <script type="text/javascript" charset="utf-8">
                    sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
                </script>
            </head>

            <body>
                <c:if test="${not empty alertMsg}">
                    <script>
                        alert("${alertMsg}");
                    </script>
                    <c:remove var="alertMsg" />
                </c:if>
                <div id="header">
                    <div id="header-top">
                        <c:choose>
                            <c:when test="${empty loginUser}"><span>신규가입 시 1만원 쿠폰을 지급해드려요!</span></c:when>
                            <c:otherwise><span>${loginUser.nickname}님만을 위한 쿠폰 확인하러가기!</span></c:otherwise>
                        </c:choose>
                    </div>
                    <div id="header-bottom">
                        <div id="header-bottom-left">
                            <div id="header-bottom-left-logo"
                                onclick="moveLocation('${pageContext.request.contextPath}')">
                                <svg width="78" height="80" viewBox="0 0 78 80" fill="none"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path
                                        d="M54.5 52.7079V58.92H3V52.7079H14.3332V42.3865H21.2565V52.7079H54.5ZM33.8694 46.9809H26.852V31.2121H6.84149V25H33.8702L33.8694 46.9809Z"
                                        fill="black" />
                                    <path
                                        d="M58.4208 40.2H38.6406V24.5252H49.6094V21.0956H39.9259V15H56.0806V30.6247H45.1119V34.1012H58.4208V40.2ZM70.8553 31.4082H67.1381V40.2H60.7586V15H67.1381V25.4494H70.8553V15H77.2806V40.2H70.8553V31.4082Z"
                                        fill="black" />
                                    <path
                                        d="M52.0801 53.5944C52.0801 52.0138 52.4105 50.4796 53.1184 49.0393C53.7792 47.6446 54.676 46.4367 55.8088 45.321C56.9407 44.2983 58.2615 43.4623 59.7726 42.8106C61.2822 42.2063 62.8869 41.8809 64.6325 41.8809C66.3316 41.8809 67.9828 42.2063 69.5411 42.8106C71.0507 43.4615 72.3722 44.2983 73.505 45.321C74.6378 46.4367 75.5337 47.6454 76.2417 49.0393C76.9025 50.4804 77.2801 52.0138 77.2801 53.5944C77.2801 55.268 76.9025 56.8013 76.2417 58.1959C75.5337 59.6371 74.6378 60.8915 73.505 61.9142C72.3722 63.0299 71.0507 63.8667 69.5411 64.4711C67.9836 65.1219 66.3316 65.4009 64.6325 65.4009C62.8861 65.4009 61.2822 65.1219 59.7726 64.4711C58.2615 63.8667 56.9407 63.0299 55.8088 61.9142C54.676 60.8915 53.7792 59.6363 53.1184 58.1959C52.4105 56.8013 52.0801 55.2672 52.0801 53.5944ZM70.3907 53.5944C70.3907 52.897 70.2491 52.1997 69.9659 51.5024C69.6355 50.8516 69.2107 50.2472 68.7388 49.7358C68.1732 49.2245 67.5588 48.8061 66.8988 48.5271C66.1436 48.2482 65.3885 48.1087 64.6333 48.1087C63.8309 48.1087 63.0765 48.2482 62.4158 48.5271C61.6614 48.8061 61.047 49.2245 60.575 49.7358C60.0094 50.2472 59.631 50.8516 59.3486 51.5024C59.0183 52.1997 58.8767 52.897 58.8767 53.5944C58.8767 54.3847 59.0183 55.1285 59.3486 55.7785C59.6318 56.4759 60.0094 57.0802 60.575 57.5451C61.047 58.103 61.6606 58.4749 62.4158 58.7538C63.0765 59.0327 63.8317 59.1722 64.6333 59.1722C66.238 59.1722 67.6068 58.6608 68.7388 57.5459C69.8243 56.4759 70.3907 55.1742 70.3907 53.5944Z"
                                        fill="black" />
                                    <path
                                        d="M33.5385 17.2678C33.3144 17.2678 33.1296 17.2173 32.984 17.1165C32.8383 17.0157 32.7655 16.8588 32.7655 16.646L32.7823 16.5115C32.9727 15.2568 33.2304 13.8284 33.5553 12.2263C33.8802 10.6242 34.1827 9.24064 34.4628 8.07551C34.642 7.3585 35.1294 7 35.9248 7C36.6418 7 37.0003 7.22967 37.0003 7.689C37.0003 7.78983 36.9835 7.90186 36.9499 8.02509C36.6586 9.21264 36.2721 10.6523 35.7904 12.3439C35.3086 14.0244 34.8493 15.4864 34.4124 16.73C34.2891 17.0885 33.9978 17.2678 33.5385 17.2678ZM32.8999 21.2841C32.407 21.2841 32.0317 21.1497 31.774 20.8808C31.5275 20.6119 31.4043 20.259 31.4043 19.8221C31.4043 19.3179 31.5443 18.9146 31.8244 18.6121C32.1157 18.3097 32.519 18.1584 33.0344 18.1584C33.5273 18.1584 33.897 18.2816 34.1435 18.5281C34.4012 18.7634 34.53 19.1163 34.53 19.5868C34.53 20.1022 34.3844 20.5167 34.0931 20.8304C33.8018 21.1329 33.4041 21.2841 32.8999 21.2841Z"
                                        fill="#1E90FF" />
                                    <path
                                        d="M26.212 21C25.5254 21 24.9377 20.8157 24.4489 20.447C23.9717 20.0657 23.611 19.5699 23.3666 18.9597C23.1222 18.3496 23 17.6949 23 16.9958C23 16.0297 23.1629 15.1716 23.4888 14.4216C23.8263 13.6589 24.2801 13.0678 24.8504 12.6483C25.4206 12.2161 26.0607 12 26.7706 12C27.4572 12 28.0449 12.1907 28.5337 12.572C29.0224 12.9407 29.389 13.4301 29.6334 14.0403C29.8778 14.6504 30 15.3051 30 16.0042C30 16.9703 29.8313 17.8347 29.4938 18.5975C29.1563 19.3475 28.6966 19.9386 28.1147 20.3708C27.5445 20.7903 26.9102 21 26.212 21ZM26.404 18.9407C26.7997 18.9407 27.1313 18.7055 27.399 18.2352C27.6783 17.7648 27.818 17.0784 27.818 16.1758C27.818 15.4767 27.7016 14.9492 27.4688 14.5932C27.2361 14.2373 26.9568 14.0593 26.6309 14.0593C26.212 14.0593 25.8628 14.2945 25.5835 14.7648C25.3159 15.2225 25.182 15.9089 25.182 16.8242C25.182 17.5487 25.2984 18.0826 25.5312 18.4258C25.7639 18.7691 26.0549 18.9407 26.404 18.9407Z"
                                        fill="#1E90FF" />
                                    <path
                                        d="M23.5254 16.5493C23.6723 16.5493 23.7853 16.6291 23.8644 16.7887C23.9548 16.9361 24 17.1264 24 17.3597C24 17.6421 23.9605 17.8631 23.8814 18.0228C23.8023 18.1824 23.678 18.3236 23.5085 18.4464C22.5367 19.1585 21.8249 19.6865 21.3729 20.0303L20.2881 20.8223C19.8588 23.364 19.2938 25.3593 18.5932 26.8082C17.904 28.2694 17.0226 29 15.9492 29C15.3729 29 14.904 28.8035 14.5424 28.4106C14.1808 28.03 14 27.5265 14 26.9003C14 26.0285 14.3164 25.0892 14.9492 24.0823C15.5819 23.0878 16.7684 21.8599 18.5085 20.3987L18.6102 19.6804C18.4181 20.0119 18.1638 20.2698 17.8475 20.454C17.5424 20.6259 17.2373 20.7118 16.9322 20.7118C16.2316 20.7118 15.6723 20.4355 15.2542 19.883C14.8362 19.3304 14.6271 18.606 14.6271 17.7096C14.6271 16.7273 14.8362 15.8003 15.2542 14.9285C15.6723 14.0444 16.226 13.3384 16.9153 12.8104C17.6158 12.2701 18.3559 12 19.1356 12C19.3842 12 19.548 12.0553 19.6271 12.1658C19.7175 12.264 19.791 12.4482 19.8475 12.7183C20.0621 12.6692 20.3107 12.6446 20.5932 12.6446C20.8757 12.6446 21.0734 12.6938 21.1864 12.792C21.3107 12.8779 21.3729 13.056 21.3729 13.3261C21.3729 13.4735 21.3672 13.5901 21.3559 13.6761C21.3107 14.0567 21.1695 15.0206 20.9322 16.5677C20.887 16.8624 20.8362 17.1878 20.7797 17.5439C20.7345 17.8877 20.6836 18.2561 20.6271 18.649C21.4972 17.9122 22.3333 17.2615 23.1356 16.6966C23.2825 16.5984 23.4124 16.5493 23.5254 16.5493ZM17.5424 18.8516C17.8023 18.8516 18.0508 18.6797 18.2881 18.3359C18.5254 17.9921 18.6949 17.5009 18.7966 16.8624L19.339 13.7129C18.8757 13.7252 18.4463 13.9216 18.0508 14.3023C17.6554 14.6706 17.339 15.1618 17.1017 15.7757C16.8644 16.3897 16.7458 17.0404 16.7458 17.7281C16.7458 18.1087 16.8136 18.3911 16.9492 18.5753C17.096 18.7595 17.2938 18.8516 17.5424 18.8516ZM16.1356 27.2134C16.4181 27.2134 16.7345 26.8451 17.0847 26.1083C17.4463 25.3716 17.791 24.199 18.1186 22.5905C17.2486 23.4009 16.6215 24.1315 16.2373 24.7822C15.8531 25.433 15.661 26.004 15.661 26.4951C15.661 26.7039 15.6949 26.8758 15.7627 27.0108C15.8418 27.1459 15.9661 27.2134 16.1356 27.2134Z"
                                        fill="#1E90FF" />
                                </svg>
                            </div>
                            <div id="header-bottom-left-category">
                                <span onclick="moveLocation('${pageContext.request.contextPath}/main.re')">레시피</span>
                                <span onclick="moveLocation('${pageContext.request.contextPath}/main.bo')">게시판</span>
                                <span onclick="moveLocation('${pageContext.request.contextPath}/main.po')">쇼핑</span>
                            </div>
                        </div>
                        <div id="header-bottom-right">
                            <div id="header-bottom-right-searchbar">
                                <input type="text" id="search-input">
                                <div id="header-bottom-right-searchbar-logo" onclick="searchResult()">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path
                                            d="M9.99951 2.9C13.9211 2.9 17.1 6.07945 17.1 10.001C17.1 13.9204 13.9212 17.1 9.99951 17.1C6.07887 17.1 2.9 13.9205 2.9 10.001C2.9 6.07938 6.07901 2.9 9.99951 2.9Z"
                                            stroke="black" stroke-width="1.8" />
                                        <path d="M15.5 15.5L20.5 20.5" stroke="black" stroke-width="1.8"
                                            stroke-linecap="round" />
                                    </svg>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${empty loginUser}">
                                    <!-- 로그인 전 -->
                                    <div id="header-bottom-right-login">
                                        <div id="header-bottom-right-login-top">
                                            <span
                                                onclick="moveLocation('${pageContext.request.contextPath}/register.me')">회원가입</span>
                                            <svg width="1" height="12" viewBox="0 0 1 12" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <rect width="1" height="12" fill="#E6E6E6" />
                                            </svg>
                                            <span
                                                onclick="moveLocation('${pageContext.request.contextPath}/loginForm.me')">로그인</span>
                                            <svg width="1" height="12" viewBox="0 0 1 12" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <rect width="1" height="12" fill="#E6E6E6" />
                                            </svg>
                                            <span>고객센터</span>
                                        </div>
                                        <div id="header-bottom-right-login-bottom">
                                            <div class="header-bottom-right-login-bottom-logo">
                                                <div>
                                                    <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                        xmlns="http://www.w3.org/2000/svg">
                                                        <circle cx="20.0007" cy="13.3327" r="5.66667" stroke="#222222"
                                                            stroke-width="2" stroke-linecap="round" />
                                                        <path
                                                            d="M8.93264 25.8303C9.89941 23.6006 12.2481 22.5 14.6783 22.5H25.3217C27.7519 22.5 30.1006 23.6006 31.0674 25.8303C31.7198 27.335 32.3234 29.2762 32.4675 31.5001C32.5032 32.0512 32.0523 32.5 31.5 32.5H8.5C7.94772 32.5 7.49676 32.0512 7.53248 31.5001C7.67664 29.2762 8.28023 27.335 8.93264 25.8303Z"
                                                            stroke="#222222" stroke-width="2" stroke-linecap="round" />
                                                    </svg>

                                                </div>
                                                <span>마이페이지</span>
                                            </div>
                                            <div class="header-bottom-right-login-bottom-logo">
                                                <div>
                                                    <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                        xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M4.88086 7.5H8.43934C9.13506 7.5 9.48292 7.5 9.74481 7.68876C10.0067 7.87752 10.1167 8.20753 10.3367 8.86754L11.5475 12.5"
                                                            stroke="#222222" stroke-width="2" stroke-linecap="round" />
                                                        <path
                                                            d="M26.2841 25.0758H15.3715C13.8628 25.0758 13.1084 25.0758 12.5645 24.6484C12.0206 24.2211 11.8421 23.4881 11.4851 22.0223L10.0695 16.2099C9.65335 14.501 9.44526 13.6466 9.89568 13.0733C10.3461 12.5 11.2255 12.5 12.9843 12.5H28.5315C30.2538 12.5 31.1149 12.5 31.5652 13.0599C32.0155 13.6197 31.8309 14.4608 31.4618 16.1431L30.1911 21.9332L30.1911 21.9332C29.8606 23.4395 29.6953 24.1926 29.1463 24.6342C28.5973 25.0758 27.8262 25.0758 26.2841 25.0758Z"
                                                            stroke="#222222" stroke-width="2" stroke-linecap="round" />
                                                        <circle cx="26.116" cy="30.2293" r="2.04762" stroke="#222222"
                                                            stroke-width="2" stroke-linecap="round" />
                                                        <circle cx="15.6414" cy="30.2293" r="2.04762" stroke="#222222"
                                                            stroke-width="2" stroke-linecap="round" />
                                                    </svg>

                                                </div>
                                                <span>장바구니</span>
                                            </div>
                                            <div class="header-bottom-right-login-bottom-logo" onclick="requireLogin()">
                                                <div>
                                                    <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                        xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M10.0884 23.0038L10.0884 23.0038L24.766 8.32625C24.7788 8.31341 24.7916 8.30058 24.8044 8.28777C25.1042 7.98785 25.3956 7.69637 25.6683 7.48833C25.9757 7.2538 26.3736 7.03335 26.8873 7.03335C27.4009 7.03335 27.7989 7.2538 28.1063 7.48833C28.379 7.69637 28.6703 7.98784 28.9701 8.28775C28.9782 8.29586 28.9863 8.30397 28.9944 8.31209C28.9992 8.3168 29.0039 8.32153 29.0086 8.32625L31.6747 10.9923L31.7132 11.0308C32.0131 11.3306 32.3046 11.622 32.5126 11.8946C32.7471 12.202 32.9676 12.6 32.9676 13.1136C32.9676 13.6273 32.7471 14.0253 32.5126 14.3327C32.3046 14.6053 32.0131 14.8967 31.7132 15.1965L31.6747 15.235L16.9971 29.9126L16.9971 29.9126C16.9969 29.9128 16.9967 29.913 16.9965 29.9132C16.9836 29.9261 16.9704 29.9393 16.9569 29.9529C16.8056 30.1051 16.6142 30.2977 16.3724 30.4346L10.0884 23.0038ZM10.0884 23.0038C10.0878 23.0044 10.0872 23.0051 10.0866 23.0057M10.0884 23.0038L10.0866 23.0057M10.0866 23.0057C10.074 23.0182 10.0612 23.031 10.048 23.0441C9.89583 23.1953 9.70321 23.3867 9.56633 23.6285C9.42945 23.8703 9.36438 24.1339 9.31297 24.3422C9.30831 24.3612 9.30375 24.3796 9.29927 24.3976L7.80424 30.3777L8.77438 30.6202L7.80424 30.3777C7.80143 30.3889 7.79851 30.4005 7.79549 30.4125C7.75867 30.559 7.70767 30.7619 7.6901 30.9415C7.66988 31.1482 7.6632 31.6002 8.03198 31.969C8.40075 32.3377 8.85271 32.331 9.05941 32.3108C9.23901 32.2933 9.44192 32.2423 9.5884 32.2054C9.60041 32.2024 9.61204 32.1995 9.62325 32.1967L15.6034 30.7017C15.6213 30.6972 15.6398 30.6926 15.6587 30.688C15.867 30.6366 16.1306 30.5715 16.3724 30.4346L10.0866 23.0057Z"
                                                            stroke="#222222" stroke-width="2" />
                                                        <path d="M21.9043 10.4766L29.5233 18.0956" stroke="#222222"
                                                            stroke-width="2" />
                                                    </svg>

                                                </div>
                                                <div class="writeDropdown">
                                                    <span>글쓰기</span>
                                                    <div class="writeDropdown-content">
                                                        <span>일반</span>
                                                        <span>레시피</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- 로그인 후 -->
                                    <div id="header-bottom-right-login">
                                        <div id="header-bottom-right-login-top">
                                            <c:if test="${loginUser.memberNo == 1}">
                                                <span
                                                    onclick="moveLocation('${pageContext.request.contextPath}/enrollproduct.ma')">관리자
                                                    페이지</span>
                                                <svg width="1" height="12" viewBox="0 0 1 12" fill="none"
                                                    xmlns="http://www.w3.org/2000/svg">
                                                    <rect width="1" height="12" fill="#E6E6E6" />
                                                </svg>
                                            </c:if>
                                            <span
                                                onclick="moveLocation('${pageContext.request.contextPath}/logout.me')">로그아웃</span>
                                            <svg width="1" height="12" viewBox="0 0 1 12" fill="none"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <rect width="1" height="12" fill="#E6E6E6" />
                                            </svg>
                                            <span>고객센터</span>
                                        </div>
                                        <div id="header-bottom-right-login-bottom">
                                            <div class="header-bottom-right-login-bottom-logo">
                                                <div class="btn-group dropleft">
                                                    <i class="fa-regular fa-bell" id="header-notify-bell" type="button" style="font-size: 30px;"
                                                        data-toggle="dropdown" aria-haspopup="true"
                                                        aria-expanded="false"></i>
                                                    <div class="dropdown-menu">
                                                        <ul class="dropdown-menu-ul">
                                                        </ul>
                                                    </div>
                                                </div>
                                                <span>알림</span>
                                            </div>
                                            <div class="header-bottom-right-login-bottom-logo"
                                                onclick="moveLocation('${pageContext.request.contextPath}/main.me')">
                                                <div>
                                                    <img class="headerProfileImg" id="header-profile-img" data-value="${loginUser.memberNo}"
                                                        src="/gorang/resources/uploadfile/memberProfile/${loginUser.profile}"
                                                        alt="회원프로필">
                                                </div>
                                                <span>마이페이지</span>
                                            </div>
                                            <div class="header-bottom-right-login-bottom-logo"
                                                onclick="moveLocation('${pageContext.request.contextPath}/cart.po')">
                                                <div>
                                                    <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                        xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M4.88086 7.5H8.43934C9.13506 7.5 9.48292 7.5 9.74481 7.68876C10.0067 7.87752 10.1167 8.20753 10.3367 8.86754L11.5475 12.5"
                                                            stroke="#222222" stroke-width="2" stroke-linecap="round" />
                                                        <path
                                                            d="M26.2841 25.0758H15.3715C13.8628 25.0758 13.1084 25.0758 12.5645 24.6484C12.0206 24.2211 11.8421 23.4881 11.4851 22.0223L10.0695 16.2099C9.65335 14.501 9.44526 13.6466 9.89568 13.0733C10.3461 12.5 11.2255 12.5 12.9843 12.5H28.5315C30.2538 12.5 31.1149 12.5 31.5652 13.0599C32.0155 13.6197 31.8309 14.4608 31.4618 16.1431L30.1911 21.9332L30.1911 21.9332C29.8606 23.4395 29.6953 24.1926 29.1463 24.6342C28.5973 25.0758 27.8262 25.0758 26.2841 25.0758Z"
                                                            stroke="#222222" stroke-width="2" stroke-linecap="round" />
                                                        <circle cx="26.116" cy="30.2293" r="2.04762" stroke="#222222"
                                                            stroke-width="2" stroke-linecap="round" />
                                                        <circle cx="15.6414" cy="30.2293" r="2.04762" stroke="#222222"
                                                            stroke-width="2" stroke-linecap="round" />
                                                    </svg>
                                                </div>
                                                <span>장바구니</span>
                                            </div>
                                            <div class="header-bottom-right-login-bottom-logo">
                                                <div>
                                                    <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
                                                        xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M10.0884 23.0038L10.0884 23.0038L24.766 8.32625C24.7788 8.31341 24.7916 8.30058 24.8044 8.28777C25.1042 7.98785 25.3956 7.69637 25.6683 7.48833C25.9757 7.2538 26.3736 7.03335 26.8873 7.03335C27.4009 7.03335 27.7989 7.2538 28.1063 7.48833C28.379 7.69637 28.6703 7.98784 28.9701 8.28775C28.9782 8.29586 28.9863 8.30397 28.9944 8.31209C28.9992 8.3168 29.0039 8.32153 29.0086 8.32625L31.6747 10.9923L31.7132 11.0308C32.0131 11.3306 32.3046 11.622 32.5126 11.8946C32.7471 12.202 32.9676 12.6 32.9676 13.1136C32.9676 13.6273 32.7471 14.0253 32.5126 14.3327C32.3046 14.6053 32.0131 14.8967 31.7132 15.1965L31.6747 15.235L16.9971 29.9126L16.9971 29.9126C16.9969 29.9128 16.9967 29.913 16.9965 29.9132C16.9836 29.9261 16.9704 29.9393 16.9569 29.9529C16.8056 30.1051 16.6142 30.2977 16.3724 30.4346L10.0884 23.0038ZM10.0884 23.0038C10.0878 23.0044 10.0872 23.0051 10.0866 23.0057M10.0884 23.0038L10.0866 23.0057M10.0866 23.0057C10.074 23.0182 10.0612 23.031 10.048 23.0441C9.89583 23.1953 9.70321 23.3867 9.56633 23.6285C9.42945 23.8703 9.36438 24.1339 9.31297 24.3422C9.30831 24.3612 9.30375 24.3796 9.29927 24.3976L7.80424 30.3777L8.77438 30.6202L7.80424 30.3777C7.80143 30.3889 7.79851 30.4005 7.79549 30.4125C7.75867 30.559 7.70767 30.7619 7.6901 30.9415C7.66988 31.1482 7.6632 31.6002 8.03198 31.969C8.40075 32.3377 8.85271 32.331 9.05941 32.3108C9.23901 32.2933 9.44192 32.2423 9.5884 32.2054C9.60041 32.2024 9.61204 32.1995 9.62325 32.1967L15.6034 30.7017C15.6213 30.6972 15.6398 30.6926 15.6587 30.688C15.867 30.6366 16.1306 30.5715 16.3724 30.4346L10.0866 23.0057Z"
                                                            stroke="#222222" stroke-width="2" />
                                                        <path d="M21.9043 10.4766L29.5233 18.0956" stroke="#222222"
                                                            stroke-width="2" />
                                                    </svg>
                                                </div>
                                                <div class="writeDropdown">
                                                    <span>글쓰기</span>
                                                    <div class="writeDropdown-content">
                                                        <span
                                                            onclick="moveLocation('${pageContext.request.contextPath}/write.bo')">일반</span>
                                                        <span
                                                            onclick="moveLocation('${pageContext.request.contextPath}/write.re')">레시피</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </body>

            </html>