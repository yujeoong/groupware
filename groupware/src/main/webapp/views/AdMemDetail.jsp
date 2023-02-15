<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>

<html>
<head>
<style>
.left {
	width: 50%;
	float: left;
}

.right {
	width: 50%;
	float: right;
}

.center {
	float: none;
	width: 100%;
}

.logTables {
	padding: 30px 0px 20px;
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<!-- Layout wrapper 메뉴 들어가게 하고 싶으면 .. layout-without-menu-->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->
			<%@ include file="menu.jsp"%>
			<!-- Layout container -->
			<div class="layout-page">
				<!-- Header -->
				<%@ include file="header.jsp"%>
				<!-- / Header -->

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">사원관리 /</span> 사원 상세보기
						</h4>

						<!-- 부트스트랩 -->
						<div class="col-xl">
							<div class="card mb-4">
								<div class="card-header d-flex justify-content-between align-items-center">
									<!-- 사원 상세보기 헤더 -->
									<h5 class="mb-0">사원 상세보기</h5>
								</div>
								<div class="card-body">

									<!-- 프로필사진첨부+미리보기 -->
									<div class="mb-3">
										<c:if test="${profile.size()>0}">
											<c:forEach items="${profile}" var="path">
												<img width="500" src="/photo/${path}" />
											</c:forEach>
										</c:if>
									</div>
									<!-- 프로필사진첨부+미리보기 /-->
									<div>


										<!-- 상세보기 -->
										<dl class="row g-2 left">
											<dt class="col-sm-3">ID</dt>
											<dd id="idDetail" class="col-sm-9">${member.mem_id}</dd>

											<dt class="col-sm-3">이름</dt>
											<dd class="col-sm-9">${member.name}</dd>

											<dt class="col-sm-3">생일</dt>
											<dd class="col-sm-9">${member.birthday}</dd>

											<dt class="col-sm-3">직속 상급자</dt>
											<dd class="col-sm-9">${member.parent_id}</dd>

											<dt class="col-sm-3">입사일</dt>
											<dd class="col-sm-9">${member.join_date}</dd>

											<dt class="col-sm-3">수직배치 여부</dt>
											<dd class="col-sm-9">${member.stack}</dd>


											<!-- 이런것도 있군 -->
											<dt class="col-sm-3"></dt>
											<dd class="col-sm-9">
												<dl class="row ">
													<dt class="col-sm-3"></dt>
													<dd class="col-sm-9"></dd>
												</dl>
											</dd>
											<!-- 이런것도 있군 참고용/-->
										</dl>

										<dl class="row g-2 right">

											<dt class="col-sm-3">부서</dt>
											<dd class="col-sm-9">${member.depName}</dd>

											<dt class="col-sm-3">직급</dt>
											<dd class="col-sm-9">${member.posName}</dd>

											<dt class="col-sm-3">직책</dt>
											<dd class="col-sm-9">${member.dutyName}</dd>

											<dt class="col-sm-3">서명이미지</dt>
											<dd class="col-sm-9">서명이미지 자리</dd>


											<!-- 서명첨부+미리보기 -->
											<!-- 
									<div class="mb-3">
										<c:if test="${sign.size()>0}">
											<c:forEach items="${sign}" var="path">
												<img width="500" src="/photo/${path}" />
											</c:forEach>
										</c:if>
									</div>
									 -->
											<!-- 서명첨부+미리보기 /-->

										</dl>
									</div>

									<dl class="row g-3 center">
										<dt class="col-sm-3">이메일</dt>
										<dd class="col-sm-9">${member.email}</dd>

										<dt class="col-sm-3">번호</dt>
										<dd class="col-sm-9">${member.phone}</dd>

										<dt class="col-sm-3">주소</dt>
										<dd class="col-sm-9">${member.address}</dd>

									</dl>






									<!-- 이력 -->  
									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">이력</h5>
										<button type="button" class="btn btn-sm btn-outline-primary" onclick= "workWrite()" style="float:right;">추가</button> 
										<table class="table table-hover" style="text-align: center;">
											<thead>
												<tr>
													<th>시작</th>
													<th>종료</th>
													<th>회사</th>
													<th>비고</th>
													<th></th>
												</tr>
											</thead>
											<tbody id="workList">
												<tr>
													<td colspan="5">데이터가 없습니다.</td>
												</tr> 
											</tbody>
											
										</table>
									</div>
									 

									<!-- 학력 -->

									<div class="table-responsive text-nowra logTables">
										<h5 class="mb-0">학력</h5> 
										<button type="button" class="btn btn-sm btn-outline-primary" onclick= "schoolWrite()" style="float:right;">추가</button> 
										<table class="table table-hover" style="text-align: center;">
											<thead>
												<tr>
													<th>시작</th>
													<th>종료</th>
													<th>학교</th>
													<th>비고</th>
													<th></th>
												</tr>
											</thead>
											<tbody id="schoolList">
												<tr>
													<td colspan="5">데이터가 없습니다.</td>
												</tr>
											</tbody>
										</table>
										<br/>
									</div>

									<!-- 조회권한 -->

									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">조회 권한</h5>
										<table class="table table-hover" style="text-align: center;">
											<thead>
												<tr>
													<th>카테고리</th>
													<th>소분류</th>
													<th>참여권한</th>
													<th></th>
												</tr>
											</thead>
											<tbody id="authList">
											</tbody>
										</table>
									</div>

									<!-- 부서로그 -->

									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">부서/직급/직책 변경 로그</h5>
										<table class="table table-hover" style="text-align: center;">
											<thead>
												<tr>
													<th>변경일</th>
													<th>부서</th>
													<th>직급</th>
													<th>직책</th>
													<th>변경자</th>
													<th>비고</th>
												</tr>
											</thead>
											<tbody id="depList">
											</tbody>
										</table>
									</div>

									<!-- 상태로그 -->

									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">상태 변경 로그</h5>
										<table class="table table-hover" style="text-align: center;">
											<thead>
												<tr>
													<th>변경일</th>
													<th>상태</th>
													<th>변경자</th>
													<th>비고</th>
												</tr>
											</thead>
											<tbody id="stateList">
											</tbody>
										</table>
									</div>


								</div> 
							</div>
						</div>
						
						<!-- 모달 -->
						<div class="modal fade" id="modalCenter" tabindex="-1">
							<div class="modal-dialog">
								<form class="modal-content">
									<div class="modal-header" style="flex-direction: row-reverse">
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
										<h5 class="modal-title" id="modalCenterTitle"></h5>
									</div>
									<div class="modal-body" id="fac_bookModal"></div>
								</form>
							</div>
						</div>
						
					</div>
					<!-- / Content -->
					<!-- Footer -->
					<%@ include file="footer.jsp"%>
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
</body>
<script>
stateListCall();

// 이력 등록
function workWrite(){ 
	var content ='';
	console.log("이력 등록 요청"); 
	
	$('#modalCenterTitle').html("이력 추가");
	$('#modalCenter').modal("show"); 
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">시작일</label>';
	content += '<div class="col-md-10" id="start_date">';
	content += '<input class="form-control end" type="date" id="html5-date-local-input" name="start_date" />';
	content += '</div></div>'; 
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">종료일</label>';
	content += '<div class="col-md-10" id="end_date">';
	content += '<input class="form-control end" type="date" id="html5-date-local-input" name="end_date" />';
	content += '</div></div>'; 
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">회사명</label>';
	content += '<div class="col-md-10" style="float: right;">';
	content += '<input class="form-control end" type="text" id="content" class="form-control"/>'; 
	content += '</div></div>';  
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">비고</label>';
	content += '<textarea id="content" class="form-control"></textarea>';
	content += '</div><br/><br/>'; 
	//  버튼 
	content += '<div style="margin:auto;"><button type="button" onclick="fbSubmit()" class="btn btn-primary" style="width: 100px;">추가</button>';
	content += '<button type="button" onclick="cancle()" class="btn btn-outline-primary" style="margin-left: 10px; width: 100px;">취소</button></div>';
	$('#fac_bookModal').empty();
	$('#fac_bookModal').append(content);
}

// 학력 등록 
function schoolWrite(){
	var content ='';
	console.log("학력 등록 요청"); 
	
	$('#modalCenterTitle').html("학력 추가");
	$('#modalCenter').modal("show"); 
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">시작일</label>';
	content += '<div class="col-md-10" id="start_date">';
	content += '<input class="form-control end" type="date" id="html5-date-local-input" name="start_date" />';
	content += '</div></div>'; 
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">종료일</label>';
	content += '<div class="col-md-10" id="end_date">';
	content += '<input class="form-control end" type="date" id="html5-date-local-input" name="end_date" />';
	content += '</div></div>'; 
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">학교명</label>';
	content += '<div class="col-md-10" style="float: right;">';
	content += '<input class="form-control end" type="text" id="content" class="form-control"/>'; 
	content += '</div></div>';  
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">비고</label>';
	content += '<textarea id="content" class="form-control"></textarea>';
	content += '</div><br/><br/>'; 
	//  버튼 
	content += '<div style="margin:auto;"><button type="button" onclick="fbSubmit()" class="btn btn-primary" style="width: 100px;">추가</button>';
	content += '<button type="button" onclick="cancle()" class="btn btn-outline-primary" style="margin-left: 10px; width: 100px;">취소</button></div>';
	$('#fac_bookModal').empty();
	$('#fac_bookModal').append(content);
}

// 모달 취소
function cancle() {
	$('#modalCenter').modal("hide"); 
}



/*

// 부서 listCall
function depListCall(){
	 console.log("모달 부서리스트콜");
	$.ajax({
		type:'GET',
		url:'/admin/actDepList.ajax',
		dataType:'JSON',
		success:function(data){
			console.log(data);
			console.log(data.list);
 			drawDepList(data.list);
		},
		error:function(e){
			console.log(e);
		}		
	});	
}//depListCall()

function drawDepList(DepList){
	var content='';
	content += '<option value="blank">부서 선택</option>';
	
	for(i=0;i<DepList.length;i++){
		content +='<option value="'+DepList[i].dep_idx+'">'+DepList[i].name+'</option>';   
	$('#depOptionList').empty();
	$('#depOptionList').append(content);
	$('#depOptionList2').empty();
	$('#depOptionList2').append(content);
	}
}//drawDepList(DepList)

*/

//상태+부서변경로그
function stateListCall() {
	const mem_id = $("#idDetail").text();
	
		$.ajax({
		type:'GET',
		url:'/admin/stateList.ajax',
		dataType:'JSON',
		data:{mem_id},
		success:function(data){
			console.log("ajax 이력:"+data.work);
			console.log("ajax 학력:"+data.school);
			console.log("ajax 조회 권한:"+data.auth);
			console.log("ajax 부서로그:"+data.dep);
			console.log("ajax 상태로그:"+data.state);
			drawStateList(data);			
			
		},
		error:function(e){
			console.log(e);
		}		
	});		
}//stateListCall() 

//상태+부서변경로그 뿌리기
function drawStateList(data){
	var content='';
	
	var workList = data.work;
	var schoolList = data.school;
	var authList = data.auth;
	var depList = data.dep;
	var stateList = data.state;
	
	//이력
	for(i=0;i<workList.length;i++){

		content += '<tr>';
		content += '<td>'+workList[i].start_date+'</td>';  //시작
		content += '<td>'+workList[i].end_date+'</td>'; //종료
		content += '<td>'+workList[i].posName+'</td>';	//회사
		content += '<td>'+workList[i].comment+'</td>';	//비고	
		content += '<td>'+workList[i].car_idx+'</td>';	//삭제	
		content += '</tr>';
		
		$('#workList').empty();// 상태변경 추가
		$('#workList').append(content);
	}
	
	//학력
	for(i=0;i<schoolList.length;i++){

		content += '<tr>';
		content += '<td>'+schoolList[i].start_date+'</td>';  //시작
		content += '<td>'+schoolList[i].end_date+'</td>'; //종료
		content += '<td>'+schoolList[i].posName+'</td>';	//회사
		content += '<td>'+schoolList[i].comment+'</td>';	//비고	
		content += '<td>'+schoolList[i].car_idx+'</td>';	//삭제	
		content += '</tr>';
		
		$('#schoolList').empty();// 상태변경 추가
		$('#schoolList').append(content);
	}
	
	//조회 권한
	for(i=0;i<authList.length;i++){
		var name = '' //부서이름 혹은 프로젝트 명
		
		content += '<tr>';
		content += '<td>'+authList[i].category+'</td>';  //카테고리
		content += '<td>'+authList[i].name+'</td>'; //소분류
		content += '<td>'+authList[i].parti+'</td>';	//참여권한
		content += '<td>삭제버튼</td>';//삭제
		content += '</tr>';
		
		$('#authList').empty();// 상태변경 추가
		$('#authList').append(content);
	}
	
	//부서 변경 이력
	for(i=0;i<depList.length;i++){

		content += '<tr>';
		content += '<td>'+depList[i].date+'</td>';  //변경일
		content += '<td>'+depList[i].depName+'</td>'; //부서
		content += '<td>'+depList[i].posName+'</td>';	//직급
		content += '<td>'+depList[i].dutyName+'</td>';//직책
		content += '<td>'+depList[i].modi_idx+'</td>'; //변경자	
		content += '<td>'+depList[i].comment+'</td>';	//비고	
		content += '</tr>';
		
		$('#depList').empty();// 상태변경 추가
		$('#depList').append(content);
	}
	
	//상태 변경 이력
	for(i=0;i<stateList.length;i++){
		content = '';
		var state = '';
		
		if(stateList[i].state == '0'){
			state = "재직중";
		}else if(stateList[i].state == '1'){
			state = "반차";
		}else if(stateList[i].state == '2'){
			state = "휴가";
		}else if(stateList[i].state == '3'){
			state = "병가";
		}else if(stateList[i].state == '4'){
			state = "출장";
		}else if(stateList[i].state == '5'){
			state = "기타";
		}else if(stateList[i].state == '6'){
			state = "퇴사";
		}
		
		content += '<tr>';
		content += '<td>'+stateList[i].date+'</td>';  //변경일
		content += '<td>'+state+'</td>'; //상태
		content += '<td>'+stateList[i].modi_id+'</td>'; //변경자	
		content += '<td>'+stateList[i].comment+'</td>';	//비고	
		content += '</tr>';
		
		$('#stateList').empty();// 부서변경 추가
		$('#stateList').append(content);
	}
	
	
}//drawStateList



</script>
</html>
