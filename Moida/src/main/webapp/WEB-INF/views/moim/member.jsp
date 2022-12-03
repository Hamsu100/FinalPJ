<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>
<!-- 사이드바 + 내용 -->

<script>
		// 관심 추가 해제 ajax
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
		function sendMsg(uNo){
			location.href = '${path}/msg/send?uNo='+uNo;
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
		
		function punish(uNo, uNick, pNo){
			if (pNo != 0){
				location.href="${path}/moim/depunish?uNo="+uNo				
			} else{
				console.log(uNo,uNick)
				$('#pId').text(uNick);
				$('#puNo').prop('value',uNo);
			}
		}
		
		function ban(uNo, uNick){
			$('#buNo').prop('value',uNo);
			$('#bNick').text(uNick);
		}
</script>
    <section class=" container">
        <div class="row">
            <!-- 사이드바 -->
            <div style="width: 200px; height: 1000px">
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
            <div class="col-10">
                <div class="mt-4 ms-3">
                    <h1> 인원 관리</h1>
                    <hr class="my-3">
                </div>
                <div class="col-12 ms-3">
                    <!-- 모임장 위임 -->
                    <c:if test="${mm.lNo ==1 }">
                    <div class="listsetbox col-12">
                        <h2 class="ms-2 mt-3">모임장 위임</h2>
                        <hr class="my-2">
                        <div class="ms-4">
                            <form class="col-12 mb-2 row align-items-center " action="${path }/moim/changeLeader" method="post">
                                <select class="selectpicker" data-live-search="true" data-width="fit" name="leaderName">
                                	<c:forEach var="m" items="${m }" varStatus="status">
                                    <option value="${m.uNo }">${m.uNick }</option>
                                    </c:forEach>
                                </select>
                                <div class="col-auto">
                                    에게 모임장을 위임합니다
                                </div>
                                <button class="btn btn-secondary col-auto offset-7 " type="submit">확인</button>
                            </form>
                        </div>
                    </div>

                    <hr>
					</c:if>
                    <div class="col-12">
                        <h2 class="my-2 ms-2 "> 인원목록</h2>

                        <div class="col-12 ms-2 ">
                            <form action="${path }/moim/updateLv" method="post">
                                <table class="tg " style="width: 100% ">
                                    <colgroup>
                                        <col style="width: 5% ">
                                        <col style="width: 15% ">
                                        <col style="width: 10% ">
                                        <col style="width: 10% ">
                                        <col style="width: 25% ">
                                        <col style="width: 15% ">
                                        <col style="width: 10% ">
                                        <col style="width: 10% ">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th class="listset ">NO</th>
                                            <th class="listset ">닉네임</th>
                                            <th class="listset ">나이</th>
                                            <th class="listset ">성별</th>
                                            <th class="listset ">징계내용</th>
                                            <th class="listset ">등급</th>
                                            <th class="listset ">징계</th>
                                            <th class="listset ">추방</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="m" items="${mem }" varStatus="status">
                                    	
                                        <tr>
                                            <td class="listset1 ">${status.count }</td>
                                            <td class="listset3 ">${m.uNick }</td>
                                            <td class="listset1 ">${m.uAge }</td>
                                            <td class="listset3 ">${m.uGender }</td>
                                            <td class="listset1 ">${m.mgCont }</td>
											<c:if test="${m.lNo == 1 }">                                            
                                            <td class="listset3 ">${m.lName }</td>
                                            <td class="listset1 "></td>
                                            <td class="listset3 "></td>
                                            </c:if>
                                            <c:if test="${m.lNo != 1 }">
                                            <input type="hidden" name="uNo" value="${m.uNo }">
                                            	<c:if test="${mm.lNo == 1 }">
											<td class="listset3 ">
                                                <select class="form-select" name="lNo">
                                                    <option value="2" ${m.lNo == 2 ? "selected":"" }>운영진</option>
                                                    <option value="3" ${m.lNo == 3 ? "selected":"" }>일반회원</option>
                                                </select>
                                                <td class="listset1 ">
                                                <button type="button" class="btn btn-secondary btn" data-bs-toggle="modal" data-bs-target="#Punishment" onclick="punish('${m.uNo}','${m.uNick}','${m.pNo }');"> 징계${m.pNo != 0 ? "해제":"" } </button>

                                            </td>
                                            <td class="listset3 ">
                                                <button type="button" class="btn btn-primary btn " data-bs-toggle="modal" data-bs-target="#exile" onclick="ban('${m.uNo}','${m.uNick }')"> 추방 </button>
                                            </td>
                                            </td>
                                            
                                            	</c:if>
                                            	<c:if test="${mm.lNo != 1 }">
                                            <td class="listset3 ">${m.lName }</td>
                                            
                                            	<c:if test="${m.lNo==2 }">
                                            <td class="listset1 "></td>
                                            <td class="listset3 "></td>
                                            	</c:if>
                                            	<c:if test="${m.lNo !=2 }">
                                            <td class="listset1 ">
                                                <button type="button" class="btn btn-secondary btn" data-bs-toggle="modal" data-bs-target="#Punishment" onclick="punish('${m.uNo}','${m.uNick }');"> 징계 </button>

                                            </td>
                                            <td class="listset3 ">
                                                <button type="button" class="btn btn-primary btn " data-bs-toggle="modal" data-bs-target="#exile" onclick="ban('${m.uNo}','${m.uNick }')"> 추방 </button>
                                            </td>
                                            	</c:if>
                                            	</c:if>
                                            
                                            </c:if>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <div class="mt-3 offset-9">
                                	<c:if test="${mm.lNo == 1 }">
                                    <button class="btn btn-secondary offset-2" type="submit">변경사항 저장</button>
                                    <button class="btn btn-primary" type="reset">취소</button>
                                    </c:if>
                                </div>

                            </form>

                            <div aria-label="navigation example " class="mt-2 ">
                                <ul class="pagination pagination-template d-flex justify-content-center ">
                                    <li class="page-item ">
                                        <a class="page-link " href="# "> <i class="fa fa-angle-left "></i></a>
                                    </li>
                                    <li class="page-item active "><a class="page-link " href="# ">1</a></li>
                                    <li class="page-item "><a class="page-link " href="# ">2</a></li>
                                    <li class="page-item "><a class="page-link " href="# ">3</a></li>
                                    <li class="page-item "><a class="page-link " href="# ">4</a></li>
                                    <li class="page-item "><a class="page-link " href="# ">5</a></li>
                                    <li class="page-item ">
                                        <a class="page-link " href="# "> <i class="fa fa-angle-right "></i></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- 징계 모달 -->
                    <div class="modal fade" id="Punishment" tabindex="-1 " role="dialog " aria-labelledby="PunishmentTitle" aria-hidden="true ">
                        <div class="modal-dialog modal-dialog-centered modal-lg" role="document ">
                            <div class="modal-content ">
                                <div class="modal-header " style="border-bottom: none; ">
                                    <h2 class="modal-title " id="PunishmentTitle"> 징계</h2>
                                    <button type="button" class="btn-close ms-n5" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body " style="border-bottom: none; ">
                                    <form action="${path }/moim/punish" method="post">
                                        <div class="row">
                                            <h4 class="col-auto mt-2">징계 인원 : </h4>
                                            <div class="col-6" style="border:1px solid gray;">
                                                <h4 class="mt-2" id="pId"></h4>
                                            </div>
											<input type="hidden" name="puNo" id="puNo" value="">
                                            <h4 class="col-auto mt-2">징계단계: </h4>
                                            <select class="form-select" name="pNo" style="width:20%">
                                                <option value="1">댓글 금지</option>
                                                <option value="2">댓글 + 게시글 금지</option>
                                                <option value="3">댓글 + 게시글 + 참석 금지</option>
                                            </select>
                                        </div>
                                        <div class="my-3 ">
                                            <textarea class="form-control h25" name="mgCont" style="resize:none;" rows="10" id="message" placeholder="징계 사유를 적어주세요" required></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-secondary offset-10-1">징계 결정</button>
                                    </form>
                                </div>
                                <div class="modal-footer mt-n5 " style=" border-top:none; height:5px "> </div>
                            </div>
                        </div>
                    </div>
                    <!-- 추방 모달 -->
                    <div class="modal fade " id="exile" tabindex="-1 " role="dialog " aria-labelledby="exileTitle " aria-hidden="true ">
                        <div class="modal-dialog modal-dialog-centered modal-lg " role="document ">
                            <div class="modal-content ">
                                <div class="modal-header  " style="border-bottom: none; ">
                                    <h2 class="modal-title" id="exileTitle "> 추방</h2>
                                    <button type="button" class="btn-close ms-n5" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body" style="border-bottom: none; ">
                                    <form action="${path }/moim/ban" method="post">
                                    <input type="hidden" id="buNo" name="buNo">
                                        <div class="row">
                                            <h4 class="col-auto mt-2">추방 인원 : </h4>
                                            <div class="col-6" style="border:1px solid gray;" >
                                                <h4 class="mt-2" id="bNick"></h4>
                                            </div>
                                        </div>
                                        <div class="my-3 ">
                                            <textarea class="form-control h25" name="banText" style="resize:none;" rows="10" id="message" placeholder="추방 사유를 적어주세요" required></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-secondary offset-10-1">추방결정</button>
                                    </form>
                                </div>
                                <div class="modal-footer mt-n5 " style=" border-top:none; height:5px "> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>