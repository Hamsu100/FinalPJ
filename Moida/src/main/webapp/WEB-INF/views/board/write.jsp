<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script>
		function changeSelect(){
			var select = $('#cat option:selected').val();
			if (select == 5){
				$.ajax({
					type:'get',
					url:'${path}/board/chalList',
					data : {'gNo' : ${gNo}},
					dataType : 'json',
					success : (list) => {
						var str = '<select class="form-select " id="cSelect" name="cNo" style="width:20%;display:inline-block">'
									+'<option>도전 과제</option>';
						for (var i = 0 ; i < list.length ; i++){
							str += '<option value="'+list[i].cNo+'">'+ list[i].cTitle+'</option>'
						}
		                str += '</select>';
						$('#sDiv').append(str);
					},
					error : (e) => {
						console.log(e);
					}
				});
			} else {
				$('#cSelect').remove();
			}
		}
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
		$(()=>{
			if(${bcNo} == 5){
				console.log($('#cat option:selected').val());
				changeSelect();
			}
		})
</script>
<section class="container">
        <div class="row">
            <!-- 사이드바 -->
            <div class="flex-shrink-0 bg-white sidebar" style="width: 200px;">
                <!-- 프로필 사진 + 관심 + 모임명 + 한줄소개 + 가입버튼 -->
                <div class="text-center mt-2">
                    <a href="${path}/moim?gNo=${gNo }"><span class="avatar avatar-xxl " id="moimImg"> </span></a>
                    <div class="mt-2 mb-2">
                        <span style=" font-size: 90%;" id="favorCnt"><i class="fa-solid fa-heart icon-coral "></i>&nbsp;</span>
                        <button type="button" data-bs-toggle="button" autocomplete="off" id="attentionbtn" class="ms-1 btn btn-outline-primary btn-xs" onclick='addattention()'>관심추가</button>
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
            <!-- 사이드 바 끝-->
            <!-- 사이드 바 옆 내용 섹션-->
            <div class="col-10">
                <div class="mt-4 ms-3">
                    <h1> 게시판 작성</h1>
                    <hr class="my-3">
                </div>
                
                <div class="ms-3">
                    <form role="form" action="${path }/board/write" method="post" id="writeForm" class="">
	                    <div class="my-3" id="sDiv">
		                    <select class="form-select me-2 " onchange="changeSelect()" id="cat" name="bcNo" style="width:20%; display:inline-block">
		                        <option> 게시판 선택</option>
		                        <c:if test="${mm.lNo < 3 }">
		                        <option value="1" ${bcNo == "1" ? "selected" : "" }>공지사항</option>
		                        </c:if>
		                        <option value="2" ${bcNo == "2" ? "selected" : "" }>자유게시판</option>
		                        <option value="3" ${bcNo == "3" ? "selected" : "" }>사진게시판</option>
		                        <option value="4" ${bcNo == "4" ? "selected" : "" }>정모후기</option>
		                        <option value="5" ${bcNo == "5" ? "selected" : "" }>도전인증</option>
		                    </select>
	                	</div>
                        <div class="my-3">
                            <div class="col-12 mb-3">
                                <input type="text" class="form-control" name="bTitle" autocomplete="off" id="title" placeholder="제목" required>
                            </div>
                            <textarea rows="" cols="" id="summernote" name="content"></textarea>
                            <input type="hidden" name="fileName" value=""/>
                            <div class="mt-2 offset-9-1">
                                <button class="btn btn-secondary offset-2" type="submit" style="padding: 9px 20px; font-weight:200;">등록</button>
                                <button class="btn btn-outline-primary" type="button" style="padding: 9px 20px; font-weight:200;" onclick="cancel()"> 취소 </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
	<script>
		$('#summernote').summernote({
        	placeholder: '내용을 입력하시오',
        	tabsize: 2,
			height: 500,
			disableResizeEditor: true,
			
			toolbar: [
			    ['style', ['style']],
			    ['font', ['bold', 'underline', 'clear']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['table', ['table']],
			    ['insert', ['link', 'picture', 'video']],
			    ['view', ['fullscreen', 'codeview', 'help']]
			],
			callbacks :{
				onImageUpload : function(files, editor, welEditable) {
			        // 파일 업로드(다중업로드를 위해 반복문 사용)
			for (var i = files.length - 1; i >= 0; i--) {
			          	uploadSummernoteImageFile(files[i], this);
			  		}
			  	}
			}
		});
      
		function uploadSummernoteImageFile(file, el) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : "${path}/board/upload",
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(data) {
					console.log(data);
					$(el).summernote('editor.insertImage', data.url);
					$('#writeForm').append('<input type="hidden" name="fileName" value='+data.fileName+'/>');
				},
				error : (e)=>{
					console.log(e);
				}
			});
		}
      	function cancel(){
      		var textarea = $('#summernote').val();
      		location.href="${path}/board/list?bcNo=${bcNo}";
      		
      	}
	</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>