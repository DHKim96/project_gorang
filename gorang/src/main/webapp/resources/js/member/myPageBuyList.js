document.addEventListener("DOMContentLoaded", function(){

    // 주문 취소 버튼 클릭 이벤트
    const cancelButtons = document.querySelectorAll(".tbody-td-btn-cancle");
    cancelButtons.forEach(function(button) {
        button.addEventListener("click", function(){
            showSweetConfirm();
        });
    });

    // 문의하기 버튼 클릭 이벤트
    const qnaButtons = document.querySelectorAll(".tbody-td-btn-qna");
    qnaButtons.forEach(function(button) {
        button.addEventListener("click", function(ev){
            ev.preventDefault();
            fillQnaModal(ev);
        });
    });

    // 후기작성 버튼 클릭 이벤트
    const reviewButtons = document.querySelectorAll(".tbody-td-btn-write");
    reviewButtons.forEach(function(button) {
        button.addEventListener("click", function(ev){   
            ev.preventDefault();
            fullReviewModal(ev);
        });
    });

    setRatingStar();

    // 이미지 버튼 클릭 시 해당하는 상품 상세 페이지로 이동하는 이벤트
    document.querySelectorAll(".tbody-td-img").forEach(imgTd => {
        const productNo = imgTd.closest(".tbody-buy-list-block").querySelector(".buyList-input-productNo").value;
        imgTd.querySelector("img").addEventListener('click', () => {location.href = ctp + "/detail.po?pno=" +  productNo});
    })

    setPaginationEventListeners();
});

// ================================== 유틸리티, 전역 변수 ======================================

const ctp = sessionStorage.getItem("contextpath");


// =================================== 모달 관련  함수 ==========================================


/** QNA 모달 내 유저, 상품 정보 기입하는 함수 */
function fillQnaModal(ev){
    // 문의하기 버튼을 자손으로 둔 tr 요소 찾기
    const trEl = ev.currentTarget.closest(".tbody-buy-list-block");

    const qnaModal = document.querySelector("#qna_Modal");
    resetImage(qnaModal);
    // 모달 내 참조 상품 번호 입력
    qnaModal.querySelector("input[name='refProductNo']").value = trEl.querySelector(".buyList-input-productNo").value;
    // 모달 내 상품명, 상품 옵션번호, 옵션명
    qnaModal.querySelector(".qna_product_name").innerHTML = trEl.querySelector(".product-name").innerHTML;
    qnaModal.querySelector(".qna_pdopt_name > option").value = trEl.querySelector(".buyList-input-pdOptNo").value;
    qnaModal.querySelector(".qna_pdopt_name > option").innerHTML = trEl.querySelector(".product-opt-name").innerHTML;

    setupFileInput(qnaModal);
}

/** review 모달 내 유저, 상품 정보 기입하는 함수 */
function fullReviewModal(ev){
    // 후기 작성 버튼을 자손으로 둔 tr 요소 찾기
    const trEl = ev.currentTarget.closest(".tbody-buy-list-block");

    const reviewModal = document.querySelector("#buyList-review_Modal");
    resetRating();
    resetImage(reviewModal);
    // 모달 내 참조 상품 번호 입력
    reviewModal.querySelector("input[name='refProductNo']").value = trEl.querySelector(".buyList-input-productNo").value;
    // 모달 내 상품명, 상품 옵션번호, 옵션명
    reviewModal.querySelector(".qna_product_name").innerHTML = trEl.querySelector(".product-name").innerHTML;
    reviewModal.querySelector(".qna_pdopt_name > option").value = trEl.querySelector(".buyList-input-pdOptNo").value;
    reviewModal.querySelector(".qna_pdopt_name > option").innerHTML = trEl.querySelector(".product-opt-name").innerHTML;

    setupFileInput(reviewModal);
} 

/** 주문 취소 관련 부트스트랩 모달 함수 */
function showSweetConfirm() {
    Swal.fire({
        title: '주문 취소하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소'
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire(
                '주문 취소',
                '주문이 취소되었습니다.',
                'success'
            );
            // 탈퇴 처리 코드 여기에 추가
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            Swal.fire(
                '취소됨',
                '주문이 취소되지 않았습니다.',
                'error'
            );
        }
    });
}

