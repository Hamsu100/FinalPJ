<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}" />


<script>
</script>
<div class="text-center mt-2">
	<span class="avatar avatar-xxl"> <img
		src="${path }/resources/upload/user/${loginUser.uRen}" alt="" class="rounded-circle"></span>
	<h4 class="my-3">${loginUser.uNick }</h4>

	<hr class="my-2 mx-2">
</div>
<div class="ms-6">
	<span class="d-block my-4 m"> <i
		class="fa-solid fa-user icon-yellow "></i> <a href="${path }/user/myPage"
		class="text-black"> &nbsp;&nbsp;나의 정보 </a>
	</span> <span class="d-block mb-4 "> <i
		class="fa-solid fa-list-ul icon-yellow"></i> <a
		href="${path }/user/myMoim" class="text-black"> &nbsp;&nbsp;내 모임 </a>
	</span> <span class="d-block mb-4 "> <i
		class="fa-regular fa-calendar-check icon-yellow "></i> <a href="${path }/user/mySchedule"
		class="text-black"> &nbsp;&nbsp;나의 일정</a>
	</span> <span class="d-block mb-4 "> <i
		class="fa-regular fa-envelope icon-yellow"></i> <a href="${path }/msg/list"
		class="text-black"> &nbsp;&nbsp;쪽지 </a>
	</span>
</div>