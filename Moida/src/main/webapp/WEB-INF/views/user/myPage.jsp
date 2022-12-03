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
        //2개만 체크되게 하기
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
                $('#submitBtn').attr('onclick','alert("비밀번호가 일치  하지 않습니다.")')
            } else {
                document.getElementById('checkPwd').style.color = '#70AD47';
                document.getElementById('checkPwd').innerHTML = '비밀번호가 <br> 일치합니다.';
                $('#submitBtn').removeAttr('onclick');
                $('#submitBtn').attr('type','submit');
            }
        }
    </script>

    <script>
        function readURL(input) {
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
    </script>
<script>
//필요한 데이터
// 유저 정보
// 유저 기본 : uRen uBirth uGender // session
// 추가 정보 : sido / gugun / emd / ri session
// 유저 관심분야 : iNo

// 지역 정보 가져오기
$(()=>{
	$('#sido').val('${loginUser.sido}').prop('selected', true);
	$('#gugun').append('<option value="${loginUser.gugun}">${loginUser.gugun}</option>');
	$('#emd').append('<option value="${loginUser.emd}">${loginUser.emd}</option>');
	$('#ri').append('<option value="${loginUser.aNo}">${loginUser.ri}</option>');
// 관심분야 가져오기
	$.ajax({
		type:'get',
		url : '${path}/user/interest',
		success:(list)=>{
			console.log(list);
			for (var i = 0 ; i < list.length ; i++){
				var arr = $('input[name=check]');
				for (var j = 0 ; j < arr.length ; j++){
					if (list[i] == arr[j].value){
						arr[j].checked = true;
					}
				}
			}
		},
		error : (e) => {
			console.log(e);
		}
	})
})
</script>
<section class=" container">
        <div class="row">
            <!-- 사이드바 -->
            <div class="col-2 bg-white sidebar sidebar-block" style="width: 200px; height: 400px">
                <!-- 프로필 사진 + 닉네임 -->
                <jsp:include page="/WEB-INF/views/user/sidebar.jsp"/>
            </div>
            <!-- 사이드 바 끝-->
            <!-- 사이드 바 옆 내용 섹션-->
            <div class="col-10">
                <!-- 제목 -->
                <div class="mt-4 ms-2">
                    <h1> 나의 정보</h1>
                    <hr class="my-3">
                </div>

                <!-- 내정보 수정 -->
                <div class="col-12 ms-2" style="border: 1px solid #f2f2f2">
                    <form action="${path }/user/update" method="post" enctype="multipart/form-data">
                        <table class="tg col-12">
                            <colgroup>
                                <col style="width: 10%">
                                <col style="width: 45%">
                                <col style="width: 25%">
                                <col style="width: 20%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <td class="mypagetitle">
                                        <div id="file-box">
                                            <label class="input-file-button mb-2" for="input-file"><img id="preview" class="avatar-xxl rounded-circle" style="background-image: url(${path}/resources/upload/user/${loginUser.uRen }); background-size: cover; background-position:center;" /></label>
                                            <input type="file" id="input-file" name="upfile" style="display: none" onchange="readURL(this)" />
                                        </div>
                                    </td>
                                    <td class="mypage2" colspan="3">

                                        <div class="col-4">
                                            <input type="text" id="fname" name="uNick" class="form-control mt-2" value="${loginUser.uNick }" required />
                                        </div>
                                        <h4 class="mt-2"> <fmt:formatDate value="${loginUser.uBirth }" pattern="yyyy.MM.dd"/>&nbsp; | &nbsp;${loginUser.uGender }</h4>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="mypagetitle">지역</td>
                                    <td class="mypagetitle" colspan="3">
                                        <div class="row ms-auto">
                                            <select class="form-select me-5 search" id="sido" onchange="areaSelector(this)" style="width:20%">
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

                                            <select class="form-select me-5" id="gugun" style="width:20%" onchange="areaSelector2()">
                                            </select>

                                            <select class="form-select me-5" style="width:20%" id="emd" onchange="areaSelector3()">
                                            </select>

                                            <select class="form-select" style="width:20%" id="ri" name="aNo">
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="mypagetitle">관심분야</td>
                                    <td class="mypage1">
                                        <input type="checkbox" class="form-check-input" name="check" id="sport" onclick="count_check(this)" value="1">
                                        <label for="sport" class="me-4" style="font-size: 110%;">운동</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="camp" onclick="count_check(this)" value="2">
                                        <label for="camp" class="me-4" style="font-size: 110%;">여행/캠핑</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="game" onclick="count_check(this)" value="3">
                                        <label for="game" class="me-4" style="font-size: 110%;">게임</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="lang" onclick="count_check(this)" value="4">
                                        <label for="lang" class="me-4" style="font-size: 110%;">어학/외국어</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="cook" onclick="count_check(this)" value="5">
                                        <label for="cook" class="me-4" style="font-size: 110%;">맛집/요리</label>

                                        <br>

                                        <input type="checkbox" class="form-check-input" name="check" id="fan" onclick="count_check(this)" value="6">
                                        <label for="fan" class="me-4" style="font-size: 110%;">팬클럽</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="pet" onclick="count_check(this)" value="7">
                                        <label for="pet" class="me-4" style="font-size: 110%;">반려동물/동물</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="religion" onclick="count_check(this)" value="8">
                                        <label for="religion" class="me-4" style="font-size: 110%;">종교</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="art" onclick="count_check(this)" value="9">
                                        <label for="art" class="me-4" style="font-size: 110%;">문화/예술</label>

                                        <input type="checkbox" class="form-check-input" name="check" id="etc" onclick="count_check(this)" value="10">
                                        <label for="etc" class="me-4" style="font-size: 110%;">기타</label>

                                    </td>
                                    <td>
                                        <div>
                                            <span id="checkFav"></span>
                                        </div>
                                    </td>
                                    <td class="mypagebtn">
                                        <button class="btn btn-secondary col-4 " type="submit">등록</button>
                                        <button class="btn btn-primary col-4" type="reset" value="Reset">취소</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>

                <!-- 비밀번호 변경 -->
                <div class="col-12  ms-2 mt-2" style="border: 1px solid #f2f2f2">
                    <h2 class="my-3 mx-3">비밀번호 변경</h2>

                    <form action="${path }/user/pwdUpdate" method="post">
                        <table class="tg col-12">
                            <colgroup>
                                <col style="width: 15%">
                                <col style="width: 40%">
                                <col style="width: 20%">
                                <col style="width: 25%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <td class="mypage3"> &nbsp; &nbsp;현재 비밀번호</td>
                                    <td class="mypage1">
                                        <input id="currentpassword" type="password" name="currentpassword" class="form-control text-black" placeholder="현재 비밀번호를 입력해주세요" required />
                                    </td>
                                    <td colspan="2">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="mypage3"> &nbsp; &nbsp;변경 비밀번호</td>
                                    <td class="mypage1">
                                        <input type="password" id="uPwd1" name="uPwd1" class="form-control text-black" placeholder="새로운 비밀번호를 입력하세요" required />
                                    </td>
                                    <td colspan="2">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="mypage3"> &nbsp; &nbsp;변경 비밀번호 확인</td>
                                    <td class="mypage1">
                                        <input type="password" id="uPwd2" class="form-control text-black" placeholder="새로운 비밀번호 확인" required onkeyup="v_password()" />
                                    </td>
                                    <td>
                                        <small id="checkPwd"></small>
                                    </td>
                                    <td class="mypagebtn ms-n2">
                                        <button class="btn btn-secondary col-3" id="submitBtn" type="button">등록</button>
                                        <button class="btn btn-primary col-3" type="reset" value="Reset">취소</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>

                <!-- 회원탈퇴 -->
                <div class="col-12  ms-2 mt-2" style="border: 1px solid #f2f2f2">
                    <h2 class="my-3 mx-3">회원 탈퇴</h2>

                    <div class="ms-3">
                        <h3 class="text-danger">
                            회원 탈퇴 시, 계정이 즉시 비활성화 되며 사라지게 됩니다. <br> 저장된 정보, 가입한 모임 등에 대한 정보가 모두 사라지게 되니, 신중하게 선택하시기 바랍니다.
                        </h3>
                        <form action="${path }/user/out" method="post" class="my-3">
                            <input type="checkbox" class="form-check-input" style="vertical-align:center;" name="withdraw " id="withdraw " value="withdraw" required>
                            <label for="withdraw " class="me-2 " style="font-size: 110%;vertical-align:top; ">회원 탈퇴를 원할 시, 체크 해주세요</label>
                            <button class="btn btn-primary offset-7-1" type="submit">회원 탈퇴</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>