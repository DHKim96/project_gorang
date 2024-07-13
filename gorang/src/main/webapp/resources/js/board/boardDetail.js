document.addEventListener('DOMContentLoaded', ()=>{
    // 스크랩 버튼 클릭 이벤트
    document.querySelector("#scrap-div").addEventListener('click', (ev) => toggleScrapBoard(ev));
    // 좋아요 버튼 클릭 이벤트
    document.querySelector("#contentLike").addEventListener('click', (ev) => toggleLikeBoard(ev));
    // 신고하기 버튼 클릭 이벤트
    document.querySelector("#contentReport").addEventListener('click', handleModalBtnClick);
    // 신고하기 제출 버튼 클릭 이벤트
    document.querySelector("#modal-reportBtn").addEventListener('click', (ev) => reportBoard(ev));

    // 댓글 작성 버튼 클릭 이벤트
    document.querySelector("#board-reply-button").addEventListener('click', (ev) => ajaxAddReply(ev));

    ajaxForGetReplyList();

    // 게시글 삭제 버튼 클릭 이벤트
    handleBoardDeleteBtnClick();
})




//========================================================================= 유틸리티 ========================================================================================

// 게시글 객체의 기본키 추출
function getBoardNo(){
    return document.querySelector("#contentTitle").getAttribute('data-boardNo');
}

// contextPath 추출
function getContextPath(){
    return sessionStorage.getItem("contextpath");
}


//========================================================================= 게시글 ========================================================================================

/** 게시글 삭제 관련 메소드 */
function deleteBoard(element) {
    const result = confirm("게시글을 삭제하시겠습니까?");

    if (result) {
        const boardNo = getBoardNo();

        $.ajax({
            url: 'delete.bo',
            type: 'post',
            data: {
                boardNo: boardNo
            },
            success: function (res) {
                console.log(res);
                if (res === 'done') {
                    alert("게시글을 삭제하였습니다.");
                    window.location.href = "main.bo";
                } else {
                    alert("게시글 삭제를 실패하였습니다.");
                }
            },
            error: function () {
                console.log("게시글 삭제 api 호출 실패");
            }
        })
    }
}

/** 게시글 삭제하기 버튼 유효성 체크 후 클릭 이벤트 부여 */
function handleBoardDeleteBtnClick(){
    const boardDeleteBtn = document.querySelector("#board-delete-btn");
    if(boardDeleteBtn){
        boardDeleteBtn.removeEventListener('click', (ev) => deleteBoard(ev));
        boardDeleteBtn.addEventListener('click', (ev) => deleteBoard(ev));
    };
}

//========================================================================= 댓글 ========================================================================================


/** 댓글 작성 ajax */
function ajaxAddReply(ev) {
    const replyInputDiv = ev.target.closest('.board-reply-input');
    let refCommentNo = ev.target.getAttribute('data-refNo');
    const boardNo = getBoardNo();
    // 대댓글 작성 버튼으로 발생한 이벤트가 아닐시
    if(!refCommentNo){
        refCommentNo = 0;
    }
    const commentContentValue = replyInputDiv.querySelector('.reply-textarea').value;
    
    if(commentContentValue.trim() === "") {
        alert("댓글내용을 입력해주세요");
        return;
    }
    const comment = {
        commentContent: commentContentValue,
        boardNo: boardNo,
        refCommentNo: refCommentNo
    }

    ajaxForInsertReply(comment);
}

/** 댓글 insert 하기 위한 ajax */
function ajaxForInsertReply(data){
    document.querySelector("#commentContent").value = "";

    $.ajax({
        url: 'insert.co',
        type: 'post',
        data,
        success: (res) => {
            if (res === "NNNNY") {
                console.log("댓글 저장 성공");
                ajaxForGetReplyList();
            };
        },
        error: () => {console.log("댓글 달기 api 호출 실패");}
    })
}

