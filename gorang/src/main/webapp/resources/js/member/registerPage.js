document.addEventListener('DOMContentLoaded', function () {
    const ctx = sessionStorage.getItem("contextpath");

    document.querySelector("#gorang-logo").addEventListener("click", () => location.href = ctx);
    document.querySelector("input[name='memberEmail']").addEventListener('blur', validateEmail);
    document.querySelector("input[name='memberPwd']").addEventListener('blur', validatePwd);
    document.querySelector("#register-pwd-confirm").addEventListener('blur', validatePwdConfirm);
    document.querySelector("input[name='nickname']").addEventListener('blur', validateNickname);
    document.querySelector("input[name='memberPhone']").addEventListener('blur', validatePhoneNumber);
    document.querySelector("input[name='birth']").addEventListener('blur', validateBirthdate);

    document.querySelector("#addressSearch > button").addEventListener('click', setAddress);

    checkAddressVali();

    document.querySelector("#register-form-submitBtn").addEventListener('click', (ev) => {validateForm(ev)});
    
    setTermSection();
});

 function validateForm(event) {
    event.preventDefault();
    
    const isValidEmail = (document.querySelector("#member-email-auth-btn").value.trim() === "인증완료" );
    const isValidPwd = validatePwd();
    const isValidPwdConfirm = validatePwdConfirm();
    const isValidNickname = (document.querySelector("#nameCheck").value.trim() === "사용가능" );
    const isValidPhoneNumber = (document.querySelector("#member-phone-auth-btn").value.trim() === "인증완료" );
    const isValidBirthdate = validateBirthdate();
    const isValidTotalAddress = validateTotalAddress();
    const isValidTerm = validateTerm();

    console.log(isValidEmail)
    console.log(isValidPwd)
    console.log(isValidPwdConfirm)
    console.log(isValidNickname)
    console.log(isValidPhoneNumber)
    console.log(isValidBirthdate)
    console.log(isValidTotalAddress)
    console.log(isValidTerm)

    if (isValidEmail && isValidPwd && isValidPwdConfirm && isValidNickname && isValidPhoneNumber && isValidBirthdate && isValidTotalAddress && isValidTerm) {
        document.querySelector("#register-form").submit();
    }
}


function showNotice(element, message, className) {
    element.innerHTML = `<span class="regi-notice ${className}">${message}</span>`;
}

// ========================================================= 이메일 ===================================================

function validateEmail() {
    const email = document.querySelector("input[name='memberEmail']").value.trim();
    const emailNotice = document.querySelector("#register-input-email > .regi-notice-wrapper");
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (email !== "") {
        if (re.test(email)) {
            emailNotice.innerHTML = "";
            const emailBtn = document.querySelector("#member-email-auth");
            emailBtn.style.pointerEvents = "auto";
            emailBtn.addEventListener('click', new EmailAuthentication());
        } else {
            showNotice(emailNotice, "잘못된 이메일 형식입니다.", "email-form");
        }
    } else {
        showNotice(emailNotice, "이메일을 입력해주세요.", "email-empty");
    }
}


function checkEmailAjax(data, callback){
    $.ajax({
        url: "idCheck.me",
        data,
        success: res => callback(res),
        error: () => {
            alert('이메일 전송 실패');
        }
    })
}

function sendEmailAuthNoAjax(data, callback){
    $.ajax({
        url: "authEmail.me",
        data,
        success: res => callback(res),
        error: () => {
            alert('이메일 전송 실패');
        }
    })
}

/**이메일 인증 관련 class */
class EmailAuthentication{

