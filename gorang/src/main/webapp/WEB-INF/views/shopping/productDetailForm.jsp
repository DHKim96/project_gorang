<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>

            <!-- font awesome kit -->
            <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>

            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${contextPath }/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath }/resources/css/shopping/productDetail.css">

        </head>

        <body onload="loadSideBar()">
            <!-- 헤더 시작-->
            <jsp:include page="../common/header.jsp" />
            <!-- 헤더 끝-->
            <!-- 상품 상세페이지 -->
            <div id="product-detail-container">
                <!-- 사이드바 -->
                <jsp:include page="../common/sidebar.jsp" />

                <!-- 상품 간략 정보-->
                <div id="productInfo-area">
                    <c:if test="${!empty loginUser}">
                        <input type="hidden" id="product-loginUser-no" value="${loginUser.memberNo}">
                    </c:if>
                    <input type="hidden" id="member-no" value="${loginUser.memberNo}">
                    <input type="hidden" id="product-no" value="${p.productNo}">
                    <div id="product-img-container">
                        <img class="product-thumbnail" src="${contextPath }/resources/uploadfile/product/productimg/${p.mainImg}"
                            alt="">
                    </div>
                    <div id="product-Information">
                        <div id="product_brand">
                            <span>${p.productBrand}</span>
                        </div>
                        <div id="product_name_area">
                            <span id="product_name">${p.productName}</span>
                            <span id="zzim">
                                <c:choose>
                                    <c:when test="${existScrapProduct > 0}">
                                        <i class="fa-solid fa-heart fa-xl" style="color: #ff0000;"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-regular fa-heart fa-xl"></i>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div id="product_grade_area">
                            <span id="product_grade">0.0</span>
                            <div>
                                <span id="product_review_quantity">0</span><span class="review_quantity">개 상품평</span>
                            </div>
                        </div>
                        <div>
                            <span id="product_origin_price"> <fmt:formatNumber value="${p.normalPrice}" type="number"/></span>
                            <span class="won">원</span>
                        </div>
                        <div id="product_discount_price">
                            <span id="product_discount_percent">${p.discountPercent}%</span>
                            <div>
                                <span id="product_discounted_price"><fmt:formatNumber value="${p.salePrice}" type="number"/></span>
                                <span style="font-size: 30px; font-weight: bold;">원</span>
                            </div>
                        </div>
                        <div id="product_etc">
                            <table>
                                <tbody>
                                    <tr>
                                        <td>판매자</td>
                                        <td>${p.seller}</td>
                                    </tr>
                                    <tr>
                                        <td>판매단위</td>
                                        <td>1봉</td>
                                    </tr>
                                    <tr>
                                        <td>중량/용량</td>
                                        <td>1.5kg 내외</td>
                                    </tr>
                                    <tr>
                                        <td>배송</td>
                                        <td>${p.shipmentType}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="product_buy_info_area">
                            <div id="product_buy_info">
                                <div><span>상품 선택</span></div>
                                <div id="product-opt-form-wrapper">
                                    <form action="order.po" id="product-opt-form" method="post">
                                        <div class="product-opts">
                                            <div class="product-opt-select">
                                                <div><span>상품을 선택해주세요</span></div>
                                                <ul class="product-opts-list">
    
                                                </ul>
                                            </div>
                                        </div>
                                        <div id="product_quantity_area">
                                        </div>
                                        <div id="product-price-btn-wrapper">
                                            <div id="price-area">
                                                <div style="font-weight: bold; font-size: 20px;">총금액</div>
                                                <div style="font-weight: bold; font-size: 25px; color: #1E90FF;">
                                                    <span class="product-price"></span>원
                                                </div>
                                            </div>
                                            <div class="product_buy_btn_container">
                                                <button class="myBtn btn_cart">장바구니 담기</button>
                                                <button class="myBtn btn_buy" id="product-buy-btn">구매하기</button>
                                            </div>
                                        </div>
                                        <input type="hidden" id="input-productSeller" value="${p.seller}">
                                        <input type="hidden" id="input-productBrand" value="${p.productBrand}">
                                        <input type="hidden" id="input-productName" value="${p.productName}">
                                        <input type="hidden" id="input-mainImg" value="${p.mainImg}">
                                        <input type="hidden" id="input-shipmentType" value="${p.shipmentType}">
                                        <input type="hidden" id="input-shipmentCost" value="${p.shippingPrice}" >
                                        <input type="hidden" id="productDetail-input-hidden" name="selectedOptList">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 상품 정보-->
                <div id="productContent_area">
                    <div id="area_left">

                        <!-- 상품네비 -->
                        <nav id="product_info_nav">
                            <div id="product_description_div" class="nav_div"
                                onclick="scrollToDiv('#product_description_area')">상품설명</div>
                            <div id="detail_description_div" class="nav_div"
                                onclick="scrollToDiv('#product_detail_description')">상세설명</div>
                            <div id="product_review_div" class="nav_div" onclick="scrollToDiv('#product_review_area')">
                                후기</div>
                            <div id="product_qna_div" class="nav_div" onclick="scrollToDiv('#product_qna_area')">문의
                            </div>
                        </nav>

                        <!-- 상품 설명 -->
                        <div id="product_description_area">
                            ${p.description}
                        </div>

                        <!-- 상품 후기 -->
                        <div id="product_review_area">
                            <div class="description_title">상품 후기</div>
                            <div id="product-review-container"></div>
                             <!-- 페이징 바 -->
                            <div id="review-pagination-area">
                                <div class="pagination">
                                </div>
                            </div>
                        </div>

                        <!-- 상품 문의 -->
                        <div id="product_qna_area">
                            <div id="qna_top">
                                <div class="description_title">상품 문의</div>
                                <button id="btn_qna" class="btn btn-primary product-qna-btn" style="width: 123px; height: 53px; font-size: 20px;"
                                    data-toggle="modal" data-target="#qna_Modal">문의하기</button>
                            </div>

                            <table id="qna_content">
                                <thead>
                                    <tr>
                                        <td class="qna_title">제목</td>
                                        <td class="qna_writer">작성자</td>
                                        <td class="qna_create_date">작성일</td>
                                        <td class="qna_status">답변상태</td>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div id="qna-pagination-area">
                                <div class="pagination">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="area_right">
                    </div>
                </div>

                <!-- 문의하기 modal -->
                <div class="modal fade" id="qna_Modal">
                    <div class="modal-dialog">
                        <div class="modal-content" style="height: fit-content;">

                            <!-- Modal Header -->
                            <div class="modal-header">
                                <h4 style="font-size: 16px; margin-bottom: 0px;">상품 문의하기</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>

                            <!-- Modal body -->
                            <div class="modal-body" style="height: 100%;">
                                <form id="modal-qna-content" action="insertQna.po" enctype="multipart/form-data" method="post">
                                    <input type="hidden" name="writerNo" value=${loginUser.memberNo}>
                                    <input type="hidden" name="refProductNo" value=${p.productNo}>
                                    <input type="hidden" name="refQnaNo" value="0">
                                    <div id="product_name_container">
                                        <div id="qna_product_name_header">
                                            상품명
                                        </div>
                                        <select name="refPdoptNo" id="qna_product_name">
                                        </select>
                                    </div> 
                                    <div id="product_pic_container">
                                        <div style="font-size: 14px; font-weight: bold;">
                                            사진 첨부(선택)
                                        </div>
                                        <div style="font-size: 12px;">
                                            사진을 첨부해주세요.(최대 1장)
                                        </div>
                                        <div id="qna_pic_container">

                                        </div>
                                        <div id="add_qna_product_pic">
                                            <div id="pic_svg_container">
                                                <svg width="21" height="16" viewBox="0 0 21 16" fill="none"
                                                    xmlns="http://www.w3.org/2000/svg">
                                                    <path
                                                        d="M19.6059 0C20.1059 0 20.5059 0.4 20.5059 0.9V15.1C20.5059 15.6 20.1059 16 19.6059 16H1.40586C1.16716 16 0.938246 15.9052 0.769463 15.7364C0.600681 15.5676 0.505859 15.3387 0.505859 15.1V0.9C0.505859 0.4 0.905859 0 1.40586 0H19.6059ZM18.6959 1.8H2.30586V12.65L7.84586 6.38C7.96586 6.21 8.22586 6.21 8.36586 6.38L11.4659 9.92C11.5259 9.98 11.5459 10.06 11.5259 10.12L11.1259 11.96C11.1059 12.1 11.2759 12.19 11.3559 12.08L14.5159 8.65C14.5664 8.59992 14.6347 8.57183 14.7059 8.57183C14.777 8.57183 14.8453 8.59992 14.8959 8.65L18.6859 12.77V1.8H18.6959ZM15.3259 6.6C14.9394 6.60004 14.5685 6.44791 14.2934 6.17654C14.0183 5.90517 13.8611 5.53639 13.8559 5.15C13.8559 4.34 14.5159 3.69 15.3259 3.69C16.1359 3.69 16.8059 4.34 16.8059 5.15C16.8059 5.95 16.1459 6.6 15.3259 6.6Z"
                                                        fill="#1E90FF" />
                                                </svg>
                                            </div>
                                            <span style="color:#1E90FF; font-size: 14px;">사진 첨부하기</span>
                                            <input type="file" name="qnaPhotoUpfile" id="file-input" accept="image/*">

                                        </div>
                                    </div>

                                    <div id="product_qna_content_container">
                                        <div style="font-size: 14px; font-weight: bold;">
                                            문의내용
                                        </div>
                                        <div id="product_qna_content_textarea">
                                            <textarea name="qnaContent" id="product_qna_content"
                                                placeholder="문의 내용을 입력하세요."></textarea>
                                        </div>
                                    </div>

                                    <div id="product_qna_enroll_btn_container">
                                        <button type="button" id="product_qna_enroll_btn" onclick="sendQnaByAjax()">완료</button>
                                    </div>
                                </form>
                            </div>


                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="../common/footer.jsp" />
            <script src="${contextPath }/resources/js/shopping/productDetail.js"></script>
        </body>

        </html>