/** 댓글 select 해서 가져오는 ajax */
function ajaxForGetReplyList(){
    const boardNo = parseInt(getBoardNo());
    $.ajax({
        url: 'selectList.co',
        data: { boradNo: boardNo },
        success: (res) => {
            // 댓글 영역 초기화
            const replyArea = document.querySelector("#ReplyArea");
            replyArea.innerHTML = "";
            // 최초 실행 시 refNo 없음, level 0
            drawReply(res, 0, 0);
            // 대댓글 댓글 달기 버튼 클릭 이벤트
            handleAddReplyBtnClick();
            // 댓글 삭제 버튼 클릭 이벤트
            handleReplyDeleteBtnClick();
        },
        error: () => {console.log("댓글 호출 실패");}
    })
}

function drawReply(replyList, refNo, level){
    // 댓글 div
    const replyArea = document.querySelector("#ReplyArea");
    // 댓글 객체 반복문
    for(let reply of replyList){
        // 현재 참조하고자 하는 부모 댓글에 해당하지 않으면 스킵. 따라서 무한 루프에서 벗어남
        if(reply.refCommentNo != refNo){
            continue;
        }
        const userReplyWrapDiv = document.createElement('div');
        replyArea.appendChild(userReplyWrapDiv);
        userReplyWrapDiv.setAttribute('class', 'userReplyWrap');
        // 댓글 요소 생성 후 추가
        // 대댓글일시 공백 생성
        for(let i = 0; i < Math.min(level, 5); i++ ){
            userReplyWrapDiv.appendChild(blank());
        }
        userReplyWrapDiv.appendChild(setReplyDiv(reply, level));
        // 재귀함수 실시
        drawReply(replyList, reply.commentNo, level + 1);
    }
}

/** 대댓글일 시 댓글 앞에 공백 늘려주는 메소드 */
function blank(){
    const div = document.createElement('div');
    div.setAttribute('class', 'comment-level');
    return div;
}

/** 댓글 요소 생성해주는 메소드 */
function setReplyDiv(reply, level){
    const contextPath = getContextPath();
    // 유저 정보
    const loginUserNo = parseInt(document.querySelector("#scrap-div").getAttribute('data-userNo'));

    // 댓글 작성자 정보, 내용 담은 div
    const userReplyWriterInfoDiv = document.createElement('div');
    userReplyWriterInfoDiv.setAttribute('class', 'userReplyWriterInfo');
    // 댓글 작성자 프로필 사진 div
    const userReplyWriterImgWrapDiv = document.createElement('div');
    userReplyWriterInfoDiv.appendChild(userReplyWriterImgWrapDiv);
    userReplyWriterImgWrapDiv.setAttribute('class', 'userReplyWriterImgWrap');
    userReplyWriterImgWrapDiv.innerHTML = `<img src="${contextPath}/resources/uploadfile/memberProfile/${reply.commentWriterImg}">`;
    // 댓글 내용 div
    const userReplyContentWrapDiv = document.createElement('div');
    userReplyWriterInfoDiv.appendChild(userReplyContentWrapDiv);
    userReplyContentWrapDiv.setAttribute('class', 'userReplyContentWrap');
    // 댓글 작성자 닉네임, 작성일, 대댓글 달기, 댓글 삭제 담은 div
    const userReplyWriterDetailDiv = document.createElement('div');
    userReplyContentWrapDiv.appendChild(userReplyWriterDetailDiv);
    userReplyWriterDetailDiv.setAttribute('class', 'userReplyWriterDetail');
    userReplyWriterDetailDiv.setAttribute('data-replyNo', reply.commentNo);
    userReplyWriterDetailDiv.innerHTML = `<div class="userReplyWriterDetailId">${reply.commentWriter}</div>
                                          <div class="userReplyWriterDetailDate"><span>${reply.commentDate}</span></div>`;
    // 로그인했을시만 댓글 달기 활성화
    if(loginUserNo != null){
        userReplyWriterDetailDiv.innerHTML += `<div class="add-reply-btn hover-curser" id="ref-reply-btn" data-level=${level}>댓글 달기</div>`;
        // 작성자일 경우에만 댓글 삭제 활성화
        if(loginUserNo == reply.writerNo){
            userReplyWriterDetailDiv.innerHTML += `<div data-commentNo="${reply.commentNo}" class="delete-reply-btn hover-curser">댓글 삭제</div>`;
        }
    }
    // 댓글 내용
    userReplyContentWrapDiv.innerHTML += `<div class="userReplyContent">
                                                <div>${reply.commentContent}</div>
                                            </div>`;
    return userReplyWriterInfoDiv;
}

