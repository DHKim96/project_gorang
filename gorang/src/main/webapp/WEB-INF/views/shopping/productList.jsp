<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

    <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
    <link rel="stylesheet" href="${contextPath }/resources/css/default.css">
    <link rel="stylesheet" href="${contextPath }/resources/css/shopping/storeList.css">
</head>

<body onload="loadSideBar()">
    <!-- 헤더 시작-->
    <jsp:include page="../common/header.jsp" />
    <!-- 헤더 끝-->
    <!-- 사이드바 -->
    <jsp:include page="../common/sidebar.jsp" />
    <!-- 컨텐츠 시작 -->
    <div id="productList-container">
        <!-- 카테고리 시작 -->
        <div id="category-area">
            <div class="store-category" id="category-all">
                <div class="category-image-area">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping/all.png" alt="모두">
                </div>
                <div class="category-name">
                    모두
                </div>
            </div>

            <div class="store-category" id="category-veget">
                <div class="category-image-area">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping/vaget.png" alt="야채">
                </div>
                <div class="category-name">
                    야채
                </div>
            </div>

            <div class="store-category" id="category-fruit">
                <div class="category-image-area" id="category-fruit">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping/fruit.png" alt="과일">
                </div>
                <div class="category-name">
                    과일
                </div>
            </div>

            <div class="store-category" id="category-fish">
                <div class="category-image-area">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping/fish.png" alt="어류">
                </div>
                <div class="category-name">
                    어류
                </div>
            </div>

            <div class="store-category" id="category-meat">
                <div class="category-image-area">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping/meat.png" alt="육류">
                </div>
                <div class="category-name">
                    육류
                </div>
            </div>

            <div class="store-category" id="category-bread">
                <div class="category-image-area">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping//bread.png" alt="빵">
                </div>
                <div class="category-name">
                    빵
                </div>
            </div>

            <div class="store-category" id="category-noodle">
                <div class="category-image-area">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping//noodle.png" alt="면">
                </div>
                <div class="category-name">
                    면
                </div>
            </div>

            <div class="store-category" id="category-dairy">
                <div class="category-image-area">
                    <img class="category-image" src="${contextPath }/resources/dummyImg/shopping//dairy.png" alt="유제품">
                </div>
                <div class="category-name">
                    유제품
                </div>
            </div>
        </div>
        <!-- 카테고리 끝 -->

        <!-- 상품 리스트 시작 -->
        <div id="productList-area" style="margin-top: 40px;">
            <!-- 정렬 방식 -->
            <div id="product-order-area">
                <div id="product-order">
                    <span class="sort" onclick="orderProductList('${contextPath }/list.po?content=${content}&category=${category}&sort=new')">최신순</span> |
                    <span class="sort" onclick="orderProductList('${contextPath }/list.po?content=${content}&category=${category}&sort=view')">조회수순</span> |
                    <span class="sort" onclick="orderProductList('${contextPath }/list.po?content=${content}&category=${category}&sort=scrap')">스크랩순</span>
                </div>
            </div>

            <!--상품 리스트 시작-->
            <div id="product-list">

                <!-- 상품 -->
                <c:forEach var="product" items="${list }">
                    <div class="item" onclick="location.href='detail.po?pno=${product.productNo}'">
                        <div class="item-thumbnail-area">
                            <img class="item-thumbnail"
                                src="${contextPath }/resources/uploadfile/product/productimg/${product.mainImg }"
                                alt="상품1">
                        </div>
                        <div class="item-text-area">
                            <div class="item-title">
                                <div class="item-brand">${product.productBrand }</div>
                                <div class="item-name">${product.productName }</div>
                            </div>
                            <div class="item-price">
                                <div class="item-origin-price">${product.normalPrice }</div>
                                <div>
                                    <span class="discount-percent">${product.discountPercent }%</span>
                                    <span class="discounted-price">${product.salePrice }</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </div>
        <!-- 상품 리스트 끝 -->

        <div id="pagination-area">
            <div id="pagination">

                <c:choose>
                    <c:when test="${pi.currentPage ne 1 }">
                        <a href="list.po?content=${content}&cpage=${pi.currentPage -1 }&category=${category}&sort=${sort}">&lt;</a>
                    </c:when>
                </c:choose>

                <c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
                    <c:choose>
                        <c:when test="${pi.currentPage eq p}">
                            <a href="list.po?content=${content}&cpage=${p}&category=${category}&sort=${sort}"><strong style="color:#1E90FF;">${p}</strong></a>
                        </c:when>
                        <c:otherwise>
                            <a href="list.po?content=${content}&cpage=${p}&category=${category}&sort=${sort}">${p}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${pi.currentPage lt pi.maxPage}">
                        <a href="list.po?content=${content}&cpage=${pi.currentPage +1 }&category=${category}&sort=${sort}">&gt;</a>
                    </c:when>
                </c:choose>
                
            </div>
            
        </div>
    </div>


    <!-- 컨텐츠 끝 -->
    <jsp:include page="../common/footer.jsp" />
    <script src="${contextPath }/resources/js/shopping/productList.js"></script>

</body>

</html>