/** 이미지 파일 첨부 및 이미지 미리 보기 함수 */
function setupFileInput(modalElement) {
    const addPicBtn = modalElement.querySelector('.add_qna_product_pic');
    const fileInput = modalElement.querySelector('.file-input');
    const mainImgContainer = modalElement.querySelector('.qna_pic_container');

    // 파일 입력 변경 이벤트 핸들러 정의
    function handleFileInputChange(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (ev) {
                mainImgContainer.innerHTML = `<img class="qna-img" src="${ev.target.result}" alt="Selected Image">`;
            };
            reader.readAsDataURL(file);
            mainImgContainer.style.display = 'block';
        }
    
    }

    function handleFileInputClick(e){
        console.log(e.currentTarget);
        fileInput.click();
    }

      // 파일 첨부 버튼 클릭 이벤트 핸들러 등록
    addPicBtn.addEventListener("click", handleFileInputClick);

    // 파일 입력 변경 이벤트 핸들러 등록 (한 번만 등록하도록 수정)
    if (!fileInput._fileInputHandlerAdded) {
        fileInput.addEventListener("change", handleFileInputChange);
        fileInput._fileInputHandlerAdded = true;
    }

    // 모달이 화면에 표시될 때 이벤트 핸들러 등록
    // 제이쿼리를 사용해야 인식!!!!
    // 모달창 사라질 때 이벤트 핸들러 제거(이벤트 핸들러 중첩 방지)
    $('.modal').on('hidden.bs.modal', function () {
        // 모달이 숨겨질 때 수행할 작업을 여기에 작성
        // 예시: 모달 내용 초기화
        addPicBtn.removeEventListener("click", handleFileInputClick);
        fileInput.removeEventListener("change", handleFileInputChange);
        fileInput._fileInputHandlerAdded = false; // 이벤트 핸들러 등록 여부 초기화
    });
}

/** 별점 평가 시 별 색칠하고 평점 값 설정하는 함수 */
function setRatingStar(){
    const stars = document.querySelectorAll(".modal-review-rating-content .star");
    const ratingInput = document.querySelector("input[name='rating']");

    stars.forEach(star => {
        star.addEventListener("click", function() {
            // data-value 값 가져옴
            let value = parseInt(this.getAttribute("data-value"));
            // input 에 값 넣기
            ratingInput.value = value;
            // 별 색칠하기
            highlightStars(value);
        });
    });

    function highlightStars(value) {
        stars.forEach(star => {
            const starValue = parseInt(star.getAttribute("data-value"));
            if (starValue <= value) {
                star.querySelector("path").setAttribute("fill", "#FFD700");
            } else {
                star.querySelector("path").setAttribute("fill", "#DBDBDB");
            }
        });
    };

}

/** 별점 리셋 */
function resetRating() {
    const ratingInput = document.querySelector("input[name='rating']");
    ratingInput.value = 0;
    const stars = document.querySelectorAll(".modal-review-rating-content .star");
    stars.forEach(star => {
        star.querySelector("path").setAttribute("fill", "#DBDBDB"); // Gray color
    });
}

/** 이미지 초기화 */
function resetImage(modalElement) {
    const fileInput = modalElement.querySelector('.file-input');
    fileInput.value = "";
    const mainImgContainer = modalElement.querySelector('.qna_pic_container');
    mainImgContainer.innerHTML = "";
    mainImgContainer.style.display = 'none';
}


// ================================= ajax 로 받아온 값들을 이용해 새로 그려주는 메소드 =======================

/** ajax 로 currentPage 보내서 RowBounds 된 ArrayList<orderPdOpt> 값 받아오는 ajax*/
function getBuyListByAjax(data, callback){
    $.ajax({
        url: "getBuyListAjax.me",
        data,
        success: function(res){
            console.log(res);
            callback(res);
        },
        error: function(){
            console.log("송신 실패");
        }
    })
}

/** ajax 로 받아온 객체들로 테이블 내 tbody 새로 만들어주는 메소드 */
function setBuyListTable(res){
    const buyList = res.orderPdopts;
    const paginationArea =  document.querySelector("#pagination-area");

    const buyListTbody = document.querySelector("#myPage-buy-list-bottom > table > tbody");
    buyListTbody.innerHTML = "";

    for(let orderPdopt of buyList){
        setOrderPdOptTr(orderPdopt, buyListTbody);
    }

     // 페이지네이션 갱신
     updatePagination(paginationArea, res.pi);
}

