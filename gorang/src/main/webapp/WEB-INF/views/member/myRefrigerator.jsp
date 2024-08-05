<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>
            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath}/resources/css/member/myRefrigerator.css">

            <!-- Slick 불러오기 -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
        </head>

        <body>
            <div class="header">
                <jsp:include page="../common/header.jsp" />
            </div>
            <div id="body-area">
                <!-- 왼쪽 프로필 메뉴바영역 -->
                <jsp:include page="myPageMenubar.jsp" />
                <!-- 우측 메인영역 -->
                <div id="right-body-area">
                    <!-- 추천레시피 전체영역 -->
                    <div id="recommend-recipe-area">
                        <!-- 추천레시피 제목영역 -->
                        <div id="right-recommend-recipe-title-area">
                            <div id="recommend-recipe-texthead">
                                추천 레시피
                            </div>
                            <div id="recommend-recipe-modal-btn">
                                <button id="viewModalBtn">
                                    레시피 추천 받기
                                </button>
                            </div>
                        </div>
                        <!-- 추천레시피 이미지영역 -->
                        <div id="recommend-recipe-imgs">
                            <div>
                                <span>레시피를 추천받아보세요!</span>
                            </div>
                        </div>
                    </div>

                    <!-- 나의 냉장고 전체 영역 -->
                    <div id="myRefrigerator-area">
                        <!-- 나의 냉장고 제목 -->
                        <div id="myRefrigerator-text-title-area">
                            <div id="myRefrigerator-texthead">
                                나의 냉장고
                            </div>
                            <div id="myRefrigerator-modal-btn">
                                <button id="viewModalBtn-two" class="refreMainBtn">
                                    + 추가하기
                                </button>
                                <button id="refreDeleteBtn" class="refreMainBtn">
                                    - 삭제하기
                                </button>
                            </div>
                        </div>

                        <!-- 나의 냉장고 식재료내역 -->
                        <div id="myRefrigerator-igre-area">
                            <c:choose>
                                <c:when test="${empty refriIngres}">
                                    <span>냉장고가 비어있습니다.</span>
                                </c:when>
                                <c:otherwise>
                                    <div id="myRefrigerator-igre-table-area">
                                        <table>
                                            <thead id="myRefrigerator-tb">
                                                <tr class="myRefrigerator-tr">
                                                    <td style="width: 50px;">분류</td>
                                                    <td style="width: 200px;">상품</td>
                                                    <td>신선도</td>
                                                    <td>소비기한</td>
                                                    <td>냉장고 입고일</td>
                                                    <td style="width: 80px;">개수</td>
                                                    <td style="width: 50px;"><input type="checkbox" id="refri-main-delete-allCheckBox"></td>
                                                </tr>
                                            </thead>
                                            <tbody id="myRefrigerator-table-tbody">
                                                <c:forEach var="refriIngre" items="${refriIngres}">
                                                    <tr class="tr-block">
                                                        <td class="myRefrigerator-tr">
                                                            <img src="${contextPath}/resources/images/myRefrigeratorKind/${refriIngre.refKind}.png" alt="">
                                                        </td>
                                                        <td class="refri-main-td-refName" data-value="${refriIngre.refNo}">
                                                            ${refriIngre.refName}
                                                        </td>
                                                        <td class="flesh-area">
                                                            <c:choose>
                                                                <c:when test="${refriIngre.daysDifference <= 3}">
                                                                    <span>위험</span> 
                                                                    <div class="flesh-status"
                                                                        style="background-color:#F20E2B;"></div>
                                                                </c:when>
                                                                <c:when
                                                                    test="${refriIngre.daysDifference > 3 && refriIngre.daysDifference <= 7}">
                                                                    <span>보통</span> 
                                                                    <div class="flesh-status"
                                                                        style="background-color:#FFE28A;"></div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>신선</span> 
                                                                    <div class="flesh-status"
                                                                        style="background-color:#7ADC66;"></div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td> <!--나중에 class id로 변경-->
                                                        <td>${refriIngre.refConsumptionDate}</td>
                                                        <td>${refriIngre.refInputDate}</td>
                                                        <td>${refriIngre.refCount}</td>
                                                        <td><input type="checkbox" class="refri-main-delete-checkBox"></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <!-- 페이징 바 -->
                    <div id="pagination-area">
                        <div class="pagination">
                            <c:if test="${pi.currentPage ne 1 }">
                                <a data-value="${pi.currentPage - 1}">&lt;</a>
                            </c:if>

                            <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                                <a data-value="${p}">
                                    <c:choose>
                                        <c:when test="${p eq 1}">
                                            <strong>${p}</strong>
                                        </c:when>
                                        <c:otherwise>
                                            ${p}
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </c:forEach>

                            <c:if test="${pi.currentPage lt pi.maxPage}">
                                <a data-value="${pi.currentPage + 1}">&gt;</a>
                            </c:if>
                        </div>
                    </div>

                    <!-- 모달 창 레시피 찾기 -->
                    <div id="myModal" class="modal">
                        <div id="modal-content-recipe-find">
                            <div id="modal-title-header">
                                레시피 찾기
                            </div>
                            <div id="modal-recipe-selectedIngre">

                            </div>
                            <div id="list-igre-area">
                                <button id="findOutRecipeBtn" class="modalBtn">레시피 찾기</button>
                                <div>
                                    <button id="completeModalBtn" class="complete modalBtn modalBtnBorder">추가하기</button>
                                </div>
                            </div>
                            <table>
                                <thead>
                                    <tr class="modal-thead-tr">
                                        <th style="width: 40px; text-align: center;"><input type="checkbox" id="modal-recipe-allCheckBox"></th>
                                        <th style="width: 200px;">식품명</th>
                                        <th style="width: 160px;">소비기한</th>
                                        <th style="width: 160px;">입고일</th>
                                    </tr>
                                </thead>
                                <tbody id="modal-recipe-tbody">
                                    <c:forEach var="refriIngre" items="${refriIngres}">
                                        <tr class="modal-recipe-tbody-tr">
                                            <td class="modal-recipe-td-checkBox"><input type="checkbox"></td>
                                            <td class="modal-recipe-refName">${refriIngre.refName}</td>
                                            <td>${refriIngre.refConsumptionDate}</td>
                                            <td>${refriIngre.refInputDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div id="modal-recipe-pagination">
                                <div class="pagination">
                                    <c:if test="${pi.currentPage ne 1 }">
                                        <a data-value="${pi.currentPage - 1}">&lt;</a>
                                    </c:if>
                                    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                                        <a data-value="${p}">
                                            <c:choose>
                                                <c:when test="${p eq 1}">
                                                    <strong>${p}</strong>
                                                </c:when>
                                                <c:otherwise>
                                                    ${p}
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:forEach>
                                    <c:if test="${pi.currentPage lt pi.maxPage}">
                                        <a data-value="${pi.currentPage + 1}">&gt;</a>
                                    </c:if>
                                </div>
                            </div>
                            <div id="modal-search-recipe-bottom">
                                <button id="closeModalBtn" class="close">닫 기</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 모달 창 식재료 추가 -->
                <div id="myModal-two" class="modal-two">
                    <div id="modal-content-recipe-add">
                        <div id="modal-title-recipe-header">
                            식재료 추가하기
                        </div>
                        <div class="modal-ingre-input-howTo">
                            <span>식품영양정보 공공데이터 이용하기(공산품일 경우)</span>
                            <span>직접 입력하기(공산품이 아닐 경우)</span>
                        </div>
                        <!-- input 창 감싸는 div-->
                        <div id="modal-search-igre2">
                            <div class="modal-ingre-search-wrapper">
                                <div class="refri-input-wrapper">
                                    <input id="refri-input-foodName" class="refri-foodNutri-input" placeholder=" 식품명 입력"
                                        onkeypress="handleKeyPress2(event)">
                                    <input id="refri-input-maker" class="refri-foodNutri-input" placeholder="제조사명 입력"
                                        onkeypress="handleKeyPress2(event)">
                                </div>
                                <button id="find-nutri-btn">
                                    <img src="${pageContext.request.contextPath}/resources/images/member-img/search 3.png"
                                        alt="">
                                </button>
                            </div>
                            <!-- 유저가 공공데이터 이용하지 않고 직접 입력하기 위한 input 요소 포함한 div -->
                            <div class="modal-ingre-search-wrapper">
                                <div class="refri-input-wrapper">
                                    <input id="refri-input-foodName-user" class="refri-foodNutri-input" placeholder=" 식품명 입력"
                                        onkeypress="handleKeyPress2(event)" style="border-bottom: 1px solid #C5C5C5;"/>
                                    <select id="refri-select-foodClassification" class="refri-foodNutri-input" style="font-size: large;">
                                        <option value="">분류를 선택해주세요</option>
                                        <option value="1">밥류</option>
                                        <option value="2">빵 및 과자류</option>
                                        <option value="3">면 및 만두류</option>
                                        <option value="4">죽 및 스프류</option>
                                        <option value="5">국 및 탕류</option>
                                        <option value="6">찌개 및 전골류</option>
                                        <option value="7">찜류</option>
                                        <option value="8">구이류</option>
                                        <option value="9">전, 적 및 부침류</option>
                                        <option value="10">볶음류</option>
                                        <option value="11">조림류</option>
                                        <option value="12">튀김류</option>
                                        <option value="13">나물 및 숙채류</option>
                                        <option value="14">생채 및 무침류</option>
                                        <option value="15">김치류</option>
                                        <option value="16">젓갈류</option>
                                        <option value="17">장아찌 및 절임류</option>
                                        <option value="18">장류 및 양념류</option>
                                        <option value="19">유제품류 및 빙과류</option>
                                        <option value="20">음료 및 차류</option>
                                        <option value="21">주류</option>
                                        <option value="22">과일류</option>
                                        <option value="23">당류</option>
                                        <option value="24">곡류 및 서류 제품</option>
                                        <option value="25">두류, 견과 및 종실류</option>
                                        <option value="26">채소 및 해조류</option>
                                        <option value="27">수, 조, 어, 육류</option>
                                        <option value="28">유지류</option>
                                        <option value="29">기타</option>
                                    </select>
                                </div>
                                <button id="input-nutri-btn" style="border-right: none;">
                                    입력
                                </button>
                            </div>
                        </div>

                        <div id="list-igre-area2">
                            <span>&#8251;입력사항 미기입 시 소비기한은 7일 후, 입고일은 금일, 갯수는 1개로 자동 기입됩니다.</span>
                            <button id="addAll-btn2">추 가</button>
                        </div>

                        <div id="overflow-recipe-area2">
                            <table id="overflow-table">
                                <thead>
                                    <tr id="list-title2" class="modal-thead-tr">
                                        <th style="width: 40px; height: 100%; text-align: center;"><input type="checkbox"
                                                id="modal-ingre-checkBox"></th>
                                        <th id="add-list-title1" style="width: 60px;">번호</th>
                                        <th id="add-list-title2" style="width: 200px;">식품명</th>
                                        <th style="width: 100px;">대분류</th>
                                        <th style="width: 70px;">영양성분</th>
                                        <th style="width: 160px;">소비기한</th>
                                        <th style="width: 160px;">냉장고 입고일</th>
                                        <th style="width: 60px;">갯수</th>
                                    </tr>
                                </thead>
                                <tbody id="modal-ingre-tbody">

                                </tbody>
                            </table>
                        </div>
                        <div id="ingre-modal-pagination">
                            <div class="pagination">

                            </div>
                        </div>
                        <div id="modal-search-recipe-bottom2">
                            <button id="closeModalBtn2" class="close">닫 기</button>
                        </div>
                    </div>
                </div>

                <!-- 영양성분표 모달 -->
                <div class="modal fade nutrition-modal" id="nutritionModal" tabindex="-1" role="dialog"
                    aria-labelledby="nutritionModalLabel" aria-hidden="true">
                    <div class="modal-dialog nutrition-modal-container" role="document" style="position: absolute;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="nutritionModalLabel">영양정보</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <table class="nutrition-table">
                                </table>
                                <p class="disclaimer">1일 영양성분 기준치에 대한 비율(%)은 2000kcal 기준이며, 개인의 필요 열량에 따라 다를
                                    수 있습니다.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <jsp:include page="../common/footer.jsp" />
            <!-- js -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
            <script src="${contextPath}/resources/js/member/myPageRefrigerator.js"></script>
        </body>

        </html>