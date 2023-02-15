<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<style>
input[type="datetime-local" i] {
	width: 40%;
}
.form-control{
	width: 60%;
}
.form-select{ /* 중분류 소분류임 */
	width: 40%;
}
</style>
<body>
	<!-- Layout wrapper 메뉴 들어가게 하고 싶으면 .. layout-without-menu-->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->
			<%@ include file="../menu.jsp"%>
			<!-- Layout container -->
			<div class="layout-page">
				<!-- Header -->
				<%@ include file="../header.jsp"%>
				<!-- / Header -->

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">

						<!-- 일정 등록 -->
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">캘린더 /</span> 일정 수정
						</h4>
						
						<!-- <form id="scheWriteForm" class="mb-3" action="/schedule/regist.do" method="POST"> -->
							<!-- 등록란 -->
							<div class="card mb-4">
								<!-- <h5 class="card-header">HTML5 Inputs</h5> -->
								<div class="card-body">
									<div class="mb-3 row">
										<label for="html5-text-input" class="col-md-2 col-form-label-lg">제목</label>
										<div class="col-md-10">
											<input class="form-control" type="text" id="html5-text-input" name="subject" value='${dto.subject }'  /> <!-- 문자열은 '' 감싸줘야 -->
										</div>
									</div>
	
									<div class="mb-3 row">
										<label for="html5-datetime-local-input" class="col-md-2 col-form-label-lg">시작 일시</label>
										<div class="col-md-10" id="end_date">
											<input class="form-control end" type="datetime-local" id="html5-datetime-local-input" name="start_date" value='${dto.start_date }' placeholder="시작 일시" />
										</div>
									</div>
									
									<div class="mb-3 row">
										<label for="html5-datetime-local-input" class="col-md-2 col-form-label-lg">종료 일시</label>
										<div class="col-md-10" id="end_date">
											<input class="form-control end" type="datetime-local" id="html5-datetime-local-input" name="end_date" value='${dto.end_date }' placeholder="종료일시" />
										</div>
									</div>
	
									<div class="mb-3 row">
										<label for="html5-datetime-local-input" class="col-md-2 col-form-label-lg">중분류</label> 
										<div class="col-md-10">
											<select class="form-select" id="exampleFormControlSelect1" aria-label="Default select example"> 
												<c:choose>
													<c:when test="${dto.main_idx == 1 }">
														<option onclick="main(this.innerText)" id="main_sort" value="1" selected>소속부서</option>
														<option onclick="main(this.innerText)" id="main_sort" value="2">개인</option>												
													</c:when>
													<c:otherwise>
														<option onclick="main(this.innerText)" id="main_sort" value="1" >소속부서</option>
														<option onclick="main(this.innerText)" id="main_sort" value="2" selected>개인</option> 
													</c:otherwise>
												</c:choose>
											</select>
										</div>
									</div>
	
									<!-- 소분류 중분류 값 db에 먼저 보내서 꺼내오기 
									    - 개인 옵션 :  출장, 휴가, 반차, 병가, 기타 
	    								- 부서 옵션 :  미팅, 회의, 행사, 세미나, 기타 
									 -->
									<div class="mb-3 row">
										<label for="exampleFormControlSelect1" class="col-md-2 col-form-label-lg">소분류</label>
										<div class="col-md-10">
											<select class="form-select" id="exampleFormControlSelect2" aria-label="Default select example"> 
												<!-- 1: 소속 부서, 2:개인  --> 
												<c:choose>
													<c:when test="${dto.main_idx == 1 && dto.sub_idx == 1}"> 
														<option value="1" id="sub_sort" selected>미팅</option>
														<option value="2" id="sub_sort">회의</option>
														<option value="3" id="sub_sort">행사</option>
														<option value="4" id="sub_sort">세미나</option>
														<option value="5" id="sub_sort">기타</option> 
													</c:when>
													<c:when test="${dto.main_idx == 1 && dto.sub_idx == 2}"> 
														<option value="1" id="sub_sort">미팅</option>
														<option value="2" id="sub_sort"selected>회의</option>
														<option value="3" id="sub_sort">행사</option>
														<option value="4" id="sub_sort">세미나</option>
														<option value="5" id="sub_sort">기타</option>
													</c:when>
													<c:when test="${dto.main_idx == 1 && dto.sub_idx == 3}"> 
														<option value="1" id="sub_sort">미팅</option>
														<option value="2" id="sub_sort">회의</option>
														<option value="3" id="sub_sort" selected>행사</option>
														<option value="4" id="sub_sort">세미나</option>
														<option value="5" id="sub_sort">기타</option>
													</c:when>
													<c:when test="${dto.main_idx == 1 && dto.sub_idx == 4}"> 
														<option value="1" id="sub_sort">미팅</option>
														<option value="2" id="sub_sort">회의</option>
														<option value="3" id="sub_sort">행사</option>
														<option value="4" id="sub_sort" selected>세미나</option>
														<option value="5" id="sub_sort">기타</option>
													</c:when>
													<c:when test="${dto.main_idx == 1 && dto.sub_idx == 5}"> 
														<option value="1" id="sub_sort">미팅</option>
														<option value="2" id="sub_sort">회의</option>
														<option value="3" id="sub_sort">행사</option>
														<option value="4" id="sub_sort">세미나</option>
														<option value="5" id="sub_sort" selected>기타</option>
													</c:when>
													
													<c:when test="${dto.main_idx == 2 && dto.sub_idx == 7}">
														<option value="7" id="sub_sort" selected>반차</option>
														<option value="8" id="sub_sort">휴가</option>
														<option value="9" id="sub_sort">병가</option>
														<option value="10" id="sub_sort">출장</option>
														<option value="12" id="sub_sort">기타</option>
													</c:when>
													<c:when test="${dto.main_idx == 2 && dto.sub_idx == 8}">
														<option value="7" id="sub_sort">반차</option>
														<option value="8" id="sub_sort" selected>휴가</option>
														<option value="9" id="sub_sort">병가</option>
														<option value="10" id="sub_sort">출장</option>
														<option value="12" id="sub_sort">기타</option>
													</c:when>
													<c:when test="${dto.main_idx == 2 && dto.sub_idx == 9}">
														<option value="7" id="sub_sort">반차</option>
														<option value="8" id="sub_sort">휴가</option>
														<option value="9" id="sub_sort" selected>병가</option>
														<option value="10" id="sub_sort">출장</option>
														<option value="12" id="sub_sort">기타</option>
													</c:when>
													<c:when test="${dto.main_idx == 2 && dto.sub_idx == 10}">
														<option value="7" id="sub_sort">반차</option>
														<option value="8" id="sub_sort">휴가</option>
														<option value="9" id="sub_sort">병가</option>
														<option value="10" id="sub_sort" selected>출장</option>
														<option value="12" id="sub_sort">기타</option>
													</c:when>
													<c:when test="${dto.main_idx == 2 && dto.sub_idx == 12}">
														<option value="7" id="sub_sort">반차</option>
														<option value="8" id="sub_sort">휴가</option>
														<option value="9" id="sub_sort">병가</option>
														<option value="10" id="sub_sort">출장</option>
														<option value="12" id="sub_sort" selected>기타</option>
													</c:when>
												</c:choose> 
											</select> 
										</div>
									</div>
									<div class="mb-3 row"> 
										<label for="html5-text-input" class="col-md-2 col-form-label-lg">비고</label>
										<div class="col-md-10">
											<c:if test="${dto.main_idx == 1}">
												<input class="form-control" type="text" id="html5-text-input sub" name="comment"  placeholder="사유를 입력바랍니다." disabled="disabled"/>
											</c:if>
											<c:if test="${dto.main_idx == 2}">
												<input class="form-control" type="text" id="html5-text-input sub" name="comment"  placeholder="사유를 입력바랍니다."/>
											</c:if>
										</div>
									</div>
	
									<div class="mb-3 row">
										<label for="html5-text-input" class="col-md-2 col-form-label-lg">장소</label>
										<div class="col-md-10">
											<input class="form-control" type="text" name="location" value='${dto.location }' id="html5-text-input" />
										</div> 
									</div>
	
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg" for="basic-default-message">내용</label>
										<div class="col-sm-10">
											<textarea id="basic-default-message" class="form-control" name="content" aria-describedby="basic-icon-default-message2">${dto.content }</textarea>
										</div>
									</div>
	
								</div>
	
								<div class="demo-inline-spacing">
									<button type="button" onclick="cancel(); return false;" class="btn btn-outline-primary float-end">취소</button> <!-- return false; 이 없는 경우 오작동 될 수 있 -->
									<button type="button" onclick="submit()" class="btn btn-primary float-end">수정</button>
					            </div>
							</div>
						<!-- </form> -->
						
						<!-- / Content -->

						<!-- Footer -->
						<%@ include file="../footer.jsp"%>
						<!-- / Footer -->

						<div class="content-backdrop fade"></div>
					</div>
					<!-- Content wrapper -->
				</div>
				<!-- / Layout page -->
			</div>

			<!-- Overlay -->
			<div class="layout-overlay layout-menu-toggle"></div>
		</div>
		<!-- / Layout wrapper -->
		</div>
