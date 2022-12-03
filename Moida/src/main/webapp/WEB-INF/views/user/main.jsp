<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Moida" name="title"/>
</jsp:include>
<style>
	ul li {
	    margin-bottom: 1px;
	}
</style>

<script>
$(()=>{
	function getBoard(gNo){
		var arr = [];
		$.ajax({
			type:'get',
			url : '${path}/user/myBoard',
			data : {gNo},
			async : false,
			dataType : 'json',
			success:(list)=>{
				arr=list;
			},
			error :(e) => {
				console.log(e)
			}
		})
		return arr;
	}
	
	$.ajax({ // 메인 모임 + 보드 글
		type: 'get',
		url:'${path}/user/myGroup',
		dataType:'json',
		success:(list)=>{
			
			if (list.length ==0){
				$('#myMoimList').append('<tr><td style="width:100%; text-align:center;font-size:20px;">조회된 모임이 없습니다.</td></tr>');
				return;
			}
			
			var str = '';
			
			for (var i = 0 ; i < list.length ; i++){
				var bList = getBoard(list[i].gNo);
				str += '<tr>'
						+'<td class="loginmain" rowspan="2">'
							+'<div class="bg-cover loginmainimg" style="background-image:url(${path}/resources/upload/moim/'+list[i].gThumbRen+'); border-radius: 10px;"></div>'
						+'</td>'
						+'<td class="loginmain" style="padding-left:15px;">'
							+'<a href="${path}/moim?gNo='+list[i].gNo+'"><h3 class="mb-n1 px-2" style="font-size:220%">'+list[i].gName+'</h3></a>'
							+'<p class="mb-n2 px-2" style="font-size:120%">멤버 '+list[i].memCnt+' | '+list[i].uNick+'</p>'
						+'</td>'
					+'</tr>';
				str += '<tr>'
				        +'<td class="loginmain" style="padding-left:15px;">'
			            	+'<ul class="mainboard-list ms-1" style="font-size:120%;">'
			            	
			    if (Array.isArray(bList) == false || bList.length == 0){
			    	str+='<p style="text-align:center;">조회된 게시글이 없습니다.</p>'
			    } else{
					for (var j=0; j<bList.length ; j++) {
						var date = new Date(bList[j].bMdf);
						var dateForm = new Intl.DateTimeFormat('kr').format(date);
						str +='<li>'
			                    +'<a href="${path}/board/detail?gNo='+list[i].gNo+'&bNo='+bList[j].bNo+'">'
			                        +'<span class="title " style="font-size:20px;width:250px;">'+bList[j].bTitle+'</span>'
			                        +'<span class="date" style="padding-right: 15px; font-size:15px;">'+bList[j].uNick+'<span class="text-muted" style="margin-left:5px;">'+dateForm+'</span></span>'
			                    +'</a>'
			                +'</li>';
					}
			    }
			    str += '</ul>'
		        	+'</td>'
	    		+'</tr>';
			}
    		$('#myMoimList').append(str);
		},
		error : (e)=>{
			console.log(e);
		}
	});
	
	$.ajax({
		type:'get',
		url : '${path}/user/recommand',
		dataType : 'json',
		async : false,
		success : (list)=>{
			
			if (Array.isArray(list) && list.length==0){
				$('#rec').append('<p style="font-size:20px;width:100%; text-align:center">조회된 모임이 없습니다.</p>');
				return;
			}
			var mm ='';
			for (var i = 0 ; list.length ; i++){
				if (list[i] == null){
					break;
				}
				mm += '<table class="tg loginmaintable col-12 mt-2 px-2">'
				            +'<tbody>'
				                +'<tr>'
				                    +'<td class="loginmain">'
				                        +'<a href="${path}/moim?gNo='+list[i].gNo+'">'
				                            +'<h2 class="ms-2 mt-2 ">'+list[i].gName+'</h2>'
				                            +'<p class="my-n2 px-2 text-black">멤버'+list[i].memCnt+' | '+list[i].uNick+'</p>'
				                        +'</a>'
				                    +'</td>'
				                    +'<td class="loginmain" rowspan="2">'
				                        +'<div class="bg-cover loginmainimg2" style="background-image:url(${path}/resources/upload/moim/'+list[i].gThumbRen+');"></div>'
				                    +'</td>'
				                +'</tr>'
				                +'<tr>'
				                    +'<td>'
				                        +'<p class="loginmainp ps-2 mb-n2" style="width: 275px; font-size:120%">'
				                        	+list[i].gIntro
				                        +'</p>'
				                    +'</td>'
				                +'</tr>'
				            +'</tbody>'
				        +'</table>';
			}
			$('#rec').append(mm);
		},
		error : (e) =>{
			console.log(e);
		}
	})
	
})
</script>
<section class="container">
        <div id="loginmainhero" class="carousel slide carousel-fade" data-bs-ride="carousel">
            <ol class="carousel-indicators">
                <li data-bs-target="#loginmainhero" data-bs-slide-to="0" class="active"></li>
                <li data-bs-target="#loginmainhero" data-bs-slide-to="1"></li>
                <li data-bs-target="#loginmainhero" data-bs-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="bg-cover loginmain-hero mt-2 " style="background-image:url(${path}/resources/images/e.jpg); "></div>
                    <div class="carousel-caption d-none d-md-block text-center">
                        <h1 style="color:white; letter-spacing:10px" class="mt-n18 fs-1">모이면 모일 수록 더욱 커지는 즐거움</h1>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="bg-cover loginmain-hero mt-2 " style="background-image:url(${path}/resources/images/f.jpg); "></div>
                    <div class="carousel-caption d-none d-md-block">
                        <h1 style="color:white; letter-spacing:10px" class="mt-n18 fs-1">우리 모두 지금 여기</h1>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="bg-cover loginmain-hero mt-2 " style="background-image:url(${path}/resources/images/g.jpg); "></div>
                    <div class="carousel-caption d-none d-md-block">
                        <h1 style="color:white; letter-spacing:10px" class="mt-n18 fs-1">나와 함께하는 다양한 사람들</h1>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#loginmainhero" role="button" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </a>
            <a class="carousel-control-next" href="#loginmainhero" role="button" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </a>
        </div>

        <div class="row mt-2 ">
            <div class="col-7 px-4">
                <a href="${path }/user/myMoim">
                    <h1 style="color:#FFD966">내 모임 <i class="icon-coral fa-solid fa-chevron-right" style="font-size:90%"></i> </h1>
                </a>
                <hr class="mt-n2" style="border: 1px solid #f2f2f2; width:100%; ">
                <div class="loginmainmylist" style="max-height:1050px;"  data-spy="scroll" data-offset="0">
                    <table class="tg col-12" >
                        <colgroup>
                            <col style="width:20%">
                            <col style="width:80%">
                        </colgroup>
                        <tbody id="myMoimList">
                            <!-- ajax1 -->

                        </tbody>
                    </table>
                </div>
            </div>

