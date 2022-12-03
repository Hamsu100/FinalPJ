<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>
<section class=" container ">

        <div class="bg-cover join-hero mt-2" style="background-image:url(${path}/resources/upload/moim/${m.gCoverRen });"></div>

        <hr class="my-3">

        <h1>
            가입 신청하기
        </h1>
        <form action="${path }/moim/apply" method="post">
        <div class="joinbox">
            <table class="tg">
                <thead>
                    <tr>
                        <th class="tg-6ibf">모임인사</th>
                        <th class="tg-fuxe">${m.gShort }</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="tg-6ibf">가입안내</td>
                        <td class="tg-fuxe">가입 질문에 성의 없는 숫자나 알파벳만 넣는 경우 가입에 제한 될 수 있습니다.</td>
                    </tr>
                    <tr>
                        <td class="tg-6ibf1">가입 질문</td>
                        <td class="tg-fuxe1">
                        	${m.gQ1 == null ? "":"1. "+=m.gQ1 }
                        	<c:if test="${m.gQ1 !=null }">
                            <div>
                                <textarea class="my-3 form-control" cols="106" rows="5.5" name="text1" style="resize: none;" placeholder=" 질문의 답을 입력하세요" required></textarea>
                            </div>
                            </c:if>
                            ${m.gQ2 == null ? "":"2. "+=m.gQ2 }
                            <c:if test="${m.gQ2 !=null }">
                            <div>
                                <textarea class="my-3 form-control" cols="106" rows="5.5" name="text2" style="resize: none;" placeholder=" 질문의 답을 입력하세요" required></textarea>
                            </div>
                            </c:if>
                            ${m.gQ3 == null ? "":"3. "+=m.gQ3 }
                            <c:if test="${m.gQ3 !=null }">
                            <div>
                                <textarea class="my-3 form-control" cols="106" rows="5.5" name="text3" style="resize: none;" placeholder=" 질문의 답을 입력하세요" required></textarea>
                            </div>
                            </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="text-center my-4">
            <button type="submit" class="btn btn-secondary  d-inline-block">  제출  </button>
            <button type="reset" class=" btn btn-primary ">  취소  </button>
        </div>
		</form>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>