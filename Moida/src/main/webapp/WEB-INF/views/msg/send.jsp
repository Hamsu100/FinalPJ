<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>

<section class=" container">
        <div class="row">
            <!-- 사이드바 -->
            <div class="col-2 bg-white sidebar sidebar-block" style="width: 200px; height: 400px">
                <!-- 프로필 사진 + 닉네임 -->
                <jsp:include page="/WEB-INF/views/user/sidebar.jsp"/>
            </div>
            <!-- 사이드 바 끝-->
            <!-- 사이드 바 옆 내용 섹션-->
            <div class="col-10">
                <!-- 제목 -->
                <div class="mt-4 ms-2">
                    <h1> 쪽지 쓰기</h1>
                    <hr class="my-3">
                </div>
                <div class="messagebox">
					<form action="${path }/msg/send" method="post">
                    <div class="mt-3">
                        <span class="fs-3 ms-5">받는 사람 : </span>
                        <select class="selectpicker ms-2" data-live-search="true" name="selectId" data-width="fit" id="ab">
                            <option>닉네임 선택</option>
                            <c:forEach var="m" items="${u }" varStatus="status">
                            <option value="${m.uNo }" ${send.uNo == m.uNo? "selected":"" }>${m.uNick }</option>
                            </c:forEach>
                        </select>
                        <button class="btn btn-secondary mx-3 col-auto " type="button" style="font-size: 17px;">검색</button>
                    </div>
					<div>
                        <textarea class="form-control text-black mt-3 ms-5" name="sendText" style="resize: none; font-size: 18px; width: 990px;" cols="105" rows="7" required></textarea>
                    </div>
                    <div class="message-but">
                        <button class="btn btn-secondary mt-5 mb-5 me-7 col-auto " type="submit" style="font-size: 15px; ">보내기</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>