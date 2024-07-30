document.addEventListener("DOMContentLoaded", function () {
    setPaginationEventListeners("#pagination-area", getRefriInfoByAjax, 1);

    setMyRefrigerator();

    setRecipeModal();

    setIngreModal();
})

const ctp = sessionStorage.getItem("contextpath");

// ================================== 유틸리티, 공통  메소드 =======================

/** 페이지바 a 태그에 클릭 이벤트 넣어주는 메소드 */
function setPaginationEventListeners(selector, ajaxFunction, mid) {
    if(selector){
        const paginationArea = document.querySelector(selector);
        if(paginationArea){
            paginationArea.addEventListener("click", function (event) {
                if (event.target.tagName === 'A') { // 왜 대문자 A일까요?
                    const cpage = event.target.getAttribute('data-value');
                    if(mid){
                        ajaxFunction(parseInt(cpage), mid);
                    } else {
                        ajaxFunction(parseInt(cpage));
                    }
                }
            });
        }
    }
}

/** 페이지네이션 a 태그 생성해주는 메소드 */
function createPaginationLink(page, text) {
    const link = document.createElement('a');
    link.setAttribute('data-value', page);
    link.innerHTML = text;
    return link;
}

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
    switch(ev){
        case document.querySelector("#pagination-area"):
            setPaginationEventListeners("#pagination-area", getRefriInfoByAjax, 1);
            break;
        case document.querySelector("#ingre-modal-pagination"):
            setPaginationEventListeners("#ingre-modal-pagination", getFoodAndNutriAjax);
            break;
        case document.querySelector("#modal-recipe-pagination"):
            setPaginationEventListeners("#modal-recipe-pagination", getRefriInfoByAjax, 2);
}        
}

/** ajax 로 currentPage 보내서 RowBounds 된 List<refrigerator> 값 받아온 후 뿌려주는 메소드(나의냉장고테이블/추천레시피모달 공통)*/
function getRefriInfoByAjax(data, mid){
    $.ajax({
        url: "selectRefriAjax.me",
        data: { cpage: data },
        success: function(res){
            const refriIngresList = res.refriIngres;
            let paginationArea = "";

            if(mid == 1){ // 나의 냉장고 식재료 테이블 관련 요청일 경우
                const refriTbody = document.querySelector("#myRefrigerator-table-tbody");
                constructRefriTable(refriIngresList, refriTbody)
                paginationArea = document.querySelector("#pagination-area");
            } else if(mid == 2){  // 추천 레시피 모달 관련 요청일 경우
                const modalRecipeTbody = document.querySelector("#modal-recipe-tbody");
                constructModalRecipeTable(refriIngresList, modalRecipeTbody);
                paginationArea = document.querySelector("#modal-recipe-pagination");
            }

            // 페이지네이션 갱신
            updatePagination(paginationArea, res.pi);
        },
        error: function(){
            console.log("송신 실패");
        }
    })
}


// =================================== 나의 냉장고 식재료 테이블 관련 메소드 ================================
const refriMainTbody = document.querySelector("#myRefrigerator-table-tbody");
/** 나의 냉장고 관련 메소드 실행해주는 메소드 */
function setMyRefrigerator(){
    setPaginationEventListeners();

    refriAllCheck();

    document.querySelector("#refreDeleteBtn").addEventListener('click', refreDeleteOnClick);
}


/** 신선도 표시해주는 메소드 */
function getFreshnessStatus(daysDifference) {
    let status, color;
    if (daysDifference <= 3) {
        status = "위험";
        color = "#F20E2B";
    } else if (daysDifference > 3 && daysDifference <= 7) {
        status = "보통";
        color = "#FFE28A";
    } else {
        status = "신선";
        color = "#7ADC66";
    }
    return `<span>${status}</span><div class="flesh-status" style="background-color:${color};"></div>`;
}

/** 데이터를 받아서 나의 냉장고 식재료 테이블 구축해주는  메소드*/
function constructRefriTable(refriIngresList, refriTbody) {
    refriTbody.innerHTML = "";
    refriIngresList.forEach(refriIngre => {
        const refriTbodyTr = document.createElement('tr');
        refriTbodyTr.setAttribute("class", "tr-block");
        refriTbody.appendChild(refriTbodyTr);

        refriTbodyTr.innerHTML = `
            <td class="myRefrigerator-tr">
                <img src="${ctp}/resources/images/myRefrigeratorKind/${refriIngre.refKind}.png">
            </td>
            <td class="refri-main-td-refName" data-value="${refriIngre.refNo}">${refriIngre.refName}</td>
            <td class="flesh-area">${getFreshnessStatus(refriIngre.daysDifference)}</td>
            <td>${refriIngre.refConsumptionDate}</td>
            <td>${refriIngre.refInputDate}</td>
            <td>${refriIngre.refCount}</td>
            <td><input type="checkbox" class="refri-main-delete-checkBox"></td>
        `;
    });
    refriAllCheck();
}

