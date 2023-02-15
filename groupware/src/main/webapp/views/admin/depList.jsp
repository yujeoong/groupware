<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<style>
table {
	text-align: center;
	font-size: 15px;
}

.table th {
	padding: 0.5rem 1.25rem;
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
							<span class="text-muted fw-light">관리자 /</span> 부서 관리
						</h4>

						<!-- 부서 리스트 -->
						<!-- Hoverable Table rows -->
						<div>
							<div class="card">

								<!-- 등록 모달 실행 버튼 -->
								<div class="modal-footer" style="padding: 0;">
									<button type="button" class="btn btn-outline-primary"
										data-bs-toggle="modal" data-bs-target="#modalRegist">등록</button>
								</div>
								<div class="table-responsive text-nowrap">
									<!-- 리스트 테이블 -->
									<table class="table table-hover" style="table-layout: fixed;">
										<thead>
											<tr class="table_center">
												<th>부서 번호</th>
												<th>부서 명</th>

												<!-- 필터먹인 활성화여부 -->
												<th>
													<div class="nav-item dropdown">
														<a class="dropdown-toggle" href="javascript:void(0)"
															id="navbarDropdown" role="button"
															data-bs-toggle="dropdown" aria-expanded="false"> 활성화
															여부 </a>
														<ul class="dropdown-menu" aria-labelledby="navbarDropdown"
															style="text-align: center;">
															<li><button type="button" class="dropdown-item"
																	onclick="showWhat(this)" value="none">활성화 여부</button></li>
															<li><button type="button" class="dropdown-item"
																	onclick="showWhat(this)" value="Y">YES</button></li>
															<li><button type="button" class="dropdown-item"
																	onclick="showWhat(this)" value="N">NO</button></li>
														</ul>
													</div>
												</th>
												<th></th>
											</tr>
										</thead>

										<tbody id="listArea">
										</tbody>

									</table>
								</div>
							</div>
						</div>
						<!--/ Hoverable Table rows -->


						<!-- 등록 Modal -->
						<div class="col-lg-4 col-md-6">
							<div class="mt-3">
								<form name="Modals" id="modalDetail">
									<div class="modal fade" id="modalRegist" tabindex="-1"
										aria-hidden="true" data-bs-backdrop="static">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="modalRegistTitle">부서 등록</h5>
													<!-- 닫기 버튼 -->
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Close"></button>
												</div>

												<!-- 부서명 입력 -->
												<div class="modal-body">
													<div class="row">
														<div class="col mb-3">
															<label for="depNameWithTitle" class="col-md-2 col-form-label-lg">부서명</label>
															<input type="text" id="depName" class="form-control col-form-label-lg"
																placeholder="부서명을 입력해주세요" />
														</div>
													</div>

													<!-- 활성화 여부 라디오 -->
													<div class="col mb-0">
														<div class="mb-3">
															<div class="card-body">
																<div class="row gy-3">
																	<div class="col-md">
																		<small class="ext-light fw-semibold d-block col-form-label-lg">활성화
																			여부</small>
																		<!-- Y -->
																		<div style="text-align: center;">
																			<div class="form-check form-check-inline mt-3">
																				<input class="form-check-input col-form-label-lg" type="radio"
																					name="activeRegist" id="activeY" value="Y"
																					checked="checked" /> <label
																					class="form-check-label" for="inlineRadio1">YES</label>
																			</div>
																			<!-- N -->
																			<div class="form-check form-check-inline">
																				<input class="form-check-input col-form-label-lg" type="radio"
																					name="activeRegist" id="activeN" value="N" /> <label
																					class="form-check-label" for="inlineRadio2">NO</label>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="modal-footer">

													<button type="button" class="btn btn-primary"
														onclick="depRegist()">등록</button>
													<button type="button" class="btn btn-outline-secondary"
														data-bs-dismiss="modal">취소</button>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						<!-- 등록 모달 끝 / -->


						<!-- 수정 모달 -->
						<div class="col-lg-4 col-md-6">
							<div class="mt-3">
								<form name="Modals" id="modalUpdateForm">
									<div class="modal fade" id="modalUpdate" tabindex="-1"
										aria-hidden="true" data-bs-backdrop="static">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="modalUpdateTitle">상세보기</h5>
													<!-- 닫기 -->
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">
													<div class="row">
														<div class="col mb-3">
															<label for="depNameWithTitle" class="col-md-2 col-form-label-lg">부서명</label>
															<!-- 부서명 입력  -->
															<input type="text" id="nameUpdate" class="form-control col-form-label-lg"
																placeholder="부서명을 입력해주세요" readonly />
														</div>
													</div>
													<!-- 활성화여부 -->
													<div class="col mb-0">
														<div class="mb-3">
															<div class="card-body">
																<div class="row gy-3">
																	<div class="col-md">

																		<small class="text-light fw-semibold d-block col-form-label-lg">활성화
																			여부</small>
																		<!-- Y -->
																		<div style="text-align: center;">
																			<div class="form-check form-check-inline mt-3">
																				<input class="form-check-input col-form-label-lg" type="radio"
																					name="updateRadioOptions" id="activeY_update"
																					value="Y" onclick="return false;" /> <label
																					class="form-check-label" for="inlineRadio1">YES</label>
																			</div>
																			<!-- N -->
																			<div class="form-check form-check-inline">
																				<input class="form-check-input col-form-label-lg" type="radio"
																					name="updateRadioOptions" id="activeN_update"
																					value="N" onclick="return false;" /> <label
																					class="form-check-label" for="inlineRadio2">NO</label>
																			</div>
																		</div>
																		<div>
																			<input id="oldName" name="oldName" value="" readonly
																				style="display: none" />
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-primary"
														id="modalUpdateFormBtn" onclick="modalUpdateForm()">수정</button>
													<button type="button" class="btn btn-primary"
														id="modalUpdateBtn" onclick="modalUpdate()">저장</button>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						<!-- 수정 모달 끝 / -->

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
var checkName = '부서';//부서/직책/직급 확인용
var option = 'none';//필터링 조건 없음
AdminDepListCall(checkName,option);

//필터링
function showWhat(elem) {
	var option = $(elem).val();
	
	console.log(option);
	AdminDepListCall(checkName,option);
}

//시작하자마자 리스트
function AdminDepListCall(checkName,option){
	console.log("부서리스트콜");
	$.ajax({
		type:'GET',
		url:'/admin/adminDepList',
		dataType:'JSON',
		data:{checkName,
				option},
		success:function(data){
			console.log(data);
			console.log(data.list);
 			drawList(data.list);			
			
		},
		error:function(e){
			console.log(e);
		}		
	});	
}//AdminDepListCall(page)

//리스트 뿌리기
function drawList(AdminDepList){
	var content='';
	var type='';
	console.log("AdminDepList length : "+AdminDepList.length);
	if(AdminDepList.length == 0){
		
		content += '<tr class="table_center">'
		content += '<td colspan="4"> 해당하는 부서가 없습니다. </td>'
		content += '</tr>'
		
		$('#listArea').empty();
		$('#listArea').append(content);
	}else{
		for(i=0;i<AdminDepList.length;i++){
			
			if(AdminDepList[i].active == 'Y'){
				activeColor = 'badge bg-label-warning';
			}else if(AdminDepList[i].active == 'N'){
				activeColor = 'badge bg-label-danger';
			}

			content +='<tr id="drawListTr" class="table_center">';
			content +='<td id = "listIdx"><i class="fab fa-bootstrap fa-lg text-primary me-3"></i>'+AdminDepList[i].dep_idx+'</td>'; //부서번호
			content +='<td><a role="button" data-bs-toggle="modal" data-bs-target="#modalUpdate" id="facListNameA" onclick="getElem(this)"><strong id = "listName">'+AdminDepList[i].name+'</strong></a></td>'; //시설명
			content +='<td><span id="listActive" class="'+activeColor+'">'+AdminDepList[i].active+'</span></td>';
			content +='<td><button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalUpdate" onclick="getElem(this);modalUpdateForm();">수정</a></td>';
			
			/*
			//수정,삭제 드롭다운
			content += '<td><div class="dropdown">';
			content += '<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">';
			content += '<i class="bx bx-dots-vertical-rounded"></i>';
			content += '</button>';
			content += '<div class="dropdown-menu">';
			content += '<button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#modalUpdate" onclick="getElem(this)"><i class="bx bx-edit-alt me-1"></i>상세보기</a>';
			content += '<button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#modalUpdate" onclick="getElem(this);modalUpdateForm();"><i class="bx bx-edit-alt me-1"></i>수정</a>';
			content += '</div>';
			content += '</div></td>';			
			content +='</tr>';     
			*/
			
		$('#listArea').empty();
		$('#listArea').append(content);
		}
		if(AdminDepList.length<2){
			$(".table-responsive").css("overflow-x","clip");
		}
	}
}//drawList(AdminDepList)


//부서등록
function depRegist(){
	console.log("부서등록");
	var name = $('#depName').val().trim();
	console.log("트림왜안돼 :"+name);
	var active = $('input[name=activeRegist]:checked').val(); 
	
	console.log(name);
	console.log(active);
	
	//공란확인
	if(name == ''){
		alert('부서 명을 작성해주세요');
		}else{
			$.ajax({
				type:'POST',
				url:'/admin/depRegist.ajax',
				data: {name,
					active,
					checkName
				},
				dataType:'JSON',
				success:function(data){
					console.log(data.msg);
					if(data.msg == "success"){
						$('#modalRegist').modal('hide'); //모달 닫힘
						$('#modalRegist').on('hidden.bs.modal', function (elem) {
							document.forms['Modals'].reset(); //모달이 닫힐 때 값 초기화
						});
						AdminDepListCall(checkName,option);
					}else{
						alert("부서명이 중복입니다.");
					};			
				},
				error:function(e){
					console.log(e);
				}		
			});	
		}//if문종료
}//depRegist()


//상세보기 파라미터 가져오기
function getElem(elem){
	console.log("getElem 실행"+elem);
	var listName =$(elem).closest('#drawListTr').find('#listName').text();
	var listActive =$(elem).closest('#drawListTr').find('#listActive').text(); 
	//var facListName =$(elem).find('#facListName').text(); //<p><span><b><strong>은 text()
	//var tagName = $('span').closest('div').prop('tagName'); // 길찾아갈때 유용한 prop
	
	console.log("listName : "+listName);
	console.log("listActive : "+listActive);
	
	$('#nameUpdate').val(listName);
	$('input:radio[name="updateRadioOptions"]:radio[value="'+listActive+'"]').prop('checked',true); 
	$('#oldName').val(listName);

	$('#modalUpdateBtn').hide();
	$('#modalUpdateFormBtn').show();
}//getElem()

//수정 폼 열기
function modalUpdateForm(){
	var newTitle = "부서 수정";
	$("#modalUpdateTitle").html(newTitle); //상세보기 => 부서 수정 : 모달헤더변경
	$("#nameUpdate").prop('readonly',false); //부서명 reaonly 해제
	$('input[name=updateRadioOptions]').prop('onclick','return true'); // 라디오버튼 return false = > true

	$("#modalUpdateBtn").show();
	$("#modalUpdateFormBtn").hide();
}


//수정 기능
function modalUpdate(){
	console.log("수정 기능 시작");
	var name = $('#nameUpdate').val().trim();
	console.log("트림왜안돼 :"+name);
	var active = $('input[name=updateRadioOptions]:checked').val(); 
	var oldName = $('#oldName').val();
	
	//공백검사
	if(name == ''){
		alert('부서명을 작성해주세요');
	}else{
		//수정한 이름과 수정전 이름이 일치할 시 공백처리
		if(name == oldName){
			name = '';
		}
		
		console.log(name);
		console.log(active);
		console.log(oldName);
		console.log(checkName);
		
		$.ajax({
			type:'POST',
			url:'/admin/depUpdate.ajax',
			data: {name,
				active,
				oldName,
				checkName,
			},
			dataType:'JSON',
			success:function(data){
				console.log(data.update);
				if(data.update == "success"){
					$('#modalUpdate').modal('hide'); //모달 닫힘
					AdminDepListCall(checkName,option);
				}else if(data.update == "activeFail"){
					alert("활성화 상태를 변경할 수 없습니다.");
				}else{
					alert("부서명이 중복입니다.");					
				};			
			},
			error:function(e){
				console.log(e);
			}		
		});	
	}
}//modalUpdate()

//모달창 닫히면 초기화
$('#modalUpdate').on('hidden.bs.modal', function () {
	document.forms['Modals'].reset();
	var newTitle = "상세보기";
	$("#modalUpdateTitle").html(newTitle); //부서 수정 => 상세보기 : 모달헤더변경
	$("#nameUpdate").prop('readonly',true); //부서명 reaonly
	$('input[name=updateRadioOptions]').attr('onclick','return false'); // 라디오버튼 return true = > false

	$("#modalUpdateBtn").hide();
	$("#modalUpdateFormBtn").show();
});




</script>
</html>
