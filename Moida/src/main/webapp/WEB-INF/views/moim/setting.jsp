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
		
		function invite(uNo) {
			location.href = '${path}/moim/inviteMember?uNo='+uNo
		}
		
		 function readURL1(input) {
	            if (input.files && input.files[0]) {
	                var reader = new FileReader();
	                reader.onload = function(e) {
	                    console.log(e)
	                    document.getElementById('preview').style.backgroundImage = "url(" + e.target.result + ")";
	                };
	                reader.readAsDataURL(input.files[0]);
	            } else {
	                document.getElementById('preview').style.backgroundImage = "url()";
	            }
	        }

	        function readURL2(input) {
	            if (input.files && input.files[0]) {
	                var reader = new FileReader();
	                reader.onload = function(e) {
	                    console.log(e)
	                    document.getElementById('preview2').style.backgroundImage = "url(" + e.target.result + ")";
	                };
	                reader.readAsDataURL(input.files[0]);
	            } else {
	                document.getElementById('preview2').style.backgroundImage = "url()";
	            }
	        }
		</script>
<section class="container">
        <div class="row">
            <!-- 사이드바 -->
            <div style="width: 200px; height: 1000px">
                <div class="flex-shrink-0 bg-white sidebar" style="width: 200px;">
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
                <!-- 제목 -->
                <div class="mt-4 ms-3">
                    <h1> 모임 설정</h1>
                    <hr class="my-3">
                    <div class="settingbox">
                   <form action="${path }/moim/setting" method="post" enctype="multipart/form-data">
                        <table class="tg">
                            <colgroup>
                                <col style="width: 20%">
                                <col style="width: 80%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <td class="setting-1 ">모임명</td>
                                    <td class="setting-2"> <input class="form-control text-black" value="${m.gName }" style="font-size: 20px;" type="text" name="gName" id="" required></td>
                                </tr>
                                <tr>
                                    <td class="setting-1 ">한 줄 소개</td>
                                    <td class="setting-2"> <input class="form-control text-black" value="${m.gShort }" style="font-size: 18px;" type="text" name="gShort" id="" required></td>
                                </tr>
                                <tr>
                                    <td class="setting-1 ">소개글</td>
                                    <td class="setting-2"><textarea class="form-control text-black" name="gIntro" style="resize: none; font-size: 18px;" cols="105" rows="5" required>${m.gIntro }</textarea></td>
                                </tr>
                                <tr>
                                    <td class="setting-3" colspan="2">
                                        <div>
                                            <h2 class="ms-5">썸네일</h2>
                                            <div class="filebox" style="text-align: center; ">
                                                <label for="thumb">
                                                        <img id="preview" style="width:300px; height: 300px; background-image: url(${path}/resources/upload/moim/${m.gThumbRen }); background-size: cover; background-position:center; ">
                                                    </label>
                                                <input type="file" name="thumb" id="thumb" style="display: none " onchange="readURL1(this) ">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="setting-3" colspan="2">
                                        <div>
                                            <h2 class="ms-5">커버 사진</h2>
                                            <div class="filebox my-4 " style="text-align: center; ">
                                                <label for="cover">
                                                        <img id="preview2" style="width:950px; height: 300px; background-image: url(${path}/resources/upload/moim/${m.gCoverRen }); background-size: cover; background-position:center; ">
                                                    </label>
                                                <input type="file" name="cover" id="cover" style="display: none " onchange="readURL2(this) ">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="setting-2 " colspan="2">
                                        <h2 class="ms-5"> 가입 질문 설정</h2>
                                        <div>
                                            <h3 class="ms-5 "> 1. 첫번째 가입 질문을 입력하세요</h3>
                                            <textarea class="form-control text-black ms-5 " name="gQ1"  style="resize: none; font-size: 18px; width: 990px;" cols="55" rows="3" required>${m.gQ3 }</textarea>
                                        </div>
                                        <div>
                                            <h3 class="ms-5 mt-2"> 2. 두번째 가입 질문을 입력하세요</h3>
                                            <textarea class="form-control text-black ms-5" name="gQ2" style="resize: none; font-size: 18px; width: 990px" cols="55" rows="3" required>${m.gQ3 }</textarea>
                                        </div>
                                        <div>
                                            <h3 class="ms-5 mt-2"> 3. 세번째 가입 질문을 입력하세요</h3>
                                            <textarea class="form-control text-black ms-5" name="gQ3" style="resize: none; font-size: 18px; width: 990px" cols="55" rows="3" required>${m.gQ3 }</textarea>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="setting-4" colspan="2">
                                        <div>
                                            <h3 class="ms-5">가입신청 설정 </h3>
                                            <input type="radio" class="btn-check " name="apply" id="apply_accept" value="Y" autocomplete="off" checked>
                                            <label class="btn btn-outline-success col-auto ms-5 mb-2" style="padding: 3px 25px;" for="apply_accept">가입 신청 가능</label>
                                            <input type="radio" class="btn-check" name="apply" id="apply_deny" value="N" autocomplete="off">
                                            <label class="btn btn-outline-danger  col-auto ms-5 mb-2" style="padding: 3px 25px;" for="apply_deny">가입 신청 불가</label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="setting-but" colspan="2">
                                        <button class="btn btn-secondary mx-3 col-auto " type="submit" style="font-size: 15px;">변경사항 저장</button>
                                        <button class="btn btn-primary mx-3 col-auto" type="reset" style="font-size: 15px;">취소</button>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                        </form>
                    </div>
                    
                    <c:if test="${mm.lNo==1 }">
                    <div class="disbandingbox mt-5">
                        <h2> 모임 해체</h2>
                        <h3> 모임 해체는 모임원이 한명도 없을 때 가능합니다. <br> 모임 해체 시 취소가 불가능 합니다 .</h3>
                        <div class="setting-but">
                            <button class="btn btn-danger mx-3 col-auto text-end d-inline-block" type="button" onclick="location.href='${path}/moim/delMoim'" style="font-size: 20px;">모임 해체</button>
                        </div>
                    </div>
                    </c:if>
                </div>
            </div>
        </div>

    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>