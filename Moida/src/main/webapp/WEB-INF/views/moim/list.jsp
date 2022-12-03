<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>
<!-- 
들어오는 Parameter
session
1. loginUser
page
1. iNo
2. pageInfo
3. mList



 -->
<script>
	function searchList(){
		var iNo = $('input[name="category"]:checked').val();
		if (iNo == 0){
			location.href='${path}/moim/list?';
		} else{
			location.href='${path}/moim/list?iNo='+iNo;
		}
	}

</script>

	<section class=" container">

        <div class="searchbox">
            <h3 class="pt-3 ps-3">카테고리</h3>
				<div>
	                <input type="radio" class="btn-check " name="category" id="category_total" value="0" autocomplete="off" ${iNo == null ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_total">전&nbsp;&nbsp;체</label>
	
	                <input type="radio" class="btn-check " name="category" id="category_sports" value="1" autocomplete="off" ${iNo == 1 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_sports">운&nbsp;&nbsp;동</label>
	                
	                <input type="radio" class="btn-check" name="category" id="category_religion" value="8" autocomplete="off" ${iNo == 8 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_religion">종&nbsp;&nbsp;교</label>
	                 
	                <input type="radio" class="btn-check" name="category" id="category_game" value="3" autocomplete="off" ${iNo == 3 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_game">게&nbsp;&nbsp;임</label>
	                
	                <input type="radio" class="btn-check" name="category" id="category_fan" value="6" autocomplete="off" ${iNo == 6 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_fan">팬&nbsp;클&nbsp;럽</label>
	                
	                <input type="radio" class="btn-check" name="category" id="category_cook" value="5" autocomplete="off" ${iNo == 5 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_cook"> 맛집 / 요리</label>
	                
	            </div>
	            
	            <div>
	                <input type="radio" class="btn-check" name="category" id="category_culture" value="9" autocomplete="off" ${iNo == 9 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_culture">문화 / 예술</label>
	                
	                <input type="radio" class="btn-check" name="category" id="category_trev" value="2" autocomplete="off" ${iNo == 2 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_trev">여행 / 캠핑</label>
	                
	                <input type="radio" class="btn-check" name="category" id="category_foreign" value="4" autocomplete="off" ${iNo == 4 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_foreign">어학 / 외국어</label>
	
	                <input type="radio" class="btn-check" name="category" id="category_pet" value="7" autocomplete="off" ${iNo == 7 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_pet">반려동물 / 동물</label>
	
	                <input type="radio" class="btn-check" name="category" id="category_etc" value="10" autocomplete="off" ${iNo == 10 ? "checked" : ""} onclick="searchList()">
	                <label class="btn btn-outline-primary col-auto ms-4 mb-2" style="padding: 3px 25px;" for="category_etc">기&nbsp;&nbsp;타</label>
	
	            </div>
            <div>
                <hr class="my-2" style="color: #FF6F61;">
            </div>

            <div class="col-12 pb-2">
                <div class="row">
                    <div class="col-auto">
                        <h3 class="ps-5 pt-2">소모임 명 검색</h3>
                    </div>
                    <div class="col-5">
                        <form class="d-flex align-items-center" role="search" method="get" action="${path }/moim/list">
                            <span class="position-absolute ps-3 search-icon"><i class="fe fe-search icon-coral"></i></span>
                            <input type="search" class="form-control ps-6" placeholder="소모임을 검색하세요" aria-label="Search" name="keyword">
                            <button class="btn btn-primary mx-3 col-auto" type="search">검색</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3">
            <!-- 검색 결과 갯수  -->
            <div>
                <span>검색결과 : </span> <span style="color:#FF6F61">${moimCnt }</span> <span>개의 모임이 있습니다.</span>
                <hr class="my-2">
            </div>

            <!-- 검색 결과 내용 -->
            <div class="col-12" id="moimList">
			<c:if test="${empty mList}">
				<p>조회된 모임이 없습니다.</p>
			</c:if>
				<c:forEach var="moim" items="${mList}">
                <!-- 검색 내역 1 -->
                <a style="color:black; text-decoration:none;" href="${path }/moim?gNo=${moim.gNo}">
                <table class="tg">
                    <thead>
                        <tr>
                            <td class="searchtitle" colspan="5" rowspan="5">
                                <div class="bg-cover searchimg me-3" style="background-image:url(${path}/resources/upload/moim/${moim.gThumbRen});"></div>
                            </td>
                            <td class="searchtitle " colspan="3">${moim.gName }</td>
                            <td class="searchcate" colspan="2">카테고리 : ${moim.iCont }</td>
                        </tr>

                        <tr>
                            <td class="searchlist col-10 " colspan="5" rowspan="3">
                                ${moim.gIntro }
                            </td>
                        </tr>

                        <!-- 비어놔야함 건들 ㄴ -->
                        <tr></tr>
                        <tr></tr>

                        <tr>
                            <td class="searchtitle ">인원수 : ${moim.memCnt } &nbsp; &nbsp; 모임장 : ${moim.uNick }</td>
                            <!-- 비어있는 칸 -->
                            <td class="searchtitle" colspan="4"></td>
                        </tr>
                    </thead>
                </table>
                </a>
                <hr class="mt-1 mb-2">
				</c:forEach>

                <div aria-label="navigation example" class="my-3">
                    <ul class="pagination pagination-template d-flex justify-content-center">
                        <li class="page-item">
                            <a class="page-link" href="#"> <i class="fa fa-angle-left icon-coral"></i></a>
                        </li>
                        <c:forEach begin="${pageInfo.startPage }" end="${pageInfo.endPage }" step="1" varStatus="status">
                        
                        <c:if test="${pageInfo.currentPage == status.current }">
                        <li class="page-item active"><a class="page-link">${status.current }</a></li>
                        	
                        </c:if>
                        <c:if test="${pageInfo.currentPage != status.current }">
                        <li class="page-item"><a class="page-link" href="${path }/moim/list?page=${status.current}">${status.current }</a></li>
                        	
                        </c:if>
                        </c:forEach>
                        <li class="page-item">
                            <a class="page-link" href="#"> <i class="fa fa-angle-right icon-coral"></i></a>
                        </li>
                        
                    </ul>
                </div>

            </div>
        </div>


    </section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>