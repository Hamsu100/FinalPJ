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
        function addattention() {
            const btnElement = document.getElementById('attentionbtn');
            btnElement.innerText = '관심해제';
            btnElement.className = 'ms-1 btn btn-primary btn-xs ';
        }

        function addjoin() {
            const btnElement = document.getElementById('joinbtn');
            btnElement.innerText = '탈퇴하기';
            btnElement.className = 'btn btn-primary col-11 btn-xs  ';
        }

        function jsChselect(value) {
            if (value == "challenge") {
                document.getElementById("challengeform").style.display = "block";
                document.getElementById("scheduleform").style.display = "none";
            } else if (value == "schedule") {
                document.getElementById("scheduleform").style.display = "block";
                document.getElementById("challengeform").style.display = "none";
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
                    <h1>일정 생성</h1>
                    <hr class="my-1">
                </div>
                <div class="col-12 ms-3">
                    <div class='cal-rap ms-2'>
                        <div class="cal-header ms-2 mb-2">
                            <div class="cal-btn1 cal-prevDay mt-3" style="vertical-align: bottom;"></div>&nbsp
                            <h2 class='cal-dateTitle' style="margin-top: .75rem;"></h2>&nbsp
                            <div class="cal-btn2 cal-nextDay mt-3"></div>
                            <a style="font-size: 2rem; margin-left: 81%; margin-top:.15rem" class="col-auto d-block" data-bs-toggle="modal" data-bs-target="#modal" role="button"><i class="fa-regular fa-square-plus icon-yellow"></i></a>
                        </div>
                        <div class="cal-grid cal-dateHead">
                            <div>
                                <h2 class="mt-2">일</h2>
                            </div>
                            <div>
                                <h2 class="mt-2">월</h2>
                            </div>
                            <div>
                                <h2 class="mt-2">화</h2>
                            </div>
                            <div>
                                <h2 class="mt-2">수</h2>
                            </div>
                            <div>
                                <h2 class="mt-2">목</h2>
                            </div>
                            <div>
                                <h2 class="mt-2">금</h2>
                            </div>
                            <div>
                                <h2 class="mt-2">토</h2>
                            </div>
                        </div>
                        <div class="cal-grid cal-dateBoard"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 누르면 나오는 모달 -->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal" id="modal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="px-3 py-3">
                    <button type="button" class="btn-close" style="float: right;" data-bs-dismiss="modal" aria-label="Close"></button>
                    <!-- 일정 내용 입력 form -->
                    <div class="col-12 mt-2">
                        <table class="tg col-12">
                            <colgroup>
                                <col style="width: 20% ">
                                <col style="width: 80% ">
                            </colgroup>
                            <tr>
                                <td class="schedulecon"> 분류</td>
                                <td class="schedulecon">
                                    <select class=" form-select" onchange="jsChselect(this.value) ">
                                        <option value="schedule" selected>일정</option>
                                        <option value="challenge">도전과제</option>                                   
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- 일정만들기 -->
                    <div class="col-12 " id="scheduleform" >
                        <form action="${path }/moim/addPlan" method="post">
                        <input type="hidden" name="x" id="plX">
                        <input type="hidden" name="y" id="plY">
                            <table class="tg col-12">
                                <colgroup>
                                    <col style="width: 20% ">
                                    <col style="width: 40% ">
                                    <col style="width: 40% ">
                                </colgroup>
                                <tr>
                                    <td class="schedulecon">일정명</td>
                                    <td class="schedulecon" colspan="2 ">
                                        <input class="form-control text-black" type="text" name="plName" id="" required>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulecon">일정 내용</td>
                                    <td class="schedulecon" colspan="2 ">
                                        <textarea class="form-control text-black" name="plCont" style="resize: none;" rows="5" required></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulecon">일정</td>
                                    <td class="schedulecon">
                                        <input class="form-control flatpickr text-black" placeholder="날짜선택하기" type="date" value="" id="" name="plDate" required/>
                                    </td>
                                    <td class="schedulecon">
                                        <input class="form-control text-black " name="time" type="time">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulecon">인원수</td>
                                    <td class="schedulecon " colspan="2 ">
                                        <!-- max는 가입자 수 만큼으로 가능하려나 -->
                                        <input type="number" class="form-control text-black" min="2" max="100" name="limit" id="">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulecon">장소</td>
                                    <td class="schedulecon" colspan="2 ">
                                        <!-- 장소검색 넣어야함 api-->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f94552a40387e551fba3cf26a20572d3&libraries=services"></script>
<script>
function offlocsearch(x,y,name) {
    $('#locsearch').hide();
    $('#plX').val(x);
    $('#plY').val(y);
    $('#areaKeyword').val(name);
    $('#planSubmit').attr('onclick',null);
    $('#planSubmit').attr('type','submit');
    
    
}


function onlocsearch(pp) {
	var keyword = $('#areaKeyword').val();
	if (keyword.length == 0){
		alert('검색어를 적어주세요!!')
		return;
	}
	
    $('#locsearch').show();
    $('#keyowrdText').text(keyword);
    var places = new kakao.maps.services.Places();

    var callback = function(result, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {
	            if (result.length != 0){
	            $('#searchList').empty();
				console.log(result);
				console.log(status);
				console.log(pagination);
	            var resultDiv='';
	            for (var i = 0 ; i < result.length ; i++){
	            	var x = result[i].x;
	            	var y = result[i].y;
	            	var name = result[i].place_name;
	            	resultDiv+='<li>'
	            	+'<a style="cursor:pointer;margin-bottom:1px;font-size:15px" onclick="offlocsearch('+x+','+y+',\''+name+'\');">'// x y name off~())
	            	+'<span class="title ">'+result[i].place_name+'</span>'
	            	+'<span class="loc ">'+result[i].address_name+'</span>'
	            	+'</a>'
	            	+'</li>'
	            }
	            $('#searchList').append(resultDiv);
	            
	            var current =pagination.current;
	            var cnt = pagination.totalCount;
	            var totalPage = Math.ceil(cnt/15);
	            if (totalPage > 1){
	            	var strPage = '';
	            	for (var j = 0 ; j < totalPage ; j++){
	            		if ((j+1) == current){
		            		strPage += '<li class="page-item active"><a class="page-link" id="page'+(j+1)+'" style="cursor:pointer;" onclick="paging('+(j+1)+')">'+(j+1)+'</a></li>';
		            		continue;
	            		}
	            		strPage += '<li class="page-item"><a class="page-link" style="cursor:pointer;" onclick="onlocsearch('+(j+1)+')">'+(j+1)+'</a></li>';
	            	}
	            	$('#paging').html(strPage);
	            	
	            	
	            	
	            }
            } 
        }else{
        	$('#searchList').append('<p>검색 결과가 없습니다.</p>');
        }
        
    };
    var paging={page:1}
	if (pp != null){
		paging.page=pp;
	}
    places.keywordSearch(keyword, callback, paging);
}



</script>
                                        <div class="row">
                                            <input type="text" id="areaKeyword" name="plPlace" class="form-control text-black " style="margin-left: .75rem; width: 80%;">
                                            <button type="button" onclick="onlocsearch()" class="btn btn-primary col-auto ms-1"><i class="fa-solid fa-magnifying-glass" style="font-size:90%"></i></button>
                                        </div>
                                        <input type="hidden" value="경도">
                                        <input type="hidden" value="위도">

                                        <!-- -->
                                        <div id="locsearch" style="border: 1px solid #f2f2f2; border-radius: 5px; display:none " class="mt-1 ">
                                            <div class="px-3 py-2 ">
                                                <span>입력하신 '</span><span id="keyowrdText"></span><span>' 검색 결과</span>
                                                <hr class="my-1 ">
                                                <ul class="locsearch-list " id="searchList">
                                                </ul>
                                            </div>
                                            <ul class="pagination pagination-template d-flex justify-content-center" id="paging">
					                        </ul>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulebtn " colspan="3 ">
                                        <button class="btn btn-secondary btn-xs " id="planSubmit" type="button" onclick="alert('장소를 지정해 주세요!!')">일정만들기</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>

                    <!-- 도전 과제 만들기  -->
                    <div class="col-12 " id="challengeform" style="display:none; ">
                        <form action="${path }/moim/addChal" method="post">
                            <table class="tg col-12 ">
                                <colgroup>
                                    <col style="width: 20% ">
                                    <col style="width: 40% ">
                                    <col style="width: 40% ">
                                </colgroup>
                                <tr>
                                    <td class="schedulecon ">과제명</td>
                                    <td class="schedulecon " colspan="2 ">
                                        <input class="form-control text-black " type="text" name="cTitle" id=" " required>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulecon ">과제내용</td>
                                    <td class="schedulecon " colspan="2 ">
                                        <textarea class="form-control text-black" name="cCont" style="resize: none; " rows="6 " required></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulecon ">과제 기한</td>
                                    <td class="schedulecon ">
                                        <input class="form-control flatpickr text-black" placeholder="날짜선택하기 " type="date" value="" id="" name="cDate" required/>
                                    </td>
                                    <td class="schedulecon ">
                                        <input class="form-control text-black " type="time" name="time">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="schedulebtn " colspan="3">
                                        <button class="btn btn-secondary btn-xs "  type="submit" >도전과제 만들기</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <script>
    $(()=>{
    		var longitude = '';
    		var latitude = '';
    		
	    const makeCalendar = (date) => {
	        // 현재의 년도와 월 받아오기
	        const nowYear = new Date(date).getFullYear();
	        const nowMonth = new Date(date).getMonth() + 1;
	
	        // 지난달의 마지막 요일
	        const prevDay = new Date(nowYear, nowMonth - 1, 1).getDay();
	
	        // 현재 월의 마지막 날 구하기
	        const lastDay = new Date(nowYear, nowMonth, 0).getDate();
	
	        // 남은 박스만큼 다음달 날짜 표시
	        const limitDay = prevDay + lastDay;
	        const nextDay = Math.ceil(limitDay / 7) * 7;
	
	        let htmlDummy = '';
	
	        // 전달 날짜 표시하기
	        for (let i = 0; i < prevDay; i++) {
	            htmlDummy += '<div class="cal-noColor"></div>';
	        }
	
	        // 현재 날짜 표시하기
	        for (let i = 1; i <= lastDay; i++) {
	            htmlDummy += '<div id="current'+i+'">'+i+'</div>';
	        }
	
	        // 다음달 날짜 표시하기
	        for (let i = limitDay; i < nextDay; i++) {
	            htmlDummy += '<div class="cal-noColor"></div>';
	        }
			console.log(nowYear);
			console.log(nowMonth);
	        document.querySelector('.cal-dateBoard').innerHTML = htmlDummy;
	        document.querySelector('.cal-dateTitle').innerText = nowYear+'년 '+ nowMonth+'월';
	    }


	    const date = new Date();
	
	    makeCalendar(date);
	
	    // 이전달 이동
	    document.querySelector('.cal-prevDay').onclick = () => {
	        var ym = new Date(date.setMonth(date.getMonth()-1))
	        makeCalendar(ym);
	        
	        $.ajax({
				type:'get',
				url:'${path}/moim/planList',
				dataType : 'json',
				data:{'month':ym},
				async:false,
				success : (list)=>{
					inputPlan(list);
				},
				error : (e)=>{
					console.log(e);
				}
			})
			$.ajax({
				type:'get',
				url:'${path}/moim/chalList',
				dataType : 'json',
				data:{'month':ym},
				async:false,
				success : (list)=>{
					inputChal(list);
				},
				error : (e)=>{
					console.log(e);
				}
			})
	    }
	
	    // 다음달 이동
	    document.querySelector('.cal-nextDay').onclick = () => {
	    	var ym = new Date(date.setMonth(date.getMonth()+1))
	        makeCalendar(ym);
	        
	        $.ajax({
				type:'get',
				url:'${path}/moim/planList',
				dataType : 'json',
				data:{'month':ym},
				async:false,
				success : (list)=>{
					inputPlan(list);
				},
				error : (e)=>{
					console.log(e);
				}
			})
			$.ajax({
				type:'get',
				url:'${path}/moim/chalList',
				dataType : 'json',
				data:{'month':ym},
				async:false,
				success : (list)=>{
					inputChal(list);
				},
				error : (e)=>{
					console.log(e);
				}
			})
	    }
	    
	    
	    function inputPlan(arr){
	        for (let i = 0;i<arr.length; i++){
	        	console.log(arr);
	        	var time = new Date(arr[i].plDate);
	            var plNo = arr[i].plNo;
	            var day=time.getDate();
	            var gname = arr[i].gname;
	            var plCont = arr[i].plCont;
	            var plTitle = arr[i].plTitle;
	            var memCnt = arr[i].memCnt;
	            var getHour= time.getHours()+' : '+time.getMinutes();
	            var plTag = '<br><span style="color : skyblue">제목 - '+plTitle+'<br>'
	                    +'시간 - '+getHour+'<br>'
	                    +'참석자 수 - '+memCnt+'</span>';
	            
	            var div = document.getElementById("current"+day);
	            div.innerHTML += plTag;
	        }
	    }

    	function inputChal(arr){
	        for (let i = 0;i<arr.length; i++){
	        	var time = new Date(arr[i].cDate);
	            var cNo = arr[i].cNo;
	            var day = time.getDate();
	            var getHour= time.getHours()+' : '+time.getMinutes();
	            var gName = arr[i].gName;
	            var cCont = arr[i].cCont;
	            var cTitle = arr[i].cTitle;
	            var cTag = '<br><span style="color:red">제목 - '+cTitle+'<br>'
                +'시간 - '+getHour+'<br>'
			
	            var div = document.getElementById("current"+day);
	            div.innerHTML += cTag;
	        }
	    }
    	
    
	    $.ajax({
			type:'get',
			url:'${path}/moim/planList',
			dataType : 'json',
			success : (list)=>{
				inputPlan(list);
			},
			error : (e)=>{
				console.log(e);
			}
		})
		$.ajax({
			type:'get',
			url:'${path}/moim/chalList',
			dataType : 'json',
			success : (list)=>{
				console.log(list)
				inputChal(list);
			},
			error : (e)=>{
				console.log(e);
			}
		})
		
		
    })
    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>