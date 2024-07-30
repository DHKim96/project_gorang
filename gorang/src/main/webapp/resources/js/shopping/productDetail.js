document.addEventListener("DOMContentLoaded", function () {

  // 파라미터값으로 뿌려주고 남은 정보창 채우기
  inputProductInfo(pno, contextPath);

  // 이벤트 핸들러 등록
  clickZzim();
  fileInputClick();
  displaySelectedImage();
  
});

// ==================================================== 유틸리티 함수, 전역 변수 ===========================
// contextPath 저장
const contextPath = sessionStorage.getItem("contextpath");

//페이지의 URL 에서 쿼리 파라미터 값 추출
function getParameterPno() {
  let query = window.location.search;
  let param = new URLSearchParams(query);
  let pno = param.get('pno');
  return pno;
}
// 상품 번호
const pno = getParameterPno();

 /** ajax로 받아온 pi 객체를 이용해 페이지네이션 업데이트 해주는 메소드 */
 function updatePagination(ev, pi) {
  const pagination = ev.querySelector(".pagination");
  pagination.innerHTML = "";

  if (pi.currentPage > 1) {
      const prevLink = document.createElement('a');
      prevLink.setAttribute('data-value', pi.currentPage - 1);
      prevLink.innerHTML = '&lt;';
      pagination.appendChild(prevLink);
  }

  for (let p = pi.startPage; p <= pi.endPage; p++) {
      const pageLink = document.createElement('a');
      pageLink.setAttribute('data-value', p);
      pageLink.innerHTML = p;
      if(p == parseInt(pi.currentPage)){
          pageLink.innerHTML = `<strong>${p}</strong>`
      }
      pagination.appendChild(pageLink)
  }

  if (pi.currentPage < pi.maxPage) {
      const nextLink = document.createElement('a');
      nextLink.setAttribute('data-value', pi.currentPage + 1);
      nextLink.innerHTML = '&gt;';
      pagination.appendChild(nextLink);
  }

  // 새로 생성된 링크에 이벤트 리스너 추가
  setPaginationEventListeners(ev);
}

 /** 페이지바 a 태그에 클릭 이벤트 넣어주는 메소드 */
 function setPaginationEventListeners(paginationArea) {
  paginationArea.querySelectorAll(".pagination a").forEach(function(ev){
      ev.addEventListener("click", function(el){
          let cpage = el.currentTarget.getAttribute('data-value');
          switch(paginationArea){
            case document.querySelector("#review-pagination-area"):
              ajaxGetProductReviews({pno: pno , cpage: cpage}, (res)=> putProductReviewList(res, contextPath));
                break;
            case document.querySelector("#qna-pagination-area"):
              ajaxGetProductQnAs({pno: pno ,cpage: cpage}, (res)=>putProductQnAList(pno, res));
                break;
        }    
      });
  });
}
//찜버튼 눌렀을 때 발생하는 이벤트
function clickZzim() {

  const productNo = document.querySelector('#product-no').value;
  const memberNo = document.querySelector('#member-no').value;
  const zzim = document.querySelector("#zzim");
  zzim.addEventListener("click", function () {

    $.ajax({
      url: 'scrap.po',
      type: 'post',
      data: {
        productNo: productNo,
        memberNo: memberNo
      },
      success: function(res) {
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
        console.log("상품 스크랩 기능 api 호출 실패")
      }

    })


    // if (!zzimStatus) {
    //   zzim.innerHTML = `<i class="fa-solid fa-heart fa-xl" style="color: #ff0000;"></i>`;
    //   zzimStatus = true;
    // } else {
    //   zzim.innerHTML = `<i class="fa-regular fa-heart fa-xl"></i>`;
    //   zzimStatus = false;
    // }
  })
}

/**  문의 사진 첨부 */
function fileInputClick() {
  const addQnaPicture = document.querySelector('#add_qna_product_pic');
  const fileInput = document.querySelector('#file-input');

  addQnaPicture.addEventListener('click', function(){
    fileInput.click();
  });
}

/** 첨부한 사진 미리 볼 수 있도록 해주는 메소드 */
function displaySelectedImage() {
  const fileInput = document.querySelector('#file-input');
  let mainImgContainer = document.querySelector('#qna_pic_container');

  fileInput.addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (ev) {
        mainImgContainer.innerHTML = `<img class="qna-img" src="${ev.target.result}" alt="Selected Image">`;
      };
      reader.readAsDataURL(file);
      console.log(mainImgContainer.style.display);
      mainImgContainer.style.display = 'block';
    }
  });
}

