<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>


    <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
    <link rel="stylesheet" href="${contextPath }/resources/css/member/myPageInfoEdit.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <script src="${pageContext.request.contextPath}/resources/js/member/myPageInfoEdit.js"></script>

</head>

<body>
    <jsp:include page="../common/header.jsp" />
    <c:if test="${not empty alertMsg }">
		<script>
			alert("${alertMsg }");
		</script>
		<c:remove var="alertMsg" scope="session"/>
	</c:if>
    <main id="myPage-Info-Edit">
        <form action="update-member-info.me" method="post" id="update-member-info-form" enctype="multipart/form-data">
            <div id="InfoEditContent">
                <input type="hidden" value="${loginUser.memberNo}" name="memberNo">
                <div id="InfoEditWrap">
                    <div id="InfoEditHead">
                        <div id="editSpan"><span>정보 수정</span></div>
                        <div id="myinfoSpan"><span>내 정보</span></div>
                    </div>
                    <div id="userInfo">
                        <div id="userProfileArea">
                            <div id="userProfile">
                                <img src="${contextPath}/resources/uploadfile/memberProfile/${loginUser.profile}"
                                    id="user-profile-img" alt="화원 프로필">
                            </div>
                            <div id="userProfile-pencil" onclick="changeMemberImg(this)">
                                <img src="${contextPath}/resources/images/member-img/Icon_Edit.png" alt="프로필 사진 버튼">
                            </div>
                            <input type="file" id="file-input" accept="image/*" name="upfile" onclick="displaySelectedImage(this)">
                        </div>
                        <div id="userNickName-area">
                            <div>${loginUser.nickname }</div> 
                            <div id="userFollow">
                                <div id="userFollower"><a href="">팔로워 ${followerCount }</a></div> |
                                <div id="userFollowing"><a href="">팔로잉 ${followingCount }</a></div>
                            </div>
                            <div id="userGrade">
                                ${loginUser.grade }등급
                            </div>
                        </div>
                    </div>
                    <div id="userIdWrap">
                        <div id="IdWrap"><span>아이디</span></div>
                        <div id="CurrentuserId"><span>${loginUser.memberEmail }</span></div>
                    </div>
                    <div id="userNpwWrap">
                        <div id="NpwWrap">
                            <span>새 비밀번호</span>
                        </div>
                        <div id="NpwInput">
                            <input type="password" placeholder="새 비밀번호를 입력해 주세요." id="new-password" name="memberPwd" oninput="checkPwdLength(this)">
                            <button type="button"><img src="${contextPath}/resources/images/member-img/Vector.png"
                                    alt=""></button>
                        </div>
                        
                    </div>
                    <div id="check-password-length">

                    </div>
                    <div id="userNpwCheckWrap">
                        <div id="NpwWrap">
                            <span>새 비밀번호 확인</span>
                        </div>
                        <div id="NpwInput">
                            <input type="password" placeholder="새 비밀번호를 다시 입력해 주세요." id="valid-new-password" oninput="validPassword(this)">
                            <button type="button"><img src="${contextPath}/resources/images/member-img/Vector.png"
                                    alt=""></button>
                        </div>
                    </div>
                    <div id="valid-password-result">

                    </div>
                    <hr style="width: 740px; height: 4px; margin-left: 232px; color: #D4D4D4;">
                    <div id="userNickNameWrap">
                        <div id="NickNameWrap"><span>닉네임</span></div>
                        <div id="CurrentuserNickName">
                            <input type="text" value="${loginUser.nickname}" class="change-info-input"
                                id="new-nickname" name="nickname" oninput="ischangeNickname()">
                        </div>
                        <div id="NickNameChangeBtn"><button type="button" onclick="validNickname()"><span>중복확인</span></button></div>
                    </div>
                    <div id="userPnumWrap">
                        <div id="PnumWrap"><span>휴대폰 번호</span></div>
                        <div id="CurrentuserPnum">
                            <input type="text" value="${loginUser.memberPhone}" class="change-info-input"
                                id="new-phone-number" name="memberPhone" maxlength="11" oninput="isChangePhoneNum()">
                        </div>
                        <div id="ChangePnumBtn"><button type="button" onclick="validPhoneNumber()"><span >중복확인</span></button></div>
                    </div>
                    <hr style="width: 740px; height: 4px; margin-left: 232px; color: #D4D4D4;">
                    <div id="userWithdraw">
                        <div id="withdrawInfo"><span>회원탈퇴 후 동일 아이디로 재가입이 불가합니다</span></div>
                        <div id="withdrawBtn"><button type="button" onclick="location.href='withdrawal.me'">회원탈퇴</button></div>
                    </div>
                    <div id="btnArea">
                        <div id="commitBtn"><button type="button" onclick="submitMemberInfo()">확인</button></div>
                        <div id="cancelBtn"><button type="button" onclick="location.href='edit.me'">취소</button></div>
                    </div>
                </div>
            </div>
        </form>

    </main>
    <jsp:include page="../common/footer.jsp" />
</body>

</html>