</body>
<script>
var scheIdx=${dto.sche_idx};	// 해당 스케줄 번호 
//console.log(scheIdx);

var today = new Date();
var fm_today = formatDate(today);
console.log(fm_today);

//날짜형태(yyyy-mm-dd)로 포맷
function formatDate(date) {
	var date = new Date(date);
    var year = date.getFullYear().toString(); //년도 뒤에 두자리
    var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
    var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
    var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
    var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59) 
    var returnDate = year + "-" + month + "-" + day + "T" + hour + ":" + minute;
    return returnDate;
}
/* function formatDate(date) {
	var date = new Date(date);
    var year = date.getFullYear().toString().slice(-2); //년도 뒤에 두자리
    var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
    var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
    var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
    var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59) 
    var returnDate = year + "-" + month + "-" + day + " " + hour + ":" + minute;
    return returnDate;
} */

// 수정
function submit(){
	// 태그 자체 가져오기 
	$subject	= $("input[name='subject']");
	$start_date = $("input[name='start_date']");
	$end_date 	= $("input[name='end_date']");
	$main_sort 	= $("option[id='main_sort']:selected");
	$sub_sort 	= $("option[id='sub_sort']:selected");
	$comment 	= $("input[name='comment']");
	$location 	= $("input[name='location']");
	$content 	= $("textarea[name='content']");
	
	//console.log($start_date.val());
	//console.log($main_sort.val());
	//console.log($sub_sort.val()); 
	
	// 공란 여부 확인 
	if($subject.val()==''){
		alert('제목을 입력해 주세요.');
		$subject.focus();
	} else if($start_date.val()==''){
		alert('시작일시를 선택해 주세요.');
	} else if($start_date.val() < fm_today){
		alert(fm_today+' 이후의 날짜를 선택하세요.');
	} else if($end_date.val()==''){
		alert('종료일시를 선택해 주세요.'); 
	} else if($start_date.val() > $end_date.val()){
		alert('시작일시 이후의 종료일시를 선택하세요.'); 
	} else if($main_sort.val()=='선택하세요.'){
		alert('중분류를 선택해 주세요.');
		$main_sort.focus();
	} else if($main_sort.val()=='2' && $comment.val()==''){
		alert('비고를 입력해 주세요.');
		$comment.focus();
	} else if($location.val()==''){
		alert('장소를 입력해 주세요.');
		$location.focus();
	} else if($content.val()==''){
		alert('내용을 입력해 주세요.');
		$content.focus();
	} else{
		var result = confirm('수정하시겠습니까?'); // ture/false
		if(result){
			console.log('서버로 전송');
			// 오브젝트 변수 생성
			var param = {};
			param.subject	= $subject.val();
			param.start_date= $start_date.val();
			param.end_date 	= $end_date.val();
			param.main_sort	= $main_sort.val();
			param.sub_sort	= $sub_sort.val();
			param.comment 	= $comment.val();
			param.location 	= $location.val();
			param.content 	= $content.val();
			console.log(param);
			
			// ajax 전송
			$.ajax({
				type:	'POST',
				url:	'/schedule/update.do',
				data:	{'param': param, 'scheIdx':scheIdx},
				dataType: 'JSON',
				success: function(data){
					console.log(data);
					// 일정 수정 성공 시 페이지 이동 
					location.href = "/schedule/scheList.move";
				},
				error: function(e){
					console.log(e);
				} 
			}); // ajax 
			
		} else {
			location.href = "/schedule/scheList.move";
		}// end -confirm
		
	}
} // end -submit()