    constructor(){
        this.isSend = false; // 인증번호 전송 여부
        this.authNo = ''; // 인증번호
        this.timerId = null; //타이머
        this.timer = $('#email-auth-timer>h4'); // 타이머 ui
        // input 창 한 쪽에 나타나게 하면 어떨까?
        this.input = $("input[name='email-authNo']");// 인증번호 input

        this.sendBtn = $('#member-email-auth'); // 인증번호 전송 버튼
        this.authBtn = $('#member-email-auth-btn'); // 인증번호 체크 버튼

        this.sendBtn.on('click',()=>{
            console.log("클릭");
            this.sendAuthNum();
        });

        this.authBtn.on('click', ()=>{
            this.checkAuthNum();
        });
    }

    showNotice(element, message, className) {
        element.innerHTML = `<span class="regi-notice ${className}">${message}</span>`;
    }

    sendAuthNum = async function(){
        const email = $("input[name='memberEmail']").val();
        
        // 핸드폰 번호 본인인증 클릭 시 db 에서 체크하도록
        const isEmailRegistered = await new Promise((resolve) => {
            checkEmailAjax({checkId: email}, res => {
                if(res === "NNNNY"){
                    const emailNotice = document.querySelector("#register-input-email > .regi-notice-wrapper");
                    showNotice(emailNotice, "이미 가입한 이메일입니다.", "email-id");
                    resolve(true);  // 이미 가입했을 경우 true 반환
                } else {
                    resolve(false); // 아닌 경우 false 반환
                }
            });
        });

        if (isEmailRegistered) {
            return;  // 이미 가입한 이메일인 경우 이후 코드 실행 중단
        }


        if(this.isSend){
            const result = confirm('재전송 하시겠습니까?');
            if(!result){ // 재전송 거절 시
                return;
            } else {
                clearInterval(this.timerId); // 호출 스케쥴링(일정 시간 간격 두고 함수 실행)
            }
        };

        // 랜덤번호 생성
        this.authNo = Math.floor(Math.random() * 100000).toString().padStart(6, '0');

        $('#emailAuthSection').css('display','flex');

        sendEmailAuthNoAjax({authNo: this.authNo, id: email}, res => {
            if(res === "success"){
                alert("인증번호가 발송되었습니다.")
                console.log("인증번호 : " + this.authNo);
                console.log("전송한 이메일 : " + email);

                this.timer.css("color", "red");
                this.authBtn.prop('disabled', false);
                this.input.prop('readonly', false).val('').focus();

                this.isSend = true;
                this.startTimer(181); // 3분 타이머 시작
            } else {
                console.log("전송한 이메일 : " + email);
                console.log(res);
                this.authNo = '';
            }
        });

    };

    checkAuthNum(){
        const inputCode = this.input.val();
        const authNumNotice = document.querySelector("#register-input-email-authNo > .regi-notice-wrapper");
        if(this.authNo.trim() !== inputCode.trim()){
            console.log(this.authNo.trim());
            console.log(inputCode.trim());
            showNotice(authNumNotice, "잘못된 인증번호입니다.", "authNo-un");
        }else {
            const emailAuthBtn = document.querySelector('#member-email-auth-btn');

            this.sendBtn.prop('disabled', true);

            alert('인증성공');
            clearInterval(this.timerId);
        
            authNumNotice.innerHTML = "";

            emailAuthBtn.value = "인증완료";
            emailAuthBtn.style.pointerEvents = "none";
            emailAuthBtn.style.background = "#1e90ff";
            emailAuthBtn.style.color = "#ffffff";

            this.input.prop('readonly', true);            
            this.timer.css("color", "#4aa500");
            this.isSend = false;
            this.authBtn.prop('disabled', true);
        };
    };

    startTimer(duration){
        let timeLeft = duration;
        this.timerId =  setInterval(() => {
            if(timeLeft <= 0){
                clearInterval(this.timerId);
                showNotice(document.querySelector("#register-input-email-authNo > .regi-notice-wrapper"), "인증시간이 초과되었습니다.", "authNo-over");
                this.timer.text("3:01");
                this.authBtn.prop('disabled', true);
                this.authNo = "";
            } else {
                timeLeft --;
                let minutes = Math.floor(timeLeft/60);
                let seconds = timeLeft % 60;
                this.timer.text(minutes + ":" + (seconds < 10 ? '0' : '') + seconds);
            }
        }, 1000); // 1초마다
    }
};

