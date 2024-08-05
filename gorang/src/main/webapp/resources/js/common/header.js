document.addEventListener('DOMContentLoaded', ()=>{
    const headerProfileImg = document.querySelector("#header-profile-img");
    if(headerProfileImg){
        const loginUserMemberNo = parseInt(headerProfileImg.getAttribute('data-value'));

        document.querySelector("#header-notify-bell").addEventListener('click', () => {
        getNotificationsByAjax(loginUserMemberNo, res => setNotifyDropdown(res));
    })
    }
    
    let searchInput = document.querySelector('#search-input');
    searchInput.addEventListener("keypress", function(event) {
        if(event.key === 'Enter') {
            event.preventDefault();
            search(searchInput.value);
        }
    });    
})


// 페이지 이동 함수
function moveLocation(path){

    if(path === '/gorang/logout.me') {
        localStorage.removeItem("uploadFile");
        localStorage.removeItem("tempBoardContent");
    }

    window.location.href =(path)

    }


function search(value) {
    // alert(value);
    if(value.trim()=== "") return;
    window.location.href = "search.re?content=" + value;
}

function searchResult() {
    let searchInput = document.querySelector('#search-input');
    search(searchInput.value);
}

// ================================ 알람 관련 메소드 =============================

/** ajax 로 알림 객체 받는 메소드  */
function getNotificationsByAjax(data, callback){
    $.ajax({
        url:"getAlarmsByAjax.me",
        data: {memberNo: data},
        success: function(res){
            callback(res);
        },
        error: function(){
            console.log("송신 실패");
        }
    })
}

/** ajax 로 받은 알림 객체들로 li 요소들 생성하는 메소드 */
function setNotifyDropdown(notifications){
    const dropDownUl = document.querySelector(".dropdown-menu > ul");
    dropDownUl.innerHTML = `<li><h6 class="dropdown-header" style="padding : 0">알림</h6></li>
                            <li><hr class="dropdown-divider"></hr></li>`
    if(notifications.length == 0){
        dropDownUl.innerHTML += "알림이 없습니다.";
    } else {
        for(let notify of notifications){
            const dropDownLi = document.createElement('li');
            dropDownUl.appendChild(dropDownLi);
            dropDownLi.setAttribute('class', 'dropdown-menu-ul-li')
            switch(notify.notifyType){
                case 1:
                    dropDownLi.innerHTML += "[좋아요]"
                    break;
                case 2:
                    dropDownLi.innerHTML += "[댓글]"
                    break;
                case 3:
                    dropDownLi.innerHTML += "[문의]"
                    break;
                case 4:
                    dropDownLi.innerHTML += "[후기]"
                    break;
                case 5:
                    dropDownLi.innerHTML += "[소비기한]"
                    break;
            }
    
            dropDownLi.innerHTML += notify.content;
            dropDownLi.addEventListener('click', () => {
                location.href = notify.notifyUrl;
            })
        }
    }
}