// ======================================================= ajax 함수 ================================

//ajax 통신으로 pno 넘겨주고 해당 상품 번호 참조하는 리뷰들 호출
function ajaxGetProductReviews(data, callback){
  $.ajax({
    url: "ajaxReview.po",
    data,
    success: function(res){
      console.log(res);
      callback(res);
    },
    error: function(){
      console.log("불러오기 실패")
    }
  });
}

// 상품  qna 가져오는 ajax
function ajaxGetProductQnAs(data, callback){
  $.ajax({
    url: "ajaxQnA.po",
    data,
    success: function(res){
      console.log(res);
      callback(res);
    },
    error: (function(){
      console.log("불러오기 실패")
    })
  });
}

// 상품 옵션 가져오는 ajax
function ajaxGetProductOpts(data, callback){
  $.ajax({
    url: "ajaxOpt.po",
    data: data,
    success: function(result){
      callback(result);
    },
    error: function(){
      console.log("불러오기 실패")
    }
  });
}

function ajaxPutPdoptInCart(data){
  $.ajax({
    url: "ajaxInsertCart.po",
    data: JSON.stringify(data),
    method: "POST",
    contentType: "application/json",
    success: function(res){
      console.log(res);
      alert("장바구니에 추가되었습니다.");
    },
    error: function(){
      console.log("장바구니 입력 실패");
    }
  })
}

// ==========================================  화면 동적 구성 위한 메소드 ============================
// ajaxGetProduct에서 가져온 product 객체 정보를 토대로 화면에 나타날 정보 입력하는 콜백 함수
function inputProductInfo(pno, contextPath){

  // 상품 선택 div 부분 높이 구하기
  document.getElementById("product-opt-form-wrapper").style.height = document.getElementById("productContent_area").offsetHeight + 300 +"px";

  //상품 총금액, 장바구니 및 구매하기 버튼 부분
  const productPriceBtnWrapper = document.querySelector("#product-price-btn-wrapper");
  productPriceBtnWrapper.style.display = "none";

  // 상품 선택하기
  ajaxGetProductOpts({pno}, (opts)=>putProductOptsForOrder(opts));

  //리뷰 수, 리뷰 내용 가져오기
  ajaxGetProductReviews({pno: pno, cpage: 1}, (res)=> putProductReviewList(res, contextPath));

  //상품 문의 가져오기
  ajaxGetProductQnAs({pno: pno, cpage: 1}, (res)=>putProductQnAList(pno, res));
}