// ======================================================= 비밀번호, 비밀번호 확인 ===============================================

function validatePwd() {
    const pwd = document.querySelector("input[name='memberPwd']").value.trim();
    const pwdNotice = document.querySelector("#register-input-pwd > .regi-notice-wrapper");
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
    if (pwd !== "") {
        if (passwordRegex.test(pwd)) {
            pwdNotice.innerHTML = "";
            return true;
        } else {
            showNotice(pwdNotice, "영문, 숫자를 포함한 8자리 이상의 비밀번호를 입력해주세요.", "pwd-form");
            return false;
        }
    } else {
        showNotice(pwdNotice, "비밀번호를 입력해주세요.", "pwd-empty");
        return false;
    }
}

function validatePwdConfirm() {
    const pwdConfirm = document.querySelector("#register-pwd-confirm").value.trim();
    const pwdConfirmNotice = document.querySelector("#register-input-pwd-confirm > .regi-notice-wrapper");
    const pwd = document.querySelector("input[name='memberPwd']").value;
    if (pwdConfirm !== "") {
        if (pwdConfirm === pwd) {
            pwdConfirmNotice.innerHTML = "";
            return true;
        } else {
            showNotice(pwdConfirmNotice, "비밀번호가 일치하지 않습니다.", "pwd-confirm");
            return false;
        }
    } else {
        showNotice(pwdConfirmNotice, "비밀번호를 한 번 더 입력해주세요.", "pwd-confirm-empty");
        return false;
    }
}


// ==================================================== 닉네임 ==============================================

