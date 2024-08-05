<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>
                <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
                <!-- css -->
                <!-- Latest compiled and minified CSS -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recipe/recipeDetail.css">
                <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
                    crossorigin="anonymous"> -->
                      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
                    <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
                    crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
                    integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
                    crossorigin="anonymous"></script>
                        <!-- font awesome kit -->
            <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>
                <script src="${contextPath}/resources/js/recipe/recipeDetail.js"></script>
            </head>

            <body onload="loadSideBar()">
                <!-- 헤더 -->
                <jsp:include page="../common/header.jsp" />

                <!-- 사이드바 -->
                <jsp:include page="../common/sidebar.jsp" />

                <main class="scale-container display-flex-column-center">
                    <!--레시피 글 썸네일영역 -->
                    <div id="recipe-thumnail-area">
                        <div id="recipe-thumnail-food-img">
                            <img src="${contextPath}/resources/uploadfile/recipe/recipemain/${rcp.recipeMainPhoto}" alt="">
                        </div>
                        <div id="recipe-thumnail-user-img-area">
                            <div id="recipe-thumnail-user-img">
                                <img src="${contextPath}/resources/uploadfile/memberProfile/${member.profile}" alt="">
                            </div>
                           
                        </div>
                        <div id="recipe-thumnail-user-nickname">
                            ${member.nickname}
                        </div>
                        <div id="recipe-thumnail-views-count">
                            <img src="${contextPath}/resources/dummyImg/recipe/recipeDetail/🦆 icon _eye_.png"
                                alt=""><span>${rcp.recipeView}</span>
                        </div>
                    </div>
                    <input type="hidden" name="loginMemberNo"  value=${loginUser.memberNo}>
                    <input type="hidden" name="loginrecipeNo" value=${rcp.recipeNo}>
                    <input type="hidden" name="recipeMemberNo" value=${rcp.memberNo}>
                    <!-- 레시피 내용 전체 -->
                    <div id="recipe-content-total-area">
    
                        <!-- 레시피 제목,태그,내용, 정보 전체영역 -->
                        <div id="recipe-total-first-area">
    
                            <div id="recipe-title-top">
                                ${rcp.recipeTitle}
                            </div>
                            <div id="recipe-total-bottom-area">
                                <div id="recipe-total-first-left">
    
                                    <div id="recipe-tage">
                                        <c:forEach var="tag" items="${tagArr}">
                                            <div class="tag-content">#${tag}</div>
                                        </c:forEach>
                                    </div>
    
                                    <div id="recipe-content">
                                        ${rcp.recipeContent}
                                    </div>
                                </div>
                                <!-- 레시피 카테고리 정보영역 -->
                                <div id="recipe-total-first-right">
                                    <div id="recipe-category-top">
                                        <div class="recipe-category">
                                            <div class="recipe-smaill-top">난이도</div>
                                            <div class="recipe-smaill-bottom">${rcp.cookLevel}</div>
                                        </div>
                                        <div class="recipe-category">
                                            <div class="recipe-smaill-top">조리시간</div>
                                            <div class="recipe-smaill-bottom">${rcp.cookTime}</div>
                                        </div>
                                        <div class="recipe-category">
                                            <div class="recipe-smaill-top">인원</div>
                                            <div class="recipe-smaill-bottom">${rcp.cookAmount}</div>
                                        </div>
                                    </div>
    
                                    <!-- <div id="recipe-nutt-info-area">
                                        <div id="nutt-info-area">
                                            <div id="bugerbarimg">
                                                <img src="${contextPath}/resources/dummyImg/recipe/recipeDetail/Vector.png"
                                                    alt="">
                                            </div>
                                            <div id="nutt-info-text">영양정보 알아보기</div>
                                            <div id="downimg">
                                                <img src="${contextPath}/resources/dummyImg/recipe/recipeDetail/icon bottom_.png"
                                                    alt="" id="show-div">
                                            </div>
                                        </div>
                                    </div> -->
    
                                    <div id="recipe-icon">
                                        <!-- <div class="icon-block">공유 <br> 아이콘</div> -->
                                         <div class="icon-area">                   
                                                <i class="fa-solid fa-eye" style="font-size: 45px;"></i>                                                                                                     
                                             <div>
                                                 <strong class="icon-text-area">${rcp.recipeView}</strong>
                                             </div>
                                         </div>
                                         <div class="icon-area" id="scrap_area">
                                            <c:if test="${checkScrap == 0 || loginUser == null}">
                                             <i class="fa-regular fa-bookmark" style="font-size: 45px;"  onclick="scrapGet(this)"></i> 
                                            </c:if>
                                             <c:if test="${checkScrap == 1}">
                                                <i class="fa-solid fa-bookmark" style="color: #1e90ff; font-size: 45px;"  onclick="scrapGet(this)"></i>
                                            </c:if>
                                             <div id="scrap_value"><strong  class="icon-text-area">${resultScrap}</strong></div>
                                             
                                         </div>
                                         <div class="icon-area" id="like_area">
                                            <c:if test="${checkLike == 0 || loginUser == null}">
                                             <i class="fa-regular fa-heart" style="font-size: 45px;"  onclick="likeGet(this)"></i>
                                             </c:if>
                                             <c:if test="${checkLike == 1}">
                                                <i class="fa-solid fa-heart" style="color: #d00101; font-size: 45px;"   onclick="likeGet(this)"></i>
                                            </c:if>
                                             <div id="like_value"><strong  class="icon-text-area">${resultLike}</strong></div>
                                             
                                         </div>
                                    </div>
                                    <!-- <div id="recipe-icon-value">
    
                                    </div> -->
    
                                    <!-- <div id="recipe-nutrition-info-list-area">
                                        <div id="recipe-nutrition-info-header">
                                            <div>레시피 영양정보</div>
                                            <div>
                                                <img src="${contextPath}/resources/dummyImg/recipe/recipeDetail/X.png"
                                                    id="close-div" alt="">
                                            </div>
                                        </div>
                                        <div id="recipe-nutrition-info-bottom">
                                            <table>
                                                <tr>
                                                    <td>총 칼로리(kcal)</td>
                                                    <td class="second-td">763</td>
                                                </tr>
                                                <tr>
                                                    <td>탄수화물(g)</td>
                                                    <td class="second-td">150</td>
                                                </tr>
                                                <tr>
                                                    <td>단백질(g)</td>
                                                    <td class="second-td">24</td>
                                                </tr>
                                                <tr>
                                                    <td>지방(g)</td>
                                                    <td class="second-td">40</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div> -->
                                </div>
    
                                <!-- <script>
                                    // JavaScript 코드
                                    document.addEventListener("DOMContentLoaded", function () {
                                        // show-div를 클릭했을 때
                                        document.getElementById("show-div").addEventListener("click", function () {
                                            document.getElementById("recipe-nutrition-info-list-area").style.display = "block"; // 영역 보이기
                                        });
    
                                        // close-div를 클릭했을 때
                                        document.getElementById("close-div").addEventListener("click", function () {
                                            document.getElementById("recipe-nutrition-info-list-area").style.display = "none"; // 영역 숨기기
                                        });
                                    });
                                </script> -->
                            </div>
                        </div>
                        <c:if test="${not empty rcp.recipeVideo}">
                        <div id="youtube_total_area">
                            <div id="youtube_title" >
                                <span id="youtube_recipe_title">유튜브 영상</span>
                            </div>                       
                            <div id="youtube_middle">
                                <iframe width="560" height="315" src="https://www.youtube.com/embed/${rcp.recipeVideo}"  title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>                           
                            </div>
                        </div>
                        </c:if>
                        <!-- id태그영역 -->
                        <div id="menubar-id-area">
                            <div class="menubar-id"onclick="scrollToDiv('#igre-total-area')"> 재료</div>
                            <div class="menubar-id"onclick="scrollToDiv('#cooking-order-total-area')"> 조리 순서</div>
                            <div class="menubar-id" onclick="scrollToDiv('#product_review_area')"> 후기</div>
                            <div class="menubar-id" onclick="scrollToDiv('#product_qna_area')">문의</div>
                            <div class="menubar-id" onclick="scrollToDiv('#relation-product-total-area')"> 연관 상품</div>
                        </div>
    
                        <!-- 재료 영역 -->
                        <div id="igre-total-area">
                            <div id="igre-head-title-area">재료</div>
                            <div class="igre-type-area">
                                <c:forEach var="division" items="${recipeInsertDTO.rcpDivList}" varStatus="divisionIndex">
                                    <table>
                                        <thead>
                                            <tr class="tr-igre-title">
                                                <td colspan="2">${division.divName}</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="ingredient" items="${division.ingredientsInfoList}"
                                                varStatus="ingreIndex">
                                                <tr>
                                                    <td>${ingredient.ingreName}</td>
                                                    <td>${ingredient.ingreAmount} ${ingredient.ingreUnit}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
    
                                </c:forEach>
                            </div>
                        </div>
                    
                        <!-- igre-type-area영역에서  igre-type-area-right로 끝나면 다시
                            igre-type-area영역을 생성해서 left, right생성을 만드는 것을 반복 (2열 종대) -->
    
    
    
                        <!-- 조리 순서 -->
                        <div id="cooking-order-total-area">
                            <div id="cooking-order-title">
                                조리순서
                            </div>
                            <div id="cooking-order-blocks">
                                <c:forEach var="cookOrder" items="${recipeInsertDTO.cookOrderList}" varStatus="orderIndex">
                                    <div class="cook-order-block">
                                        <div class="cooking-order-step-title">
                                            STEP ${orderIndex.index+1}
                                        </div>
                                        <div class="cooking-order-step-image">
                                            <img src="${contextPath}/resources/uploadfile/recipe/recipeorder/${cookOrder.cookOrdPhoto}"
                                                alt="">
                                        </div>
                                        <div class="cooking-order-step-content">
                                            ${cookOrder.cookOrdContent}
                                        </div>
                                        <c:forEach var="cookTip" items="${cookOrder.cookTipList}" varStatus="tipIndex">
                                            <div class="cooking-order-step-tip">
                                                TIP ${tipIndex.index+1} : ${cookTip.cookTipContent}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
    
                        <!-- 완성 사진 영역 -->
                        <div id="review"></div>
                        <div id="complete-cook-image-area">
                            <span>* 요리 완성사진</span>
                            <div id="carouselExampleFade" class="carousel slide carousel-fade">
                                <div class="carousel-inner">
                                    <c:forEach var="media" items="${recipeInsertDTO.completeFoodPhoto}" varStatus="status">
                                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                            <img src="${contextPath}/resources/uploadfile/recipe/recipefinal/${media.changeName}"
                                                class="d-block w-100" alt="..." style="width: 700px;">
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade"
                                    data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden"></span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade"
                                    data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden"></span>
                                </button>
                            </div>
                        </div>
    
    
    
                        <!-- 레시피 후기 -->
                        <div id="product_review_area">
                            <div id=write_review_area>
    
                                <div class="description_title" id="review_description_title">레시피 후기</div>
                                <button class="tbody-td-btn-write" data-toggle="modal" data-target="#buyList-review_Modal">후기 작성</button>
    
                            </div>
                            <div id="recipe_review_area">
                           
                            </div>
    
                            <div id="review-pagination-area">
                                <div class="pagination">
                                   
                                </div>
                            </div>
                            
                                
                        </div>
                     
    
    
    
    
    
                        <!-- 상품 문의 -->
                        <div id="product_qna_area">
                            <div id="qna_top">
                                <div class="description_title" id="qna_description_title">레시피 문의</div>
    
                                <button id="btn_qna" class="btn btn-primary"
                                    style="background-color: #1E90FF; width: 123px; height: 53px; font-size: 20px;"
                                    data-toggle="modal" data-target="#qna_Modal">문의하기</button>
                                    
                            </div>
            
                            <table id="qna_content">
                                <thead>
                                    <tr >
                                        <td class="qna_title">제목</td>
                                        <td class="qna_writer">작성자</td>
                                        <td class="qna_create_date">작성일</td>
                                        <td class="qna_status">답변상태</td>
                                    </tr>
                                </thead>
                                <tbody id="tbodyQnA">
                                    
                                </tbody>
                            </table>
                            
                            <!-- 페이징 바 -->
                            <div id="qna-pagination-area">
                                <div class="pagination">
                                 
                                </div>
                            </div>
                        </div>
    
    
    
    
                        <!-- 연관 상품 영역  -->
                        <div id="relation-product-total-area">
                            <div id="relation-product-head">
                                연관 상품
                            </div>
                            <div id="relation-product-list">
                                <c:forEach var="product" items="${recipeInsertDTO.productList}" varStatus="productIndex">
                                    <div class="relation-product-list-block" onclick="goProduct(this)">
                                        <input type="hidden" value="${product.productNo}">
                                        <div class="relation-product-image">
                                            <img src="${contextPath}/resources/uploadfile/product/productimg/${product.mainImg}" alt="">
                                        </div>
                                        <div class="relation-product-brand">${product.productBrand}</div>
                                        <div class="relation-product-title">${product.productName}</div>
                                        <div class="relation-product-normalPrice">${product.normalPrice}원</div>
                                        <div class="relation-product-ps-size"><span class="relation-product-sale">${product.discountPercent}%</span>
                                            <span class="relation-product-price">${product.salePrice}원</span></div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div id="goto-list-area">
                                <button id="goto-list-btn" onclick="goRecipeList()">목록으로</button>
                            </div>
                        </div>
                      
                    </div>
                     <!-- 문의하기 modal -->
                     <div class="modal" id="qna_Modal" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
    
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 style="font-size: 16px; margin-bottom: 0px;">레시피 문의하기</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
    
                                <!-- Modal body -->
                                <div class="modal-body" style="height: 100%;">
                                    <div class="modal-qna-content">
                                        <input type="hidden" name="writerNo" id="qna-modal-writerNo" value=${loginUser.memberNo}>
                                        <input type="hidden" name="refRecipeNo" id="qna-modal-refProductNo" value=${rcp.recipeNo}>
                                        <input type="hidden" name="refQnaNo" value="0">
                                        <div class="product_pic_container">
                                            <div style="font-size: 14px; font-weight: bold;">
                                                사진 첨부(선택)
                                            </div>
                                            <div style="font-size: 12px;">
                                                사진을 첨부해주세요.(최대 1장)
                                            </div>
                                            <div class="qna_pic_container">
    
                                            </div>
                                            <div class="add_qna_product_pic">
                                                <div class="pic_svg_container">
                                                    <svg width="21" height="16" viewBox="0 0 21 16" fill="none"
                                                        xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M19.6059 0C20.1059 0 20.5059 0.4 20.5059 0.9V15.1C20.5059 15.6 20.1059 16 19.6059 16H1.40586C1.16716 16 0.938246 15.9052 0.769463 15.7364C0.600681 15.5676 0.505859 15.3387 0.505859 15.1V0.9C0.505859 0.4 0.905859 0 1.40586 0H19.6059ZM18.6959 1.8H2.30586V12.65L7.84586 6.38C7.96586 6.21 8.22586 6.21 8.36586 6.38L11.4659 9.92C11.5259 9.98 11.5459 10.06 11.5259 10.12L11.1259 11.96C11.1059 12.1 11.2759 12.19 11.3559 12.08L14.5159 8.65C14.5664 8.59992 14.6347 8.57183 14.7059 8.57183C14.777 8.57183 14.8453 8.59992 14.8959 8.65L18.6859 12.77V1.8H18.6959ZM15.3259 6.6C14.9394 6.60004 14.5685 6.44791 14.2934 6.17654C14.0183 5.90517 13.8611 5.53639 13.8559 5.15C13.8559 4.34 14.5159 3.69 15.3259 3.69C16.1359 3.69 16.8059 4.34 16.8059 5.15C16.8059 5.95 16.1459 6.6 15.3259 6.6Z"
                                                            fill="#1E90FF" />
                                                    </svg>
                                                </div>
                                                <span style="color:#1E90FF; font-size: 14px;">사진 첨부하기</span>
                                            </div>
                                            <input type="file" name="qnaPhotoUpfile" class="file-input"
                                                    accept="image/*">
                                        </div>
    
                                        <div class="product_qna_content_container">
                                            <div style="font-size: 14px; font-weight: bold;">
                                                문의내용
                                            </div>
                                            <div class="product_qna_content_textarea">
                                                <textarea name="qnaContent" class="product_qna_content"
                                                    placeholder="문의 내용을 입력하세요."></textarea>
                                            </div>
                                        </div>
    
                                        <div class="product_qna_enroll_btn_container">
                                            <button  class="product_qna_enroll_btn" onclick="insertQnARecipe()">완료</button>
                                        </div>
                                        </div>
                                    </form>
                                </div>
    
    
                            </div>
                        </div>
                    </div>
    
                    <!-- 후기작성 modal -->
                    <div class="modal" id="buyList-review_Modal" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
    
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 style="font-size: 16px; margin-bottom: 0px;">레시피 후기 작성하기</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
    
                                <!-- Modal body -->
                                <div class="modal-body" style="height: 100%;">
                                        <div class="modal-qna-content">
                                        <input type="hidden" name="refMemberNo" value=${loginUser.memberNo}>
                                        <input type="hidden" name="refRecipeNo" value=${rcp.recipeNo} id="review-modal-refProductNo">
                                        <div class="modal-review-rating-container">
                                            <span>별점 평가</span>
                                            <div class="modal-review-rating-content">
                                                <!-- data-value 속성 부여 -->
                                                <svg class="star" data-value="1" width="37" height="35" viewBox="0 0 37 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M18.3225 30.7001L9.32254 34.5001C7.82254 35.2001 6.72254 34.3001 6.82254 32.7001L7.62254 23.0001L1.32254 15.6001C0.322536 14.3001 0.722536 13.0001 2.32254 12.6001L11.8225 10.4001L16.8225 2.1001C17.8225 0.600098 19.1225 0.600098 19.9225 2.1001L24.9225 10.4001L34.5225 12.6001C36.1225 13.0001 36.5225 14.3001 35.5225 15.6001L29.0225 23.0001L29.8225 32.7001C29.9225 34.3001 28.8225 35.2001 27.3225 34.5001L18.3225 30.7001Z" fill="#DBDBDB"/>
                                                </svg>
                                                <svg class="star" data-value="2" width="37" height="35" viewBox="0 0 37 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M18.3225 30.7001L9.32254 34.5001C7.82254 35.2001 6.72254 34.3001 6.82254 32.7001L7.62254 23.0001L1.32254 15.6001C0.322536 14.3001 0.722536 13.0001 2.32254 12.6001L11.8225 10.4001L16.8225 2.1001C17.8225 0.600098 19.1225 0.600098 19.9225 2.1001L24.9225 10.4001L34.5225 12.6001C36.1225 13.0001 36.5225 14.3001 35.5225 15.6001L29.0225 23.0001L29.8225 32.7001C29.9225 34.3001 28.8225 35.2001 27.3225 34.5001L18.3225 30.7001Z" fill="#DBDBDB"/>
                                                </svg>
                                                <svg class="star" data-value="3" width="37" height="35" viewBox="0 0 37 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M18.3225 30.7001L9.32254 34.5001C7.82254 35.2001 6.72254 34.3001 6.82254 32.7001L7.62254 23.0001L1.32254 15.6001C0.322536 14.3001 0.722536 13.0001 2.32254 12.6001L11.8225 10.4001L16.8225 2.1001C17.8225 0.600098 19.1225 0.600098 19.9225 2.1001L24.9225 10.4001L34.5225 12.6001C36.1225 13.0001 36.5225 14.3001 35.5225 15.6001L29.0225 23.0001L29.8225 32.7001C29.9225 34.3001 28.8225 35.2001 27.3225 34.5001L18.3225 30.7001Z" fill="#DBDBDB"/>
                                                </svg>
                                                <svg class="star" data-value="4" width="37" height="35" viewBox="0 0 37 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M18.3225 30.7001L9.32254 34.5001C7.82254 35.2001 6.72254 34.3001 6.82254 32.7001L7.62254 23.0001L1.32254 15.6001C0.322536 14.3001 0.722536 13.0001 2.32254 12.6001L11.8225 10.4001L16.8225 2.1001C17.8225 0.600098 19.1225 0.600098 19.9225 2.1001L24.9225 10.4001L34.5225 12.6001C36.1225 13.0001 36.5225 14.3001 35.5225 15.6001L29.0225 23.0001L29.8225 32.7001C29.9225 34.3001 28.8225 35.2001 27.3225 34.5001L18.3225 30.7001Z" fill="#DBDBDB"/>
                                                </svg>
                                                <svg class="star" data-value="5" width="37" height="35" viewBox="0 0 37 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M18.3225 30.7001L9.32254 34.5001C7.82254 35.2001 6.72254 34.3001 6.82254 32.7001L7.62254 23.0001L1.32254 15.6001C0.322536 14.3001 0.722536 13.0001 2.32254 12.6001L11.8225 10.4001L16.8225 2.1001C17.8225 0.600098 19.1225 0.600098 19.9225 2.1001L24.9225 10.4001L34.5225 12.6001C36.1225 13.0001 36.5225 14.3001 35.5225 15.6001L29.0225 23.0001L29.8225 32.7001C29.9225 34.3001 28.8225 35.2001 27.3225 34.5001L18.3225 30.7001Z" fill="#DBDBDB"/>
                                                </svg>
                                            </div>
                                            <input type="hidden" name="rating" id="rating" value="0">
                                        </div>
                                        
                                        <!-- recipe_pic_container -->
                                        <div class="product_pic_container"> 
                                            <div style="font-size: 14px; font-weight: bold;">
                                                사진 첨부(선택)
                                            </div>
                                            <div style="font-size: 12px;">
                                                사진을 첨부해주세요.(최대 1장)
                                            </div>
                                            <div class="qna_pic_container">
    
                                            </div>
                                            <!--add_qna_recipe_pic  -->
                                            <div class="add_qna_product_pic">
                                                <div class="pic_svg_container">
                                                    <svg width="21" height="16" viewBox="0 0 21 16" fill="none"
                                                        xmlns="http://www.w3.org/2000/svg">
                                                        <path
                                                            d="M19.6059 0C20.1059 0 20.5059 0.4 20.5059 0.9V15.1C20.5059 15.6 20.1059 16 19.6059 16H1.40586C1.16716 16 0.938246 15.9052 0.769463 15.7364C0.600681 15.5676 0.505859 15.3387 0.505859 15.1V0.9C0.505859 0.4 0.905859 0 1.40586 0H19.6059ZM18.6959 1.8H2.30586V12.65L7.84586 6.38C7.96586 6.21 8.22586 6.21 8.36586 6.38L11.4659 9.92C11.5259 9.98 11.5459 10.06 11.5259 10.12L11.1259 11.96C11.1059 12.1 11.2759 12.19 11.3559 12.08L14.5159 8.65C14.5664 8.59992 14.6347 8.57183 14.7059 8.57183C14.777 8.57183 14.8453 8.59992 14.8959 8.65L18.6859 12.77V1.8H18.6959ZM15.3259 6.6C14.9394 6.60004 14.5685 6.44791 14.2934 6.17654C14.0183 5.90517 13.8611 5.53639 13.8559 5.15C13.8559 4.34 14.5159 3.69 15.3259 3.69C16.1359 3.69 16.8059 4.34 16.8059 5.15C16.8059 5.95 16.1459 6.6 15.3259 6.6Z"
                                                            fill="#1E90FF" />
                                                    </svg>
                                                </div>
                                                <span style="color:#1E90FF; font-size: 14px;">사진 첨부하기</span>
                                            </div>
                                            <input type="file" name="reviewPhotoUpfile" class="file-input"
                                            accept="image/*">
                                        </div>
    
                                        <div class="product_qna_content_container">
                                            <div style="font-size: 14px; font-weight: bold;">
                                                후기 내용
                                            </div>
                                            <div class="product_qna_content_textarea">
                                                <textarea name="reviewContent" class="product_qna_content"
                                                    placeholder="후기 내용을 입력하세요."></textarea>
                                            </div>
                                        </div>
    
                                        <div class="product_qna_enroll_btn_container">
                                            <button type="submit" class="product_qna_enroll_btn" onclick="insertReviewRecipe();" >완료</button>
                                        </div>
                                    </div>
                                    </form>
                                </div>
    
    
                            </div>
                        </div>
                    </div>
                </main>
              
                <jsp:include page="../common/footer.jsp" />
            </body>

            </html>