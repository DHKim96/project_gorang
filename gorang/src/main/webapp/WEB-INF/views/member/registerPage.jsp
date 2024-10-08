<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>
            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

             <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

            <!-- jQuery library -->
            <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

            <!-- Popper JS -->
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

            <!-- Latest compiled JavaScript -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

            <!-- font awesome kit -->
            <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>

            <!-- css -->
            <link rel="stylesheet" href="${contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath}/resources/css/member/registerPage.css">
        </head>

        <body>
            <div class="container scale-container">
                <div id="gorang-logo">
                    <svg width="120" height="120" viewBox="0 0 78 80" fill="none" xmlns="http://www.w3.org/2000/svg">
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
                <h2>회원가입</h2>
                <form method="post" id="register-form" action="${contextPath}/insert.me">
                    <div class="registerSection">
                        <div class="registerSpan"><span>이메일</span></div>
                        <div class="register-inputForm" id="register-input-email">
                            <input type="email" class="register-input" name="memberEmail" placeholder="이메일을 입력해주세요." value="${email}" required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                        <div class="registerCheck">
                            <input type="button" value="본인인증" id="member-email-auth" style="pointer-events: none;">
                        </div>
                    </div>
                    <div class="registerSection" id="emailAuthSection" style="justify-content: center; display: none;">
                        <div class="registerSpan timer" id="email-auth-timer"><h4></h4></div>
                        <div class="register-inputForm" id="register-input-email-authNo">
                            <input type="text" class="register-input" name="email-authNo" placeholder="인증번호를 입력해주세요." required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                        <div class="registerCheck">
                            <input type="button" id="member-email-auth-btn" value="인증하기">
                        </div>
                    </div>
                    <div class="registerSection">
                        <div class="registerSpan"><span>비밀번호</span></div>
                        <div class="register-inputForm" id="register-input-pwd">
                            <input type="password" class="register-input" name="memberPwd" placeholder="비밀번호를 입력해주세요(영문, 숫자 포함 8자 이상)" required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                    </div>
                    <div class="registerSection">
                        <div class="registerSpan"><span>비밀번호 확인</span></div>
                        <div class="register-inputForm" id="register-input-pwd-confirm">
                            <input type="password" class="register-input" id="register-pwd-confirm" placeholder="비밀번호를 한 번 더 입력해주세요." required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                    </div>
                    <div class="registerSection">
                        <div class="registerSpan"><span>닉네임</span></div>
                        <div class="register-inputForm" id="register-input-nickname">
                            <input type="text" class="register-input" name="nickname" placeholder="닉네임을 입력해주세요(2~15자)." value="${nickname}" required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                        <div class="registerCheck">
                            <input type="button" value="중복확인" id="nameCheck" style="pointer-events: none;">
                        </div>
                    </div>
                    <div class="registerSection">
                        <div class="registerSpan"><span>전화번호</span></div>
                        <div class="register-inputForm" id="register-input-phone">
                            <input type="tel" class="register-input" name="memberPhone" placeholder="전화번호를 입력해주세요.('-' 생략)" value='${mobile.replaceAll("[^0-9]", "")}' required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                        <div class="registerCheck">
                            <input type="button" id="member-auth-btn" value="본인인증" style="pointer-events: none;">
                        </div>
                    </div>
                    <div class="registerSection" id="phoneAuthSection" style="justify-content: center; display: none;">
                        <div class="registerSpan timer"><h4></h4></div>
                        <div class="register-inputForm" id="register-input-authNo">
                            <input type="text" class="register-input" name="phone-authNo" placeholder="인증번호를 입력해주세요." required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                        <div class="registerCheck">
                            <input type="button" id="member-phone-auth-btn" value="인증하기">
                        </div>
                    </div>
                    <div id="registAddressSection" class="registerSection">
                        <div class="registerSpan"><span>주소</span></div>
                        <div id="addressSearch" class="register-inputForm">
                            <button type="button">주소 검색</button>
                        </div>
                    </div>
                    <div class="registerSection">
                        <div class="registerSpan"><span>성별</span></div>
                        <div id="genderSelect">
                            <input type="radio" name="gender" value="M" checked><span>남</span>
                            <input type="radio" name="gender" value="F"><span>여</span>
                            <input type="radio" name="gender" value="unselect"><span>선택안함</span>
                        </div>
                    </div>
                    <div id="registBirthSection" class="registerSection">
                        <div class="registerSpan"><span>생년월일</span></div>
                        <div id="birthInput" class="register-inputForm">
                            <input type="date"  class="register-input" name="birth" placeholder="YYYYMMDD" required>
                            <div class="regi-notice-wrapper">
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="profile" id="profileImage" value="${profile_image}">
                    <hr>
                    <div id="gorangTermSection">
                        <div id="termSpan"><span>이용약관동의</span></div>
                        <div id="termCheck">
                            <div class="all-check">
                                <label class="checkbox">
                                    <input type="checkbox" id="select-all">
                                    <span class="txt">[전체 동의] 선택항목에 대한 동의 포함</span>
                                </label>
                            </div>
                            <ul class="list">
                                <li class="item">
                                    <label class="checkbox">
                                        <input type="checkbox">
                                        <span class="txt">[필수] 이용약관 동의</span>
                                    </label>
                                    <button type="button" class="btn small outline2 thin">내용보기</button>
                                </li>
                                <li class="item">
                                    <label class="checkbox">
                                        <input type="checkbox">
                                        <span class="txt">[필수] 개인정보 수집 이용 동의</span>
                                    </label>
                                    <button type="button" class="btn small outline2 thin">내용보기</button>
                                </li>
                                <li class="item">
                                    <label class="checkbox">
                                        <input type="checkbox" class="select-all-mkt" name="marketing" value="Y">
                                        <span class="txt">[선택] 개인정보 마케팅 활용 동의</span>
                                    </label>
                                </li>
                                <li class="item">
                                    <label class="checkbox">
                                        <input type="checkbox" class="select-all-mkt" name="alarm" value="Y">
                                        <span class="txt">[선택] 나의 냉장고 알림/이벤트/할인 등 혜택/정보 수신 동의</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div id="registerSubmitBtn">
                        <button type="submit"  id="register-form-submitBtn">
                            회원가입하기
                        </button>
                    </div>
                </form>
            </div>
            <script type="text/javascript" charset="utf-8">
                 sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
             </script>

            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

            <script src="${contextPath}/resources/js/member/registerPage.js"></script>

             
        </body>

        </html>