/** th 체크 버튼 클릭 시 모든 td 체크되는 이벤트 */
function refriAllCheck(){
    const refriMainAllCheckBox = document.querySelector("#refri-main-delete-allCheckBox");
    if(refriMainAllCheckBox){
        refriMainAllCheckBox.addEventListener('change', function(){
            refriMainTbody.querySelectorAll(".tr-block").forEach(tr => {
                let checkBox = tr.querySelector("td input[type='checkbox']");
                checkBox.checked = refriMainAllCheckBox.checked;
            })
        })
    }
}

/** 삭제하기 버튼 클릭 시 ajax 통해 db에서 식재료 삭제하는 메소드*/
function refreDeleteOnClick(){
    // 삭제할 식재료 데이터 담을 배열 선언
    // Array.prototype.filter() 은  얕은 복사본을 생성하고, 주어진 배열에서 제공된 함수에 의해 구현된 테스트를 통과한 요소로만 필터링
    // Array.prototype.map() 은 배열 내의 모든 요소 각각에 대하여 주어진 함수를 호출한 결과를 모아 새로운 배열을 반환
    const ingresFordelete = Array.from(document.querySelectorAll(".refri-main-delete-checkBox"))
    .filter(checkbox => checkbox.checked)
    .map(checkbox => parseInt(checkbox.closest("tr").querySelector(".refri-main-td-refName").getAttribute("data-value")));

    $.ajax({
        url: "deleteRefriIngre.me",
        data: {refriNums: JSON.stringify(ingresFordelete)},
        success: function(res){
            console.log("송신 성공");
            if(res === "success"){
                location.reload();
            }
        },
        error: function(){
            console.log("송신 실패");
        }
    })
}
    
// =================================== 식재료 추가 모달 관련 메소드 ==========================================

// 모달 요소
const modalIngre = document.querySelector("#myModal-two");
// 테이블 tbody
const ingreModalTbody = document.querySelector("#modal-ingre-tbody");

/** 식재료 추가 모달 구축해주는 메소드 */
function setIngreModal(){
    document.querySelector("#viewModalBtn-two").addEventListener("click",viewModal2);
    // 식재료 추가 모달 검색 버튼 클릭 시 이벤트 
    document.querySelector("#find-nutri-btn").addEventListener("click", findSearch2);
    // 이벤트 위임을 사용하여 동적으로 생성된 요소에도 이벤트 리스너를 적용
    document.querySelector("#modal-ingre-tbody").addEventListener("change", handleCheckboxChange);
     // 모두 체크
    document.querySelector("#modal-ingre-checkBox").addEventListener('change', handleModalAllCheckboxChange );
     // 식재료 추가 모달 내 추가하기 버튼 클릭 시 데이터 송신하는 이벤트
    document.querySelector("#addAll-btn2").addEventListener("click", sendIngreByAjax);
    // 유저가 직접 입력
    document.querySelector("#input-nutri-btn").addEventListener('click', addUserInputToModalTable);
    // 페이지네이션 이벤트 추가
    setPaginationEventListeners("#ingre-modal-pagination", getFoodAndNutriAjax);
    // 닫기 버튼
    document.querySelector("#closeModalBtn2").addEventListener('click', closeModal2);
};

/** 이벤트 위임을 사용하여 동적으로 생성된 요소에도 이벤트 리스너를 적용 */
function handleCheckboxChange(event){
    if (event.target.type === 'checkbox') {
        const checkbox = event.target;
        const tr = checkbox.closest("tr");
        const display = checkbox.checked ? 'inline' : 'none';
        tr.querySelectorAll('.direct-input').forEach(el => el.style.display = display);
    }
}

/** 모두체크  */
function handleModalAllCheckboxChange(){
    const allChecked = this.checked;
    document.querySelectorAll(".overflow-tr").forEach( tr => {
        let checkbox = tr.querySelector("input[type='checkbox']");
        checkbox.checked = allChecked;
        const display = allChecked ? 'inline' : 'none';
        tr.querySelectorAll(".direct-input").forEach(el => el.style.display = display);
     })
 }

// 식재료 추가하기 모달창 표시 / 숨김
function viewModal2() {
    modalIngre.style.display = "block";
}

function closeModal2() {
    modalIngre.style.display = "none";
    ingreModalTbody.innerHTML = "";
}