// =========================== 제품 옵션 및 수량 조절 메소드 ======================
function putProductOptsForOrder(opts){
  //드롭다운 구현
  const pdoptLiST = document.querySelector(".product-opts-list");
  pdoptLiST.innerHTML = ""; // 기존 옵션 초기화

  //드롭박스에 옵션값 넣기
  for(let opt of opts){
    //옵션 부분
    const pdoptSelectOpt = document.createElement('li');
    pdoptSelectOpt.setAttribute("class", "product-opt-select-options")
    pdoptLiST.appendChild(pdoptSelectOpt);

    //옵션명
    const pdoptSelectOptName = document.createElement('span');
    pdoptSelectOptName.setAttribute("class", "product-opt-select-name");
    pdoptSelectOpt.appendChild(pdoptSelectOptName);
    pdoptSelectOptName.innerHTML = opt.detailOptionName; 

    //옵션 가격
    const pdoptSelectOptPrice = document.createElement('span');
    pdoptSelectOptPrice.setAttribute("class", "product-opt-select-price");
    pdoptSelectOpt.appendChild(pdoptSelectOptPrice);
    pdoptSelectOptPrice.innerHTML = opt.detailOptionSaledPrice.toLocaleString();

    //옵션 번호 hidden
    const pdoptSelectOptNo = document.createElement('input');
    pdoptSelectOptNo.setAttribute("type", "hidden");
    pdoptSelectOptNo.setAttribute("class", "product-opt-select-no")
    pdoptSelectOpt.appendChild(pdoptSelectOptNo);
    pdoptSelectOptNo.value = opt.detailOptionNo;
  }
  
  //드롭박스 구현
  $(".product-opt-select").on("click", function (e) {
    e.preventDefault();
    const $optsList = $(".product-opts-list");
    if (!$optsList.hasClass("active")) {
      $optsList.addClass("active");
      $optsList.children("li").slideDown(300);
    } else {
      $optsList.removeClass("active");
      $optsList.children("li").slideUp(300);
    }
  });


  //드롭박스 li요소 클릭 시 하단에 수량 조절하는 부분 생성
  $(".product-opts-list").on("click", ".product-opt-select-options", function (ev) {
    
    // 상품 선택 항목에서 보여지는 부분
    const selectedOption = $(this);
    const selectedOptionNo = selectedOption.find(".product-opt-select-no").val();
    const selectedOptionName = selectedOption.find(".product-opt-select-name").text();
    const selectedOptionPrice = selectedOption.find(".product-opt-select-price").text();
    //parseFloat?

    if (!isOptionAlreadySelected(selectedOptionName)) {
      createQuantityAdjustment(selectedOptionNo, selectedOptionName, selectedOptionPrice);
    }
  });

  // 선택한 옵션이 이미 존재하는지 확인하는 함수
  function isOptionAlreadySelected(optionName) {
    let isOptionAlreadySelected = false;
    $(".product_quantity_content .pname").each(function () {
      if ($(this).text() === optionName) {
        isOptionAlreadySelected = true;
        return false; // each 루프 종료
      }
    });
    return isOptionAlreadySelected;
  }

 // 옵션별 수량 조절 부분 생성하는 메소드
  function createQuantityAdjustment(optionNo, optionName, optionPrice){ 

    // 수량 조절 부분 생성
    const pdQuantityContent = document.createElement('div');
    pdQuantityContent.setAttribute("class", "product_quantity_content");

    // 상품옵션명
    const selectedProductName = document.createElement('div');
    selectedProductName.setAttribute("class", "pname");
    selectedProductName.innerHTML = optionName; // 첫번째 span 의 innerHTML
    pdQuantityContent.appendChild(selectedProductName);

    // 옵션 번호 hidden
    const pdoptSelectOptNo = document.createElement('input');
    pdoptSelectOptNo.setAttribute("type", "hidden");
    pdoptSelectOptNo.setAttribute("class", "product-opt-select-no");
    pdoptSelectOptNo.value = optionNo;
    pdQuantityContent.appendChild(pdoptSelectOptNo);

    // 옵션 수량 조절
    const pdAmountPrice = document.createElement('div');
    pdAmountPrice.setAttribute("class", "product_amount_price");
    pdQuantityContent.appendChild(pdAmountPrice);
    const pamountBtn = document.createElement('div');
    pamountBtn.setAttribute("id", "pamount_btn");
    pdAmountPrice.appendChild(pamountBtn);

    //마이너스 버튼
    const pbtnMinusQuantity = document.createElement('div');
    pbtnMinusQuantity.setAttribute("class", "pbtn minus_quantity");
    pamountBtn.appendChild(pbtnMinusQuantity);
    pbtnMinusQuantity.innerHTML = "-";

    //수량 보여주는 input 요소
    const pbtnQuantity = document.createElement('input');
    pbtnQuantity.setAttribute("class", "pbtn quantity pbtn-quantity");
    pbtnQuantity.setAttribute("type", "text");
    pbtnQuantity.value = "1";
    pamountBtn.appendChild(pbtnQuantity);

    // 플러스 버튼
    const pbtnPlusQuantity = document.createElement('div');
    pbtnPlusQuantity.setAttribute("class", "pbtn plus_quantity");
    pamountBtn.appendChild(pbtnPlusQuantity);
    pbtnPlusQuantity.innerHTML = "+";

    // 가격 보여주는 부분
    const productPriceView = document.createElement('div');
    productPriceView.setAttribute("class", "product-price-view");
    pdAmountPrice.appendChild(productPriceView);

    // 정상가
    const productBasicPrice = document.createElement('span');
    productPriceView.appendChild(productBasicPrice);
    productBasicPrice.setAttribute("class", "product-price-basicPrice");
    productBasicPrice.innerHTML = optionPrice; // 두번째 span 의 innerHTML부분

    // 할인가
    const productDiscountedPrice = document.createElement('span');
    productPriceView.appendChild(productDiscountedPrice);
    productDiscountedPrice.setAttribute("class", "product-price-discountedPrice");

    //삭제버튼
    const selectedOptDelete = document.createElement('div');
    productPriceView.appendChild(selectedOptDelete);
    selectedOptDelete.setAttribute("class", "product-quantity-delete");
    // 폰트 어썸 부분
    const xMark = document.createElement('i');
    selectedOptDelete.appendChild(xMark);
    xMark.setAttribute("class", "fa-solid fa-xmark");

    document.querySelector("#product_quantity_area").appendChild(pdQuantityContent);

    updateTotalPrice();

  }

  // 삭제 버튼 클릭 이벤트 추가
  $("#product_quantity_area").on("click", ".product-quantity-delete", function () {
    $(this).closest(".product_quantity_content").remove();
    updateTotalPrice();
  });

   // 수량 조절 버튼 이벤트 추가
   $("#product_quantity_area").on("click", ".minus_quantity, .plus_quantity", function () {
    const $quantityInput = $(this).siblings(".pbtn-quantity");
    let quantity = parseInt($quantityInput.val());

    if ($(this).hasClass("minus_quantity") && quantity > 1) {
      quantity -= 1;
    } else if ($(this).hasClass("plus_quantity")) {
      quantity += 1;
    }

    $quantityInput.val(quantity);
    updateTotalPrice();
  });

  // 총금액 산출하는 함수
  function calculateTotalPrice() {
    let caltotalPrice = 0;
    $(".product_quantity_content").each(function () {
      const quantity = parseInt($(this).find(".pbtn-quantity").val());
      const price = parseFloat($(this).find(".product-price-basicPrice").text().replace("$", "").replace(",", ""));
      caltotalPrice += quantity * price;
    });
    return caltotalPrice;
  }

  // 총금액 업데이트 함수
  function updateTotalPrice() {
    const totalPrice = calculateTotalPrice();
    document.querySelector(".product-price").innerHTML = totalPrice.toLocaleString();
    if (totalPrice > 0) {
      $("#product-price-btn-wrapper").show();
    } else {
      $("#product-price-btn-wrapper").hide();
    }
  }

}

