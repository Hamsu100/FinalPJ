<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>

    <section class="container">
        <div class="row">
            <!-- 사이드바 -->
            <div class=" bg-white sidebar col-2" style="width: 200px; height: 400px">
                <!-- 프로필 사진 + 닉네임 -->
                <jsp:include page="/WEB-INF/views/user/sidebar.jsp"/>
            </div>
            <!-- 사이드 바 끝-->
            <!-- 사이드 바 옆 내용 섹션-->
            <div class="col-10">
                <!-- 제목 -->
                <div class="mt-4 ms-2">
                    <h1> 내 일정 관리</h1>
                    <hr class="my-3">
                </div>
                <!-- 달력 -->
                <div class="col-12 ms-3">
                    <div class='cal-rap'>
                        <div class="cal-header ms-2 mb-2">
                            <div class="cal-btn1 cal-prevDay mt-3" style="vertical-align: bottom;"></div>&nbsp
                            <h2 class='cal-dateTitle' style="margin-top: .75rem;"></h2>&nbsp
                            <div class="cal-btn2 cal-nextDay mt-3"></div>
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
                <hr class="ms-3">
                <!-- 상세보기 -->
                <div class="col-12 ms-3">
                    <h2>상세 보기</h2>
                    <hr>
                    <!-- 일정 -->
                    <div class="col-12" id="schedule" style="display:none">
                        <div class="row">
                            <div class="col-7">
                                <!-- 일정 명 -->
                                <h2 id="planTitle"></h2>
                                <hr class="mt-n2">
                                <!-- 모임명 -->
                                <h3 class="mt-n2 mb-n1" id="moimName"></h3>
                                <!-- 날짜 -->
                                <span class="text-gray-700 mt-n1" id="planDate"></span>
                                <!-- 일정 내용 -->
                                <div class="px-2 schedulelist" data-spy="scroll" data-offset="0">
                                    <h3 id="planContent">
                                    </h3>
                                </div>
                                <!-- 위치랑 지도 -->
                                <div>
                                    <span class="text-black fs-3 mt-n1" id="planPlace"><i class="fa-solid fa-location-pin icon-coral"></i></span>
                                    <div id="map" style="height:200px; width:100%;"></div>
                                    
                                </div>
                                <!-- 버튼 -->
                                <div class="my-2">
                                    <button type="button" class="btn btn-primary" id="cancelBtn">  참석 취소  </button>
                                </div>
                            </div>
                            <div class="col-5 ">
                                <div class="pt-3 px-2">
                                    <span class="fs-3">참석인원 : <span><span id="memCnt"></span>/<span id="limit"></span></span> </span>
                                </div>
                                <div class="px-2">
                                    <!-- 인원 보여주기 -->
                                    <div class="myschedule col-8" data-spy="scroll" data-offset="0">
                                        <table class="tg col-12">
                                            <tbody id="memName">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 도전과제(cNo로 검색하는거) -->
                    <div class="col-12" id="challenge" style="display:none">
                        <div class="col-7 ">
                            <!-- 도전과제 명 -->
                            <h2 id="cName"></h2>
                            <hr class="mt-n2 ">
                            <!-- 모임명 -->
                            <h3 class="mt-n2 mb-n1 " id="cmName"></h3>
                            <!-- 날짜 -->
                            <span class="text-gray-700 mt-n1 " id="cDate"></span>
                            <!-- 도전과제 내용 -->
                            <div class="px-2 schedulelist " data-spy="scroll " data-offset="0 ">
                                <h3 id="cContent">
                                </h3>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f94552a40387e551fba3cf26a20572d3"></script>
    <script>
    function member(plNo){
    	$.ajax({
    		type:'get',
    		url:'${path}/user/planMember',
    		data : {plNo},
    		dataType:'json',
    		success : (list) =>{
    			console.log(list);
    			var str = '';
    			for (var i = 0 ; i < list.length ; i++){
    				str += '<tr>'
			                    +'<th class="myschedulename">'+list[i].unick+'</th>'
			                    +'<th class="myschedulegender">'+list[i].ugender+'</th>'
			                    +'<th class="myscheduleage">'+list[i].uage+'</th>'
		                	+'</tr>';
    			}
    			$('#memName').html(str);
    		},
    		error:(e)=>{
    			console.log(e);
    		}
    	})
    }
    const plDetail = (plNo)=>{
		$.ajax({
			type:'get',
			url:'${path}/user/planDetail',
			data : {plNo},
			dataType : 'json',
			success : (data)=>{
				onschedule();
				var date = new Date(data.plDate)
				console.log(plNo)
				$('#planTitle').text(data.plTitle);
				$('#moimName').text(data.gName);
				$('#planDate').text(date.getFullYear()+'/'+(date.getMonth()+1)+'/'+date.getDate()+' ' + date.getHours()+':'+date.getMinutes());
				$('#planContent').text(data.plCont);
				$('#planPlace').text(data.plPlace);
				$('#limit').text(data.plMemLimit);
				$('#memCnt').text(data.memCnt)
				longitude=data.plX;
				latitude=data.plY;
				console.log();
				console.log();
				member(plNo);
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
				$('#cancelBtn').attr('onclick','location.href="${path}/plan/cancel?plNo='+data.plNo+'"')
			},
			error : (e) => {
				console.log(e);
			}
		});
	}
    
	const cDetail = (cNo) =>{
		$.ajax({
			type:'get',
			url:'${path}/user/cDetail',
			data:{cNo},
			dataType:'json',
			success : (data)=>{
				var date = new Date(data.cDate)
				onchallenge();
				$('#cName').text(data.cTitle);
				$('#cmName').text(data.gName);
				$('#cDate').text(date.getFullYear()+'/'+(date.getMonth()+1)+'/'+date.getDate());
				$('#cContent').text(data.cCont);
			},
			error : (e)=> {
				console.log(e);
			}
		})
	}
	function onchallenge() {
           $('#challenge').show();
       }

       function onschedule() {
           $('#schedule').show();
       }
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
	
	        document.querySelector('.cal-dateBoard').innerHTML = htmlDummy;
	        document.querySelector('.cal-dateTitle').innerText = nowYear+ '년 ' +nowMonth+'월';
	    }


	    const date = new Date();
	
	    makeCalendar(date);
	
	    // 이전달 이동
	    document.querySelector('.cal-prevDay').onclick = () => {
	    	var ym = new Date(date.setMonth(date.getMonth()-1))
	        makeCalendar(ym);
	        
	        $.ajax({
				type:'get',
				url:'${path}/user/planList',
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
				url:'${path}/user/chalList',
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
				url:'${path}/user/planList',
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
				url:'${path}/user/chalList',
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
	            var plNo = arr[i].plNo;
	            var day=new Date(arr[i].plDate).getDate();
	            var gname = arr[i].gName;
	            var plCont = arr[i].plCont;
	            var plTitle = arr[i].plTitle;
	        
	            var plTag = '<a onclick="plDetail('+plNo+');" style="color:skyblue;cursor:pointer"><p style="margin:0">모임명 : '+gname+'</p>'
	                    +'<p>일정명 : '+plTitle+'</p></a>'
	            
	            var div = document.getElementById("current"+day);
	            div.innerHTML += plTag;
	        }
	    }

    	function inputChal(arr){
	        for (let i = 0;i<arr.length; i++){
	            var cNo = arr[i].cNo;
	            var day = new Date(arr[i].cDate).getDate();
	            var gName = arr[i].gName;
	            var cCont = arr[i].cCont;
	            var cTitle = arr[i].cTitle;
	            var cTag = '<a onclick="cDetail('+cNo+');" style="color:red;cursor:pointer"><p style="margin:0">모임명 : '+gName+'</p>'
	            +'<p>일정명 : '+cTitle+'</p></a>'
			
	            var div = document.getElementById("current"+day);
	            div.innerHTML += cTag;
	        }
	    }
    	
    
	    $.ajax({
			type:'get',
			url:'${path}/user/planList',
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
			url:'${path}/user/chalList',
			dataType : 'json',
			success : (list)=>{
				inputChal(list);
			},
			error : (e)=>{
				console.log(e);
			}
		})
		
		
    })
    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>