// 모달 식재료 추가 검색창
function findSearch2() {
    getFoodAndNutriAjax(1);
}

function addUserInputToModalTable(){
    // 직접 입력 시 번호 부여하기 위한 변수
    const numForInput = document.querySelectorAll(".overflow-tr").length + 1;
    const foodNameByUser = modalIngre.querySelector("#refri-input-foodName-user").value;
    const foodSelectBox = modalIngre.querySelector("#refri-select-foodClassification");
    const foodClassNum = foodSelectBox.options[foodSelectBox.selectedIndex].value;
    const foodClassNameByUser = foodSelectBox.options[foodSelectBox.selectedIndex].innerHTML;

    const food = {
        FOOD_NM_KR: foodNameByUser,
        FOOD_CAT1_CD: foodClassNum,
        FOOD_CAT1_NM: foodClassNameByUser
    };
    constructIngreModalTable(ingreModalTbody, numForInput, food);
    // 초기화
    modalIngre.querySelector("#refri-input-foodName-user").value = '';
    modalIngre.querySelector("#refri-select-foodClassification").selectedIndex = 0;
}

// 공공데이터 가져오는 ajax
function getFoodAndNutriAjax(cpage) {
    // 공백제거
    const foodNameVl = document.querySelector("#refri-input-foodName").value.replace(/\s+/g, '');;
    const makerVl = document.querySelector("#refri-input-maker").value.replace(/\s+/g, '');;

    $.ajax({
        url: "food.me",
        data: {
            foodName: foodNameVl,
            makerName: makerVl,
            cpage: cpage
        },
        success: function (res) {
            // 가져온 식품 데이터 가공
            let foodArr = res.body.items;

            foodArr = foodArr.map(f => {
                let food = {}
                for (let key in f) {
                    food[key.trim()] = f[key];
                }
                return food;
            })
            let currentPage = res.body.pageNo;

            drawFoodAndNutri(currentPage, foodArr);
            
            // 페이지 처리 위한 pi 변수 생성
            let listCount = res.body.totalCount;
            

            let boardLimit = 10;
            let pageLimit = 10;
            let maxPage = Math.ceil(listCount / boardLimit); // 총 페이지 수
            let startPage = Math.floor((currentPage -1) / pageLimit) * pageLimit + 1; // 페이징바의 시작 
            let endPage = startPage + pageLimit -1; // 페이징 바의 끝 수
            endPage = endPage > maxPage ? maxPage : endPage;

            let pi = {
                listCount: listCount,
                currentPage: currentPage,
                pageLimit: pageLimit,
                boardLimit: boardLimit,
                maxPage: maxPage,
                startPage: startPage,
                endPage: endPage
            }

            // 페이지바 요소를 담은 상위 요소 호출
            const ingreModalPagination = document.querySelector("#ingre-modal-pagination");
            updatePagination(ingreModalPagination, pi);


        },
        error: function () {
            console.log("송신 실패");
        }
    })
}

/**getFoodAndNutriAjax 로 받아온 데이터를 모달에 뿌려주는 메소드 */ 
function drawFoodAndNutri(currentPage, foodArr) {
    ingreModalTbody.innerHTML = "";

    let temp = 1;

    for (let food of foodArr) {
        let num = ((currentPage - 1) * 10) + temp;
        constructIngreModalTable(ingreModalTbody, num, food);
        temp++;
    }
}

