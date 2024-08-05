<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<link rel="stylesheet" href="${contextPath}/resources/css/recipe/recipeUpdate.css">
<script src="${contextPath}/resources/js/recipe/recipeUpdate.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
       <!-- 헤더 -->
       <jsp:include page="../common/header.jsp" />
       
       <form id="update-form"action="${contextPath}/update.re" method="post">  
        <div id="head-btn-area">
            <button id="save-recipe">임시 저장</button>
            <button type="submit"  id="register-rcipe" onclick="return enrollRecipeBtn()">등록 하기</button>
        </div>
        <input type="hidden" name="memberNo" value="${loginUser.memberNo}">
        <input type="hidden" name="recipeNo" value="${rcp.recipeNo}">
        
        <!-- 레시피 작성 전체영역 -->
       <div id="recipe-write-all-area">
        <!-- 썸네일 추가영역 -->
            <div id="recipe-write-imgupload-area" onclick="choiceThumnailImg()">
                <img id="thumnailImg" src="${contextPath}/resources/dummyImg/recipe/recipeWrite/camerg.png" alt="" style="display: none;">
                <img id="thumnailImg-real" src="${contextPath}/resources/uploadfile/recipe/recipemain/${rcp.recipeMainPhoto}" alt="" style="display: block;">
                <input type="hidden" name="recipeMainPhoto" id="recipeMainPhoto" value="${rcp.recipeMainPhoto}">
                <input type="file" id="recipeMainPhotoFile" onchange="changeThumnailImg(this)">
                <div id="recipe-write-img-middle-text" style="display: none;">Upload recipe photo</div>
                <div id="recipe-write-img-bottom-text" style="display: none;">Show others your finished dish</div>
            </div>



            <!-- 제목,소개,동영상, 태그, 카테고리 -->
            <div id="recipe-write-title-area">
                <input name="recipeTitle" type="text" placeholder="레시피 제목을 입력해주세요." value="${rcp.recipeTitle}">
            </div>

            <div id="recipe-introduce-area">
                <textarea name="recipeContent" id="" maxlength="500" placeholder="여러분의 요리를 소개시켜주세요"  >${rcp.recipeContent}</textarea>
            </div>

            <div id="recipe-yotube-area">
                <textarea name="recipeVideo" id="" maxlength="500" placeholder="동영상이 있다면 주소를 작성해주세요(Youtube 만 가능)" value="${rcp.recipeVideo}" >${rcp.recipeVideo}</textarea>
            </div>

            <div id="recipe-tage-area">
                <input type="text" placeholder="태그를 넣어주세요 예)#얼큰 #찌개 #건강식"  name="recipeTag"  value="${rcp.recipeTag}">
            </div>

            <div id="recipe-category-area">
                <div id="ctg-div">카테고리</div>
                <div class="selectbox-areas" > 
                    <select name="cookKind" id="" class="mySelect" > 
                        <option value="" disabled selected hidden>종류</option>
                        <c:forEach var="kind" items="${['한식', '중식', '일식', '양식', '디저트', '기타']}">
                            <option value="${kind}" ${kind eq rcp.cookKind ? 'selected' : ''}>${kind}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="selectbox-areas"> 
                    <select name="cookLevel" id="" class="mySelect" > 
                        <option value="" disabled selected hidden>난이도</option>
                        <c:forEach var="level" items="${['상','중','하']}">
                            <option value="${level}" ${level eq rcp.cookLevel ? 'selected' : ''}>${level}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="selectbox-areas"> 
                    <select name="cookTime" id="" class="mySelect"> 
                        <option value="" disabled selected hidden>시간</option>
                        <c:forEach var="time" items="${['5분 이내','10분 이내','15분 이내','30분 이내','1시간 이내','2시간 이내','2시간 이상']}">
                            <option value="${time}" ${time eq rcp.cookTime ? 'selected' : ''}>${time}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="selectbox-areas"> 
                    <select name="cookAmount" id="" class="mySelect"> 
                        <option value="" disabled selected hidden>인원</option>
                        <c:forEach var="amount" items="${['1인분','2인분','3인분','4인분','5인분','6인분','6인분 이상']}">
                            <option value="${amount}" ${amount eq rcp.cookAmount ? 'selected' : ''}>${amount}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <script>
                const selectElement = document.querySelector(".mySelect");
            
                selectElement.addEventListener("change", function() {
                    if (this.value === "") {
                        this.selectedIndex = -1; // 플레이스홀더를 선택하지 못하도록 함
                    }
                });
            </script>

            <div id="recipe-ingredient-info-area"> 
                <div id="recipe-ingredient-info-area-title">
                    <span id="ingredient-info-span-top">재료 정보</span><br>
                    <span id="ingredient-info-span-bottom">※ 식재료,양념, 양념장, 소스, 드레싱, 토핑, 시럽, 육수 밑간 등으로 구분해서 작성해주세요.</span>
                </div>
                <c:forEach var="division" items="${recipeInsertDTO.rcpDivList}" varStatus="divisionIndex">
                    <div class="recipe-ingredient-info-blocks" id="divisions-${divisionIndex.index}">
                        <div class="recipe-ingredient-info-top">
                            <input class ="divNocl" name="rcpDivList[${divisionIndex.index}].divNo" type="hidden" value="${division.divNo}">
                            <div class="location-btn"><img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/Link.png" alt=""></div>
                            <div class="ingre-div-block" > 
                                <input name="rcpDivList[${divisionIndex.index}].divName" type="text" placeholder="분류 예)식재료" value="${division.divName}">
                            </div> 
                            <div class="delete-btn" onclick="deleteIngreBlock(this,'${divisionIndex.index}')"><img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/Icon.png" alt=""></div>
                        </div>
                        <div class="recipe-ingredient-info-bottom">
                            <c:forEach var="ingredient" items="${division.ingredientsInfoList}" varStatus="ingreIndex">
                                <div class="recipe-smaill-block" id="ingredients-${ingreIndex.index}">
                                <div class="location-btn"><img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/Link.png" alt=""></div>
                                <div class="igre-name-block"><input name="rcpDivList[${divisionIndex.index}].ingredientsInfoList[${ingreIndex.index}].ingreName" type="text" placeholder="재료명 예)돼지고기" value="${ingredient.ingreName}"></div>
                                <div class="igre-amount-block"><input name="rcpDivList[${divisionIndex.index}].ingredientsInfoList[${ingreIndex.index}].ingreAmount" type="text" placeholder="수량" value="${ingredient.ingreAmount}"></div>
                                <div class="igre-unit-block"><input name="rcpDivList[${divisionIndex.index}].ingredientsInfoList[${ingreIndex.index}].ingreUnit" type="text" placeholder="단위" value="${ingredient.ingreUnit}"></div>
                                <div class="delete-btn2" onclick="deleteSmaillBlock(this,'${divisionIndex.index}','${ingreIndex.index}')"><img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/Icon.png" alt="" ></div>
                                <button type="button">태그 +</button>
                            </div>
                            </c:forEach>
                            <div class="add-igre-btn">                     
                                <img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/plus.png" alt="" onclick="addBundle(this,'${divisionIndex.index}','${division.ingredientsInfoList.size()-1}')">
                                <button type="button"  onclick="addBundle(this,'${divisionIndex.index}','${division.ingredientsInfoList.size()-1}' )">묶음 추가</button>
                            </div>
                        </div>               
                    </div>
                </c:forEach>
                    <!-- </div> -->
                    <div id="add-div-btn">
                        <button type="button" onclick="addUnit(this,'${recipeInsertDTO.rcpDivList.size()-1}')">+ 분류 추가</button>
                    </div>
            </div>

            <!-- 조리 순서 영역 -->
            <div id="cooking-order-area">
                <div id="cooking-order-area-title">조리순서</div>
                    <c:forEach var="cookOrder" items="${recipeInsertDTO.cookOrderList}" varStatus="orderIndex">
                        <div class="cooking-order-blocks" id="cookOrder-${orderIndex.index}">
                            <div class="cooking-order-block" >
                                <div class="cooking-order-block-top">
                                    <div class="cook-order-number-img">${orderIndex.index+1}</div>
                                    <div class="cook-order-write-content"><input name ="cookOrderList[${orderIndex.index}].cookOrdContent" type="text" placeholder="예) 소고기는 기름을 떼어내고 적당한 크기로 썰어주세요" value="${cookOrder.cookOrdContent}"></div>
                                    <div class="cook-order-hambugerbar"><img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/SVG.png" alt=""></div>
                                </div>
                                <div class="cooking-order-block-bottom" >
                                    <div class="cooking-order-block-bottom-img" onclick="cookIngOrderImg(this,'${orderIndex.index}')">
                                        <img class ="cookingImg" src="${contextPath}/resources/dummyImg/recipe/recipeWrite/camera.png" alt="" style="display: none;">
                                        <input type="hidden" name="cookOrderList[${orderIndex.index}].cookOrdPhoto" id="cookOrdPhoto" value="${cookOrder.cookOrdPhoto}">
                                        <img class="cookingImg-real" src="${contextPath}/resources/uploadfile/recipe/recipeorder/${cookOrder.cookOrdPhoto}" alt="" style="display: block;" >
                                        <input type="file"  id="fileInput"  onchange="changeCookIngOrderImg(this,'${orderIndex.index}')">
                                    </div>
                                    <div class="cooking-order-block-bottom-tips">
                                        <c:forEach var="cookTip" items="${cookOrder.cookTipList}" varStatus="tipIndex">
                                                <div class="cooking-order-block-bottom-tip" id="cookTip-${tipIndex.index}">
                                                    <input name ="cookOrderList[${orderIndex.index}].cookTipList[${tipIndex.index}].cookTipContent" type="text" placeholder="팁 예) 볶는 시간은 최소로 합니다" value="${cookTip.cookTipContent}">
                                                    <button type="button" class="add-tip"  onclick="addTip(this,'${orderIndex.index}','${tipIndex.index}')">
                                                        <img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/plus (2).png" alt=""></button>
                                                    <button type="button" class="delte-tip" onclick="deleteTip(this,'${orderIndex.index}','${tipIndex.index}')">
                                                        <img src="${contextPath}/resources/dummyImg/recipe/recipeWrite/Icon.png" alt=""  ></button>
                                                </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div id="recipe-order-delete-btn-area">
                                    <button type="button" id="order-delete-btn" onclick="deleteCookingOrder(this,'${orderIndex.index}')">삭제</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div id="add-order-btn">
                        <button type="button" onclick="addCookingOrder(this,'${recipeInsertDTO.cookOrderList.size()-1}')">+ 순서 추가</button>
                    </div>
            </div>
            
            <!-- 완성사진영역 -->
            <div id="complete-food-img-area">
                <div id="complete-food-img-title">완성사진</div>
                <div id="complete-food-img-blocks" >
                    <c:forEach var="media" items="${recipeInsertDTO.completeFoodPhoto}" varStatus="status">
                        <div class="cfiBlock">
                            <input type="button" class="btn-delete" value="x" onclick="deleteCPhoto(this)">
                            <div class="complete-food-img-block"  onclick="completeImg(this)" >
                                <img class="completeImg" src="${contextPath}/resources/dummyImg/recipe/recipeWrite/camera.png" alt="" style="display: none;">
                                <input type="hidden" name="completeFoodPhoto[${status.index}].originName" value="${media.originName}">
                                <img class="completeImg-real" src="${contextPath}/resources/uploadfile/recipe/recipefinal/${media.changeName}" alt=""  style="display: block;">
                                <input type="file" class="completeImages" id="" onchange="changecompleteImg(this)">
                            </div>
                        </div>
                    </c:forEach>

                    <c:forEach begin="${recipeInsertDTO.completeFoodPhoto.size()}" end="3" varStatus="status">
                        <div class="cfiBlock">    
                            <input type="button" class="btn-delete" value="x" onclick="deleteCPhoto(this)">
                            <div class="complete-food-img-block"  onclick="completeImg(this)">
                                <img class="completeImg" src="${contextPath}/resources/dummyImg/recipe/recipeWrite/camera.png" alt="">
                                <input type="hidden" name="completeFoodPhoto[${status.index}].originName" value="" >
                                <img class="completeImg-real" src="" alt="">
                                <input type="file" class="completeImages" id="" onchange="changecompleteImg(this)">
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

          
        </div>
    </form>

    <!-- 푸터 -->
    <jsp:include page="../common/footer.jsp" />
</body>
</html>