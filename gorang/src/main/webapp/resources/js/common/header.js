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

// ========================================== 전역 변수 ============================================
const headerContextPath = sessionStorage.getItem("contextpath");


// ===================================================================================================
// 페이지 이동 함수
function moveLocation(path){

    if(path === '/gorang/logout.me') {
        localStorage.removeItem("uploadFile");
        localStorage.removeItem("tempBoardContent");
    }
    console.log("contextpath:", path)
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
        url:"notifications/getAlarmsByAjax.me",
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
        const sortedNotifications = sortNotifications(notifications);
        for(let notify of sortedNotifications){
            setNotificationDropDownLi(dropDownUl,notify);    
        }
    }
}

/** 알림 중 소비기한 알림을 먼저 노출시키도록 정렬해주는 메소드 */
function sortNotifications(notifications){
    // 1. 소비기한 알림 타입이 5인 객체들을 우선적으로 필터링
    const priorityNotifications = notifications.filter(notify => notify.notifyType === 5);
    // 2. 나머지 알림들을 필터링
    const otherNotifications = notifications.filter(notify => notify.notifyType !== 5);
    // 3. 소비기한 알림들을 먼저, 그 다음에 다른 알림들을 순서대로 노출
    const sortedNotifications = [...priorityNotifications, ...otherNotifications];

    return sortedNotifications;
}

/** 알림창 dropDownLi 만드는 메소드 */
function setNotificationDropDownLi(dropDownUl, notify){
    const dropDownLi = document.createElement('li');
    dropDownUl.appendChild(dropDownLi);
    dropDownLi.setAttribute('class', 'dropdown-menu-ul-li')
    dropDownLi.setAttribute('data-notificationNo', notify.no);
    // 소비기한 알림일 시 폰트 굵기 확대
    if( notify.notifyType == 5){
        dropDownLi.style.fontWeight = "bold";
    } 
    
    dropDownLi.innerHTML += setNotificationForeword(dropDownLi, notify);

    dropDownLi.innerHTML += notify.content;

    setNotificationDeleteDiv(dropDownLi);

    dropDownLi.addEventListener('click', () => {
        updateNotificationIsReadTrueByAjax(notify);
    })

    //클릭 시 배경색 변하는 이벤트 부여
    dropDownLi.addEventListener('mouseenter', () => {
        dropDownLi.style.backgroundColor = '#EDEDED';
    })

    dropDownLi.addEventListener('mouseleave', () => {
        dropDownLi.style.backgroundColor = 'transparent';
    })
}


/** 알림의 속성에 따라 머릿말 만들어주는 메소드 */
function setNotificationForeword(dropDownLi, notify){
    switch(notify.notifyType){
        case 1:
            dropDownLi.innerHTML += "[좋아요] "
            break;
        case 2:
            dropDownLi.innerHTML += "[댓글] "
            break;
        case 3:
            dropDownLi.innerHTML += "[문의] "
            break;
        case 4:
            dropDownLi.innerHTML += "[후기] "
            break;
        case 5:
            dropDownLi.innerHTML += "[소비기한] "
            break;
    }
    return  dropDownLi.innerHTML;
}

/** 알림 드롭다운 li 에 x 박스 만드는 메소드 */
function setNotificationDeleteDiv(dropDownLi){
    const deleteDiv = document.createElement('div');
    dropDownLi.appendChild(deleteDiv);
    deleteDiv.setAttribute('class', "dropdown-menu-ul-li-deleteDiv");

    // 폰트 어썸 xmark
    const notificationXmark = document.createElement('i');
    deleteDiv.appendChild(notificationXmark);
    notificationXmark.setAttribute("class", "fa-solid fa-xmark");

    // div 클릭 시 삭제
    deleteDiv.addEventListener('click', (ev) => {
        handleClickDeleteDiv(ev, dropDownLi);
    })
}

/** DIV 클릭 시 삭제하는 메소드 */
function handleClickDeleteDiv(ev, dropDownLi){
    ev.stopPropagation();
    let loginUserMemberNo = parseInt(document.querySelector("#header-profile-img").getAttribute('data-value'));
    const notificationNo = dropDownLi.getAttribute('data-notificationNo');
    data = {
            notifyNo : parseInt(notificationNo),
            memberNo : loginUserMemberNo
        };
    deleteNotificationByAjax(data, (res) => setNotifyDropdown(res));
}

/** 알림 삭제 요청 ajax */
function deleteNotificationByAjax(data, callback){
    $.ajax({
        url:"notifications/deleteNotificationByAjax",
        data: data,
        success: (res) => {
            console.log("삭제 성공");
            callback(res);
        },
        error: () => {
            console.log("통신 실패");
        }
    })
}

/** 알림 내용 클릭 시 notify.isRead = true 로 update 하는 메소드 */
function updateNotificationIsReadTrueByAjax(notify){
    $.ajax({
        url:"notifications/updateNotificationIsReadTrueByAjax",
        data: {notifyNo : notify.no},
        success: (res) => {
            if ( res === 0 ) return;
            console.log("읽음 표시 성공");
            location.href = headerContextPath + notify.notifyUrl;
        },
        error: () => {
            console.log("통신 실패");
        }
    })
}