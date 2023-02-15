<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<style>
textarea.form-control {
	resize: none;
}

.msg_content {
	display: block;
	width: 200px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-align: center;
	align-items: center;
}
</style>
</head>

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
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">관리자 /</span> 시설관리
						</h4>



						<!-- 시설 리스트 -->
						<!-- Hoverable Table rows -->
						<div class="card">
							<div class="table-responsive text-nowrap">
								<!-- 등록 모달 실행 버튼 -->
								<div class="demo-inline-spacing">
									<button type="button" class="btn btn-outline-primary float-end"
										data-bs-toggle="modal" data-bs-target="#modalCenter">등록</button>
								</div>
								<table class="table table-hover"
									style="text-align: center; table-layout: fixed;">
									<thead>
										<tr class="table_center">
											<th>시설 번호</th>
											<th>시설 명</th>
											<!-- 필터먹인 활성화여부 -->
											<th>
												<div class="nav-item dropdown">
													<a class="dropdown-toggle" href="javascript:void(0)"
														id="navbarDropdown" role="button"
														data-bs-toggle="dropdown" aria-expanded="false">시설 종류</a>
													<ul class="dropdown-menu" aria-labelledby="navbarDropdown"
														style="text-align: center;">
														<li><button type="button" class="dropdown-item"
																onclick="showWhat(this)">시설 종류</button></li>
														<li><button type="button" class="dropdown-item"
																onclick="showWhat(this)">시설</button></li>
														<li><button type="button" class="dropdown-item"
																onclick="showWhat(this)">차량</button></li>
														<li><button type="button" class="dropdown-item"
																onclick="showWhat(this)">기타</button></li>
													</ul>
												</div>
											</th>

											<th>상태</th>
											<th>비고</th>
											<th></th>
										</tr>
									</thead>
									<tbody id="listArea">
									</tbody>

								</table>
							</div>
						</div>
						<!--/ Hoverable Table rows -->


						<!-- 검색 박스 -->
						</br>
						<div class="input-group input-group-merge" id="facSearchDiv"
							style="width: 60%; margin: 0 auto;">
							<span class="input-group-text" id="basic-addon-search31"><i
								class="bx bx-search"></i></span> <input type="text"
								class="form-control" placeholder="시설명을 입력해주세요"
								aria-label="Search..." aria-describedby="basic-addon-search31"
								value="" id="facNameSearch" />


							<button type="button" class="btn btn-outline-primary"
								onclick="facSearch(this)">검색</button>

						</div>

						<!-- 페이지 네이션 -->
						<div class="card-body">
							<div class="demo-inline-spacing">
								<nav aria-label="Page navigation" style="text-align: center">
									<ul class="pagination justify-content-center" id="pagination">

									</ul>
								</nav>
							</div>
						</div>
						<!-- 페이지 네이션 /-->


						<!-- 등록 Modal -->
						<div class="col-lg-4 col-md-6">
							<div class="mt-3">
								<form name="facModal">
									<div class="modal fade" id="modalCenter" tabindex="-1"
										aria-hidden="true" data-bs-backdrop="static">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="modalCenterTitle">시설 등록</h5>
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">
													<div class="row">
														<div class="col mb-3">
															<label for="facNameWithTitle" class="col-md-2 col-form-label-lg">시설명</label>
															<input type="text" id="facName" class="form-control col-form-label-lg"
																placeholder="시설명을 입력해주세요" />
														</div>
													</div>
													<div class="row g-2">
														<div class="col mb-0">
															<div class="mb-3">
																<label for="facTypeWithTitle" class="col-form-label-lg">시설종류
																</label> <select id="facType" class="form-select col-form-label-lg">
																	<option value="blank">시설종류</option>
																	<option value="0">시설</option>
																	<option value="1">차량</option>
																	<option value="2">기타</option>
																</select>
															</div>
														</div>

														<!-- 시설상태 셀렉트박스 -->
														<div class="col mb-0">
															<div class="mb-3">
																<label for="facStateWithTitle" class="col-form-label-lg">시설상태
																</label> <select id="facState" class="form-select col-form-label-lg">
																	<option value="blank">시설상태</option>
																	<option value="사용가능">사용가능</option>
																	<option value="사용중">사용중</option>
																	<option value="사용불가">사용불가</option>
																</select>
															</div>
														</div>
													</div>
													<div class="col mb-0">
														<label for="facTextarea" class="col-form-label-lg">비고</label>
														<textarea class="form-control" id="facComment" rows="3"></textarea>
													</div>

												</div>
												<div class="modal-footer">

													<button type="button" class="btn btn-primary"
														onclick="facRegist()">등록</button>
													<button type="button" class="btn btn-outline-secondary"
														data-bs-dismiss="modal">취소</button>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>



						<!-- 상세 모달 -->
						<div class="col-lg-4 col-md-6">
							<div class="mt-3">
								<form name="facModal" id="modalDetail">
									<div class="modal fade" id="modalUpdate" tabindex="-1"
										aria-hidden="true" data-bs-backdrop="static">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="modalUpdateTitle">시설 상세보기</h5>
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">
													<div class="row">
														<div class="col mb-3">
															<label for="facNameWithTitle" class="col-form-label-lg">시설명</label>
															<input type="text" id="facNameUpdate"
																class="form-control" placeholder="시설명을 입력해주세요" value=""
																readonly />
														</div>
													</div>
													<div class="row g-2">
														<div class="col mb-0">
															<div class="mb-3">
																<label for="facTypeWithTitle" class="col-form-label-lg">시설종류
																</label> <select id="facTypeUpdate" class="form-select">
																	<option value="blank">시설종류</option>
																	<option value="0">시설</option>
																	<option value="1">차량</option>
																	<option value="2">기타</option>
																</select>
															</div>
														</div>

														<div class="col mb-0">
															<div class="mb-3">
																<label for="facStateWithTitle" class="col-form-label-lg">시설상태
																</label> <select id="facStateUpdate" class="form-select">
																	<option value="blank">시설상태</option>
																	<option value="사용가능">사용가능</option>
																	<option value="사용중">사용중</option>
																	<option value="사용불가">사용불가</option>
																</select>
															</div>
														</div>
													</div>
													<div class="col mb-0">
														<label for="facTextarea" class="col-form-label-lg">비고</label>
														<textarea class="form-control" id="facCommentUpdate"
															rows="3" readonly></textarea>
													</div>
													<input id="facOldName" name="facOldName" value="" readonly
														style="display: none" />
												</div>
												<div class="modal-footer">

													<button type="button" class="btn btn-primary"
														id="facUpdateFormBtn" onclick="facUpdateForm()">수정</button>
													<button type="button" class="btn btn-primary"
														id="facUpdateBtn" onclick="facUpdate()">저장</button>
												</div>
											</div>

										</div>

									</div>
								</form>
							</div>
						</div>










					</div>
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



