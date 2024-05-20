<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>


            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath }/resources/css/member/myPageInfoEdit.css">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                crossorigin="anonymous">
        </head>

        <body>
            <jsp:include page="../common/header.jsp" />
            <main id="myPage-Info-Edit">
                <div id="InfoEditContent">
                    <div id="InfoEditWrap">
                        <div id="InfoEditHead">
                            <div id="editSpan"><span>정보 수정</span></div>
                            <div id="myinfoSpan"><span>내 정보</span></div>
                        </div>
                        <div id="userInfo">
                            <div id="userProfileArea">
                                <div id="userProfile">
                                    <img src="${contextPath}/resources/images/member-img/120X120.png" alt="화원 프로필">
                                </div>
                                <div id="userProfile-pencil">
                                    <img src="${contextPath}/resources/images/member-img/Icon_Edit.png" ale="프로필 사진 버튼">
                                </div>
                            </div>
                            <div id="userNickName-area">
                                <a href="">닉네임 자리</a> <img
                                    src="${contextPath}/resources/images//member-img/Vector 340.png" alt=">"
                                    id="Bector">
                                <br>
                                <div id="userFollow">
                                    <div id="userFollower"><a href="">팔로워 0</a></div> |
                                    <div id="userFollowing"><a href="">팔로잉 0</a></div>
                                </div>
                                <div id="userGrade">
                                    브론즈등급
                                </div>
                            </div>
                        </div>
                        <div id="userIdWrap">
                            <div id="IdWrap"><span>아이디</span></div>
                            <div id="CurrentuserId"><span>admin@naver.com</span></div>
                            <div id="IdChangeBtn"><button><span>변경</span></button></div>
                        </div>
                        <div id="userNpwWrap">
                            <div id="NpwWrap">
                                <span>새 비밀번호</span>
                            </div>
                            <div id="NpwInput">
                                <input type="text" placeholder="새 비밀번호를 입력해 주세요.">
                                <button><img src="${contextPath}/resources/images/member-img/Vector.png" alt=""></button>
                            </div>
                        </div>
                        <div id="userNpwCheckWrap">
                            <div id="NpwWrap">
                                <span>새 비밀번호 확인</span>
                            </div>
                            <div id="NpwInput">
                                <input type="text" placeholder="새 비밀번호를 다시 입력해 주세요.">
                                <button><img src="${contextPath}/resources/images/member-img/Vector.png" alt=""></button>
                            </div>
                        </div>
                        <hr style="width: 740px; height: 4px; margin-left: 232px; color: #D4D4D4;">
                        <div id="userNickNameWrap">
                            <div id="NickNameWrap"><span>닉네임</span></div>
                            <div id="CurrentuserNickName"><span>adminer</span></div>
                            <div id="NickNameChangeBtn"><button><span>중복확인</span></button></div>
                        </div>
                        <div id="userNameWrap">
                            <div id="NameWrap"><span>이름</span></div>
                            <div id="CurrentuserName"><span>관리자1</span></div>
                            <div id="NameChangeBtn"><button><span>변경</span></button></div>
                        </div>
                        <div id="userBirthSexWrap">
                            <div id="BirthSexWrap"><span>생년월일/성별</span></div>
                            <div id="CurrentuserBirthSex"><span>1990.01.01/남</span></div>
                        </div>
                        <div id="userPnumWrap">
                            <div id="PnumWrap"><span>휴대폰 번호</span></div>
                            <div id="CurrentuserPnum"><span>010-1234-5678</span></div>
                            <div id="ChangePnumBtn"><button><span>변경</span></button></div>
                        </div>
                        <hr style="width: 740px; height: 4px; margin-left: 232px; color: #D4D4D4;">
                        <div id="userWithdraw">
                            <div id="withdrawInfo"><span>회원탈퇴 후 동일 아이디로 재가입이 불가합니다</span></div>
                            <div id="withdrawBtn"><button>회원탈퇴</button></div>
                        </div>
                        <div id="btnArea">
                            <div id="commitBtn"><button>확인</button></div>
                            <div id="cancelBtn"><button>취소</button></div>
                        </div>
                    </div>
                    
                </div>
            </main>
            <jsp:include page="../common/footer.jsp" />
        </body>

        </html>