document.addEventListener("DOMContentLoaded", function(){

  // 장바구니 버튼 클릭 이벤트
  document.querySelector(".btn_cart").addEventListener("click", function (ev){
    ev.preventDefault();
    const selectedOptsForCart = [];

    // 각 옵션번호, 수량을 가져와서 JSON 형태로 저장
    document.querySelectorAll(".product_quantity_content").forEach(function(ev){
      const selectedOptNo = ev.querySelector(".product-opt-select-no").value;
      const selectedOptQnt = ev.querySelector(".pbtn-quantity").value;

      const productCart = {
        pdOptNo: selectedOptNo,
        pdOptQuantity: selectedOptQnt
      };

      selectedOptsForCart.push(productCart);
    });
    ajaxPutPdoptInCart(selectedOptsForCart);

  })
  
  // JSON 형식으로 보내기 위한 구매하기 버튼 클릭 이벤트
  document.querySelector("#product-buy-btn").addEventListener("click", function(e){
    e.preventDefault();
    // array 변수 선언
    const selectedOpts = [];

    // 상품 정보
    const selectedPno = document.querySelector("#product-no").value;
    const productSeller = document.querySelector("#input-productSeller").value;
    const productBrand = document.querySelector("#input-productBrand").value;
    const productName = document.querySelector("#input-productName").value;
    const mainImg = document.querySelector("#input-mainImg").value;
    const shipmentType = document.querySelector("#input-shipmentType").value;
    const shippingPrice = document.querySelector("#input-shipmentCost").value;

    const selectProductInfo = {
      productNo: selectedPno,
      seller: productSeller,
      productBrand: productBrand,
      productName: productName,
      mainImg: mainImg,
      shipmentType: shipmentType, 
      shippingPrice: shippingPrice
    };  
    
    // 각 옵션번호, 수량을 가져와서 JSON 형태로 저장
    document.querySelectorAll(".product_quantity_content").forEach(function(ev){
      const selectedOptNo = ev.querySelector(".product-opt-select-no").value;
      const selectedOptName = ev.querySelector(".pname").innerHTML;
      const selectedOptQnt = ev.querySelector(".pbtn-quantity").value;
      const selectedOptPrice = ev.querySelector(".product-price-basicPrice").innerHTML.replace(/,/g, "");
      

      selectedOpts.push({
          detailOptionNo: selectedOptNo,
          detailOptionName: selectedOptName,
          detailOptionQuantity: selectedOptQnt,
          detailOptionSaledPrice: selectedOptPrice,
          pdForOpt : selectProductInfo
      });
    });

    document.querySelector("#productDetail-input-hidden").value = JSON.stringify(selectedOpts);

    document.querySelector("#product-opt-form").submit();
  });
})