/** 모든 대댓글 댓글 달기 버튼에 이벤트 부여하는 메소드 */
function handleAddReplyBtnClick(){
    document.querySelectorAll('.add-reply-btn').forEach(replyBtn => {
        const level = parseInt(replyBtn.getAttribute('data-level'));
        replyBtn.removeEventListener('click', (ev) => applyReplyDiv(ev, level));
        replyBtn.addEventListener('click', (ev) => applyReplyDiv(ev, level));
    })
}

/** 대댓글 작성 공간 생성하는 메소드 */
function applyReplyDiv(ev, level) {
    const replyTargetDiv = ev.target.closest('.userReplyWrap');
    const commentNo = replyTargetDiv.querySelector('.userReplyWriterDetail').getAttribute('data-replyNo');
    const existReply = document.querySelector('.reply-input');
    if(existReply){
        existReply.remove();
    }
    const replyInputDiv = drawReReply(replyTargetDiv, commentNo, level);
    // 대댓글 작성 div 의 등록 버튼 클릭 이벤트
    replyInputDiv.querySelector(".submit-reply").addEventListener('click', (ev) => ajaxAddReply(ev));
}

/** 대댓글 input창 생성 메소드 */
function drawReReply(replyTarget, commentNo, level) {
    const replyInputDiv = document.createElement('div');

    for (let i = 0; i < Math.min(level, 5) + 2; i++) {
        replyInputDiv.appendChild(blank());
    }

    replyInputDiv.classList.add('reply-input');
    replyInputDiv.classList.add('board-reply-input');

    const textarea = document.createElement('textarea');
    textarea.classList.add('rereply-textarea', 'reply-textarea');
    textarea.setAttribute('placeholder', '댓글을 입력하세요');
    textarea.setAttribute('maxlength', '500');
    replyInputDiv.appendChild(textarea);

    const button = document.createElement('button');
    button.type = 'button';
    button.classList.add('submit-reply');
    button.setAttribute('data-refNo', commentNo);
    button.textContent = '등록';
    replyInputDiv.appendChild(button);

    replyTarget.insertAdjacentElement('afterend', replyInputDiv);
    // 화면 다른 곳 클릭 시 대댓글 input 사라지게 하는 이벤트 핸들러
    document.addEventListener('click', (ev) => {
        // 클릭한 곳이 댓글 영역 이외의 곳이라면 삭제
        if (!ev.target.closest('#ReplyArea')) {
            document.querySelectorAll('.reply-input').forEach(input => {
                input.remove();
            });
        }
    });

    return replyInputDiv;
}



/** 댓글 삭제 관련 메소드 */
function removeReply(ev) {
    const commentNo = ev.target.getAttribute('data-commentNo');
    $.ajax({
        url: 'delete.co',
        type: 'post',
        data: {commentNo: commentNo},
        success: (res) => {
            if (res === 'done') {
                alert('댓글을 삭제하였습니다.');
                window.location.reload();
            }
        },
        error: () => {console.log("댓글 삭제 api 호출 실패");}
    })
}


/** 댓글 삭제 버튼 유효성 체크 후 클릭 이벤트 부여 */
function handleReplyDeleteBtnClick(){
    const replyDeleteBtns = document.querySelectorAll(".delete-reply-btn");
    if(replyDeleteBtns){
        replyDeleteBtns.forEach(replyDeleteBtn => {
            if(replyDeleteBtn){
                replyDeleteBtn.addEventListener('click', (ev) => removeReply(ev));
            };
        })
    };
}

