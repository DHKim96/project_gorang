
window.onload = function(){

    const ctx = getContextPath();

    function getContextPath() {
        return sessionStorage.getItem("contextpath");
    };

    document.querySelector("#gorang-logo").addEventListener("click", function(){
        location.href = (ctx);
    })

    //네이버로그인설정
    const naverLoginBtn = document.getElementById('naver-login');
    naverLoginBtn.addEventListener("click", function(ev){
        console.log("Test");
        naverLogin(ev);
    })
    
   const googleLoginBtn = document.getElementById('google-login');
   googleLoginBtn.addEventListener("click", function(ev){
        console.log("Test");
        googleLogin(ev);
   })

   const kakaoLoginBtn = document.getElementById('kakao-login');
   kakaoLoginBtn.addEventListener("click", function(ev){
        console.log("Test");
        kakaoLogin(ev);
   })
}

const state = Math.random().toString(36).substring(2);

function naverLogin(ev){
    const naverClientId = "6D1ucwJgv10DLouX8avE";
    //리다이렉트 URI를 utf-8로 인코딩해서 저장
    const naverRedirectURI = encodeURIComponent("http://localhost:8111/gorang/naver-login");
    //로그인 api url
    const naverApiURL = 'https://nid.naver.com/oauth2.0/authorize?response_type=code&'
        + 'client_id=' + naverClientId + "&redirect_uri=" + naverRedirectURI + '&state=' + state;

    location.href= naverApiURL;
}

function googleLogin(ev){
    const googleClientId = "40344897700-35960j6e829nkhubnsg0hgjjgm4jis0t.apps.googleusercontent.com"
    const googleRedirectURI = encodeURIComponent("http://localhost:8111/gorang/google-login");
    // 로그인 api url
    const googleApiURL = 'https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id=' +
                        googleClientId + '&redirect_uri=' + googleRedirectURI +'&scope=email profile' + '&state=' + state;
    
    location.href= googleApiURL;
}

function kakaoLogin(ev){
    const kakaoClientId = "d4037551f8cbcbabd29870906070f07f"
    const kakaoRedirectURI = encodeURIComponent("http://localhost:8111/gorang/kakao-login");
    // 로그인 api url
    const kakaoApiURL = 'https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=' +
                        kakaoClientId + '&redirect_uri=' + kakaoRedirectURI  + '&state=' + state;
    
    location.href= kakaoApiURL;
}