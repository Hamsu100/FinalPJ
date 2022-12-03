<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MOIDA</title>
    <!-- 타이틀 옆 아이콘-->
    <link rel="shortcut icon" href="${path}/resources/images/link.png">
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <!-- theme stylesheet-->
    <!-- 글꼴 가져오는 css -->
    <link rel="stylesheet" href="${path}/resources/css/default.css" id="stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="${path}/resources/css/custom.css">
    <!-- Theme CSS -->
    <link rel="stylesheet" href="${path}/resources/assets/css/theme.min.css">
    <script src="https://kit.fontawesome.com/32bfd9afec.js" crossorigin="anonymous"></script>

    <!-- Libs CSS -->
    <link href="${path}/resources/assets/fonts/feather/feather.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="${path}/resources/assets/libs/dragula/dist/dragula.min.css" rel="stylesheet" />
    <link href="${path}/resources/assets/libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" />
    <link href="${path}/resources/assets/libs/dropzone/dist/dropzone.css" rel="stylesheet" />
    <link href="${path}/resources/assets/libs/magnific-popup/dist/magnific-popup.css" rel="stylesheet" />
    <link href="${path}/resources/assets/libs/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/@yaireo/tagify/dist/tagify.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/tiny-slider/dist/tiny-slider.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/tippy.js/dist/tippy.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/prismjs/themes/prism-okaidia.min.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/simplebar/dist/simplebar.min.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/nouislider/dist/nouislider.min.css" rel="stylesheet">
    <link href="${path}/resources/assets/libs/glightbox/dist/css/glightbox.min.css" rel="stylesheet">

    <style>
        body {
            background-image: url(${path}/resources/images/nonlogin.jpg);
            background-size:cover;
        }
        
        img {
            width: 200px;
            height: 200px;
        }
    </style>