// 수정 취소 
function cancel(){
	location.href = "/schedule/scheList.move";
}


// 중분류 선택 
$(function(){
	$("#exampleFormControlSelect1").change(function(){
		var mainVal = document.getElementById('exampleFormControlSelect1').value;
		console.log(mainVal);
		if(mainVal == '2'){
			console.log('비고 입력 가능');
			document.getElementById('html5-text-input sub').disabled = false; // 비고란 
		} else{
			console.log('비고 입력 불가능');
			document.getElementById('html5-text-input sub').disabled = true; 
		}
		
		$.ajax({
			type: 'post',
			url: '/schedule/regist/sub/list.ajax',
			data: {'mainVal':mainVal},
			success: function(data){
				//console.log(data);
				
				//document.getElementById('exampleFormControlSelect2').disabled = false; // 소분류 선택 가능 
				var sub_sort = data.subList;
				drawSubList(sub_sort);
			},
			errer: function(e){
				console.log(e);
			}
		}); 
	});
});

// 소분류선택 
function drawSubList(sub_sort){
	//console.log(sub_sort);
	
	var content = '';
	for(var i=0; i<sub_sort.length; i++){
		if(sub_sort[i].sub_name == '1'){ // 개인 
			content += '<option value="'+sub_sort[i].sub_idx+'" name="sub_sort">'+'반차'+'</option>';
		} else if(sub_sort[i].sub_name == '2'){
			content += '<option value="'+sub_sort[i].sub_idx+'" name="sub_sort">'+'휴가'+'</option>';
		} else if(sub_sort[i].sub_name == '3'){
			content += '<option value="'+sub_sort[i].sub_idx+'" name="sub_sort">'+'병가'+'</option>';
		} else if(sub_sort[i].sub_name == '4'){
			content += '<option value="'+sub_sort[i].sub_idx+'" name="sub_sort">'+'출장'+'</option>';
		} else if(sub_sort[i].sub_name == '5'){
			content += '<option value="'+sub_sort[i].sub_idx+'" name="sub_sort">'+'기타'+'</option>';
		} else{ // 소속부서 
			content += '<option value="'+sub_sort[i].sub_idx+'" name="sub_sort">'+sub_sort[i].sub_name+'</option>';			
		}
		
	}
	$('#exampleFormControlSelect2').empty();
	$('#exampleFormControlSelect2').append(content);

	
}

</script>
</html>