function validateNickname(ev) {
    const nickname = document.querySelector("input[name='nickname']").value.trim();
    const nicknameNotice = document.querySelector("#register-input-nickname > .regi-notice-wrapper");
    const specialCharacterRegex = /[!@#$%^&*(),.?":{}|<>[\]\\/~`'_\-+=;№]/;
    
    if (nickname !== "") {
        if (specialCharacterRegex.test(nickname)) {
            showNotice(nicknameNotice, "닉네임에는 특수문자가 사용할 수 없습니다.", "nickname-form-special");
        } else if (nickname.length > 15) {
            showNotice(nicknameNotice, "15글자 이하로 입력해주세요.", "nickname-form-max");
        } else if (nickname.length < 2) {
            showNotice(nicknameNotice, "2글자 이상 입력해주세요.", "nickname-form-min");
        } else {
            nicknameNotice.innerHTML = "";
            const idCheckBtn = document.querySelector("#nameCheck");
            idCheckBtn.style.pointerEvents = "auto";

            idCheckBtn.addEventListener('click', () => {checkNickname(idCheckBtn, nicknameNotice, nickname)});
        }
    } else {
        showNotice(nicknameNotice, "닉네임을 입력해주세요.", "nickname-empty");
    }
}

function checkNickname(idCheckBtn, nicknameNotice, nickname) {
    $.ajax({
        url: "nameCheck.me",
        data: { checkName: nickname },
        success: function (result) {
            if (result === "NNNNY") {
                showNotice(nicknameNotice, "이미 사용중인 닉네임입니다.", "nickname-check");
            } else {
                nicknameNotice.innerHTML = "";
                idCheckBtn.value = "사용가능";
                idCheckBtn.style.pointerEvents = "none";
                idCheckBtn.style.background = "#1e90ff";
                idCheckBtn.style.color = "#ffffff";
            }
        },
        error: function () {
            console.log("닉네임 중복체크 실패");
        }
    });
}


// ==================================================== 핸드폰 ===============================================

 function validatePhoneNumber() {
    const phone = document.querySelector("input[name='memberPhone']").value.trim();
    const phoneNotice = document.querySelector("#register-input-phone > .regi-notice-wrapper");
    const onlyNumbersRegex = /^[0-9]+$/;
    if (phone !== "") {
        if (!onlyNumbersRegex.test(phone)) {
            showNotice(phoneNotice, "전화번호에는 숫자만 기입 가능합니다.", "phone-form-onlyNum");
        } else if (phone.length !== 11) {
            showNotice(phoneNotice, "전화번호 형식이 올바르지 않습니다(11자리).", "phone-form");
        } else {
            phoneNotice.innerHTML = "";
            const authBtn = document.querySelector("#member-auth-btn");
            authBtn.style.pointerEvents = "auto";
            authBtn.addEventListener('click', new PhoneAuthentication());
        }
    } else {
        showNotice(phoneNotice, "전화번호를 입력해주세요.", "phone-empty");
    }
}



class PhoneAuthentication{

    constructor(){
        this.isSend = false; // 인증번호 전송 여부
        this.authNo = ''; // 인증번호
        this.timerId = null; //타이머
        this.timer = $('.timer>h4'); // 타이머 ui
        // input 창 한 쪽에 나타나게 하면 어떨까?
        this.input = $("input[name='phone-authNo']");// 인증번호 input

        this.sendBtn = $('#member-auth-btn'); // 인증번호 전송 버튼
        this.authBtn = $('#member-phone-auth-btn'); // 인증번호 체크 버튼

        this.sendBtn.on('click',()=>{
            console.log("클릭");
            this.sendAuthNum();
        });

        this.authBtn.on('click', ()=>{
            this.checkAuthNum();
        });
    }

    showNotice(element, message, className) {
        element.innerHTML = `<span class="regi-notice ${className}">${message}</span>`;
    }

    sendAuthNum = async function(){
        const phone = $("input[name='memberPhone']").val();
        
        // 핸드폰 번호 본인인증 클릭 시 db 에서 체크하도록
        const isPhoneRegistered = await new Promise((resolve) => {
            checkPhoneNumberAjax({phone: phone}, res => {
                if(res === "NNNNY"){
                    const phoneNotice = document.querySelector("#register-input-phone > .regi-notice-wrapper");
                    showNotice(phoneNotice, "이미 사용중인 전화번호입니다.", "phone-check")
                    resolve(true);  // 이미 가입한 전화번호인 경우 true 반환
                } else {
                    resolve(false); // 아닌 경우 false 반환
                }
            });
        });

        if (isPhoneRegistered) {
            return;  // 이미 가입한 전화번호인 경우 이후 코드 실행 중단
        }


        if(this.isSend){
            const result = confirm('재전송 하시겠습니까?');
            if(!result){ // 재전송 거절 시
                return;
            } else {
                clearInterval(this.timerId); // 호출 스케쥴링(일정 시간 간격 두고 함수 실행)
            }
        };

        // 랜덤번호 생성
        this.authNo = Math.floor(Math.random() * 100000).toString().padStart(6, '0');

        $('#phoneAuthSection').css('display','flex');

        sendPhoneAuthNoAjax({authNo: this.authNo, phone: phone}, res => {
            if(res === "success"){
                alert("인증번호가 발송되었습니다.")
                console.log("인증번호 : " + this.authNo);
                console.log("전송한 휴대폰 번호 : " + phone);

                this.timer.css("color", "red");
                this.authBtn.prop('disabled', false);
                this.input.prop('readonly', false).val('').focus();

                this.isSend = true;
                this.startTimer(181); // 3분 타이머 시작
            } else {
                console.log("전송한 휴대폰 번호 : " + phone);
                alert('전송 실패');
                this.authNo = '';
            }
        });

    };

    checkAuthNum(){
        const inputCode = this.input.val();
        const authNumNotice = document.querySelector("#register-input-authNo > .regi-notice-wrapper");
        if(this.authNo.trim() !== inputCode){
            showNotice(authNumNotice, "잘못된 인증번호입니다.", "authNo-un");
        }else {
            const phoneAuthBtn = document.querySelector('#member-phone-auth-btn');

            this.sendBtn.prop('disabled', true);

            alert('인증성공');
            clearInterval(this.timerId);
        
            authNumNotice.innerHTML = "";

            phoneAuthBtn.value = "인증완료";
            phoneAuthBtn.style.pointerEvents = "none";
            phoneAuthBtn.style.background = "#1e90ff";
            phoneAuthBtn.style.color = "#ffffff";

            this.input.prop('readonly', true);            
            this.timer.css("color", "#4aa500");
            this.isSend = false;
            this.authBtn.prop('disabled', true);
        };
    };

    startTimer(duration){
        let timeLeft = duration;
        this.timerId =  setInterval(() => {
            if(timeLeft <= 0){
                clearInterval(this.timerId);
                showNotice(document.querySelector("#register-input-authNo > .regi-notice-wrapper"), "인증시간이 초과되었습니다.", "authNo-over");
                this.timer.text("3:01");
                this.authBtn.prop('disabled', true);
                this.authNo = "";
            } else {
                timeLeft --;
                let minutes = Math.floor(timeLeft/60);
                let seconds = timeLeft % 60;
                this.timer.text(minutes + ":" + (seconds < 10 ? '0' : '') + seconds);
            }
        }, 1000); // 1초마다
    }
};

// 휴대폰 인증 관련 ajax 함수
function sendPhoneAuthNoAjax(data, callback){
    $.ajax({
        url:'authPhone.me',
        type: 'post',
        data,
        success: res => callback(res),
        error: () => {
            alert('휴대폰 인증번호 전송 실패');
        }
    });
};

function checkPhoneNumberAjax(data, callback){
    $.ajax({
        url: "checkPhoneNum.me",
        method: "post",
        data,
        success: res => callback(res),
        error: () => {
            alert('휴대폰 번호 전송 실패');
        }
    })
}

// ====================================================== 생년월일 =====================================

function validateBirthdate() {
    const birthdate = document.querySelector("input[name='birth']").value.trim();
    const birthNotice = document.querySelector("#birthInput >.regi-notice-wrapper");
    const birthdateRegex = /^(19|20)\d{2}-\d{2}-\d{2}$/;
    if (birthdate !== "") {
        if (birthdateRegex.test(birthdate)) {
            const [year, month, day] = birthdate.split('-').map(Number);
            const today = new Date();
            const birthDate = new Date(year, month - 1, day);
            if (birthDate > today) {
                showNotice(birthNotice, "미래 날짜는 입력할 수 없습니다.", "birth-form");
                return false;
            } else {
                birthNotice.innerHTML = "";
                return true;
            }
        } else {
            showNotice(birthNotice, "날짜 형식이 올바르지 않습니다. (예: YYYY-MM-DD)", "birth-form");
            return false;
        }
    } else {
        showNotice(birthNotice, "생년월일을 입력해주세요.", "birth-empty");
        return false;
    }
}

// ==================================================== 주소 ========================================

function setAddress(){
    // 버튼 없애고 새로운 input 창들 생성 후 위 메소드의 결과값 띄우기
    let addressSection = document.querySelector("#registAddressSection");
    addressSection.removeChild(document.getElementById("addressSearch"));
    let searchResult = document.createElement('div');
    addressSection.appendChild(searchResult);
    searchResult.setAttribute("id", "address-search-result");

    searchResult.innerHTML = `
                            <input type="text" class="register-input" id="sample6_postcode" style="width: 160px;" required></input>
                            <input type="text" class="register-input" id="sample6_address" required></input>
                            <div class="regi-notice-wrapper notice-form-address"></div>
                            <input type="text" class="register-input" id="sample6_detailAddress" placeholder="상세 주소를 입력해주세요" required></input>
                            <div class="regi-notice-wrapper notice-form-detail-address"></div>
                            `

    let totalAddress = document.createElement('input');
    searchResult.appendChild(totalAddress);
    totalAddress.setAttribute("type", "hidden");
    totalAddress.setAttribute("name", "memberAddress");
    totalAddress.setAttribute("id", "totalAddress");

    sample6_execDaumPostcode();

    checkAddressVali();
}

function validateTotalAddress() {
    let isTrue = true;
    const address = document.querySelector("#sample6_address");
    const detailAddress = document.querySelector("#sample6_detailAddress");
    const addressNotice = document.querySelector(".notice-form-address");
    const detailAddressNotice = document.querySelector(".notice-form-detail-address");

    if (address && detailAddress) {
        if (address.value.trim() === "") {
            showNotice(addressNotice, "주소를 입력해주세요.", "address-empty");
            isTrue = false;
        } else {
            addressNotice.innerHTML = "";
        }

        if (detailAddress.value.trim() === "") {
            showNotice(detailAddressNotice, "상세주소를 입력해주세요.", "detail-address-empty");
            isTrue = false;
        } else {
            detailAddressNotice.innerHTML = "";
        }

        if (isTrue) {
            document.querySelector("#totalAddress").value = address.value + " " + detailAddress.value;
        }
    }

    return isTrue;
}

function validateAddress(ev) {
    const address = ev.target.value.trim();
    const addressNotice = document.querySelector(".notice-form-address");
    if (address === "") {
        showNotice(addressNotice, "주소를 입력해주세요.", "address-empty");
        return false;
    } else {
        addressNotice.innerHTML = "";
        return true;
    }
}

function validateDetailAddress(ev) {
    const detailAddress = ev.target.value.trim();
    const detailAddressNotice = document.querySelector(".notice-form-detail-address");
    if (detailAddress === "") {
        showNotice(detailAddressNotice, "상세주소를 입력해주세요.", "detail-address-empty");
        return false;
    } else {
        detailAddressNotice.innerHTML = "";
        return true;
    }
}

function sample6_execDaumPostcode() {
    new daum.Postcode({
    oncomplete: function (data) {
    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ''; // 주소 변수

        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
        } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('sample6_postcode').value = data.zonecode;
        document.getElementById("sample6_address").value = addr;
        // 커서를 상세주소 필드로 이동한다.
        document.getElementById("sample6_detailAddress").focus();

        // 주소와 상세주소 합치기
        document.getElementById("totalAddress").value = addr + " " + document.getElementById("sample6_detailAddress").value;
    }
    }).open();
}

