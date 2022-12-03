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
param 
1. Moim
2. session user
3. board data (nList, iList, rList, cList) 
4. plan data

-->
<script src="${path }/resources/js/slide.js" type="text/javascript" charset="utf-8"></script>
<script>
		// 관심 추가 해제 ajax
		function favor(){
			var chkFavor = '';
			$.ajax({
				type : 'get',
				url : '${path}/side/favor',
				data : {'gNo': ${param.gNo}},
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
		function sendMsg(uNo){
			location.href = '${path}/msg/send?uNo='+uNo;
		}
		
		// moim data ajax
		$.ajax({
			type : 'get',
			url : '${path}/side/moim',
			data : {'gNo' : ${param.gNo}},
			dataType: 'json',
			success : (data)=>{
		         var img = '<img src="${path}/resources/upload/moim/'+data.gThumbRen+'" alt="" class="rounded-circle">';
		         $('#moimImg').append(img);
		         $('#favorCnt').append(data.gCnt);
		         $('#gName').append(data.gName);
		         $('#gShort').append(data.gShort);
		         $("#cover").css({"background":"url(${path}/resources/upload/moim/"+data.gCoverRen+")",
		        	 				"background-size":"cover",
		        	 				"background-position":"center"});
		         $('#gIntro').text(data.gIntro);
			},
			error : (e)=>{
				console.log(e)
			}
		});
		// favor chk
		$.ajax({
			type : 'get',
			url : '${path}/side/favor',
			data : {'gNo': ${param.gNo}},
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
			data : {'gNo' : ${param.gNo}},
			dataType : 'json',
			success : (list) =>{
				for (var i = 0 ; i < list.length ; i++){
					var str = '<tr>'
								+'<th class="sidebarname">'+list[i].uNick+'</th>'
								+'<th class="sidebargenage">'+list[i].uGender+'/'+list[i].uAge+'</th>'
								+'<th class="sidebarmessage"><button type="button" onclick="sendMsg('+list[i].uNo+');" class=" btn btn-primary btn-xs ms-4"> 쪽지 </button></th>'
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
			data : {'gNo' : ${param.gNo}},
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

	<section class="container">
        <div class="row">
            <!-- 사이드바 -->
            <div style="width: 200px; height: 800px">
                <div class="flex-shrink-0 bg-white sidebar " style="width: 200px;">
                    <!-- 프로필 사진 + 관심 + 모임명 + 한줄소개 + 가입버튼 -->
                    <div class="text-center mt-2">
                        <a href="${path}/moim?gNo=${gNo }"><span class="avatar avatar-xxl " id="moimImg"> </span></a>
                        <div class="mt-2 mb-2">
                            <span style=" font-size: 90%;" id="favorCnt"><i class="fa-solid fa-heart icon-coral "></i>&nbsp;</span>
                            <button type="button" data-bs-toggle="button" autocomplete="off" id="attentionbtn" class="ms-1 btn btn-outline-primary btn-xs" onclick='favor()'>관심추가</button>
                        </div>
                        <h4 id="gName">
                        </h4>
                        <div class="sidebar-oneline mx-3">
                            <h6 class="my-1 mx-3" id="gShort">
                            </h6>
                        </div>
                        <div class="my-2 col-11 mx-2" id="addBtn">
                            <button type="button" data-bs-toggle="button" autocomplete="off" id="joinbtn" class="btn btn-secondary col-11 btn-xs" style="font-size: 110%;" onclick='addjoin()'> 가입하기 </button>
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
            <div class="col-10 ">
                <div class="col-12 mt-2 ms-3">
                    <!-- 모임 커버 사진 및 모임 소개글 -->
                    <div class="bg-cover main-hero" id="cover"></div>
                    <div style="border: 2px solid #f2f2f2">
                        <h4 class="mx-3 my-3" id="gIntro">
                        </h4>
                    </div>

                    <hr class="my-2">

                    <!-- 공지시항 & 모임 일정 -->
                    <div class="col-12 row ">
                        <!-- 공지사항 -->
                        <div class="col-6 mt-1">
                            <a href="${path }/board/list?bcNo=1">
                            	<!-- notice -->
                                <h2>공지사항 <i class="fa-solid fa-caret-right icon-yellow"></i></h2>
                            </a>
                            <hr class="my-2">
                            <ul class="mainboard-list">
                            	<c:if test="${empty notice }">
                            	<li style="list-style:none;font-size:20px;text-align:center">조회된 게시글이 없습니다.</li>
                            	</c:if>
                            	<c:if test="${!empty notice }">
                            	<c:forEach var="n" items="${notice }">
                                <li>
                                    <a href="${path }/board/detail?bNo=${n.bNo}">
                                        <span class="title">${n.bTitle }</span>
                                        <span class="date"><fmt:formatDate value="${n.bMdf }" pattern="yyyy-MM-dd"/></span>
                                    </a>
                                </li>
                                </c:forEach>
                                </c:if>
                            </ul>
                        </div>
                        <!-- 모임 일정 -->
                        <div class="col-6 mt-1">
                            <h2>
                                모임 일정
                            </h2>
                            <hr class="my-2">
<div class="loginmainmylist" style="height:300px;overflow:auto;width:100%"  data-spy="scroll" data-offset="0">
                            <!-- 리스트1 -->
                            <!-- 누르면 모달 / 모달창 코드는 제일 아래에 -->
                            <c:if test="${empty plList }">
                            <p style="width:100%; text-align:center;font-size:20px;">조회된 일정이 없습니다.</p>
                            </c:if>
                      		<c:if test="${!empty plList }">
                            <c:forEach var="pl" items="${plList }" varStatus="status">
                            <div class="row" style="margin-right:0;">
                                <!-- d-? -->
                                <div class="col-auto">
                                    <h3 class="mt-3 ms-2" style="color:#FF6F61">D-${pl.dDay }</h3>
                                </div>
                                <!-- 내용 -->
                                <div class="col-auto ms-n2">
                                    <a data-bs-toggle="modal" data-bs-target="#mainschedule" role="button" onclick="planData(${pl.plNo})">
                                        <!-- 날짜 & 위치-->
                                        <div>
                                            <i class="fa-regular fa-calendar fs-4 icon-yellow"></i> <span class="fs-4 text-gray-700"><fmt:formatDate value="${pl.plDate }" pattern="yyyy.MM.dd HH:mm"/> </span> &nbsp;
                                            <i class="fa-solid fa-location-dot fs-4 icon-coral"></i> <span class="fs-4 text-black"> ${pl.plPlace }</span>
                                        </div>
                                        <!-- 일정명 -->
                                        <div>
                                            <h3 class="mainschedule">${pl.plTitle }</h3>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <hr class="my-2">
							</c:forEach>
							</c:if>
                            <!-- 리스트4 -->
                        </div>
                    </div>

                    <hr class="mb-3 mt-n1">

                    <!-- 사진 슬라이더 -->
                    <c:if test="${empty img }">
                    <div style="width:100%;text-align:center;font-size:20px">조회된 사진이 없습니다.</div>
                    </c:if>
                    <c:if test="${!empty img }">
                    <div class="slide_wrapper ">
                        <ul class="slides d-flex mainli">
                            <!-- 사진 1 -->
                            <c:forEach var="i" items="${img }" varStatus="status" >
                            <li>
                                <a href="${path }/board/detail?bNo=${i.bNo}">
                                    <div class="bg-cover mainphoto" style="background-image:url(${path}/resources/upload/board/${i.bRen });"></div>
                                </a>
                            </li>
                            </c:forEach>
                        </ul>
                        <p class="maincontrols">
                            <span class="prev" style="font-size: 240%;"><i class="fa-solid fa-circle-chevron-left icon-coral"></i></span>
                            <span class="next" style="font-size: 240%;"><i class="fa-solid fa-circle-chevron-right icon-coral"></i></span>
                        </p>
                    </div>
					</c:if>
                    <hr class="my-3">


                    <!-- 정모후기 & 도전 인증 -->
                    <div class="col-12 row">
                        <!-- 정모후기 -->
                        <div class="col-6">
                            <a href="${path }/board/list?bcNo=4">
                                <h2>정모후기 <i class="fa-solid fa-caret-right icon-yellow"></i></h2>
                            </a>

                            <div class="mt-2">

                                <!-- 게시글 1 -->
                                <c:if test="${empty after }">
                    <div style="width:100%;text-align:center;font-size:20px">조회된 게시글이 없습니다.</div>
                    </c:if>
                    <c:if test="${!empty after }">
                                <c:forEach var="a" items="${after }" varStatus="status">
                                <div>
                                    <div class="d-flex">
                                        <!-- 작성자 프사 -->
                                        <span class="avatar avatar-md "><img src="${path }/resources/upload/user/${a.uRen}" alt="" class="rounded-circle"></span>
                                        <div class="ms-2 mt-2">
                                            <!-- 닉네임 작성일 -->
                                            <a class="text-black">${a.uNick }&nbsp;|&nbsp;<fmt:formatDate value="${a.bMdf }" pattern="yyyy-MM-dd"/></a>
                                        </div>
                                        <!-- 댓글 수 -->
                                        <div class="offset-6 mt-2">
                                            <a class="text-gray-700">
                                                <i class="fa-solid fa-comment-dots icon-yellow"></i>&nbsp;${a.cnt }
                                            </a>
                                        </div>
                                    </div>
                                    <div class="ms-3">
                                        <!-- 글 내용 -->
                                        <a href="${path }/board/detail?bNo=${a.bNo}">
                                            <p class="text-black mainboardp mb-2" style="font-size:110%;">
                                                ${a.bTitle }
                                            </p>
                                        </a>
                                    </div>
                                    <hr class="my-2">
                                </div>
								</c:forEach>
								</c:if>
                            </div>
                        </div>

                        <!-- 도전인증 -->
                        <div class="col-6">
                            <a href="board.html">
                                <h2>도전 인증<i class="fa-solid fa-caret-right icon-yellow"></i></h2>
                            </a>

                            <div class="mt-2 mx-2">
                            
                                <!-- 게시글 1 -->
                                            <c:if test="${empty after }">
                    <div style="width:100%;text-align:center;font-size:20px">조회된 게시글이 없습니다.</div>
                    </c:if>
                    <c:if test="${!empty after }">
                                <c:forEach var="ch" items="${chal }" varStatus="status">
                                <div>
                                    <div class="d-flex">
                                        <!-- 작성자 프사 -->
                                        <span class="avatar avatar-md "><img src="${path }resources/upload/user/${ch.uRen}" alt="" class="rounded-circle"></span>
                                        <div class="ms-2 mt-2">
                                            <!-- 닉네임 작성일 -->
                                            <a class="text-black">${ch.uNick }&nbsp;|&nbsp;<fmt:formatDate value="${ch.bMdf }" pattern="yyyy-MM-dd"/></a>
                                        </div>
                                        <!-- 댓글 수 -->
                                        <div class="offset-6 mt-2">
                                            <a class="text-gray-700">
                                                <i class="fa-solid fa-comment-dots icon-yellow"></i>&nbsp;${ch.cnt }
                                            </a>
                                        </div>
                                    </div>
                                    <div class="ms-3">
                                        <!-- 글 내용 -->
                                        <a href="">
                                            <p class="text-black mainboardp mb-2" style="font-size:110%;">
                                                ${ch.bTitle }
                                            </p>
                                        </a>
                                    </div>
                                    <hr class="my-2">
                                </div>
								</c:forEach>
								</c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<script>
function planData(plNo){
	console.log(plNo)
	$.ajax({
		type:'get',
		url : '${path}/moim/planData',
		data : {plNo},
		dataType:'json',
		success:(data) => {
			// 1. 멤버가 아닐경우
			console.log(data)
			if (data == null){
				$('#plData').html('<p>모임 가입 후 확인해 주세요!!</p>')
			}
			var date = new Date(data.plDate);
			
			var strDate = date.getFullYear() + '.'+(date.getMonth()+1)+'.'+date.getDate()+' '+date.getHours()+':'+date.getMinutes();
			// 2. 멤버인 경우
			$('#plName').text(data.plTitle);
			$('#plDate').text(strDate);
			$('#plPlace').text(data.plPlace);
			$('#attendCnt').text(data.memCnt);
			$('#memLimit').text(data.plMemLimit);
			attendMember(plNo);
		},
		error : (e) =>{
			console.log(e)
		}
	});
};

function attendMember(plNo){
	$.ajax({
		type:'get',
		url:'${path}/moim/attMem',
		data : {plNo},
		dataType : 'json',
		success : (list)=>{
			
			$('#attendBtn').attr('onclick','att('+plNo+')')
			console.log(list)
			str = ''; 
			
			for (var i = 0 ; i < list.length ; i++){
				if (${loginUser.uNo}==list[i].uno){
					console.log('중복')
					$('#attendBtn').attr('onclick','alert("이미 참석 하신 일정입니다.")');
				}
				str+='<li>'+list[i].unick+'</li>';
			}
			$('#attendMember').html(str);
		},
		error:(e)=>{
			console.log(e)
		}
	})
	
}

function att(plNo){
	location.href = '${path}/moim/att?plNo='+plNo;
}
</script>
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mainschedule" id="mainschedule" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="px-3 py-3" id="plData">
                    <div class="row">
                        <!-- 일정명 -->
                        <div class="col-11">
                            <h3 class="col-auto" id="plName"></h3>
                        </div>
                        <button type="button" class="btn-close" style="float: right;" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="row mt-n2">
                        <span class="fs-4 text-black"> 
                        <span id="plDate"></span>&nbsp<i class="fa-solid fa-location-dot fs-4 icon-coral"></i>&nbsp<span id="plPlace"></span>
                        </span>
                    </div>
                    <hr class="mt-n1" style="color: black; margin-bottom:-.05rem">
                    <!-- 참석인원 수 및 참석인원 리스트 -->
                    <div>
                        <span>참석인원 : (<span id="attendCnt"></span>/<span id="memLimit"></span>)</span>
                        <div class="modalattendlist" data-spy="scroll" data-bs-target="#navbar-example2" data-offset="0" style="padding:0px">
                            <ul class="px-2 pt-1" style=" list-style:none; line-height:1.5rem;" id="attendMember">
                            </ul>
                        </div>
                    </div>
                    <!-- 참석 버튼 -->
                    <button type="button" class="btn btn-secondary mt-2" id="attendBtn" onclick="" style="font-weight:200; padding: 5px 25px; float: right;" ${mm == null || mm.pNo==3 ? "disabled":"" }>참석 하기</button>
                </div>
            </div>
        </div>
    </div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>