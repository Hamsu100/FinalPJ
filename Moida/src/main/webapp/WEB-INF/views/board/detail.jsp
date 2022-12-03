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
<section class=" container">
        <div class="row">
            <!-- 사이드바 -->
            <div style="width: 200px; height: 800px">
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
            </div>
            <!-- 사이드 바 끝-->


            <!-- 사이드 바 옆 내용 섹션-->
            <div class="col-10">
                <div class="mt-4 ms-3">
                    <h1>${b.cTitle == null? "": b.cTitle} ${b.bTitle }</h1>
                    <hr class="my-3">
                </div>
                <div class="col-12 ms-4">
                    <div class="d-flex">
                        <span class="avatar avatar-lg  "><img src="${path }/resources/upload/user/${b.uRen}" alt="" class="rounded-circle"></span>
                        <div class="ms-2">
                            <p>
                                <a class="text-black" style="font-size:120%">${b.uNick }</a>
                                <br>
                                <a class="me-2 text-black" style="font-size:90%"><i class="bi bi-calendar3 icon-coral"></i> <fmt:formatDate value="${b.bMdf}" pattern="yyyy-MM-dd hh:mm:ss"/></a>
                            </p>
                        </div>
                    </div>
                    <!-- 글 내용    -->
                    <div class="boardbox col-12">
                        ${b.bCont }
                    </div>

                    <div class="mt-2 offset-8">
                    
                    <c:if test="${loginUser.uNo == b.uNo }">
                        <button class="btn btn-primary offset-5" type="button" onclick="location.href='${path}/board/update?bNo=${b.bNo }'"> 수정 </button>
                        <button class="btn btn-primary" type="button" onclick="location.href='${path}/board/delete?bNo=${b.bNo }'"> 삭제 </button>
                   	</c:if>
                        <button class="btn btn-secondary" type="button" onclick="location.href='${path}/board/list?bcNo=${b.bcNo }'"> 목록 </button>
                    </div>

                    <hr>

                    <h2>댓글 작성하기</h2>

                    <form class="form" id="contact-form" method="post" action="${path }/board/rWrite">
                        <div class="mb-3">
                            <textarea class="form-control" name="rCont" placeholder="댓글을 작성하세요" style="resize: none;" required="required"></textarea>
                            <input type="hidden" name="bNo" value="${b.bNo }">
                        </div>
                        <div class="offset-1">
                            <button class="btn btn-primary btn-sm offset-10-1 " style="font-weight:200;" type="submit">작성하기</button>
                            <button class="btn btn-primary btn-sm " style="font-weight:200;" type="reset">취소</button>
                        </div>
                    </form>
                            <hr>
	<!-- r.rNo,	r.rCont,	r.rMdf,
			r.uNo,	r.gNo,	r.bNo,
			u.uNick,	u.uRen -->
			<c:forEach var="r" items="${rList }" varStatus="status">
                    <div class="text-block">
                        <div class="d-flex">
                            <span class="avatar avatar-lg "><img src="${path }/resources/upload/user/${r.uRen}" alt="" class="rounded-circle"></span>
                            <div class="ms-2">
                                <p>
                                    <!-- 닉네임 -->
                                    <a class="text-black">${r.uNick }</a>
                                    <br>
                                    <a class="me-2 text-black" style="font-size:90%"><i class="fa-regular fa-clock icon-coral"></i><fmt:formatDate value="${r.rMdf }" pattern="yyyy-MM-dd hh:mm:ss"/></a>
                                    <c:if test="${r.uNo == loginUser.uNo }">
	                                    <a href="#" data-bs-toggle="collapse" style="font-size:90%" data-bs-target="#boardcomment" aria-expanded="false" aria-controls="boardcomment" class=" me-2  ">수정</a>
	                                    <a href="${path }/board/rDelete?rNo=${r.rNo}" style="font-size:90%">삭제</a>
                                    </c:if>
                                </p>
                            </div>
                        </div>
                        <div class="ms-4">
                            <p class="text-black text-sm mb-2" style="font-size:110%; font-weight:200;">
                                ${r.rCont }
                            </p>
                        </div>
                    </div>

                    <hr class="my-2">

                    <!-- 수정하는 영역 -->
                    <div class="collapse mt-4" id="boardcomment">
                        <form class="form" id="contact-form" method="post" action="${path }/board/rUpdate">
                        <input type="hidden" name="rNo" value="${r.rNo }">
                            <div class="mb-3">
                                <textarea class="form-control" name="rCont" id="boardcomment" placeholder="어쩌구 저쩌구" style="resize: none;" required="required"></textarea>
                            </div>
                            <button class="btn btn-primary btn-sm offset-11-1" style="font-weight:200;" type="submit">수정하기</button>
                        </form>
                    </div>
			</c:forEach>
                </div>
            </div>
        </div>
    </section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>