//=========================== review 관련 메소드 ========================================

   // 리뷰 부분 구성하는 요소들 구축하는 메소드
function putProductReviewList(res, contextPath){
  const reviews = res.reviews;
  if(reviews.length > 0){
    console.log(reviews);
    const productReviewContainer = document.querySelector("#product-review-container");
    productReviewContainer.innerHTML = "";
    // 리뷰수
    document.querySelector("#product_review_quantity").innerHTML = reviews.length;
    // 평점 평균 변수
    let ratingSum = 0;
    for(let review of reviews){
      ratingSum += review.rating;
      //리뷰 내용 담을 div
      const productReview = document.createElement('div');
      productReview.setAttribute("class", "product_review");
      productReviewContainer.appendChild(productReview);
      //작성자 정보 담은 div
      const reviewWriterArea = document.createElement('div');
      reviewWriterArea.setAttribute("class", "review_writer_area");
      productReview.appendChild(reviewWriterArea);
      // 작성자 프로필 사진 영역
      const writerPicContainer = document.createElement('div');
      writerPicContainer.setAttribute("class", "review_writer_pic_container");
      reviewWriterArea.appendChild(writerPicContainer);
      // 작성자 프로필 이미지
      const writerPic = document.createElement('img');
      writerPic.setAttribute("class", "review_writer_pic");
      writerPicContainer.appendChild(writerPic);
      writerPic.src = contextPath + "/resources/uploadfile/memberProfile/" + review.writerProfile;
      // 작성자 id, 평점 영역
      const reviewWriterIdRate = document.createElement('div');
      reviewWriterIdRate.setAttribute("class", "review_writer_id_rate");
      reviewWriterArea.appendChild(reviewWriterIdRate);
      // 작성자 아이디
      const reviewWriterId = document.createElement('div');
      reviewWriterId.setAttribute("class", "review_writer_id");
      reviewWriterIdRate.appendChild(reviewWriterId);
      reviewWriterId.innerHTML = review.writerNickname;
  
      // 작성자 평점
      const reviewRate = document.createElement('div');
      reviewRate.setAttribute("class", "review_rate");
      reviewWriterIdRate.appendChild(reviewRate);
  
      // 리뷰의 평점만큼 반복문 돌려서 별 모양 표시
      for(let i = 0; i < review.rating; i++){
        const reviewRateStar = document.createElement('i');
        reviewRateStar.setAttribute("class", "fa-solid fa-star");
        reviewRateStar.setAttribute("style", "color: #FFD43B;");
        reviewRate.appendChild(reviewRateStar);
      }
  
      // 유저가 구입한 상품의 옵션명
      const reviewProductName = document.createElement('div');
      reviewProductName.setAttribute("class", "review_product_name");
      productReview.appendChild(reviewProductName);
      reviewProductName.innerHTML = review.refPdOptName;
      
      // 리뷰 사진
      const reviewPhotoWrapper = document.createElement('div');
      reviewPhotoWrapper.setAttribute("class", "review_img_container");
      productReview.appendChild(reviewPhotoWrapper);

      if(review.reviewPhoto != null){
        const reviewPhoto = document.createElement('img');
        reviewPhoto.setAttribute("class", "review_img");
        reviewPhotoWrapper.appendChild(reviewPhoto);
        reviewPhoto.setAttribute("src", contextPath + "/resources/uploadfile/review/product-review/" + review.reviewPhoto);
      }

      // 리뷰 내용
      const reviewContent = document.createElement('div');
      reviewContent.setAttribute("class", "review_content");
      reviewContent.innerHTML = review.reviewContent;
      productReview.appendChild(reviewContent);
    }
    // 상품 평점 평균
    let ratingAvg = (ratingSum / reviews.length).toFixed(1);
    document.querySelector("#product_grade").innerHTML = ratingAvg;
  
    // 페이지네이션 처리
    const reviewPaginationArea = document.querySelector("#review-pagination-area");
    
    updatePagination(reviewPaginationArea, res.pi)
  }
}

