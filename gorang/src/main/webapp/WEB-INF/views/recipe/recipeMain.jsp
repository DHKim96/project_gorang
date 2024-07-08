<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
	<!-- Latest compiled and minified CSS -->
	<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"> -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recipe/recipeMain.css">



</head>
<body onload="loadSideBar()">
	<jsp:include page="../common/header.jsp" />
	
	<main id="recipe-main">
		<!-- 사이드바 -->
		<jsp:include page="../common/sidebar.jsp" />
		
		<div id="recipe-main-contents">
			<div id="recommend-box">
				<div class="recipe-main-box-title">
					<span>오늘은 이 메뉴 어떠세요?</span>
				</div>
				<div id="recommend-box-recipe">
					<div id="recommend-box-recipe-thumbnail" data-type="recipe" data-no="1" onclick="moveDetailPage(this)">
						<img src="${pageContext.request.contextPath}/resources/uploadfile/recipe/recipemain/recipeBoardImg(1).jpg" alt="">
					</div>
					<div id="recommend-box-textbox">
						<span>솔티드 딸바 크레페</span>
						<span>크레이프 케이크에 환상적인 카라멜과의 조합으로 달콤한 디저트 시간을 보내요!</span>
					</div>
				</div>
			</div>
			<div id="recipe-main-new">
				<div class="recipe-main-box-title">
					<span>새로운 레시피들이에요</span>
					<span onclick="goRecipeList()">더보기</span>
				</div>
				<div class="recipe-main-listBox">
					<div class="recipe-main-listBox-grid" >
						<div class="recipe-img-div" data-type="recipe" data-no="2" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/recipe/recipemain/recipeBoardImg(2).jpg" alt="">
						</div>
						<div class="recipe-main-listBox-grid-textBox">
							<span>통삼겹살과 차슈요리양념이면 충분해요</span>
							<span>차슈덮밥</span>
						</div>
					</div>
					<div class="recipe-main-listBox-grid" >
						<div class="recipe-img-div" data-type="recipe" data-no="3" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/recipe/recipemain/recipeBoardImg(3).jpg" alt="">
						</div>
						<div class="recipe-main-listBox-grid-textBox">
							<span>밥도둑 생선 조림 레시피를 소개합니다.</span>
							<span>창녕갈릭 삼치 조림</span>
						</div>
					</div>
					<div class="recipe-main-listBox-grid" >
						<div class="recipe-img-div" data-type="recipe" data-no="4" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/recipe/recipemain/recipeBoardImg(4).jpg" alt="">
						</div>
						<div class="recipe-main-listBox-grid-textBox">
							<span>돈까스를 넣고 잘 말아준 인기만점 김밥!</span>
							<span>돈까스 김밥</span>
						</div>
					</div>
					<div class="recipe-main-listBox-grid" >
						<div class="recipe-img-div" data-type="recipe" data-no="5" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/recipe/recipemain/recipeBoardImg(5).jpg" alt="">
						</div>
						<div class="recipe-main-listBox-grid-textBox">
							<span>국물 자작하게 졸여 즐기는 짜글이의 매력!</span>
							<span>감자 짜글이</span>
						</div>
					</div>
				</div>

			</div>
			<div id="recipe-main-shopping">
				<div class="recipe-main-box-title">
					<span>재료가 모자라지 않으신가요?</span>
					<span onclick="goShoppingList()">더보기</span>
				</div>
				<div id="recipe-main-shopping-list">
					<div class="recipe-main-shopping-list-product"  >
						<div class="recipe-main-product" data-type="product" data-no="39" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/product/productimg/육류2.jpg" alt="">
						</div>
						<div class="recipe-main-shopping-list-product-textBox">
							<div class="recipe-main-shopping-list-product-textBox-title">
								<span>Kims Butcher</span>
								<span>[Kims Butcher] 돌돌말이 대패 삼겹살 1kg(냉동)</span>
							</div>
							<div class="recipe-main-shopping-list-product-textBox-price">
								<span> <del>16,900원</del> </span>
								<div class="recipe-main-shopping-list-product-textBox-price-box">
									<div class="recipe-main-shopping-list-product-textBox-price-box-discount">
										<span class="recipe-main-discount">24%</span>
										<span>12,900원</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="recipe-main-shopping-list-product" >
						<div class="recipe-main-product" data-type="product" data-no="3" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/product/productimg/과일2.jpg" alt="">
						</div>
						<div class="recipe-main-shopping-list-product-textBox">
							<div class="recipe-main-shopping-list-product-textBox-title">
								<span>제스프리</span>
								<span>[제스프리] 뉴질랜드 골드키위 1.1kg (8~10입) (후숙필요)</span>
							</div>
							<div class="recipe-main-shopping-list-product-textBox-price">
								<span> <del>14,900원</del> </span>
								<div class="recipe-main-shopping-list-product-textBox-price-box">
									<div class="recipe-main-shopping-list-product-textBox-price-box-discount">
										<span class="recipe-main-discount">10%</span>
										<span>13,410원</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="recipe-main-shopping-list-product" >
						<div class="recipe-main-product" data-type="product" data-no="78" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/product/productimg/면4.jpg" alt="">
						</div>
						<div class="recipe-main-shopping-list-product-textBox">
							<div class="recipe-main-shopping-list-product-textBox-title">
								<span>테이블마크</span>
								<span>[테이블마크] 사누끼 우동</span>
							</div>
							<div class="recipe-main-shopping-list-product-textBox-price">
								<span> <del>7,380원</del> </span>
								<div class="recipe-main-shopping-list-product-textBox-price-box">
									<div class="recipe-main-shopping-list-product-textBox-price-box-discount">
										<span class="recipe-main-discount">0%</span>
										<span>7,380원</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="recipe-main-shopping-list-product" >
						<div class="recipe-main-product" data-type="product" data-no="62" onclick="moveDetailPage(this)">
							<img src="${pageContext.request.contextPath}/resources/uploadfile/product/productimg/어류10.jpg" alt="">
						</div>
						<div class="recipe-main-shopping-list-product-textBox">
							<div class="recipe-main-shopping-list-product-textBox-title">
								<span>만전김</span>
								<span>[만전김] 만지도 무산김(곱창김) 2종 (택1)</span>
							</div>
							<div class="recipe-main-shopping-list-product-textBox-price">
								<span> <del>15,860원</del> </span>
								<div class="recipe-main-shopping-list-product-textBox-price-box">
									<div class="recipe-main-shopping-list-product-textBox-price-box-discount">
										<span class="recipe-main-discount">10%</span>
										<span>14,260원</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
	<!--recipeMain-->
	<script src="${pageContext.request.contextPath}/resources/js/recipe/recipeMain.js"></script>
</html>