<script>
function dday(plNo){
	var dayCnt = 0;
	$.ajax({
		type:'get',
		url:'${path}/user/dday',
		data :{plNo},
		async:false,
		dataType : 'json',
		success : (data)=>{
			dayCnt=data;
		},
		error : (e)=>{
			console.log(e);
		}
	})
	
	return dayCnt;
}
$(()=>{
	$.ajax({
		type:'get',
		url:'${path}/user/mainPlan',
		dataType:'json',
		success:(list)=>{
			var str='';
			if (Array.isArray(list) == true && list.length ==0){
				$('#plandata').append('<div style="height:200px;padding-top:80px; "><p style="font-size:20px;width:100%;text-align:center">조회된 일정이 없습니다.</p></div>');
				return;
			}
			for (var i = 0 ; i < list.length ; i++){
				var dayCnt = dday(list[i].plNo);
				var date = new Date(list[i].plDate);
				str +='<div class="col-auto">'
						+'<h3 class="mt-5 ms-2 " style="color:#FF6F61">D-<span id="deadline">'+dayCnt+'</span></h3>'
						+'</div>'
						+'<div class="col-auto ms-n2 mt-1">'
							+'<div>'
								+'<i class="fa-regular fa-calendar fs-4 icon-yellow"></i> <span class="fs-4 text-gray-700" id="when">'+date.getFullYear()+'.'+(date.getMonth()+1)+'.'+date.getDate()+' '+date.getHours()+':'+date.getMinutes()+'</span> &nbsp;'
								+'<i class="fa-solid fa-location-dot fs-4 icon-coral"></i> <span class="fs-4 text-black" id="where">'+list[i].plPlace+'</span>'
							+'</div>'
							+'<div>'
								+'<h1 class="mainschedule " style="font-size:160%" id="planName">'+list[i].plTitle+'</h1>'
								+'<p class="mt-n2" id="moimName">'+list[i].gName+'</p>'
							+'</div>'
						+'</div>'
						+'<hr>';
			}
			$('#plandata').append(str);
		},
		error : (e)=>{
			console.log(e)
		}
	})

				
})
</script>
            <div class="col-5 px-1">
                <div class="row">
                    <a href="${path }/user/mySchedule">
                        <h1 style="color:#FFD966" >
                            내 일정 <i class="icon-coral fa-solid fa-chevron-right " style="font-size:90%"></i>
                        </h1>
                    </a>
                    <hr class="mt-n2" style="border: 1px solid #f2f2f2; width:100%; " class="my-2">
<div class="row loginmainmylist" style="max-height:470px;overflow:auto;width:100%;"  data-spy="scroll" data-offset="0" id="plandata">
</div>
                </div>

                <div class="mt-3 col-12" id="rec">
                    <div class="col-12 mt-1">
                        <h1 style="color:#FFD966">
                            추천 모임
                        </h1>
                    </div>
                </div>
            </div>
        </div>
    </section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>