// ============================= QNA 관련 메소드 ====================================
/** 문의하기 모달 구축하는 메소드 */
function putProductQnAList(pno, res){
  const qnas = res.qnas;

  const memberNoInput = document.querySelector("#product-loginUser-no");

  let isAdmin = false;

  if(memberNoInput){
    const memberNo = document.querySelector("#product-loginUser-no").value;
    // 관리자 여부 확인
    isAdmin = ( parseInt(memberNo) === 1);
  }

  // 상품 문의 모달
    // 문의하기 버튼
    const qnaModalBtn = document.querySelector("#qna_top > button");
    // 문의하기 버튼 클릭 시 상품 문의 모달 내용 채우는 메소드 발동
    qnaModalBtn.addEventListener("click", function(){
      ajaxGetProductOpts({pno},(opts)=>inquireQuestion(opts));
    })

    if(qnas.length > 0){
      // 문의 내용
    const qnaContentTbody = document.querySelector('#qna_content > tbody');
    qnaContentTbody.innerHTML = "";
    let qnaStatus = "답변대기";

    for(let qna of qnas){
      // 답변글일 경우 노출안시킴
      if(qna.qnaAnswerType === 2){
        continue;
      }
      setProductQna(qnaContentTbody, qnaStatus, qna, isAdmin);
    }

     // 이벤트 핸들러 등록
    $(".qna_content_tr").click(function() {
      // 현재 보이는 상세 내용 숨기기
      $(".qna_content_tr_display").removeClass("qna_content_tr_display").addClass("qna_content_tr_display_none");

      // 클릭된 요소의 다음 요소(상세 내용) 보이게 하기
      $(this).next().removeClass("qna_content_tr_display_none").addClass("qna_content_tr_display");
    });

    // 페이지의 다른 곳을 클릭할 때 상세 내용 숨기기
    document.addEventListener("click", function(event) {
      // 클릭된 요소가 .qna_content_tr 이거나 그 자식이 아닌 경우 상세 내용 숨기기
      if (!event.target.closest(".qna_content_tr")) {
        $(".qna_content_tr_display").removeClass("qna_content_tr_display").addClass("qna_content_tr_display_none");
      }
    });
    //페이지 처리
    const qnaPaginationArea = document.querySelector("#qna-pagination-area");
    updatePagination(qnaPaginationArea, res.pi);
  }
}

/** form submit 대신 ajax 로 데이터 보내는 메소드 */
function sendQnaByAjax() {
  const modalForm = document.querySelector("#modal-qna-content");
  const formUrl = modalForm.getAttribute("action");
  const formData = new FormData(modalForm);
  $.ajax({
    url: formUrl,
    type: 'POST',
    data: formData,
    enctype: 'multipart/form-data',
    processData: false,
    contentType: false,
    cache: false,
    success: function(res) {
      alert('문의가 성공적으로 제출되었습니다.');
      if(res > 1) {
        sendNotifyByAjax(res);
      }
      location.reload();
    },
    error: function(res) {
      alert('문의 제출에 실패했습니다. 다시 시도해주세요.');
    }
  });
}