/** OrderPdopt 객체로 tbody 내 tr 만드는 메소드 */
function setOrderPdOptTr(orderPdopt, buyListTbody){
    let buyListTbodyTr = document.createElement('tr');
    buyListTbody.appendChild(buyListTbodyTr);
    buyListTbodyTr.setAttribute("class", "tbody-buy-list-block");
    buyListTbodyTr.innerHTML += `
                                <td class="tbody-td-img"><img style="cursor: pointer;"
                                        src="${ctp}/resources/uploadfile/product/productimg/${orderPdopt.orderPdThumbnail}"
                                        alt="">
                                </td>
                                <td class="tbody-td-name">
                                    <input type="hidden" class="buyList-input-productNo" value="${orderPdopt.orderPdNo}">
                                    <input type="hidden" class="buyList-input-pdOptNo" value="${orderPdopt.optNo}">
                                    <span class="product-brand-name">${orderPdopt.orderPdBrand}</span>
                                    <br>
                                    <span class="product-name">${orderPdopt.orderPdName}</span> <br>
                                    <span class="product-opt-name">${orderPdopt.orderPdOptName}</span>
                                </td>
                                <td class="tbody-td-amount">${orderPdopt.optQuantity}</td>
                                <td class="tbody-td-price">${orderPdopt.orderPdOptPrice}원</td>
                                <td class="tbody-td-buyDate">${orderPdopt.orderPdOptDate}</td>
                                <td class="tbody-td-status">
                                    <span style="color:#068E3D;">배송 완료</span><br>
                                    <form action="https://info.sweettracker.co.kr/tracking/5" method="post">
                                        <div class="form-group" style="display: none;">
                                            <label for="t_key">API key</label>
                                            <input type="hidden" class="form-control" id="t_key" name="t_key" placeholder="제공받은 APIKEY" value="ln0430YYI1g2THuT7m4Atg">
                                        </div>
                                        <div class="form-group" style="display: none;">
                                            <label for="t_code">택배사 코드</label>
                                            <input type="text" class="form-control" name="t_code" id="t_code" placeholder="택배사 코드" value="04">
                                        </div>
                                        <div class="form-group" style="display: none;">
                                            <label for="t_invoice">운송장 번호</label>
                                            <input type="hidden" class="form-control" name="t_invoice" id="t_invoice" placeholder="운송장 번호">
                                        </div>
                                        <button type="submit" class="btn btn-default" style="width: 85px;">조회하기</button>
                                    </form>
                                </td>`;
    const tbodyTdBtn = document.createElement('td');
    buyListTbodyTr.appendChild(tbodyTdBtn);
    tbodyTdBtn.setAttribute("class", "tbody-td-btn");

    tbodyTdBtn.innerHTML += `<button class="tbody-td-btn-qna" data-toggle="modal"
                                        data-target="#qna_Modal">문의 하기</button>`;
    tbodyTdBtn.innerHTML += ( orderPdopt.refReviewNo == 0  ? `<button class="tbody-td-btn-write" data-toggle="modal" data-target="#buyList-review_Modal">후기 작성</button>` : `<button class="tbody-td-btn-write" style="pointer-events: none;">작성 완료</button>` );

    
    tbodyTdBtn.innerHTML += `<button class="tbody-td-btn-cancle" onclick="showSweetConfirm()">주문취소</button>`;
}

// ==================================================== 페이지네이션 =========================================================

/** ajax로 받아온 pi 객체를 이용해 페이지네이션 업데이트 해주는 메소드 */
function updatePagination(ev, pi) {
    const pagination = ev.querySelector(".pagination");
    pagination.innerHTML = "";

    if (pi.currentPage > 1) {
        const prevLink = createPaginationLink(pi.currentPage - 1, '&lt;');
        pagination.appendChild(prevLink);
    }

    for (let p = pi.startPage; p <= pi.endPage; p++) {
        const pageLink = createPaginationLink(p, p);
        if (p == parseInt(pi.currentPage)) {
            pageLink.innerHTML = `<strong>${p}</strong>`;
        }
        pagination.appendChild(pageLink);
    }

    if (pi.currentPage < pi.maxPage) {
        const nextLink = createPaginationLink(pi.currentPage + 1, '&gt;');
        pagination.appendChild(nextLink);
    }

    // 새로 생성된 링크에 이벤트 리스너 추가
    setPaginationEventListeners();
}

/** 페이지네이션 a 태그 생성해주는 메소드 */
function createPaginationLink(page, text) {
    const link = document.createElement('a');
    link.setAttribute('data-value', page);
    link.innerHTML = text;
    return link;
}

/** 페이지바 a 태그에 클릭 이벤트 넣어주는 메소드 */
function setPaginationEventListeners() {
    const paginationArea = document.querySelector("#pagination-area");
    if(paginationArea){
        paginationArea.addEventListener("click", function (event) {
            if (event.target.tagName === 'A') { // 왜 대문자 A일까요?
                const cpage = event.target.getAttribute('data-value');
                getBuyListByAjax({cpage: parseInt(cpage)}, res => {setBuyListTable(res)});
            }
        });
    }
}