</body>
<script>
window.onload = function(){
	$(".table-responsive").css("overflow-x","clip");
}


// 현재 보여줄 페이지 지정
var showPage = 1;//첫 페이지
var option = 'none';//필터링 조건 없음
var searchWhat = ''; //검색 조건 없음

//필터링
function showWhat(elem) {
	var option = $(elem).html();
	if(option=='시설 종류'){
		option = 'none';
	}else if(option=='시설'){
		option = '0';
	}else if(option=='차량'){
		option = '1';
	}else if(option=='기타'){
		option = '2';
	}
	
	console.log(option);
	AdminFacListCall(showPage,option,searchWhat);
}

//hoisting
AdminFacListCall(showPage,option,searchWhat);

function AdminFacListCall(page,option,searchWhat){
	console.log("시설리스트콜");
	console.log("page : "+page);
	console.log("option : "+option);
	console.log("searchWhat : "+searchWhat);
	$.ajax({
		type:'GET',
		url:'/admin/facList.ajax',
		data:{page, 
				option,
				searchWhat}, // page라는 이름으로 page넣기
		dataType:'JSON',
		success:function(data){
			console.log(data);
			console.log(data.list);
 			console.log(data.total);
 			console.log(data.page);
 			drawList(data);
			
		},
		error:function(e){
			console.log(e);
		}		
	});	
}//AdminFacListCall(page)