function checkAddressVali(){
    // 주소 입력 필드의 유효성 검사를 위한 이벤트 리스너 설정
    const addressField = document.querySelector("#sample6_address");
    const detailAddressField = document.querySelector("#sample6_detailAddress");
    
    if (addressField && detailAddressField) {
        addressField.addEventListener('blur', function (ev) {
            console.log("체크1")
            validateAddress(ev);
            validateTotalAddress();
        });

        detailAddressField.addEventListener('blur', function (ev) {
            console.log("체크2")
            validateDetailAddress(ev);
            validateTotalAddress();
        });
}
}

// ======================================================== 이용약관 =========================================

function setTermSection() {
    const termsCheckboxes = document.querySelectorAll(".list input[type='checkbox']");
    const allCheckbox = document.querySelector("#select-all");

    allCheckbox.addEventListener('click', function () {
        termsCheckboxes.forEach(checkbox => checkbox.checked = allCheckbox.checked);
    });

    termsCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('click', function () {
            const allChecked = [...termsCheckboxes].every(checkbox => checkbox.checked);
            allCheckbox.checked = allChecked;
        });
    });
}

function validateTerm(){
    let isTrue = true;

    document.querySelectorAll(".list input[type='checkbox']").forEach(checkbox => {
        if(!checkbox.checked) isTrue = false;
    });
    if (!isTrue) {
        alert("모든 약관에 동의해야 회원가입이 가능합니다.");
    }
    return isTrue
}