/** 식재료 추가 모달의 테이블 만들어주는 메소드 */
function constructIngreModalTable(ingreModalTbody, num, food) {
    const nutri = {
        servingSize: food.SERVING_SIZE,
        kcal: food.AMT_NUM1,
        protein: food.AMT_NUM3,
        fat: food.AMT_NUM4,
        saluratedFat: food.AMT_NUM23,
        transFat: food.AMT_NUM24,
        carb: food.AMT_NUM6,
        sugar: food.AMT_NUM7,
        sodium: food.AMT_NUM13,
        cholesterol: food.AMT_NUM22
    };

    const foodTabletr = document.createElement('tr');
    foodTabletr.setAttribute("class", "overflow-tr");
    ingreModalTbody.appendChild(foodTabletr);
    // 체크박스
    const foodTableTdCk = document.createElement('td');
    foodTableTdCk.setAttribute("class", "td-checkbox");
    foodTabletr.appendChild(foodTableTdCk);

    const foodTableTdCkInput = document.createElement('input');
    foodTableTdCk.appendChild(foodTableTdCkInput);
    foodTableTdCkInput.setAttribute("class", "row-checkbox");
    foodTableTdCkInput.setAttribute("type", "checkbox");
    // 번호
    const foodTableTd1 = document.createElement('td');
    foodTableTd1.setAttribute("class", "fixed-width1");
    foodTableTd1.innerHTML = num;
    foodTabletr.appendChild(foodTableTd1);
    // 식품명
    const foodTableTd2 = document.createElement('td');
    foodTableTd2.setAttribute("class", "fixed-width2");
    foodTableTd2.innerHTML = food.FOOD_NM_KR;
    foodTabletr.appendChild(foodTableTd2);
    // 대분류
    const foodTd5 = document.createElement('td');
    foodTabletr.appendChild(foodTd5);
    foodTd5.setAttribute("class", "fixed-width5");
    foodTd5.setAttribute("data-value", parseInt(food.FOOD_CAT1_CD));
    foodTd5.innerHTML = food.FOOD_CAT1_NM;
    // 영양성분
    const foodTableTd3 = document.createElement('td');
    foodTableTd3.setAttribute("class", "fixed-width3");
    foodTabletr.appendChild(foodTableTd3);

    const nutriBtn = document.createElement('button');
    foodTableTd3.appendChild(nutriBtn);
    nutriBtn.setAttribute("class", "seek-ingre-btn");
    nutriBtn.setAttribute("data-toggle", "modal");
    nutriBtn.setAttribute("data-target", "#nutritionModal");
    nutriBtn.innerHTML = "보기";
    // 소비기한
    const foodTableTd4 = document.createElement('td');
    foodTableTd4.setAttribute("class", "fixed-width4");
    foodTableTd4.setAttribute("style", "text-align: left; font-size: 12px");
    foodTabletr.appendChild(foodTableTd4);

    const foodTd4Input = document.createElement('input');
    foodTableTd4.appendChild(foodTd4Input);
    foodTd4Input.setAttribute("class", "direct-input");
    foodTd4Input.setAttribute("type", "text");
    foodTd4Input.setAttribute("name", "refConsumptionDate");
    foodTd4Input.setAttribute("placeholder", "입력: 예시) 20240611");
    foodTd4Input.setAttribute("style", "display: none;");

    // 입고일
    const foodTableTd5 = document.createElement('td');
    foodTableTd5.setAttribute("class", "fixed-width4");
    foodTableTd5.setAttribute("style", "text-align: left; font-size: 12px");
    foodTabletr.appendChild(foodTableTd5);

    const foodTd5Input = document.createElement('input');
    foodTableTd5.appendChild(foodTd5Input);
    foodTd5Input.setAttribute("class", "direct-input");
    foodTd5Input.setAttribute("type", "text");
    foodTd5Input.setAttribute("name", "refInputDate");
    foodTd5Input.setAttribute("placeholder", "입력: 예시) 20240611");
    foodTd5Input.setAttribute("style", "display: none;");

    // 갯수
    const foodTableTd6 = document.createElement('td');
    foodTableTd6.setAttribute("class", "fixed-width4");
    foodTableTd6.setAttribute("style", "text-align: left; font-size: 12px");
    foodTabletr.appendChild(foodTableTd6);

    const foodTd6Input = document.createElement('input');
    foodTableTd6.appendChild(foodTd6Input);
    foodTd6Input.setAttribute("class", "direct-input");
    foodTd6Input.setAttribute("type", "text");
    foodTd6Input.setAttribute("name", "refCount");
    foodTd6Input.setAttribute("placeholder", "입력: 예시) 3");
    foodTd6Input.setAttribute("style", "display: none;");

    nutriBtn.addEventListener("click", constructNutriModal(nutri));
}

