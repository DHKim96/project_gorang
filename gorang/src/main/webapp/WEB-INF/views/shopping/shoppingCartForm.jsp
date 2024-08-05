<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

            <!-- font awesome kit -->
            <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>

            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${contextPath }/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath }/resources/css/shopping/shoppingCart.css">
            <script src="${contextPath }/resources/js/shopping/shoppingCart.js"></script>
            <!-- font awesome kit -->
            <script src="https://kit.fontawesome.com/68309de260.js" crossorigin="anonymous"></script>

        </head>

        <body>
            <!-- 헤더 -->
            <jsp:include page="../common/header.jsp" />


            <!-- 장바구니 container -->
            <div id="cart-container">
                <c:choose>
                    <c:when test="${empty groupedCarts}">
                        <div><span>장바구니가 비어있습니다.</span></div>
                    </c:when>
                    <c:otherwise>
                        <div id="cart-product-area">
                            <!-- 장바구니 top -->
                            <div id="product-area-top">
                                <div id="selectall-checkbox-container">
                                    <input type="checkbox" id="all-select-checkbox" value="">
                                    <label for="all-select-checkbox" id="all-check-label">모두 선택</label>
                                </div>
                                <div id="selected-delete" onclick="reallyDelete()">선택삭제</div>
                            </div>

                            <!-- 장바구니 내용물들 -->
                            <div id="product-content-area">
                                <!-- 장바구니 내용물 -->
                                <c:forEach var="entry" items="${groupedCarts}">
                                    <div class="product-in-cart">
                                        <div class="select-checkbox-container">
                                            <input type="checkbox" class="select-checkbox"
                                                onclick="changeAllCheckBox()">
                                        </div>
                                        <input type="hidden" class="cart-input-productNo"
                                            value="${entry.key.productNo}">
                                        <input type="hidden" class="cart-input-seller" value="${entry.key.seller}">
                                        <input type="hidden" class="cart-input-productBrand"
                                            value="${entry.key.productBrand}">
                                        <div class="product-img-container">
                                            <input type="hidden" class="cart-input-mainImg"
                                                value="${entry.key.mainImg}">
                                            <img class="product-img" style="cursor: pointer;"
                                                src="${contextPath }/resources/uploadfile/product/productimg/${entry.key.mainImg}"
                                                alt="" data-value="${entry.key.productNo}">
                                        </div>
                                        <div class="cart-product-info-container">
                                            <div class="cart-product-name-container">
                                                <span class="cart-product-name">${entry.key.productName}</span>
                                            </div>
                                            <div class="product-delivery-method">${entry.key.shipmentType}</div>
                                            <div>
                                                <span>배송비</span>
                                                <span class="product-delivery-cost">
                                                    ${entry.key.shippingPrice}
                                                </span>
                                            </div>
                                            <c:forEach var="cart" items="${entry.value}">
                                                <div class="cart-pdopt-container">
                                                    <input type="hidden" class="cart-input-optNo"
                                                        value="${cart.pdOptNo}">
                                                    <span
                                                        class="cart-productOpt-name">${cart.pdOptForCart.detailOptionName}</span>
                                                    <div class="product-quantity-price-container">
                                                        <div class="product-quantity">
                                                            <div class="pbtn minus_quantity" id="minus_quantity" style="cursor: pointer;">-</div>
                                                            <div class="pbtn quantity" id="quantity">
                                                                ${cart.pdOptQuantity}</div>
                                                            <div class="pbtn plus_quantity" id="plus_quantity" style="cursor: pointer;">+</div>
                                                        </div>
                                                        <div class="product-price">
                                                            <div>
                                                                <span
                                                                    class="product-origin-price" data-value="${cart.pdOptForCart.detailOptionOriginPrice}">${cart.pdOptForCart.detailOptionOriginPrice * cart.pdOptQuantity}</span><span
                                                                    class="origin-won">원</span>
                                                            </div>
                                                            <div>
                                                                <span
                                                                    class="product-saled-price" data-value="${cart.pdOptForCart.detailOptionSaledPrice}">${cart.pdOptForCart.detailOptionSaledPrice * cart.pdOptQuantity}</span><span
                                                                    class="saled-won">원</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="cart-product-delete" onclick="deleteProductOpt(this)">
                                                        <i class="fa-solid fa-x"></i>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div id="cart-price-area">
                            <div id="cart-detail-price-area">
                                <div id="cart-detail-price">
                                    <div id="total-product-price-area">
                                        <span>총 상품금액</span>
                                        <div>
                                            <span id="total-origin-price">0</span><span>원</span>
                                        </div>
                                    </div>
                                    <div id="total-delivery-charge-area">
                                        <span>총 배송비</span>
                                        <div>
                                            <span id="total-delivery-charge">0</span><span>원</span>
                                        </div>
                                    </div>
                                    <div id="total-discount-quantity-area">
                                        <span>총 할인금액</span>
                                        <div>
                                            <span id="total-discount-price">0</span><span>원</span>
                                        </div>
                                    </div>
                                </div>
                                <div id="cart-price-sum-area">
                                    <span style="font-size: 17px; font-weight: bold;">결제금액</span>
                                    <div>
                                        <span id="cart-price-sum">0</span><span
                                            style="font-size: 25px; font-weight: bold;">원</span>
                                    </div>
                                </div>

                            </div>
                            <form action="order.po" id="cart-form" method="post">
                                <input type="hidden" class="cart-input-json" name="selectedOptList">
                                <div id="buy_btn_container">
                                    <button type="button" id="buy_btn">구매하기</button>
                                </div>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>


            <!-- 푸터 -->
            <jsp:include page="../common/footer.jsp" />
        </body>

        </html>