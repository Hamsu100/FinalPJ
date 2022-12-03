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
		// add/deleteFavor
		function favor(){
			var chkFavor = '';
			$.ajax({
				type : 'get',
				url : '${path}/side/favor',
				data : {'gNo': ${gNo}},
				dataType : 'json',
				success : (data) =>{
					var url = '';
					if (data == true){
						url = '${path}/side/addFavor?gNo=';
					} else{
						url = '${path}/side/delFavor?gNo=';	
					}
					var gNo = ${gNo};
					
					location.href = url + gNo;
				},
				error : (e)=>{
					console.log(e);
				}
			});
			
			
		}
		
		
		// moim data ajax
		$.ajax({
			type : 'get',
			url : '${path}/side/moim',
			data : {'gNo' : ${gNo}},
			dataType: 'json',
			success : (data)=>{
		         var img = '<img src="${path}/resources/upload/moim/'+data.gThumbRen+'" alt="" class="rounded-circle">';
		         $('#moimImg').append(img);
		         $('#favorCnt').append(data.gCnt);
		         $('#gName').append(data.gName);
		         $('#gShort').append(data.gShort);
			},
			error : (e)=>{
				console.log(e)
			}
		});
		// favor chk
		$.ajax({
			type : 'get',
			url : '${path}/side/favor',
			data : {'gNo': ${gNo}},
			dataType : 'json',
			success : (data) =>{
				console.log(data);
				if (data == false){
					$('#attentionbtn').attr('class','ms-1 btn btn-primary btn-xs');
					$('#attentionbtn').text('관심 해제')
				}
			},
			error : (e)=>{
				console.log(e);
			}
		});

		// memberList
		$.ajax({
			type:'get',
			url : '${path}/side/member',
			data : {'gNo' : ${gNo}},
			dataType : 'json',
			success : (list) =>{
				for (var i = 0 ; i < list.length ; i++){
					var str = '<tr>'
								+'<th class="sidebarname">'+list[i].uNick+'</th>'
								+'<th class="sidebargenage">'+list[i].uGender+'/'+list[i].uAge+'</th>'
								+'<th class="sidebarmessage"><button type="button" onclick="sendMsg();" class=" btn btn-primary btn-xs ms-4"> 쪽지 </button></th>'
							+'</tr>'
					$('#memList').append(str);
				}
				
			},
			error : (e)=>{
				console.log(e);				
			}
		});
		
		// memDetail
		$.ajax({
			type : 'get',
			url : '${path}/side/memDetail',
			data : {'gNo' : ${gNo}},
			dataType : 'json',
			success : (data) => {
				console.log(data);
				if (data != null){
					$('#joinbtn').attr('class','btn btn-primary col-11 btn-xs');
					$('#joinbtn').text('탈퇴하기');
					$('#joinbtn').attr('onclick','outjoin();');
					if (data.lNo == 1 || data.lNo == 2){
						var str = '<button class="btn btn-toggle d-inline-flex align-items-center border-0 collapsed text-black" style="font-size: 130%; font-weight:200;" data-bs-toggle="collapse" data-bs-target="#setting-collapse" aria-expanded="false">모임 관리</button>'
				                + '<div class="collapse" id="setting-collapse">'
				                +     '<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 ms-4 ">'
				                +         '<li><a href="${path}/moim/member" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 인원관리</a></li>'
				                +         '<li><a href="${path}/moim/invite" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 초대</a></li>'
				                +         '<li><a href="${path}/moim/block" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 차단</a></li>'
				                +         '<li><a href="${path}/moim/setting" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 설정</a></li>'
				                +         '<li><a href="${path}/moim/plan" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 일정 생성</a></li>'
				                +         '<li><a href="${path}/moim/join" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 가입 신청 목록</a></li>'
				                +     '</ul>'
				                + '</div>';
		                $('#setting').append(str);
					}	
				} else {
					$('#joinbtn').attr('class','btn btn-secondary col-11 btn-xs');
					$('#joinbtn').text('가입하기');
					$('#joinbtn').attr('onclick','addjoin();');
				}
			},
			error : (e) => {
				console.log(e)
			}
		});
		
		function addjoin(){
			location.href ="${path}/side/addJoin";
		}
		
		function outjoin(){
			location.href ="${path}/side/outJoin";
		}