/** 식재료 추가 모달 내 영양성분 보기 클릭 시 영양성분표 모달 만들어주는 메소드 */
//1일 영양성분 기준치 국가법령정보센터 제6조 제2항 및 제3항 관련 식품 등의 표시, 광고에 관한 시행규칙 참고
function constructNutriModal(nutri) {
    const nutriTable = document.querySelector(".nutrition-table");
    if (nutriTable) {
        nutriTable.innerHTML = `
        <thead>
            <tr>
                <th colspan="3" style="text-align: left">영양성분함량기준량 ${nutri.servingSize}</th>
            </tr>
            <tr>
                <th>성분명</th>
                <th>내용</th>
                <th style="font-size: 10px">1일 영양성분 기준치에 대한 비율</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>열량</td>
                <td>${nutri.kcal}Kcal</td>
                <td>${Math.ceil((nutri.kcal / 2000) * 100)}%</td>
            </tr>
                <tr>
                <td>나트륨</td>
                <td>${nutri.sodium}mg</td>
                <td>${Math.ceil((nutri.sodium / 2000) * 100)}%</td>
            </tr>
            <tr>
                <td>탄수화물</td>
                <td>${nutri.carb}g</td>
                <td>${Math.ceil((nutri.carb / 324) * 100)}%</td>
            </tr>
            <tr>
                <td>당류</td>
                <td>${nutri.sugar}g</td>
                <td>${Math.ceil((nutri.sugar / 100) * 100)}%</td>
            </tr>
            <tr>
                <td>지방</td>
                <td>${nutri.fat}g</td>
                <td>${Math.ceil((nutri.fat / 54) * 100)}%</td>
            </tr>
            <tr>
                <td>트랜스지방</td>
                <td>${nutri.transFat}g</td>
                <td></td>
            </tr>
            <tr>
                <td>포화지방</td>
                <td>${nutri.saluratedFat}g</td>
                <td>${Math.ceil((nutri.saluratedFat / 15) * 100)}%</td>
            </tr>
            <tr>
                <td>콜레스테롤</td>
                <td>${nutri.cholesterol}mg</td>
                <td>${Math.ceil((nutri.saluratedFat / 15) * 100)}%</td>
            </tr>
            <tr>
                <td>단백질</td>
                <td>${nutri.protein}g</td>
                <td>${Math.ceil((nutri.protein / 55) * 100)}%</td>
            </tr>
        </tbody>
        `;
    }
}

/** 냉장고 db에 식재료 저장하기 위해 컨트롤러로 보내는 ajax */
function sendIngreByAjax() {
    const ingreData = Array.from(document.querySelectorAll("#modal-ingre-tbody .overflow-tr input[type='checkbox']"))
                      .filter(checkbox => checkbox.checked)
                      .map(checkbox => {
                        const modalIngrediTr = checkbox.closest('tr');

                        let today = new Date();

                        // 두 자리 숫자로 변환하는 함수
                        function padToTwoDigits(num) {
                            return num.toString().padStart(2, '0');
                            // padStart(targetLength, padString) 은 문자열의 길이가 targetLength 보다 짧을 시 문자열의 시작 부분에 지정된 padString 추가함
                        }
            
                        // 식품명
                        const refNameOrigin = modalIngrediTr.querySelector(".fixed-width2").innerHTML;
                        // '_'이후의 문자열만 추출
                        const refName = refNameOrigin.substring(refNameOrigin.indexOf('_')+1);

                        //대분류코드
                        let refKindNo = modalIngrediTr.querySelector(".fixed-width5").getAttribute("data-value");
            
                        // 소비기한
                        let refConsumptionDate = modalIngrediTr.querySelector("input[name='refConsumptionDate']").value;
                                    
                        // 소비기한 미입력 시 현재 날짜에 7일을 더 해줌
                        let refConsumptionDateFormat;
                        if (!refConsumptionDate) {
                            today.setDate(today.getDate() + 7);
                            // getMonth() 는 0부터 11 반환
                            refConsumptionDateFormat = today.getFullYear() + "-" + padToTwoDigits(today.getMonth()+1) + "-" + padToTwoDigits(today.getDate());
                            today = new Date(); // reset today
                        } else if(validateDate(refConsumptionDate)) refConsumptionDateFormat = dateFormatting(refConsumptionDate);
                    

            
                        // 냉장고 입고일
                        let refInputDate = modalIngrediTr.querySelector("input[name='refInputDate']").value;
            
                        // 냉장고 입고일 미기입 시 현재 날짜로 넣어줌
                        let refInputDateFormat;
                        if (!refInputDate) {
                            refInputDateFormat = today.getFullYear() + "-" + padToTwoDigits(today.getMonth() + 1) + "-" + padToTwoDigits(today.getDate());
                        } else if(validateDate(refInputDate)) refInputDateFormat = dateFormatting(refInputDate);
            
                        // 갯수
                        let refCount = modalIngrediTr.querySelector("input[name='refCount']").value;
                        if (!refCount) {
                            refCount = 1;
                        }
            
                        return {
                            refName: refName,
                            refKind: refKindNo,
                            refConsumptionDate: refConsumptionDateFormat,
                            refInputDate: refInputDateFormat,
                            refCount: refCount
                        }
                      });

    if (ingreData.length === 0) {
        alert("추가할 재료를 선택해주세요");
        return;
    }

    // db 에 저장하는 ajax
    $.ajax({
        url: "insertRefri.me",
        method: "POST",
        data: JSON.stringify(ingreData),
        contentType: "application/json; charset=UTF-8",
        success: function (res) {
            console.log("송신 성공: ", res);
            window.location.reload();
        },
        error: function (xhr, status, error) {
            console.error("송신 실패 - 상태 코드: " + xhr.status + ", 상태: " + status + ", 에러 메시지: " + error);
        }
    });
}

