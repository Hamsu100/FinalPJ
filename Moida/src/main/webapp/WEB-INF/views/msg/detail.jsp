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
                    <h1> 쪽지 읽기</h1>
                    <hr class="my-3">
                    <div class="messagebox">
                        <div class="mt-3 ">
                            <span class="fs-3 ms-5">보낸 사람 :</span><span class=" ms-2 fs-3 col-8">${m.uNick }</span>
                        </div>
                        <div class="mt-2">
                            <span class="fs-3 ms-5 mt-2">받은 시간 : </span><span class=" ms-2 fs-3 col-8"><fmt:formatDate value="${m.mDate}" pattern="yyyy-MM-dd hh:mm"/></span>
                            <hr class="my-3">
                        </div>
                        <div class="messageread ms-5" style="background-color:#FFE0DD">
                            ${m.mContent }</h3>
                        </div>
                        <div class="message-but">
                            <button class="btn btn-secondary mt-5 mb-5 me-7 col-auto " type="button" onclick="location.href='${path}/msg/send?uNo=${m.mSender}'" style="font-size: 15px; ">답장하기</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>