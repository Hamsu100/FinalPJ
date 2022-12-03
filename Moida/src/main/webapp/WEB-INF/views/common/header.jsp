<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title }</title>
    <!-- 타이틀 옆 아이콘-->
    <link rel="shortcut icon" href="${path }/resources/images/link.png">

    <!-- theme stylesheet-->
    <!-- 글꼴 가져오는 css -->
    <link rel="stylesheet" href="${path }/resources/css/default.css" id="stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="${path }/resources/css/custom.css">
    <!-- Theme CSS -->
    <link rel="stylesheet " href="${path }/resources/assets/css/theme.min.css">

    <script src="https://kit.fontawesome.com/32bfd9afec.js" crossorigin="anonymous"></script>

    <!-- Libs CSS -->
    <link href="${path }/resources/assets/fonts/feather/feather.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${path }/resources/assets/libs/dragula/dist/dragula.min.css" rel="stylesheet" />
    <link href="${path }/resources/assets/libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" />
    <link href="${path }/resources/assets/libs/dropzone/dist/dropzone.css" rel="stylesheet" />
    <link href="${path }/resources/assets/libs/magnific-popup/dist/magnific-popup.css" rel="stylesheet" />
    <link href="${path }/resources/assets/libs/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/@yaireo/tagify/dist/tagify.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/tiny-slider/dist/tiny-slider.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/tippy.js/dist/tippy.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/prismjs/themes/prism-okaidia.min.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/simplebar/dist/simplebar.min.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/nouislider/dist/nouislider.min.css" rel="stylesheet">
    <link href="${path }/resources/assets/libs/glightbox/dist/css/glightbox.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>


</head>

<body style="padding-top: 58px;">
    <script>
    	$.ajax({
    		type : 'get',
    		url : '${path}/header/alarm',
    		dataType : 'json',
    		success : (list)=>{
    			console.log(list)
    			if (list.length == 0){
    				$('#alarmList').append('<li class="list-group-item">조회된 알람이 없습니다.</li>')
    				return;
    			}
    				$('#dropdownNotificationSecond').append('<sub style="color:#FF6F61">!</sub>')
    			var str = '';
    			for (var i = 0 ; i < list.length;i++){
    				var date = new Date(list[i].alDate);
		    		str += '<li class="list-group-item">'
				                +'<div class="row">'
				                    +'<div class="col">'
				                        +'<a class="text-body" href="${path}/moim?gNo='+list[i].gno+'">'
				                            +'<div class="d-flex">'
				                                +'<div class="ms-3">'
				                                    +'<p class="mb-1 text-body">'
				                                        +list[i].alCont
				                                    +'</p>'
				                                    +'<span class="fs-6 text-muted">'+date.getFullYear() +'.'+(date.getMonth()+1)+'.'+date.getDate()+'</span>'
				                                +'</div>'
				                            +'</div>'
				                        +'</a>'
				                    +'</div>'
				                +'</div>'
				            +'</li>';
    			}
    			$('#alarmList').append(str);
    		},
    		error : (e)=>{
    			console.log('e');
    		}
    	});
    	
    	$.ajax({
    		type : 'get',
    		url : '${path}/header/msg',
    		dataType : 'json',
    		success : (list)=>{
    			if (list.length > 0){
    				$('#msgIcon').append('<sub style="color:#FF6F61">!</sub>')
    			}
    		}
    	})
    	
    </script>
    <!-- 헤더 시작 -->
    <header class="header">
        <nav class="navbar navbar-expand-lg fixed-top  navbar-light bg-white">
            <div class="container">
                <div class="d-flex align-items-center">
                    <a class="navbar-brand " href="${path }/"><img class="logo" src="${path }/resources/images/logo.png"></a>
                    <!-- 로고를 누르면 홈으로 -->
                </div>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <ul class="navbar-nav ms-auto">
                        <!-- 그룹 만들기 -->
                        <li class="nav-item me-2">
                            <a class="nav-link" href="${path }/moim/insert">
                                <span class="icon-coral">모임생성</span> <i class="fa-solid fa-plus icon-yellow"></i>
                            </a>
                        </li>

                        <!-- 검색 페이지 -->
                        <li class="nav-item me-2">
                            <a class="nav-link" href="${path }/moim/list">
                                <span class="icon-coral"></span> <i class="fa-solid fa-magnifying-glass icon-yellow"></i>
                            </a>
                        </li>

                        <!-- 쪽지 페이지 -->
                        <li class="nav-item me-3">
                            <a class="nav-link" id="msgIcon" href="${path }/msg/list">
                                <span class="icon-coral"></span> <i class="fa-regular fa-envelope icon-yellow "></i>
                            </a>
                        </li>

                        <!-- 알림 -->
                        <li class="dropdown d-inline-block stopevent me-4">
                            <a class="d-block link-dark text-decoration-none mt-1" role="button" id="dropdownNotificationSecond" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="fa-solid fa-bell icon-yellow"></i></a>
                            <div class="dropdown-menu dropdown-menu-end dropdown-menu-lg" aria-labelledby="dropdownNotificationSecond">
                                <div>
                                    <div class="border-bottom px-3 pb-3 d-flex justify-content-between align-items-center">
                                        <span class="h5 mb-0 text-primary">알람</span>
                                    </div>
                                    <ul class="list-group list-group-flush  " id="alarmList" data-simplebar>
                                    </ul>
                                </div>
                            </div>
                        </li>

                        <!-- 내 정보 확인하기 -->
                        <div class="dropdown d-inline-block col-auto" style="float: right;vertical-align: bottom;">
                            <a href="#" class="d-block  link-dark text-decoration-none" style="vertical-align: center;" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="${path }/resources/upload/user/${loginUser.uRen}" alt="mdo" width="32" height="32" class="rounded-circle">
                            </a>
                            <ul class="dropdown-menu text-small">
                                <li><a class="dropdown-item" href="${path }/user/myPage">마이페이지</a></li>
                                <li><a class="dropdown-item" href="${path }/user/myMoim">내 모임</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="${path}/user/logout">로그아웃</a></li>
                            </ul>
                        </div>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <hr>
    <!-- 헤더 끝 -->