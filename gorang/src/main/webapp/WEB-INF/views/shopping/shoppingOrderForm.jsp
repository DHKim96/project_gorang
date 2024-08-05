<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

                <!-- font awesome kit -->
                <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>

                <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
                <link rel="stylesheet" href="${contextPath }/resources/css/default.css">
                <link rel="stylesheet" href="${contextPath }/resources/css/shopping/productOrder.css">
                <script src="${contextPath }/resources/js/shopping/shoppingOrder.js"></script>

                <!-- 카카오 주소검색 api -->
                <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            </head>

            <body>
                <!-- 헤더 -->
                <jsp:include page="../common/header.jsp" />

                <!-- 주문 container -->
                <div id="order-container">
                    <div id="order-information-area">
                        <div style="font-size: 23px; font-weight: bold;">주문/결제</div>

                        <!-- 구매자 정보 칸 -->
                        <div id="buyer-information-area">
                            <div class="area-top">
                                구매자 정보
                                <button id="put-myInfo">내 정보 넣기</button>
                                <input type="hidden" id="information-loginUser-email" value="${loginUser.memberEmail}">
                                <input type="hidden" id="information-loginUser-phone" value="${loginUser.memberPhone}">
                            </div>
                            <div id="buyer-information" class="information-area">
                                <div id="buyer-name-area" class="information-div">
                                    <div class="information-title">이름</div>
                                    <div class="input-container">
                                        <input type="text" id="input-buyer-name">
                                    </div>
                                </div>
                                <div id="buyer-email-area" class="information-div">
                                    <div class="information-title">이메일</div>
                                    <div id="email-container">
                                        <div id="email-name-container" class="input-container">
                                            <input type="text" id="input-buyer-email">
                                        </div>
                                    </div>
                                </div>
                                <div id="buyer-phone-area" class="information-div">
                                    <div class="information-title">전화번호</div>
                                    <div class="input-container">
                                        <input type="text" id="input-buyer-phone">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 구매자 배송지 정보 칸 -->
                        <div id="buyer-address-information">
                            <div class="area-top">배송지 정보</div>
                            <div class="information-area">
                                <div id="buyer-address-name-area" class="information-div">
                                    <div class="information-title">배송지명</div>
                                    <div class="input-container">
                                        <input type="text" id="input-delivery-name">
                                    </div>
                                </div>

                                <div id="buyer-recipient-area" class="information-div">
                                    <div class="information-title">받는사람</div>
                                    <div class="input-container">
                                        <input type="text" id="input-delivery-recipient">
                                    </div>
                                </div>

                                <div id="buyer-phonenumber-area" class="information-div">
                                    <div class="information-title">전화번호</div>
                                    <div class="input-container">
                                        <input type="text" id="input-delivery-phone">
                                    </div>
                                </div>

                                <div id="buyer-address-area" class="information-div">
                                    <div class="information-title">주소</div>
                                    <div class="address-input-container">
                                        <div class="find_address_area">
                                            <div>
                                                <button id="find-address-btn" onclick="searchAddress()">주소찾기</button>
                                            </div>
                                            <div class="input-container" id="zonecode">
                                            </div>
                                        </div>
                                        <div class="input-container large" id="address">
                                        </div>
                                        <div class="input-container large">
                                            <input type="text" placeholder="상세주소 입력" style="padding-left: 10px;"
                                                id="input-delivery-detailAddress">
                                        </div>
                                    </div>
                                </div>

                                <div id="buyer-requirement-area" class="information-div">
                                    <div class="information-title">요청사항</div>
                                    <div class="input-container wd-576">
                                        <select name="" id="requirement-select">
                                            <option value="부재시 문앞에 놓아주세요">부재시 문앞에 놓아주세요</option>
                                            <option value="배송전 미리 연락주세요">배송전 미리 연락주세요</option>
                                            <option value="부재시 경비실에 맡겨주세요">부재시 경비실에 맡겨주세요</option>
                                            <option value="부재시 전화주시거나 문자 남겨주세요">부재시 전화주시거나 문자 남겨주세요</option>
                                            <option value="직접 입력">직접 입력</option>
                                        </select>
                                    </div>
                                </div>



                            </div>
                        </div>

                        <!-- 주문상품 -->
                        <div id="buyer-order-product-area">
                            <div class="area-top">주문상품</div>
                            <div class="information-area">
                                <c:forEach var="entry" items="${groupedOpts}">
                                    <div class="order-product-container">
                                        <div class="order-product-container-top">
                                            <span class="brandName">${entry.key.productBrand}</span>
                                        </div>
                                        <div class="order-product-container-content">
                                            <div class="order-product-img-container">
                                                <img class="order-product-img"
                                                    src="${contextPath }/resources/uploadfile/product/productimg/${entry.key.mainImg}"
                                                    alt="">
                                            </div>
                                            <div class="order-product-info">
                                                <div class="order-product-name">
                                                    <span
                                                        class="order-product-name-pname">${entry.key.productName}</span>
                                                </div>
                                                <c:forEach var="opt" items="${entry.value}">
                                                    <div class="order-productOpt-container">
                                                        <input type="hidden" class="input-order-optNo"
                                                            value="${opt.detailOptionNo}">
                                                        <span
                                                            class="order-product-name-optname">${opt.detailOptionName}</span>
                                                        <div class="order-product-quantity-area">
                                                            <div>
                                                                <span class="order-product-saled-price">
                                                                    <fmt:formatNumber
                                                                        value="${opt.detailOptionSaledPrice}"
                                                                        type="number" />
                                                                </span><span class="won">원</span>
                                                            </div>
                                                            <span style="color: #ededed;">|</span>
                                                            <div>
                                                                <span
                                                                    class="order-product-quantity">${opt.detailOptionQuantity}</span><span>개</span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </c:forEach>
                                                <div class="order-product-delivery-info order-product-quantity-area">
                                                    <div class="order-product-shipping-cost">
                                                        <span class="order-product-additional-info">배송비</span>
                                                        <span class="shipping-cost order-product-additional-info">
                                                            ${entry.key.shippingPrice}
                                                        </span>
                                                    </div>
                                                    
                                                    <span style="color: #ededed;">|</span>
                                                    <span
                                                        class="shipping-method order-product-additional-info">${entry.key.shipmentType}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach>

                            </div>
                        </div>

                        <!-- 결제수단 -->
                        <div id="order-payment-container">
                            <div class="area-top">결제수단</div>
                            <div class="information-area">

                                <div class="payment-list">
                                    <div class="payment" id="payment-card" onclick="clickPayment(this,'card')">
                                        <div>카드</div>
                                        <div>
                                            <img src="${contextPath }/resources/dummyImg/shopping/payment/card.png"
                                                alt="">
                                        </div>
                                    </div>
                                    <div class="payment" id="payment-bank-transfer"
                                        onclick="clickPayment(this,'transfer')">
                                        <div>무통장입급</div>
                                        <div>
                                            <img src="${contextPath }/resources/dummyImg/shopping/payment/bank_transfer.png"
                                                alt="">
                                        </div>
                                    </div>
                                    <div class="payment" id="payment-kakaopay" onclick="clickPayment(this,'kakaopay')">
                                        <div>카카오페이</div>
                                        <div>
                                            <img src="${contextPath }/resources/dummyImg/shopping/payment/img_kakaopay.png"
                                                alt="">
                                        </div>
                                    </div>
                                    <div class="payment" id="payment-naverpay" onclick="clickPayment(this,'naverpay')">
                                        <div>네이버페이</div>
                                        <div>
                                            <img src="${contextPath }/resources/dummyImg/shopping/payment/img_naver.png"
                                                alt="">
                                        </div>
                                    </div>
                                    <div class="payment" id="payment-phone" onclick="clickPayment(this,'phone')">
                                        <div>핸드폰</div>
                                        <div>
                                            <img src="${contextPath }/resources/dummyImg/shopping/payment/phone.png"
                                                alt="">
                                        </div>
                                    </div>
                                </div>

                                <!-- 카드를 선택했을 때 나올 div -->
                                <div id="select-card-area">
                                    <div class="select-list">
                                        <select name="" id="">
                                            <option value="">농협</option>
                                            <option value="">신한</option>
                                            <option value="">우리</option>
                                            <option value="">BC</option>
                                            <option value="">삼성</option>
                                            <option value="">현대</option>
                                        </select>
                                    </div>
                                    <div class="select-list">
                                        <select name="" id="">
                                            <option value="">1개월</option>
                                            <option value="">2개월</option>
                                            <option value="">3개월</option>
                                            <option value="">4개월</option>
                                            <option value="">5개월</option>
                                            <option value="">6개월</option>
                                            <option value="">7개월</option>
                                            <option value="">8개월</option>
                                            <option value="">9개월</option>
                                            <option value="">10개월</option>
                                        </select>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="cart-price-area">
                        <div id="cart-detail-price-area">

                            <div style="font-weight: bold; font-size: 18px;">
                                결제금액
                            </div>

                            <div id="cart-detail-price">
                                <div id="total-product-price-area">
                                    <span>총 상품금액</span>
                                    <div>
                                        <span id="total-product-price"></span><span>원</span>
                                    </div>
                                </div>
                                <div id="total-delivery-charge-area">
                                    <span>배송비</span>
                                    <div>
                                        <span id="total-delivery-charge">0</span><span>원</span>
                                    </div>
                                </div>
                            </div>

                            <div id="cart-price-sum-area">
                                <span style="font-size: 17px; font-weight: bold;">결제금액</span>
                                <div>
                                    <span class="cart-price-sum totalPrice"></span><span
                                        class="total-price-sum">원</span>

                                </div>
                            </div>

                        </div>

                        <form id="buy_btn_container" method="post" action="insertOrder.po">
                            <input type="hidden" id="order-input-orderInfo" name="orderDataJson">
                            <button id="buy_btn"><span class="totalPrice"></span>원 결제하기</button>
                        </form>
                    </div>
                </div>


                <!-- 푸터 -->
                <jsp:include page="../common/footer.jsp" />
            </body>

            </html>