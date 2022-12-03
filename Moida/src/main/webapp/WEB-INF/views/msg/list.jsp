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
function chkAll(){
	if ($('#cbx_chkAll').is(':checked') == true){
		$('input[name=chk]').prop('checked',true);
	} else{
		$('input[name=chk]').prop('checked',false);
	}
}
</script>
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
                    <h1> 쪽지</h1>
                    <hr class="my-3">
                    <div class="message-list">
                        <div class="row">
                            <div class="col-5 mt-3 ms-3">
                                <form class="d-flex align-items-center" role="search" action="${path }/msg/list" method="get">
                                    <span class="position-absolute ps-3 search-icon"><i class="fe fe-search icon-coral"></i></span>
                                    <input type="search" class="form-control ps-6" name="keyword" placeholder="닉네임을 입력하세요" aria-label="Search">
                                    <button class="btn btn-primary mx-3 col-auto"  type="submit" style="font-size: 20px;">검색</button>
                                    <button class="btn btn-secondary mx-3 col-auto " type="button" onclick="location.href='${path}/msg/send'" style="font-size: 20px;">쪽지쓰기</button>
                                </form>
                            </div>
                        </div>
                        <hr class="my-3">
                        <form action="${path }/msg/delete" method="post">
                        <div>
                            <input type="checkbox" id="cbx_chkAll" onclick="chkAll();" class="ms-4" style="height:25px;width:25px;"/>  <label for="cbx_chkAll" style="font-size:25px;">&nbsp; 전체</label>
                            <button class="btn btn-primary col-auto offset-10 " type="submit" style="font-size: 20px;">삭제</button>
                        </div>
                        <hr class="my-3">
                        <div class=" mt-5 d-flex messagescorll" data-spy="scroll" data-offset="0">
                        
                            <table class="tg col-12 " >
                                <colgroup>
                                    <col style="width: 15% ">
                                    <col style="width: 15% ">
                                    <col style="width: 50% ">
                                    <col style="width: 20% ">
                                </colgroup>
                                <tbody>
                                    <c:if test="${!empty mList }">
                                    <c:forEach var="msg" items="${mList }" varStatus="status">
                                    <tr>
                                        <td class="tg-c3ow" rowspan="2"><input type="checkbox" name="chk" value="${msg.mNo }" style="height:50px;width:50px;" ></td>
                                        <td class="tg-c3ow" rowspan="2"> <img src="${path }/resources/upload/user/${msg.uRen}" id="img-uploaded" class="avatar-xxl rounded-circle" alt="" /> </td>
                                        <td class="message-n"><a href="${path }/msg/detail?mNo=${msg.mNo}" style="color:black;"><span>${msg.uNick }</span></a></td>
                                        <td class="tg-c3ow text-muted"><fmt:formatDate value="${msg.mDate}" pattern="yyyy-MM-dd hh:mm"/></td>
                                    </tr>
                                    
                                    <tr>
                                        <td class="message-m" colspan="2">
                                            <h3> ${msg.mContent }</h3>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                    </c:if>
                                    
                                    <c:if test="${empty mList }">
                                    <tr><td style="width:100%;text-align:center;font-size:20px">조회된 메세지가 없습니다.</td></tr>
                                    </c:if>
                                    <!-- 1 -->
                                </tbody>
                            </table>
                        </div>
                            </form>
                    </div>
                </div>
            </div>
        </div>

    </section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>