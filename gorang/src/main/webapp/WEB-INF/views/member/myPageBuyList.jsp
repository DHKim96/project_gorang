<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>푸드 커뮤니티 커머스, 고랭: 고수의 냉장고</title>

            <!-- Latest compiled and minified CSS -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">


            <c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
            <link rel="stylesheet" href="${contextPath}/resources/css/default.css">
            <link rel="stylesheet" href="${contextPath}/resources/css/member/myPageBuyList.css">
        </head>

        <body>
            <jsp:include page="../common/header.jsp" />


            <div id="body-area">
                <!-- 왼쪽 프로필 메뉴바영역 -->
                <jsp:include page="myPageMenubar.jsp" />

                <!-- 우측 메인영역 -->
                <div id="right-body-area">
                    <c:choose>
                        <c:when test="${empty orderPdopts}">
                            <span>구매 내역이 없습니다.</span>
                        </c:when>
                        <c:otherwise>
                            <div id="myPage-buy-list-top">
                                구매내역(${orderPdoptsCount}개)
                            </div>
                            <div id="myPage-buy-list-bottom">
                                <table style="border-spacing: 10px;">
                                    <thead>
                                        <tr>
                                            <td colspan="2" id="head-name">상품</td>
                                            <td id="head-amount">수량</td>
                                            <td id="head-price">상품가격</td>
                                            <td id="head-buyDate">결제일자</td>
                                            <td colspan="2" id="head-status">상태</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="orderPdopt" items="${orderPdopts}">
                                            <tr class="tbody-buy-list-block">
                                                <td class="tbody-td-img"><img style="cursor: pointer;"
                                                        src="${contextPath}/resources/uploadfile/product/productimg/${orderPdopt.orderPdThumbnail}"
                                                        alt="">
                                                </td>
                                                <td class="tbody-td-name">
                                                    <input type="hidden" class="buyList-input-productNo" value="${orderPdopt.orderPdNo}">
                                                    <input type="hidden" class="buyList-input-pdOptNo" value="${orderPdopt.optNo}">
                                                    <span class="product-brand-name">${orderPdopt.orderPdBrand}</span>
                                                    <br>
                                                    <span class="product-name">${orderPdopt.orderPdName}</span> <br>
                                                    <span class="product-opt-name">${orderPdopt.orderPdOptName}</span>
                                                </td>
                                                <td class="tbody-td-amount">${orderPdopt.optQuantity}</td>
                                                <td class="tbody-td-price">${orderPdopt.orderPdOptPrice}원</td>
                                                <td class="tbody-td-buyDate">${orderPdopt.orderPdOptDate}</td>
                                                <td class="tbody-td-status">
                                                    <span style="color:#068E3D;">배송 완료</span><br>
                                                    <form action="https://info.sweettracker.co.kr/tracking/5" method="post">
                                                        <div class="form-group" style="display: none;">
                                                          <label for="t_key">API key</label>
                                                          <input type="hidden" class="form-control" id="t_key" name="t_key" placeholder="제공받은 APIKEY" value="ln0430YYI1g2THuT7m4Atg">
                                                        </div>
                                                        <div class="form-group" style="display: none;">
                                                          <label for="t_code">택배사 코드</label>
                                                          <input type="text" class="form-control" name="t_code" id="t_code" placeholder="택배사 코드" value="04">
                                                        </div>
                                                        <div class="form-group" style="display: none;">
                                                          <label for="t_invoice">운송장 번호</label>
                                                          <input type="hidden" class="form-control" name="t_invoice" id="t_invoice" placeholder="운송장 번호">
                                                        </div>
                                                        <button type="submit" class="btn btn-default" style="width: 85px;">조회하기</button>
                                                    </form>
                                                    <!-- <span class="status-font">도착 예정일<br>2024.01.02</span>  -->
                                                </td>
                                                <td class="tbody-td-btn">
                                                    <button class="tbody-td-btn-qna" data-toggle="modal"
                                                        data-target="#qna_Modal">문의 하기</button>
                                                    <c:choose>
                                                        <c:when test="${orderPdopt.refReviewNo == 0}">
                                                            <button class="tbody-td-btn-write" data-toggle="modal" data-target="#buyList-review_Modal">후기 작성</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="tbody-td-btn-write" style="pointer-events: none;">작성 완료</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <button class="tbody-td-btn-cancle" onclick="showSweetConfirm()">주문
                                                        취소</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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
                            <!-- 문의하기 modal -->
                            <div class="modal" id="qna_Modal" style="display: none;" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">

                                        <!-- Modal Header -->
                                        <div class="modal-header">
                                            <h4 style="font-size: 16px; margin-bottom: 0px;">상품 문의하기</h4>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>

                                        <!-- Modal body -->
                                        <div class="modal-body" style="height: 100%;">
                                            <form class="modal-qna-content" action="insertQna.po" enctype="multipart/form-data" method="post">
                                                <input type="hidden" name="writerNo" id="qna-modal-writerNo" value=${loginUser.memberNo}>
                                                <input type="hidden" name="refProductNo" id="qna-modal-refProductNo">
                                                <input type="hidden" name="refQnaNo" value="0">
                                                <div class="product_name_container">
                                                    <div class="qna_product_name_header">
                                                        상품명
                                                    </div>
                                                    <span class="qna_product_name"></span>
                                                    <select name="refPdoptNo" class="qna_pdopt_name">
                                                        <option></option>
                                                    </select>
                                                </div>
                                                <div class="product_pic_container">
                                                    <div style="font-size: 14px; font-weight: bold;">
                                                        사진 첨부(선택)
                                                        <div>
                                                            사진을 첨부해주세요.(최대 1장)
                                                        </div>
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
                                                    <button type="submit" class="product_qna_enroll_btn">완료</button>
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
                                            <h4 style="font-size: 16px; margin-bottom: 0px;">상품 후기 작성하기</h4>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>

                                        <!-- Modal body -->
                                        <div class="modal-body" style="height: 100%;">
                                            <form class="modal-qna-content" action="insertReview.po" enctype="multipart/form-data" method="post">
                                                <input type="hidden" name="refMemberNo" value=${loginUser.memberNo}>
                                                <input type="hidden" name="refProductNo" id="review-modal-refProductNo">
                                                <div class="product_name_container">
                                                    <div class="qna_product_name_header">
                                                        상품명
                                                    </div>
                                                    <span class="qna_product_name"></span>
                                                    <select name="refPdoptNo" class="qna_pdopt_name">
                                                        <option></option>
                                                    </select>
                                                </div>
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
                                                <div class="product_pic_container">
                                                    <div style="font-size: 14px; font-weight: bold;">
                                                        사진 첨부(선택)
                                                        <div>
                                                            사진을 첨부해주세요.(최대 1장)
                                                        </div>
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
                                                    <button type="submit" class="product_qna_enroll_btn">완료</button>
                                                </div>
                                            </form>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <jsp:include page="../common/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script src="${contextPath }/resources/js/member/myPageBuyList.js"></script>
        </body>

        </html>