function drawList(data){
	var AdminFaclist = data.list;
	var content='';
	var type='';
	
	for(i=0;i<AdminFaclist.length;i++){
	  
		if(AdminFaclist[i].type=='0'){
			type = '시설';
		}else if(AdminFaclist[i].type=='1'){
			type = '차량';
		}else if(AdminFaclist[i].type=='2'){
			type = '기타';
		}
		
		if(AdminFaclist[i].state == '사용가능'){
			statecolor = 'badge bg-label-primary';
		}else if(AdminFaclist[i].state == '사용중'){
			statecolor = 'badge bg-label-warning';
		}else if(AdminFaclist[i].state == '사용불가'){
			statecolor = 'badge bg-label-secondary';
		}
		
			content +='<tr id="drawListTr" class="table_center">';
			content +='<td>'+AdminFaclist[i].fac_idx+'</td>'; //시설 번호
			content +='<td><a role="button" data-bs-toggle="modal" data-bs-target="#modalUpdate" id="facListNameA" onclick="getElem(this)"><strong id = "facListName">'+AdminFaclist[i].name+'</strong></a></td>'; //시설명
			content +='<td id = "facListType">'+type+'</td>'; //시설종류
			content +='<td><span class="'+statecolor+' me-1" id="facListState">'+AdminFaclist[i].state+'</span></td>'; //시설 상태
			content +='<td><div id="facListComment" class="msg_content">'+AdminFaclist[i].comment+'</div></td>' //비고
			content +='<td><button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalUpdate" onclick="getElem(this);facUpdateForm();">수정</a></td>';

		
		$('#facListComment').attr('style',"display:none;");//comment td 숨기기
		$('#listArea').empty();
		$('#listArea').append(content);
	}
	
	listPaging(data);
	
}//drawList(AdminFaclist)