</head>
<body>

    <script>
    	function isAlphabetic(val){
    		var patternAlpha = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    		if (patternAlpha.test(val.value) == true){
    			$('#uId').val('');
    			$('#uId').attr('placeholder','한글은 입력 불가능해요!!');
    		}
    	}
    	var duplicID = false;
    	var duplicNick = false;
    		function areaSelector(target){
    			
    			var sido = target.value;
	    		$.ajax({
	    			type : 'get',
	    			url : '${path}/user/gugun',
	    			data : {sido},
	    			dataType : 'json',
	    			success :function(list){
	    				$('#gugun').empty();
	    				$('#emd').empty();
    					$('#ri').empty();
	    				$('#gugun').append('<option>구군</option>');
	    				$('#emd').append('<option>읍면동</option>');
	    				$('#ri').append('<option>리</option>');
	    				
	    				for (var i = 0; i < list.length ; i++){
	    					var option = '<option value="'+list[i]+'">'+list[i]+'</option>'
	    					$('#gugun').append(option);
	    				}
	    			},
	    			error : (e)=>{
	    				console.log(e);
	    			}
	    		})
    		}
    		
    		function areaSelector2(){
    			var area1 = $('#sido option:selected').val();
    			var area2 = $('#gugun option:selected').val();
    			console.log(area1 + ' ' + area2);
    			if (area1 != null){
    				if(area2 != null)
	    			$.ajax({
	    				type : 'get',
	    				url : '${path}/user/emd',
	    				data : {
	    					sido : area1,
	    					gugun : area2
	    				},
	    				dataType : 'json',
	    				success : (list) => {
	    					$('#emd').empty();
	    					$('#ri').empty();
	    					$('#emd').append('<option>읍면동</option>');
	    					$('#ri').append('<option>리</option>')
	    					for (var i = 0 ; i < list.length ; i++){
	    						var option = '<option value="'+list[i]+'">'+list[i]+'</option>'
	    						$('#emd').append(option);
	    					}
	    				},
	    				error : (e) => {
	    					console.log(e);
	    				}
	    			})
    			}
    		}
    		
    		function areaSelector3(){
    			var area1 = $('#sido option:selected').val();
    			var area2 = $('#gugun option:selected').val();
    			var area3 = $('#emd option:selected').val();
    			
    			if (area1 != null){
    				if (area2 != null){
    					if (area3 != null){
    						$.ajax({
    							type : 'get',
    		    				url : '${path}/user/ri',
    		    				data : {
    		    					sido : area1,
    		    					gugun : area2,
    		    					emd : area3
    		    				},
    		    				dataType : 'json',
    		    				success : (list) => {
    		    					console.log(list[0])
    		    					$('#ri').empty();
    		    					$('#ri').append('<option>리</option>')
    		    					for (var i = 0 ; i < list.length ; i++){
    		    						var option = '<option value="'+list[i].ANO+'">'+list[i].RI+'</option>'
    		    						$('#ri').append(option);
    		    					}
    		    				},
    		    				error : (e) => {
    		    					console.log(e);
    		    				}
    						})
    					}
    				}
    			}
    		}
    		
	        function count_check(obj) {
	            var chkbox = document.getElementsByName("check");
	            var chkCnt = 0;
	            for (var i = 0; i < chkbox.length; i++) {
	                if (chkbox[i].checked) {
	                    chkCnt++;
	                }
	            }
	            if (chkCnt > 3) {
	                document.getElementById('checkFav').style.color = '#e53f3c';
	                document.getElementById('checkFav').innerHTML = '3개 이하만 선택 가능합니다';
	                obj.checked = false;
	                return false;
	            }
	        }
	        function v_password() {
	
	            var uPwd1 = document.getElementById('uPwd1').value;
	            var uPwd2 = document.getElementById('uPwd2').value;
	            if (uPwd1 != uPwd2) {
	                document.getElementById('checkPwd').style.color = '#e53f3c';
	                document.getElementById('checkPwd').innerHTML = '비밀번호가 <br> 일치하지 않습니다.';
	                document.getElementById('join').disabled = true;
	                document.getElementById('join').style.opacity = (0.4);
	            } else {
	                document.getElementById('checkPwd').style.color = '#70AD47';
	                document.getElementById('checkPwd').innerHTML = '비밀번호가 <br> 일치합니다.';
	                document.getElementById('join').disabled = false;
	                document.getElementById('join').style.opacity = (1);
	            }
	        }
	        function readURL(input) {
	            if (input.files && input.files[0]) {
	                var reader = new FileReader();
	                reader.onload = function(e) {
	                    console.log(e)
	                    document.getElementById('preview').style.backgroundImage ="url(" + e.target.result +")";
	                };
	                reader.readAsDataURL(input.files[0]);
	            } else {
	                document.getElementById('preview').style.backgroundImage ="url()";
	            }
	        }
	        
	        function dupId(){
	        	var uId = $('#uId').val();
	        	console.log(uId)
	        	if (uId == null ){
	        		alert("ID를 입력해 주세요.")
	        		return;
	        	}
	        	if (uId.length > 0){
		        	$.ajax({
		        		type:'get',
		        		url:'${path}/user/dupId',
		        		data:{uId},
		        		dataType:'json',
		        		success:(data)=>{
		        			if (data == true){
		        				alert("사용 가능한 ID입니다.")
		        				duplicID= true;
		        			} else {
		        				alert("사용 불가능한 ID입니다.")
		        				duplicID= false;
		        				$('#uId').val('');
		        			}
		        		},
		        		error : (e) => {
		        			console.log(e);
		        		}
		        	})
	        	} else {
	        		alert("ID를 입력해 주세요.")
	        		return;
	        	}
	        }
	        
	        function dupNick(){
	        	var uNick = $('#uNick').val();
	        	
	        	if (uNick == null ){
	        		alert("닉네임을 입력해 주세요.")
	        		return;
	        	}
	        	
	        	if (uNick.length > 0){
		        	$.ajax({
		        		type:'get',
		        		url:'${path}/user/dupNick',
		        		data:{uNick},
		        		dataType:'json',
		        		success:(data)=>{
		        			if (data == true){
		        				alert("사용 가능한 닉네임입니다.")
		        				duplicNick= true;
		        			} else {
		        				alert("사용 불가능한 닉네임입니다.")
		        				duplicNick= false;
		        				$('#uNick').val('');
		        			}
		        		},
		        		error : (e) =>{
		        			console.log(e);
		        		}
		        	})
	        	} else{
	        		alert("닉네임을 입력해 주세요.")
	        		return;
	        	}
	        }
	        
	        function checkJoin(){
	        	var chkedCnt = $("input:checkbox[name='check']:checked").length;
	        	var detArea = $('#ri option:selected').attr('value');
	        	var inputBirth = $('#uBirth').val();
	        	var inputFile = $('#input-file').val();
	        	if ((duplicID && duplicNick)==false){
					alert('ID 및 닉네임 중복 검사해주세요!!')
					return;
				}
	        	if (inputBirth.length == 0){
	        		alert('생년월일을 입력해주세요!!')
	        		return;
	        	}
	        	if (inputFile.length == 0){
	        		alert('프로필 사진을 설정해 주세요!!')
	        		return;
	        	}	        	
	        	if (chkedCnt == 0 || chkedCnt >3){
	        		alert('관심 분야 1~3개 선택해주세요!!')
	        		return;
	        	}
	        	if (detArea == null){
	        		alert('주소를 선택해 주세요!!');
	        		return;
	        	}
	        	
				
	        	$('#join').prop('type','submit');
				$('#join').prop('onclick',null);
	        }
    </script>
    <div class="pt-lg-12 pb-lg-3 pt-8 pb-6">
        <div class="container">
            <div class="outline text-center" style="color: #FFD966; font-size: 80px; letter-spacing :20px;">MOIDA</div>
            <div class="text-center mt-n4 mb-5" style="color: white; font-size: 40px"> 모이면 모일 수록 더욱 커지는 즐거움 </div>
            <div class="container d-flex flex-column">
                <div class="row align-items-center justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <!-- Form -->
                        <form id="loginFrm" action="${path}/user/login" method="post">
                            <!-- Username -->
                            <div class="mb-3">
                                <label for="uLoginId" class="form-label" style="color:white; font-size: 110%;"> 아이디 </label>
                                <input type="text" id="uLoginId" class="form-control" name="uLoginId" placeholder="아이디를 입력하세요" value='${cookie.saveId.value != null ? cookie.saveId.value:""}' required>
                            </div>
                            <!-- Password -->
                            <div class="mb-3">
                                <label for="uPwd" class="form-label" style="color:white; font-size: 110%;"> 비밀번호 </label>
                                <input type="password" id="uPwd" class="form-control" name="uPwd" placeholder="비밀번호를 입력하세요" required>
                            </div>
                            <!-- 체크 2 개 + 로그인 버튼-->
                            <div class="d-lg-flex justify-content-between align-items-center mb-4 row ms-1">
                                <div class="form-check col-3">
                                    <input type="checkbox" class="form-check-input" id="rememberme" name="saveId" ${cookie.saveId.value != null ? "checked":""}>
                                    <label class="form-check-label" style="color:white; font-size:110%" for="rememberme"> 기억하기 </label>
                                </div>
                                <div class="form-check col-3">
                                    <input type="checkbox" class="form-check-input" id="rememberlogin" name="auto">
                                    <label class="form-check-label" style="color:white; font-size:110%" for="rememberlogin"> 자동로그인 </label>
                                </div>
                                <div class="d-grid col-5">
                                    <button type="submit" class="btn btn-outline-primary btn-sm" style="font-size: 110%; padding: 90%, 100%;"> 로그인 </button> </div>
                            </div>
                        </form>
                        <hr class="my-2">
                        <div class="d-grid  mt-3">
                            <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#signUp" style="font-size: 115%;"> 회원가입 </button>
                        </div>
                        <!-- 회원가입 모달 -->
                        <div class="modal fade" id="signUp" tabindex="-1" role="dialog" aria-labelledby="signUpTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header signupmodal" style="border-bottom: none;">
                                        <h2 class="modal-title offset-5-1 mt-2" id="signUpTitle"> 회원가입</h2>
                                        <button type="button" class="btn-close ms-n5" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body signupmodal mt-n2" style="border-bottom: none;">
                                        <form action="${path}/user/signUp" method="post" enctype="multipart/form-data">
                                            <table class="tg ms-7">
                                                <colgroup>
                                                    <col style="width: 100px">
                                                    <col style="width: 450px">
                                                    <col style="width: 100px">
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th class="signupTitle"> 아이디 </th>
                                                        <th class="signupMiddle">
                                                            <input type="text" id="uId" name="uId" oninput="isAlphabetic(this);" class="form-control" placeholder="아이디" required />
                                                        </th>
                                                        <th class="signupMiddle">
                                                            <button type="button" style="font-size:16px;" class="btn btn-primary" onclick="dupId()"> 중복확인 </button>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="signupTitle"> 비밀번호</td>
                                                        <td class="signupMiddle2">
                                                            <input type="password" id="uPwd1" name="uPwd1" class="form-control" placeholder="비밀번호" required />
                                                        </td>
                                                        <td class="signupMiddle"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signupTitle"> 비밀번호 확인</td>
                                                        <td class="signupMiddle2">
                                                            <input type="password" id="uPwd2" class="form-control" placeholder="비밀번호 확인" required onkeyup="v_password()" />
                                                        </td>
                                                        <td class="signupMiddle"> <small id="checkPwd"></small></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signupTitle"> 닉네임</td>
                                                        <td class="signupMiddle2">
                                                            <input type="text" id="uNick" name="uNick" class="form-control" placeholder="닉네임" required />
                                                        </td>
                                                        <td class="signupMiddle">
                                                            <button type="button" style="font-size:16px;" onclick="dupNick();" class="btn btn-primary">  중복확인  </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signupTitle"> 생년월일</td>
                                                        <td class="signupMiddle2">
                                                            <input class="form-control flatpickr" type="date" placeholder="Birth of Date" id="uBirth" name="uBirthValue" required/>
                                                        </td>
                                                        <td class="signupMiddle"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signupTitle"> 성별 </td>
                                                        <td class="signupMiddle2" colspan="2">
                                                            <input type="radio" class="btn-check" name="uGender" id="gender_male" value="M" autocomplete="off" checked>
                                                            <label class="btn btn-outline-secondary col-auto me-3" for="gender_male"> 남</label>
                                                            
                                                            <input type="radio" class="btn-check" name="uGender" id="gender_female" value="F" autocomplete="off">
                                                            <label class="btn btn-outline-primary col-auto" for="gender_female"> 여</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signupTitle"> 프로필 사진</td>
                                                        <td class="signupMiddle2" colspan="2">
                                                            <div id="file-box">
                                                                <label class="input-file-button mb-2" for="input-file"><img id="preview" style="background-image: url(${path}/resources/images/photo.png); background-size: cover; background-position:center;" /></label>
                                                                <input type="file" accept="image/gif, image/jpeg, image/png" id="input-file" name="upfile" style="display: none" onchange="readURL(this)"/>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signupTitle"> 관심분야 </td>
                                                        <td class="signupMiddle2">
                                                            <input type="checkbox" class="form-check-input" name="check" id="sport" onclick="count_check(this)" value="1">
                                                            <label for="sport" class="me-2" style="font-size: 110%;">운동</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="camp" onclick="count_check(this)" value="2">
                                                            <label for="camp" class="me-2" style="font-size: 110%;">여행/캠핑</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="game" onclick="count_check(this)" value="3">
                                                            <label for="game" class="me-2" style="font-size: 110%;">게임</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="lang" onclick="count_check(this)" value="4">
                                                            <label for="lang" class="me-2" style="font-size: 110%;">어학/외국어</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="cook" onclick="count_check(this)" value="5">
                                                            <label for="cook" class="me-2" style="font-size: 110%;">맛집/요리</label>

                                                            <br>

                                                            <input type="checkbox" class="form-check-input" name="check" id="fan" onclick="count_check(this)" value="6">
                                                            <label for="fan" class="me-2" style="font-size: 110%;">팬클럽</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="pet" onclick="count_check(this)" value="7">
                                                            <label for="pet" class="me-2" style="font-size: 110%;">반려동물/동물</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="religion" onclick="count_check(this)" value="8">
                                                            <label for="religion" class="me-2" style="font-size: 110%;">종교</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="art" onclick="count_check(this)" value="9">
                                                            <label for="art" class="me-2" style="font-size: 110%;">문화/예술</label>

                                                            <input type="checkbox" class="form-check-input" name="check" id="etc" onclick="count_check(this)" value="10">
                                                            <label for="etc" class="me-2" style="font-size: 110%;">기타</label>

                                                        </td>
                                                        <td class="signupMiddle2">
                                                            <small id="checkFav"></small>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signuplast"> 지역 </td>
                                                        <td class="signuplast" colspan="2">
                                                            <div class="row ms-auto">
                                                                <select class="form-select me-5 search" id="sido" onchange="areaSelector(this)" style="width:45%">
                                                                    <option> 지역 선택</option>
                                                                    <option value="서울특별시">서울특별시</option>
                                                                    <option value="부산광역시">부산광역시</option>
                                                                    <option value="대구광역시">대구광역시</option>
                                                                    <option value="인천광역시">인천광역시</option>
                                                                    <option value="광주광역시">광주광역시</option>
                                                                    <option value="대전광역시">대전광역시</option>
                                                                    <option value="울산광역시">울산광역시</option>
                                                                    <option value="경기도">경기도</option>
                                                                    <option value="강원도">강원도</option>
                                                                    <option value="충청북도">충청북도</option>
                                                                    <option value="충청남도">충청남도</option>
                                                                    <option value="전라북도">전라북도</option>
                                                                    <option value="전라남도">전라남도</option>
                                                                    <option value="경상북도">경상북도</option>
                                                                    <option value="경상남도">경상남도</option>
                                                                    <option value="제주도">제주도</option>                                             
                                                                </select>
                                                                <select class="form-select" id="gugun" style="width:45%" onchange="areaSelector2()">
                                                                    <option> 구군</option>
                                                                </select>
                                                            </div>
                                                            <div class="row mt-3 ms-auto">
                                                                <select class="form-select me-5" style="width:45%" id="emd" onchange="areaSelector3()">
                                                                    <option> 읍면동</option>
                                                                </select>
                                                                <select class="form-select" style="width:45%" id="ri" name="aNo" required>
                                                                    <option> 리</option>
                                                                </select>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="signuplast2" colspan="3">
                                                            <button type="button" onclick="checkJoin();" id="join" class="btn btn-secondary mt-2">회원가입</button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </form>
                                    </div>
                                    <div class="modal-footer mt-n5" style=" background-color: #E7E6E6; border-top:none; height:5px"> </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr class="my-5">

                    <div class="d-block text-center">
                        <img class="logo3" src="${path}/resources/images/link.png" alt="">
                    </div>
                    <div class="mt-3">
                        <h3 class="outline text-white text-center mb-n1">Pleasure with Us </h3>
                        <h4 class="mt-2 outline text-center text-primary">
                            <span class="text-secondary"> ⓒ </span> MOIDA </h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <!-- Libs JS -->
    <script src="${path}/resources/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="${path}/resources/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${path}/resources/assets/libs/odometer/odometer.min.js"></script>
    <script src="${path}/resources/assets/libs/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
    <script src="${path}/resources/assets/libs/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
    <script src="${path}/resources/assets/libs/flatpickr/dist/flatpickr.min.js"></script>
    <script src="${path}/resources/assets/libs/inputmask/dist/jquery.inputmask.min.js"></script>
    <script src="${path}/resources/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
    <script src="${path}/resources/assets/libs/file-upload-with-preview/dist/file-upload-with-preview.iife.js"></script>
    <script src="${path}/resources/assets/libs/dragula/dist/dragula.min.js"></script>
    <script src="${path}/resources/assets/libs/bs-stepper/dist/js/bs-stepper.min.js"></script>
    <script src="${path}/resources/assets/libs/dropzone/dist/min/dropzone.min.js"></script>
    <script src="${path}/resources/assets/libs/jQuery.print/jQuery.print.js"></script>
    <script src="${path}/resources/assets/libs/prismjs/prism.js"></script>
    <script src="${path}/resources/assets/libs/prismjs/components/prism-scss.min.js"></script>
    <script src="${path}/resources/assets/libs/@yaireo/tagify/dist/tagify.min.js"></script>
    <script src="${path}/resources/assets/libs/tiny-slider/dist/min/tiny-slider.js"></script>
    <script src="${path}/resources/assets/libs/@popperjs/core/dist/umd/popper.min.js"></script>
    <script src="${path}/resources/assets/libs/tippy.js/dist/tippy-bundle.umd.min.js"></script>
    <script src="${path}/resources/assets/libs/typed.js/lib/typed.min.js"></script>
    <script src="${path}/resources/assets/libs/jsvectormap/dist/js/jsvectormap.min.js"></script>
    <script src="${path}/resources/assets/libs/jsvectormap/dist/maps/world.js"></script>
    <script src="${path}/resources/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="${path}/resources/assets/libs/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
    <script src="${path}/resources/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="${path}/resources/assets/libs/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
    <script src="${path}/resources/assets/libs/prismjs/plugins/toolbar/prism-toolbar.min.js"></script>
    <script src="${path}/resources/assets/libs/prismjs/plugins/copy-to-clipboard/prism-copy-to-clipboard.min.js"></script>
    <script src="${path}/resources/assets/libs/@lottiefiles/lottie-player/dist/lottie-player.js"></script>
    <script src="${path}/resources/assets/libs/simplebar/dist/simplebar.min.js"></script>
    <script src="${path}/resources/assets/libs/nouislider/dist/nouislider.min.js"></script>
    <script src="${path}/resources/assets/libs/wnumb/wNumb.min.js"></script>
    <script src="${path}/resources/assets/libs/glightbox/dist/js/glightbox.min.js"></script>
    <!-- CDN File for moment -->
    <script src='https://cdn.jsdelivr.net/npm/moment@2.29.1/min/moment.min.js'></script>
    <!-- Theme JS -->
    <script src="${path}/resources/assets/js/theme.min.js"></script>

</body>
</html>