/** qna 객체마다 qna 구축해주는 메소드 */
function setProductQna(qnaContentTbody,qnaStatus, qna, isAdmin){
  //tr 생성
  const qnaContentTableTr = document.createElement('tr');
  qnaContentTableTr.setAttribute("class", "qna_content_tr")
  qnaContentTbody.appendChild(qnaContentTableTr);
  //qna 제목 td 생성
  const qnaTitle = document.createElement('td');
  qnaContentTableTr.appendChild(qnaTitle);
  qnaTitle.setAttribute("class", "qna_title");
  qnaTitle.innerHTML = qna.qnaContent;
  //qna 작성자, 작성일 td 생성
  qnaContentTableTr.innerHTML += `<td class="qna_writer">${qna.writerNickname}</td>`
  qnaContentTableTr.innerHTML += `<td class="qna_create_date">${qna.qnaCreateDate}</td>`

  if(qna.answerNo != 0){
    qnaStatus = "답변완료"
  }
    // 답변 없는 문의는 관리자로 접속시 답변작성 버튼 생성
    if(qna.answerNo == 0 && isAdmin){
      qnaContentTableTr.innerHTML += `<td class="qna_status"><button class="product-qna-answer-btn" data-toggle="modal" data-target="#qna_Modal" data-value="${qna.qnaNo}">답변쓰기</button></td>`;
      qnaContentTableTr.querySelector(".product-qna-answer-btn").addEventListener('click',(ev)=>{
        ev.preventDefault();
        let refQnaNo = ev.target.getAttribute("data-value");
        ajaxGetProductOpts({pno},(opts)=>inquireQuestion(opts, refQnaNo));
      })
    } else {
      qnaContentTableTr.innerHTML += `<td class="qna_status">${qnaStatus}</td>`
    } 

  //qna
  //qna 내용 생성
  const qnaQuestionTr = document.createElement('tr');
  qnaQuestionTr.setAttribute("class", "qna_content_tr_display_none");
  qnaQuestionTr.setAttribute("style", "border-top: none;");
  qnaContentTbody.appendChild(qnaQuestionTr);

  // 질문 상세
  const qnaContentQuestionTd = document.createElement('td');
  qnaQuestionTr.appendChild(qnaContentQuestionTd);
  qnaContentQuestionTd.setAttribute("style", "text-align: left;  width: 741px;");
  qnaContentQuestionTd.setAttribute("colspan", "4");
  qnaContentQuestionTd.innerHTML += `<div class="qna-content-container display-row">
                                        <span class="qna-content-kind">Q</span>
                                        <div class="qna-content-wrapper">
                                          <span>${qna.qnaContent}</span>
                                            <div class="qna-content-img-container">
                                            </div>
                                          
                                        </div>
                                      </div>`
  if(qna.qnaPhoto){
    const qnaContentContainer = qnaContentQuestionTd.querySelector(".qna-content-img-container");
    const qnaContentImg = document.createElement('img');
    qnaContentContainer.appendChild(qnaContentImg);
    qnaContentImg.setAttribute("class", "qna-content-img");
    qnaContentImg.setAttribute("src", "/gorang/resources/uploadfile/qna/product-qna/" + qna.qnaPhoto);
  }

  //만약 답변이 있다면 생성
  if(qna.answerNo != 0){
    // 답변 상세
    const qnaContentAnswerDiv = document.createElement('div');
    qnaContentQuestionTd.appendChild(qnaContentAnswerDiv);
    qnaContentAnswerDiv.setAttribute("class", "qna-content-container display-row");
    qnaContentAnswerDiv.innerHTML +=  ` <span class= "qna-content-kind">A</span>
                                        <div class="qna-content-wrapper">
                                          <span>${qna.answerContent}</span>
                                          <span style="font-size: 14px; font-weight: 300">${qna.answerCreateDate}</span>
                                        </div>`
  }

  //답변 여부 초기화
  qnaStatus = "답변대기";
}

 /** 문의하기 모달창 구축하는 메소드 */
function inquireQuestion(opts, refQnaNo){
  if(refQnaNo){
    document.querySelector("input[name='refQnaNo']").value = refQnaNo;
  }
  // 옵션명 보여줄 셀렉트
  const optnameSelect = document.querySelector("#qna_product_name");
  // 상품 옵션 불러와서 넣기
  for(let opt of opts){
     const optnames = document.createElement('option');
     optnameSelect.appendChild(optnames);
     optnames.setAttribute('value', opt.detailOptionNo);
     optnames.innerHTML = opt.detailOptionName;
  }
}



// ======================== 네비게이션 및 페이지 이동 =========================
// nav 눌렀을 때 발생하는 함수
function scrollToDiv(div) {
  const divOffsetTop = document.querySelector(div).offsetTop;
  window.scrollTo(0, divOffsetTop - 225);
}


// ======================== 알림 관련 메소드 ===================================
function sendNotifyByAjax(memberNo){
  let notify = {refMemberNo: memberNo,
                notifyType: 3,
                content: "문의글에 답변이 달렸습니다.",
                notifyUrl: "detail.po?pno=" + pno
                }
  $.ajax({
    url: "insertNotifyByAjax.me",
    data: notify,
    type: 'post',
    success: function(res){
      console.log("송신성공", res);
    },
    error: function(){
      console.log("송신실패");
    }
  })
}