</script>
<!-- 사이드바 + 내용 -->
    <section class=" container">
        <div class="row">
            <!-- 사이드바 -->

            <div class="flex-shrink-0 bg-white sidebar" style="width: 200px;">
                <!-- 프로필 사진 + 관심 + 모임명 + 한줄소개 + 가입버튼 -->
                <div class="text-center mt-2">
                    <a href="${path}/moim?gNo=${gNo }"><span class="avatar avatar-xxl " id="moimImg"> </span></a>
                    <div class="mt-2 mb-2">
                        <span style=" font-size: 90%;" id="favorCnt"><i class="fa-solid fa-heart icon-coral "></i> &nbsp; </span>
                        <button type="button" data-bs-toggle="button" autocomplete="off" id="attentionbtn" onclick='favor()' class="ms-1 btn btn-outline-primary btn-xs">관심추가</button>
                    </div>
                    <h4 id="gName">
                    </h4>
                    <div class="sidebar-oneline mx-3">
                        <h6 class="my-1 mx-3" id="gShort">
                        </h6>
                    </div>
                    <div class="my-2 col-11 mx-2" id="addBtn">
                        <button type="button" data-bs-toggle="button" autocomplete="off" id="joinbtn" class="btn btn-secondary col-11 btn-xs" onclick='addjoin()' style="font-size: 110%;"> 가입하기 </button>
                    </div>
                </div>
                <hr class="my-2 mx-2">
                <!-- 인원 보여주기 -->
                <div class="sidebar-list mx-3 my-2" data-spy="scroll" data-bs-target="#navbar-example2" data-offset="0">
                    <table class="tg">
                        <tbody id="memList">
                        </tbody>
                    </table>
                </div>
                <hr class="my-2 mx-2">
                <!-- 메뉴바 -->
                <ul class="list-unstyled ps-0 ms-2">
                        <li class="mb-1">
                            <button class="btn btn-toggle d-inline-flex align-items-center border-0 collapsed text-black" style="font-size: 130%; font-weight:200;" data-bs-toggle="collapse" data-bs-target="#menu-collapse" aria-expanded="true">메뉴</button>
                            <div class="collapse show" id="menu-collapse">
                                <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 ms-4 ">
                                    <li><a href="${path }/board/list?bcNo=1" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 공지사항</a></li>
                                    <li><a href="${path }/board/list?bcNo=2" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 자유게시판</a></li>
                                    <li><a href="${path }/board/list?bcNo=3" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 사진 게시판</a></li>
                                    <li><a href="${path }/board/list?bcNo=4" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 정모 게시판</a></li>
                                    <li><a href="${path }/board/list?bcNo=5" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 도전 인증</a></li>
                                    <li><a href="${path }/board/greet" class="link-dark d-inline-flex text-decoration-none rounded mb-2">- &nbsp; 가입 인사</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="border-top my-3"></li>
                        <li class="mb-1" id="setting">
                        </li>
                    </ul>
            </div>
            <!-- 사이드 바 끝-->

            <!-- 사이드 바 옆 내용 섹션-->
            <div class="col-10">
                <div class="mt-4 ms-3">
                    <h1> ${bcName }&nbsp;게시판</h1>
                    <hr class="my-3">
                </div>
                <div class="col-12 ms-3">
                    <table class="tg" style="width: 100%">
                        <colgroup>
                            <col style="width: 10%">
                            <col style="width: 50%">
                            <col style="width: 15%">
                            <col style="width: 15%">
                            <col style="width: 10%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th class="boardTitle">번호</th>
                                <th class="boardTitle">제목</th>
                                <th class="boardTitle">글쓴이</th>
                                <th class="boardTitle">작성일</th>
                                <th class="boardTitle">조회수</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty bList }">
                        <tr>
                        	<td colspan="5" style="text-align:center">조회된 게시글이 없습니다.</td>
                        </tr>
                        </c:if>
                        <c:if test="${!empty bList }">
							<c:forEach var="b" items="${bList }" varStatus="status">
							<tr>
                                <td class="board4">${b.bNo}</td>
                                <td class="board2"><a href="${path }/board/detail?bNo=${b.bNo}" class="text-black">${b.cTitle ==null?"":"["+= b.cTitle +="]"} ${b.bTitle }</a></td>
                                <td class="board4">${b.uNick }</td>
                                <td class="board2"><fmt:formatDate value="${b.bMdf }" pattern="yyyy-MM-dd"/></td>
                                <td class="board4">${b.bRdCnt }</td>
                            </tr>
							</c:forEach>                        	
                        </c:if>
                        </tbody>
                    </table>
                    <hr class="mt-5">
                    <form class="row ms-2 mt-5" action="${path }/board/list" method="get">
                        <div class="mb-3 col ps-0 ms-2 ms-md-0 d-flex align-items-center form-group no-divider">
                        <input type="hidden" value="${bcNo }" name="bcNo">
                            <select class="form-select" style="width: 150px;" title="분류 " data-style="btn-form-control " name="searchType">
                                <option value="writer">작성자</option>
                                <option value="title">제목</option>
                            </select>
                            <input type="search" class="form-control ms-3" placeholder="검색어를 입력하시오" required name="searchValue">
                        </div>
                        <div class="mb-3 col-auto">
                            <button class="btn btn-primary me-3" type="search">검색</button>
                            <c:if test="${bcNo != 1 }">
                            <button class="btn btn-secondary" type="button" onclick="location.href='${path}/board/write?bcNo=${bcNo }'">글쓰기</button>
                            </c:if>
                            <c:if test="${bcNo == 1 }">
                            	<c:if test="${mm.lNo <3 }">
                            	<button class="btn btn-secondary" type="button" onclick="location.href='${path}/board/write?bcNo=${bcNo }'">글쓰기</button>
                            	</c:if>
                            </c:if>
                        </div>
                    </form>
                    <div aria-label=" navigation example" class="my-3">
                        <ul class="pagination pagination-template d-flex justify-content-center">
                            <li class="page-item">
                                <a class="page-link" href="${path }/board/list?bcNo=${bcNo}&page=${pageInfo.prevPage}"> <i class="fa fa-angle-left"></i></a>
                            </li>
                            <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" varStatus="status">
                            	<c:if test="${pageInfo.currentPage == status.current }">
                            		<li class="page-item active"><a class="page-link" href="${path }/board/list?bcNo=${bcNo}&page=${status.current}">${status.current }</a></li>
                            	</c:if>
                            	<c:if test="${pageInfo.currentPage != status.current }">
                            	<li class="page-item"><a class="page-link" href="${path }/board/list?bcNo=${bcNo}&page=${status.current}">${status.current }</a></li>
                            	</c:if>
                            </c:forEach>
                            
                            <li class="page-item">
                                <a class="page-link" href="${path }/board/list?bcNo=${bcNo}&page=${pageInfo.nextPage }"> <i class="fa fa-angle-right"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>