//========================================================================= 신고하기 ========================================================================================

/** 신고하기 모달 내 체크박스 관련 메소드 */
function checkSelectedOneOption(event) {
    const checkBoxes = document.querySelectorAll('.reason');
    checkBoxes.forEach(function (checkBox) {
        checkBox.checked = false;
    })
    event.target.checked = true;
}

/** 신고하기 모달 관련 메소드 */
function handleModalBtnClick(){
    const modal = document.getElementById("myModal");
    const modalBtn = document.getElementById("contentReport");

    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    modalBtn.addEventListener('click', () => {
        modal.style.display = "block";
        const boardTitle = document.querySelector('#board-title').innerText;
        const reportBoardTitle = document.querySelector('#report-board-title');
        reportBoardTitle.value=boardTitle;
    })

    handleModalSpanClick(modal);
}

/** 신고하기 모달 내 close 버튼 클릭 시 모달 닫는 메소드 */
function handleModalSpanClick(modal){
    const modalSpan = document.getElementsByClassName("close")[0];
    modalSpan.addEventListener('click', ()=>{
        modal.style.display = "none";
    })
}


/** 신고 관련 내용 ajax 통해 백으로 보내는 함수 */
function reportBoard(element) {
    const checkedReasonDiv = document.querySelector('.reason:checked');
    const reportContentDiv = document.querySelector('#report-content');
    const boardNo = getBoardNo();
    
    if(!checkedReasonDiv) {
        alert("신고사유를 골라주세요.");
        return;
    } 

    const reason = checkedReasonDiv.closest('.reason-div').querySelector('label').innerText;
    const reportContent = reportContentDiv.value;

    $.ajax({
        url: 'report.bo',
        type: 'post',
        data: {
            boardNo: boardNo,
            reportReason : reason,
            reportContent : reportContent
        },
        success: function(res) {
            if(res === "done") {
                alert("신고가 성공적으로 완료되었습니다.");
                window.location.reload();
            } else {
                alert("신고를 실패하였습니다.");
            }
        },
        error : function() {
            console.log("게시글 신고 api 호출 실패");
        }

    })
    
}

//========================================================================= 스크랩 / 좋아요 ========================================================================================

/** 좋아요 후 ajax로 백에 보내는 함수 */
function toggleLikeBoard(ev) {
    ev.preventDefault();
    const loginUserNo = ev.target.getAttribute('data-userNo');
    const boardNo = getBoardNo();

    if (loginUserNo) {
        $.ajax({
            url: 'like.bo',
            type: 'post',
            data: {
                boardNo: boardNo
            },
            success: function (res) {
                if (res === 'cancle_like') {
                    alert("좋아요 취소하셨습니다.");
                } else if (res === 'do_like') {
                    alert("좋아요를 누르셨습니다.")
                } else {
                    alert("좋아요를 실패하였습니다.");
                }
                window.location.reload();
            },
            error: function () {
                console.log('좋아요 기능 api 호출 실패');
            }
        })
    } else {
        alert("로그인이 필요한 기능입니다.");
    }

}

/** 스크랩 후 ajax 로 back 에 보내는 함수 */
function toggleScrapBoard(element) {
    const loginUserNo = element.getAttribute('data-userNo');
    const boardNo = getBoardNo();

    if(loginUserNo) {
        $.ajax({
            url:'scrap.bo',
            type: 'post',
            data: {
                boardNo: boardNo
            },
            success: function (res) {
                if (res === 'cancle_scrap') {
                    alert("스크랩을 취소하셨습니다.");
                } else if (res === 'do_scrap') {
                    alert("스크랩을 완료하였습니다.")
                } else {
                    alert("스크랩을 실패하였습니다.");
                }
                window.location.reload();
            }, 
            error: function() {
                console.log('상품 스크랩 api 호출 실패');
            }
        })
    } else {
        alert("로그인이 필요한 기능입니다.");
    }
}
