<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>
<script>
function outMoim(gNo){
	location.href="${path}/moim/outMoim?gNo="+gNo;
}
</script>
	<section class="container">
        <div class="row">
            <!-- 사이드바 -->
            <div class=" bg-white sidebar col-2" style="width: 200px; height: 400px">
                <!-- 프로필 사진 + 닉네임 -->
                <!-- sidebar -->
                <jsp:include page="/WEB-INF/views/user/sidebar.jsp"/>
                <!-- sidebar -->
            </div>
            <!-- 사이드 바 끝-->
            <!-- 사이드 바 옆 내용 섹션-->
            <div class="col-10">
                <!-- 제목 -->
                <div class="mt-4 ms-2">
                    <h1> 내 모임</h1>
                    <hr class="my-3">
                </div>
                <!-- 내모임 리스트 -->
                <div class="col-12 ms-3">

                    <!-- 2개 씩 리스트-->
                    <c:if test="${empty mList }">
                    <div style="width:100%; font-size : 20px; text-align:center">가입된 모임이 없습니다.</div>
                    </c:if>
                    <c:if test="${!empty mList }">
                   	<c:forEach var="m" items="${mList }" varStatus="status">
              	<c:if test="${status.index % 2 == 0 }">
                    <div class="row">
                </c:if>
                        <table class='tg mylisttable col-5 ${status.index % 2 ==0 ? "me-1":""}'>
                                <tr>
                                    <td class="mylist ms-2" colspan="4">
                                        <a href="${path }/moim?gNo=${m.gNo}"><h2> ${m.gName }</h2></a>
                                    </td>
                                    <td class="mylist" colspan="3" rowspan="4">
                                        <div class="bg-cover mylistimg" style="background-image:url(${path}/resources/upload/moim/${m.gThumbRen });"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="mylist ms-2" colspan="4" rowspan="2">
                                        <h4 style="width: 250px;">
                                            ${m.gIntro }
                                        </h4>
                                    </td>
                                </tr>
                                <tr>
                                    <!-- 비어놔야함-->
                                </tr>
                                <tr>
                                    <td class="mylist" colspan="4">
                                        <button class="btn btn-secondary  mylistloca col-5 me-3" style="font-size:95%; width:105px; height:45px">${m.ri }</button>
                                        <button class="btn btn-primary mylistloca col-5" style="font-size:95%; width:105px; height:45px ">${m.iCont }</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="mylistheadcnt" colspan="5">
                                        <span style="font-size:130%; color: #ff6f61;">&nbsp; ${m.memCnt }</span>
                                        <span style="font-size:130% ">명 모임 가입</span>
                                    </td>
                                    <td class="mylistbtn " colspan="2 ">
                                        <button type="button " class="btn btn-outline-primary col-8" onclick="outMoim(${m.gNo})">탈퇴하기</button>
                                    </td>
                                </tr>
                        </table>
                     <c:if test="${status.index % 2 == 1 }">
                        </div>
                     </c:if>
                        </c:forEach>
                        </c:if>

                </div>
                </div>
    </section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>