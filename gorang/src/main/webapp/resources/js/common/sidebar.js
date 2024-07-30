
function getPageType() {
    const pathname = window.location.pathname;
    if (pathname.includes('main.re')) {
        return 'main_recipe';
    } else if (pathname.includes('list.re')) {
        return 'list_recipe';
    } else if (pathname.includes('main.po')) {
        return 'main_product';
    } else if (pathname.includes('list.po')) {
        return 'list_product';
    } else if (pathname.includes('.re')) {
        return 'recipe';
    } else if (pathname.includes('.po')) {
        return 'product';
    }
    return null;
}


function setSidebarTitle(pageType) {
    if (pageType === 'recipe' || pageType === 'main_recipe' || pageType === 'list_recipe') {
        document.querySelector("#recently-seen-container > span").innerHTML = "최근 본 레시피";
    } else if (pageType === 'product' || pageType === 'main_product' || pageType === 'list_product') {
        document.querySelector("#recently-seen-container > span").innerHTML = "최근 본 상품";
    }
}


// 페이지 로드 시 실행되는 함수
function loadSideBar() {

    const ctx = getContextPath();

    function getContextPath() {
        return sessionStorage.getItem("contextpath");
    }

    // 페이지 유형 확인
    const pageType = getPageType();
    if (!pageType) {
        console.log("페이지 유형을 알 수 없습니다.");
        return;
    }

    // 사이드바 제목 설정
    setSidebarTitle(pageType);

    console.log("pageType = ",pageType);

     // main 페이지일 경우 최근 본 목록을 표시
    if (pageType === 'main_recipe' || pageType === 'list_recipe') {
  
        const isRecipe = true;
        let watched = getRecentlyWatched(isRecipe);
        console.log("최근 본 객체 목록:", watched);

        displayRecentlyWatchedItems(watched, ctx, isRecipe);
    } else if(pageType === 'main_product' || pageType === 'list_product'){

        const isRecipe = false;
        let watched = getRecentlyWatched(isRecipe);
        console.log("최근 본 객체 목록:", watched);
        displayRecentlyWatchedItems(watched, ctx, isRecipe);
    } else {
        // 상품 또는 레시피의 id값 가져오기
        let { num: itemId, isRecipe, thumbnailUrl } = getParameter(pageType);
           
        if (itemId === null) {
            let watched = getRecentlyWatched(isRecipe);
            console.log("최근 본 객체 목록:", watched);
            displayRecentlyWatchedItems(watched, ctx, isRecipe);
        } else {
            initRecentlyWatchedList(itemId, thumbnailUrl, ctx, isRecipe);
        }
    }

    $(function(){
        $('#recently-seen-list').slick({
            vertical: true, // 세로 방향 슬라이드 옵션
            slidesToShow: 3, // 한 화면에 보여질 컨텐츠 개수
            slidesToScroll: 1, //스크롤 한번에 움직일 컨텐츠 개수
            verticalSwiping: true,
            prevArrow: $('.slick-prev'),
            nextArrow: $('.slick-next'),
        });
    });
};

// 현재 페이지의 URL에서 쿼리 파라미터 값을 추출하는 함수
function getParameter(pageType) {
    let query = window.location.search;
    let param = new URLSearchParams(query);
    let num;
    let isRecipe;
    let thumbnailUrl;

    // 레시피 게시글일 때와 상품 게시글일 때를 구분하여 가져옴
    if(pageType === 'recipe') {
        num = param.get('recipeNo');
        isRecipe = true;
        thumbnailUrl = document.querySelector('#recipe-thumnail-food-img img').src;
    } else if(pageType === 'product') {
        num = param.get('pno');
        isRecipe = false;
        thumbnailUrl = document.querySelector('.product-thumbnail').src;
    }

    return { num, isRecipe, thumbnailUrl };
}

function clearOldItems(watched) {
    let now = new Date().getTime();
    const oneDay = 24 * 60 * 60 * 1000;
    return watched.filter(item => (now - item.timestamp) < oneDay);
}

// localStorage에서 최근 본 목록을 가져오는 함수
function getRecentlyWatched(isRecipe) {
    let key = isRecipe ? "recentlyWatchedRecipes" : "recentlyWatchedProducts";
    let watched = getFilteredWatched(key);

    return watched;
}

function getFilteredWatched(key) {
    let watched = localStorage.getItem(key);

    if (watched) {
        watched = JSON.parse(watched);
        watched = clearOldItems(watched);
        // localStorage.setItem(key, JSON.stringify(watched));
    } else {
        watched = [];
    }
    return watched;
}

// localStorage에 최근 본 목록을 저장하는 함수
function setRecentlyWatched(watched, isRecipe) {
    let key = isRecipe ? "recentlyWatchedRecipes" : "recentlyWatchedProducts";
    localStorage.setItem(key, JSON.stringify(watched));
}

// 최근 본 목록을 초기화하는 함수
function initRecentlyWatchedList(itemId, thumbnailUrl, ctx, isRecipe) {
    let maxCount = 5;
    // localStorage에서 최근 본 목록을 가져옴
    let watched = getRecentlyWatched(isRecipe);
    // 레시피를 조회한 타임스탬프
    let now = new Date().getTime();
    // 현재 페이지의 아이템 ID가 최근 본 목록에 이미 있는지 확인
    let index = watched.findIndex(item => item.id === itemId);
    // 최근 본 목록에서 현재 페이지의 아이템 ID가 발견되지 않았을 경우에만 추가
    if (index === -1) {
        // 최근 본 목록에 아이템 ID 추가
        watched.push({id: itemId, thumbnail: thumbnailUrl, timestamp: now});
        // 최근 본 목록이 최대 아이템 갯수보다 큰 경우, 가장 오래된 아이템 삭제
        if (watched.length > maxCount) {
            watched.shift(); // 배열의 첫 번째 요소 제거
        }
    }
    // 최근 본 목록을 localStorage에 다시 저장
    setRecentlyWatched(watched, isRecipe);
    // 최근 본 목록을 화면에 표시
    displayRecentlyWatchedItems(watched, ctx, isRecipe);
}

// 최근 본 목록을 화면에 표시하는 함수
function displayRecentlyWatchedItems(items, ctx, isRecipe) {

    let recentlySeenList = document.getElementById('recently-seen-list');
    recentlySeenList.innerHTML = ''; // 기존 내용을 비움

    // 최근 본 목록이 비어 있는 경우
    if (items.length === 0) {
        let sidebar = document.getElementById('sidebar');
        sidebar.innerHTML = ''; // sidebar의 내용을 비움
        return; // 함수 종료
    }

    items.forEach(item => {
        // 실제 상품 이미지와 링크를 가져오는 로직으로 대체해야 합니다
        // 예: item을 기반으로 AJAX 요청을 통해 상품 정보를 가져옴
        let listItem = document.createElement('div');
        let itemImg = document.createElement('img');

        itemImg.src = item.thumbnail;
        itemImg.style.cursor = "pointer";

        // 이미지 클릭 시 해당 썸네일의 상세 페이지로 이동
        itemImg.onclick = function(){
            if(isRecipe) {
                location.href = ctx + "/detailForm.re?recipeNo=" + item.id;
            } else {
                location.href = ctx + "/detail.po?pno=" + item.id;
            }
        }

        listItem.appendChild(itemImg);
        recentlySeenList.appendChild(listItem);
    });
}
