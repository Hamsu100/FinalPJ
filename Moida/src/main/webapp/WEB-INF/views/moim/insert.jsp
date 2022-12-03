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
	<section class=" container">
        <table class="tg col-12" style="background-color:#f2f2f2">
            <tr>
                <td class="outline" width="50%" style="font-size:30px; text-align: center; color:coral">
                    <div class="mb-n4">
                        <p style="letter-spacing: 8pt; line-height: 200%">우 리 모 두</p>
                        <p style="letter-spacing: 12pt; line-height: 20%">지 금 여 기</p>
                        <p style="letter-spacing: 6pt;"> M O I D A </p>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                <form action="${path }/moim/insert" method="post" enctype="multipart/form-data">
                    <div class="makebox col-11 ms-8 mb-5">
                        <div class=" py-3 me-3">
                            <div class="filebox" style="text-align: center;">
                                <label for="thumb">
                                        <img id="preview" style="width:300px; height: 300px; background-image: url(${path}/resources/images/photo.png); background-size: cover; background-position:center;">
                                    </label>
                                <input type="file" accept="image/gif, image/jpeg, image/png" id="thumb" name="thumb" style="display: none" onchange="readURL1(this)">
                            </div>
                            <hr style="border: 1px solid #f2f2f2; width:98%; margin-left : auto; margin-right : auto;">
                            <div class="filebox my-4" style="text-align: center;">
                                <label for="cover">
                                        <img id="preview2"  style="width:1100px; height: 300px; background-image: url(${path}/resources/images/cover.png); background-size: cover; background-position:center;">
                                    </label>
                                <input type="file" id="cover" name="cover" accept="image/gif, image/jpeg, image/png" style="display: none" onchange="readURL2(this)">
                            </div>
                            <hr style="border: 1px solid #f2f2f2; width:98%; margin-left : auto; margin-right : auto;">

                            <label for="make" style="font-size:20px;">&nbsp;&nbsp;&nbsp;모임명 </label>

                            <input class="form-control ms-3 text-black" type="text" style="resize: none; width:97%;" name="gName" required>
                            <hr style="border: 1px solid #f2f2f2; width:98%; margin-left : auto; margin-right : auto;">

                            <label for="make" style="font-size:20px;">&nbsp;&nbsp;&nbsp;한줄 소개 </label>
                            <input class="form-control ms-3 text-black" type="text" style="resize: none; width:97%; font-size:15px;" placeholder="모임을 한줄로 표현해주세요" name="gShort" required>

                            <hr style="border: 1px solid #f2f2f2; width:98%; margin-left : auto; margin-right : auto;">
                            <div>
                                <textarea class="form-control my-1 ms-3 text-black" cols="100" rows="5" style="font-size:15px; resize: none; width: 97%" placeholder="모임을 자세하게 소개해주세요" required name="gIntro"></textarea>
                            </div>
                            <hr style="border: 1px solid #f2f2f2; width:97%; margin-left : auto; margin-right : auto;">

                            <label for="make" style="font-size:20px;">&nbsp;&nbsp;&nbsp;모임 카테고리 </label>
                            <style>
                                	.btn-outline-secondary{
                                		width:145px;
                                		height:41px;
                                	}
                            </style>
                            <div class="text-center my-2">
                            	<input type="radio" class="btn-check" name="iNo" id="sport" autocomplete="off" value="1">
								<label class="btn btn-outline-secondary me-9" for="sport">운동</label>
								
                                <input type="radio" class="btn-check" name="iNo" id="vacation" autocomplete="off" value="2">
								<label class="btn btn-outline-secondary me-9" for="vacation">여행/캠핑</label>
								
                                <input type="radio" class="btn-check" name="iNo" id="game" autocomplete="off" value="3">
								<label class="btn btn-outline-secondary me-9" for="game">게임</label>
								
								<input type="radio" class="btn-check" name="iNo" id="lang" autocomplete="off" value="4">
								<label class="btn btn-outline-secondary me-9" for="lang">어학/외국어</label>
								
								<input type="radio" class="btn-check" name="iNo" id="cook" autocomplete="off" value="5">
								<label class="btn btn-outline-secondary me-9" for="cook">맛집/요리</label>
                            </div>
                            <div class="text-center my-3">
								<input type="radio" class="btn-check" name="iNo" id="fan" autocomplete="off" value="6">
								<label class="btn btn-outline-secondary me-9" for="fan">팬클럽</label>
								
								<input type="radio" class="btn-check" name="iNo" id="pet" autocomplete="off" value="7">
								<label class="btn btn-outline-secondary me-9" for="pet">반려동물/동물</label>
								
								<input type="radio" class="btn-check" name="iNo" id="rel" autocomplete="off" value="8">
								<label class="btn btn-outline-secondary me-9" for="rel">종교</label>
								
								<input type="radio" class="btn-check" name="iNo" id="cul" autocomplete="off" value="9">
								<label class="btn btn-outline-secondary me-9" for="cul">문화/예술</label>
								
								<input type="radio" class="btn-check" name="iNo" id="etc" autocomplete="off" value="10">
								<label class="btn btn-outline-secondary me-9" for="etc">기타</label>
                            </div>
                            <hr style="border: 1px solid #f2f2f2; width:97%; margin-left : auto; margin-right : auto;">
                            <label for="make" style="font-size:20px;">&nbsp;&nbsp;&nbsp;모임 지역 </label>
                            <div class="row ms-auto">
                                <select class="form-select ms-3 search" id="sido" onchange="areaSelector(this);" style="width:20%">
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

                                <select class="form-select ms-5" id="gugun" style="width:20%" onchange="areaSelector2()">
                                    <option> 군구</option>
                                </select>

                                <select class="form-select ms-5" style="width:20%" id="emd" onchange="areaSelector3()">
                                    <option> 읍면동</option>
                                </select>

                                <select class="form-select ms-5" style="width:20%" id="ri" name="aNo">
                                    <option> 리</option>
                                </select>
                            </div>

                            <hr class="my-4" style="border: 1px solid #f2f2f2; width:97%; margin-left : auto; margin-right : auto;">
                            <div class="text-center">
                                <button type="submit" class="btn btn-secondary">  모임 만들기  </button>
                            </div>
                        </div>
                    </div>
                    </form>
                </td>
            </tr>
        </table>
    </section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>