// 페이징그리기 
function listPaging(data) { // page : 전체 페이지 
	var page = data.total; 
	var showPage = data.page;
	
	console.log(page); // 전체 페이지 
	console.log(showPage); // 현재 showPage 
	
	var content = '';

	content += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="AdminFacListCall('
			+ 1
			+ ',option,searchWhat); return false;"><i class="tf-icon bx bx-chevrons-left"></i></a></li>';
	if (showPage - 1 > 0) {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="AdminFacListCall('
				+ (showPage - 1)
				+ ',option,searchWhat); return false;"><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	} else {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" ><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	}
	for (var i = 0; i < page; i++) { // class="page-item active" : 선택 보라색 
		if (showPage == (i + 1)) {
			content += '<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="AdminFacListCall('
					+ (i + 1)
					+ ',option,searchWhat); return false;">'
					+ (i + 1)
					+ '</a></li>';
		} else {
			content += '<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="AdminFacListCall('
					+ (i + 1)
					+ ',option,searchWhat); return false;">'
					+ (i + 1)
					+ '</a></li>';
		}
	}
	if (showPage + 1 <= page) {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="AdminFacListCall('
				+ (showPage + 1)
				+ ',option,searchWhat); return false;"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	} else {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	}
	content += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="AdminFacListCall('
			+ page
			+',option,searchWhat); return false;"><i class="tf-icon bx bx-chevrons-right"></i></a></li>';
			
	$('#pagination').empty();
	$('#pagination').append(content);
}


//시설등록
function facRegist(){
	console.log("시설등록");
	var facName = $('#facName').val();
	var facType = $('#facType option:selected').val();
	var facState = $('#facState option:selected').val();
	var facComment = $('#facComment').val();
	
	console.log(facComment);
	console.log(facName);
	console.log(facState);
	console.log(facType);
	
	//공란확인
	if(facName == ''){
		alert('시설 명을 작성해주세요');
		}else if(facType == 'blank'){
			alert('시설 종류를 선택해주세요');
		}else if(facState == 'blank'){
			alert('시설 상태를 선택해주세요');
		}else{
		$.ajax({
			type:'POST',
			url:'/admin/facRegist.ajax',
			data: {facName,
				facType,
				facState,
				facComment
			},
			dataType:'JSON',
			success:function(data){
				console.log(data.fac);
				if(data.fac == "success"){
					$('#modalCenter').modal('hide'); //모달 닫힘
					$('#modalCenter').on('hidden.bs.modal', function (elem) {
						document.forms['facModal'].reset(); //모달이 닫힐 때 값 초기화
					});
					var page = 1;
					AdminFacListCall(page,option,searchWhat);
				}else{
					alert("시설명이 중복입니다.");
				};			
			},
			error:function(e){
				console.log(e);
			}		
		});	
	}
}//facRegist()


//시설상세보기 파라미터 가져오기
function getElem(elem){
	console.log("getElem 실행"+elem);
	var facListName =$(elem).closest('#drawListTr').find('#facListName').text();
	var facListType =$(elem).closest('#drawListTr').find('#facListType').text(); 
	var facListState =$(elem).closest('#drawListTr').find('#facListState').text(); 
	var facListComment =$(elem).closest('#drawListTr').find('#facListComment').text(); 
	//var facListName =$(elem).find('#facListName').text(); //<p><span><b><strong>은 text()
	//var tagName = $('span').closest('div').prop('tagName'); // 길찾아갈때 유용한 prop
	
	if(facListType =='시설'){
		facListType = '0';
	}else if(facListType =='차량'){
		facListType = '1';
	}else if(facListType =='기타'){
		facListType = '2';
	}
	
	console.log("facListName : "+facListName);
	console.log("facListType : "+facListType);
	console.log("facListState : "+facListState);
	console.log("facListComment : "+facListComment);
	
	
	$('#facNameUpdate').val(facListName);
	$('#facOldName').val(facListName);
	$('#facTypeUpdate').val(facListType).prop('disabled',true);
	$('#facStateUpdate').val(facListState).prop('disabled',true);
	$('#facCommentUpdate').text(facListComment);
	
	$('#facUpdateBtn').hide();
	$('#facUpdateFormBtn').show();
}



//시설 수정 폼 열기
function facUpdateForm(){
	var newTitle = "시설 수정";
	$("#modalUpdateTitle").html(newTitle);
	$("#facNameUpdate").prop('readonly',false);
	$("#facTypeUpdate").prop('disabled',false);
	$("#facStateUpdate").prop('disabled',false);
	$("#facCommentUpdate").prop('readonly',false);
	$("#facUpdateBtn").show();
	$("#facUpdateFormBtn").hide();
}

//시설 수정
function facUpdate(){
	console.log("시설수정");
	var facNewName = $('#facNameUpdate').val();
	var facNewType = $('#facTypeUpdate option:selected').val();
	var facNewState = $('#facStateUpdate option:selected').val();
	var facNewComment = $('#facCommentUpdate').val();
	var facOldName = $('#facOldName').val();
	
	//공백검사
	if(facNewName == ''){
		alert('시설 명을 작성해주세요');
		}else if(facNewType == 'blank'){
			alert('시설 종류를 선택해주세요');
		}else if(facNewState == 'blank'){
			alert('시설 상태를 선택해주세요');
		};
	
	if(facListType =='시설'){
		facListType = '0';
	}else if(facListType =='차량'){
		facListType = '1';
	}else if(facListType =='기타'){
		facListType = '2';
	}
	 

	if(facNewName == facOldName){
		facNewName = '';
	}
	
	/*
	console.log(facNewComment);
	console.log(facNewName);
	console.log(facNewState);
	console.log(facNewType);
	console.log(facOldName);
	*/
	
	$.ajax({
		type:'POST',
		url:'/admin/facUpdate.ajax',
		data: {facNewName,
			facNewType,
			facNewState,
			facNewComment,
			facOldName
		},
		dataType:'JSON',
		success:function(data){
			console.log(data.fac);
			if(data.fac == "success"){
				$('#modalUpdate').modal('hide'); //모달 닫힘
				var page = 1;
				AdminFacListCall(page,option,searchWhat);
			}else{
				alert("시설명이 중복입니다.");
			};			
		},
		error:function(e){
			console.log(e);
		}		
	});	
}//facUpdate()

//시설명 검색
function facSearch(elem) {
	console.log(elem);
	var searchWhat = $(elem).closest("#facSearchDiv").find("#facNameSearch").val();
	console.log(searchWhat);
	AdminFacListCall(showPage,option,searchWhat);
}		


//모달창 닫히면 초기화
$('#modalUpdate').on('hidden.bs.modal', function () {
	document.forms['facModal'].reset();
	var newTitle = "시설 상세보기";
	$("#modalUpdateTitle").html(newTitle);
	$("#facNameUpdate").prop('readonly',true);
	$("#facTypeUpdate").prop('disabled',true);
	$("#facStateUpdate").prop('disabled',true);
	$("#facCommentUpdate").prop('readonly',true);
	$("#facUpdateBtn").hide();
	$("#facUpdateFormBtn").show();
});



</script>
</html>