// 소비기한 입력 시 올바른 날짜인지 체크하는 함수
function validateDate(date){
// 8자리인지 체크
if(date.length !== 8){
    alert("연월일은 8자리의 숫자만 입력해주세요")
    return false;
}
let yyyy = date.substring(0,4);
let mm = date.substring(4,6);
let dd = date.substring(6,8);
// mm = Number(mm) - 1; // month index 0부터 시작하기에

if(mm < 1 || mm > 12){
    alert("존재하지 않는 달을 입력하셨습니다. 다시 확인해주세요");
    return false;
}

if(dd < 1 || dd > 31){
    alert("존재하지 않는 일자를 입력했습니다. 다시 확인해주세요");
    return false;
}

if((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd == 31){
    alert("존재하지 않은 일자를 입력했습니다. 다시 확인해주세요");
    return false;
}

if(mm == 2){
    let isLeapYear = (yyyy % 4 == 0 && (yyyy % 100 != 0 || yyyy % 400 == 0));
    if(dd > 29 || (dd == 29 && !isLeapYear)){
        alert("존재하지 않은 일자를 입력했습니다. 다시 확인해주세요.")
        return false
    }
}

return true;
}

// yyyy-mm-dd 형식으로 만들어주는 함수
function dateFormatting(date){
    let yyyy = date.substring(0,4);
    let mm = date.substring(4,6);
    let dd = date.substring(6,8);
    
    // 직접 입력시에는 개월 수에 1을 더할 필요가 없음
    return yyyy + "-" + mm + "-" + dd;
}

// =============================================== 추천 레시피 찾기 관련 메소드 ================================================
// 레시피 찾기 모달 div 요소
const recipeModal = document.querySelector("#myModal");

// 식재료 추가시 #modal-recipe-selectedIngre 에 저장하기 위한 배열 생성
let tempForModalRecipeselectedIngre = [];

function setRecipeModal(){
    constructRecommendedRecipeDiv();
     // 모달 띄우는 이벤트  
     document.querySelector("#viewModalBtn").addEventListener('click', viewRecipeRecommendModal);
     // 모달 숨기는 이벤트
     document.getElementById("closeModalBtn").addEventListener("click", hideRecipeRecommendModal);
      // 레시피 찾기 모달 모두 체크 버튼 이벤트
     document.querySelector("#modal-recipe-allCheckBox").addEventListener('change', handlerrecipeModalAllCheckChange);
     // 페이지네이션 이벤트
     setPaginationEventListeners("#modal-recipe-pagination", getRefriInfoByAjax, 2);
    // 추천받을 레시피를 고를 식재료 넣는 이벤트
     recipeModal.querySelector("#completeModalBtn").addEventListener('click', handlerrecipeCompleteBtnClick);
     // 추천 레시피 찾는 이벤트
     recipeModal.querySelector("#findOutRecipeBtn").addEventListener('click', getRecipeByIngre);
} 

/**추가하기 버튼 클릭 시 선택한 항목들을 위에 뿌리기 */
function handlerrecipeCompleteBtnClick(){
    tempForModalRecipeselectedIngre = Array.from(recipeModal.querySelectorAll(".modal-recipe-tbody-tr input[type='checkbox']"))
                                  .filter(checkbox  => checkbox.checked)
                                  .map(checkbox => {
                                    const tr = checkbox.closest("tr");
                                    return  tr.querySelector(".modal-recipe-refName").innerHTML;
                                  });

    if(tempForModalRecipeselectedIngre.length > 0){
        setSelectedIngreDiv(tempForModalRecipeselectedIngre);
    }
 }

/** 추가한 식재료명 옆 삭제 버튼 클릭 시 삭제시켜주는 함수 */
function handlerIbtnClick(ev){
    let btn = ev.target;
    // 선택한 식재료 삭제
    let ingre = btn.closest('.modal-recipe-ingre').querySelector(".modal-recipe-ingre-name").innerHTML;
    tempForModalRecipeselectedIngre = tempForModalRecipeselectedIngre.filter(e => e !== ingre);
    setSelectedIngreDiv(tempForModalRecipeselectedIngre);
}

/** 선택한 식재료 칸 새로 구축해주는 함수 */
function setSelectedIngreDiv(tempForModalRecipeselectedIngre) {
    const selectedIngreContainer = recipeModal.querySelector("#modal-recipe-selectedIngre");

    for (let ingre of tempForModalRecipeselectedIngre) {
        // 동일한 식재료가 이미 있는지 확인
        const exists = Array.from(selectedIngreContainer.querySelectorAll('.modal-recipe-ingre-name'))
            .some(span => span.textContent === ingre);
        // Array.prototype.some() 메서드는 배열 내 요소 중 적어도 하나의 주어진 조건을 만족할 경우 true 반환

        // 동일한 식재료가 있으면 건너뜀
        if (exists) continue;

        // 새로운 식재료 추가
        const div = document.createElement('div');
        div.className = 'modal-recipe-ingre';
        div.innerHTML = `<span class="modal-recipe-ingre-name">${ingre}</span><i class="fa-solid fa-delete-left"></i>|`;
        selectedIngreContainer.appendChild(div);
    }

    // 새로 추가된 삭제 버튼에 이벤트 리스너를 추가
    selectedIngreContainer.querySelectorAll('i').forEach(ibtn => {
        ibtn.addEventListener('click', handlerIbtnClick);
    });
}


/** 추천 레시피 모달창 구축하고 띄우는 메소드 */
function viewRecipeRecommendModal(){
    getRefriInfoByAjax(1, 2);
    recipeModal.style.display = "block";
 }

/** 추천 레시피 숨김 메소드 */
 function hideRecipeRecommendModal(){
    recipeModal.style.display = "none";
    tempForModalRecipeselectedIngre = []; // 배열 초기화
    recipeModal.querySelector("#modal-recipe-selectedIngre").innerHTML = tempForModalRecipeselectedIngre;
 }

/** 추천 레시피 모달 모두 체크 메소드 */
function handlerrecipeModalAllCheckChange(){
    const allChecked = this.checked;
    recipeModal.querySelectorAll(".modal-recipe-tbody-tr").forEach(tr => {
        let checkbox = tr.querySelector("td input[type='checkbox']");
        checkbox.checked = allChecked;
    });
 }

/** ajax 데이터 받아서 레시피 모달 구축하는 메소드 */
function constructModalRecipeTable(refriIngresList, modalRecipeTbody){
    modalRecipeTbody.innerHTML = "";
    for( let refriIngre of refriIngresList ){
        //tr 생성
        let recipeTbodyTr = document.createElement('tr');
        modalRecipeTbody.appendChild(recipeTbodyTr);
        recipeTbodyTr.setAttribute("class", "modal-recipe-tbody-tr");
        // 체크박스
        const recipeTableTdCk = document.createElement('td');
        recipeTableTdCk.setAttribute("class", "modal-recipe-td-checkBox");
        recipeTbodyTr.appendChild(recipeTableTdCk);
        const recipeCheckBox = document.createElement('input');
        recipeCheckBox.setAttribute("type", "checkbox");
        recipeTableTdCk.appendChild(recipeCheckBox);
        // 식재료명 td
        const recipeTbodyTd1 = document.createElement('td');
        recipeTbodyTd1.setAttribute("class", "modal-recipe-refName");
        recipeTbodyTd1.innerHTML = refriIngre.refName;
        recipeTbodyTr.appendChild(recipeTbodyTd1);
        // 소비기한 td
        const recipeTbodyTd2 = document.createElement('td');
        recipeTbodyTd2.innerHTML = refriIngre.refConsumptionDate;
        recipeTbodyTr.appendChild(recipeTbodyTd2);
        // 입고일 td
        const refriIngreTd3 = document.createElement('td');
        refriIngreTd3.innerHTML = refriIngre.refInputDate;
        recipeTbodyTr.appendChild(refriIngreTd3);
    }
}

/** 레시피 찾기 버튼 클릭 시 ajax 로 식재료 보내서 레시피 데이터 받는 메소드 */
function getRecipeByIngre(){
    const selectedIngreList = Array.from(recipeModal.querySelectorAll(".modal-recipe-ingre-name"))
                                    .map(name => {return name.innerHTML});
    
    // 식재료 추가 안했을 경우 예외처리
    if(selectedIngreList < 1){
        alert("추가할 식재료를 체크해주세요.")
        return;
    }
    $.ajax({
        url: "selectRecipeListByRefri.me",
        data: {ingreList: JSON.stringify(selectedIngreList)},
        contentType: "application/json; charset-utf-8",
        success: function(res){
            console.log("송신 성공");
            saveRecipeNoInLocalStorage(res);
                   
            location.reload();
        },
        error: function(){
            console.log("송신 실패");
        }
    });
}

/** localStorage에서 최근 본 목록을 가져오는 함수 */ 
function getRecommendedRecipeList(key) {
    let recipeList = localStorage.getItem(key);

    // 최근 본 목록이 없는 경우, 빈 배열로 초기화
    return recipeList ? JSON.parse(recipeList) : [];
}

/** 받아 온 레시피들을 로컬 스토리지에 저장하는 메소드 */
function saveRecipeNoInLocalStorage(recipes){
    // 로컬스토리지의 키값
    let key = "recommendedRecipe";
    // 로컬 스토리지 불러오기(필터링됨)
    let localRecipeNoList = getFilteredLocalRecipeList(key);

    // localRecipeNoList가 배열인지 확인
    if (!Array.isArray(localRecipeNoList)) {
        localRecipeNoList = [];
    }

    // 해당 키에 저장할 최대 데이터 갯수
    let maxCount = 10;

    // 저장한 일시 타임스탬프
    let now = new Date().getTime();

    // 받아온 추천 레시피 반복문 돌리기
    for(let recipe of recipes){
        // 로컬 스토리지에 저장 전에 이미 존재하는 데이터인지 여부 체크
        let index = localRecipeNoList.indexOf(item => item.recipeNo === recipe.recipeNo);
        // 없다면 리스트에 넣기
        if(index === -1){
            localRecipeNoList.push({recipeNo: recipe.recipeNo, timestamp: now});
            // 10개가 넘어가면 가장 앞의 데이터 삭제
            if(localRecipeNoList.length > maxCount){
                localRecipeNoList.shift();
            }
        }
    }
     // 로컬 스토리지에 저장
     localStorage.setItem(key, JSON.stringify(localRecipeNoList));
}

function clearOldItems(localRecipeNoList){
    let now = new Date().getTime();
    const oneDay = 24 * 60 * 60 * 1000;

    return localRecipeNoList.filter(item => (now - item.timestamp) < oneDay);
}

/** 로컬스토리지 내 레시피 필터링해서 가져오는 메소드 */
function getFilteredLocalRecipeList(key){
    let localRecipeNoList = localStorage.getItem(key);

    if(localRecipeNoList){
        localRecipeNoList = JSON.parse(localRecipeNoList);
        localRecipeNoList = clearOldItems(localRecipeNoList);
    } else {
        localRecipeNoList = [];
    }
    return localRecipeNoList;
}

/** 로컬 스토리지에 저장된 추천 레시피 no 들로  div 요소 채우는 메소드 */
function constructRecommendedRecipeDiv(){
    let localRecipeNoList = getFilteredLocalRecipeList("recommendedRecipe");
    if(localRecipeNoList.length > 0){
        const recipeNums = localRecipeNoList.map(recipe => {return recipe.recipeNo})
        $.ajax({
            url: "selectRecipeListByRecipeNo.me",
            type: "post",
            data: {recipeNums: JSON.stringify(recipeNums)},
            success: function(res){
                // 추천 레시피 div
                const recommendRecipeDiv = document.querySelector("#recommend-recipe-imgs");
                recommendRecipeDiv.innerHTML = "";
                if(res.length > 0){
                    for(let recipe of res){
        
                        const divForRecoRecipe = document.createElement('div');
                        recommendRecipeDiv.appendChild(divForRecoRecipe);
            
                        const recoRecipe = document.createElement('img');
                        recoRecipe.src = ctp + "/resources/uploadfile/recipe/recipemain/" + recipe.recipeImg
                        recoRecipe.setAttribute("style", "width: 295px; height: 240px; cursor: pointer");
                        divForRecoRecipe.appendChild(recoRecipe);
                        
                        // 이미지 클릭 시 해당하는 url 로 넘어갈 수 있도록 클릭 이벤트 추가
                        recoRecipe.addEventListener('click', function(){
                            location.href = ctp + "/detailForm.re?recipeNo=" + recipe.recipeNo;
                        })
                    };
                };
                $(function(){
                    $('#recommend-recipe-imgs').slick({
                        slick: 'img',
                        infinite: false,
                        slidesToShow: 3,
                        slidesToScroll: 1,
                        arrows : true, 
                        prevArrow : "<button type='button' class='slick-prev'>Previous</button>",
                        nextArrow : "<button type='button' class='slick-next'>Next</button>"
                      });
                })
            },
            error: function(){
                console.log("송신 실패");
            }
        });
    }

}



// // 엔터로 쳐도 검색가능
// function handleKeyPress(ev) {
//     if (ev.key === 'Enter') {
//         findSearch();
//     }
// }

// // 엔터로 쳐도 검색가능
// function handleKeyPress2(ev) {
//     if (ev.key === 'Enter') {
//         findSearch2();
//     }
// }
