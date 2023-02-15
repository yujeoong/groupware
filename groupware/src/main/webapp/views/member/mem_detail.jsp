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
							<span class="text-muted fw-light">사원관리 /</span> 사원 상세보기
						</h4>

						<!-- 부트스트랩 -->
						<div class="col-xl">
							<div class="card mb-4">
								<div
									class="card-header d-flex justify-content-between align-items-center">
									<!-- 사원 상세보기 헤더 -->
									<h5 class="mb-0">사원 상세보기</h5>
								</div>
								<div class="card-body">

									<!-- 프로필사진첨부+미리보기 -->
									<div class="mb-3">
										<label class="col-md-2 col-form-label-lg" for="basic-icon-default-fullname">프로필
											사진</label>
										<div class="row g-2">

											<img id="profilePreview"
												src="/photo/${profile.new_file_name}"
												style="width: auto; height: 200px; margin: auto; border-radius: 70%;" />

										</div>
									</div>


									<div class="mb-3">
										<input type="file" id="profileFile" class="form-control"
											name="profile" onchange="profileChange(event)"
											value="${profile}"
											style="width: 40%; margin: 0 auto; display: none;"
											disabled="disabled" /> <input id="imgId" class="imgUpload"
											disabled="disabled" onchange="readURL(this);"
											style="display: none;">
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

											<dt class="col-sm-3">이메일</dt>
											<dd class="col-sm-9">${member.email}</dd>
	
											<dt class="col-sm-3">번호</dt>
											<dd class="col-sm-9">${member.phone}</dd>
	
											<dt class="col-sm-3">주소</dt>
											<dd class="col-sm-9">${member.address}</dd>

											<!-- 
											이런것도 있군
											<dt class="col-sm-3"></dt>
											<dd class="col-sm-9">
												<dl class="row ">
													<dt class="col-sm-3"></dt>
													<dd class="col-sm-9"></dd>
												</dl>
											</dd>
											이런것도 있군 참고용/ -->
										</dl>

										<dl class="row g-2 right">

											<dt class="col-sm-3">부서</dt>
											<dd class="col-sm-9">${member.depName}</dd>

											<dt class="col-sm-3">직급</dt>
											<dd class="col-sm-9">${member.posName}</dd>

											<dt class="col-sm-3">직책</dt>
											<dd class="col-sm-9">${member.dutyName}</dd>

											<dt class="col-sm-3">서명이미지</dt>
											<dd class="col-sm-9">

												<!-- 서명첨부+미리보기 -->
												<img id="signPreview" src="/photo/${sign.new_file_name}"
													style="width: auto; height: 200px; margin: auto; padding: 30px;" />
												<input id="signId" class="signImg" disabled="disabled"
													onchange="readURL(this);" style="display: none;">

												<!-- 서명첨부+미리보기 /-->

											</dd>
										</dl>
									</div>

									<div class="row" style="width:100%;"></div>
									<div>
										<button type="button" class="btn btn-outline-primary"
											onclick="location.href='/member/memUpdate.move?mem_id=${loginId}'"
											style="float: right;">수정</button>
									</div>
									<p>&nbsp;</p>
									<p>&nbsp;</p>
									<div class="divider">
										<div class="divider-text">추가 정보</div>
									</div>

									<!-- 이력 -->
									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">이력</h5>
										<button type="button" class="btn btn-sm btn-outline-primary"
											onclick="workWrite()" style="float: right;">추가</button>
										<p>&nbsp;</p>
										<div class="table-responsive text-nowrap"
											style="height: 200px">
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
												</tbody>
											</table>
										</div>
									</div>


									<!-- 학력 -->
									<div class="table-responsive text-nowra logTables">
										<h5 class="mb-0">학력</h5>
										<button type="button" class="btn btn-sm btn-outline-primary"
											onclick="schoolWrite()" style="float: right;">추가</button>
										<p>&nbsp;</p>
										<div class="table-responsive text-nowrap"
											style="height: 200px">
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
												</tbody>
											</table>
										</div>
										<br />
									</div>


									<!-- 조회권한 -->
									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">조회 권한</h5> 
										<p>&nbsp;</p>
										<div class="table-responsive text-nowrap"
											style="height: 200px">
											<table class="table table-hover" style="text-align: center;">
												<thead>
													<tr>
														<th>카테고리</th>
														<th>소분류</th>
														<th>참여권한</th> 
													</tr>
												</thead>
												<tbody id="authList">

												</tbody>
											</table>
										</div>
									</div>

									<p>&nbsp;</p>
									<!-- 부서로그 -->
									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">부서 | 직급 | 직책 변경</h5>
										<p>&nbsp;</p>
										<div class="table-responsive text-nowrap"
											style="height: 200px">
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
												<tbody id="changeList">
												</tbody>
											</table>
										</div>
									</div>


									<!-- 상태로그 -->
									<div class="table-responsive text-nowrap logTables">
										<h5 class="mb-0">상태 변경</h5>
										<button type="button" class="btn btn-sm btn-outline-primary"
											onclick="location.href='/schedule/adminScheWriteForm.move?mem_id=${member.mem_id}'"
											style="float: right;">스케줄러 이동</button>
										<p>&nbsp;</p>
										<div class="table-responsive text-nowrap"
											style="height: 300px">
											<table class="table table-hover" style="text-align: center;">
												<thead>
													<tr>
														<th>변경일</th>
														<th>상태</th>
														<!-- <th>변경자</th> -->
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
						</div>


						<!-- 모달 이력/학력 등록 -->
						<div class="modal fade" id="modalCenter" tabindex="-1">
							<div class="modal-dialog">
								<form class="modal-content">
									<div class="modal-header" style="flex-direction: row-reverse">
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
										<h5 class="modal-title" id="modalCenterTitle"></h5>
									</div>
									<div class="modal-body" id="careermodal">
										<div class="mb-3 row">
											<label for="html5-datetime-local-input"
												class="col-md-2 col-form-label">시작일</label>
											<div class="col-md-9" style="margin: 0 auto;">
												<input class="form-control end" type="date"
													id="html5-date-local-input" name="start_date" />
											</div>
										</div>
										<div class="mb-3 row">
											<label for="html5-datetime-local-input"
												class="col-md-2 col-form-label">종료일</label>
											<div class="col-md-9" style="margin: 0 auto;">
												<input class="form-control end" type="date"
													id="html5-date-local-input" name="end_date" />
											</div>
										</div>
										<div class="mb-3 row">
											<label for="html5-datetime-local-input"
												class="col-md-2 col-form-label">회사/학교명</label>
											<div class="col-md-9" style="margin: 0 auto;">
												<!-- style="float: right;" -->
												<input class="form-control end" type="text" id="car_name"
													class="form-control" /> <input class="form-control end"
													type="hidden" id="car_category" value=""
													class="form-control" />
											</div>
										</div>
										<div class="row">
											<label for="nameWithTitle" class="form-label">비고</label>
											<textarea id="detail" class="form-control"></textarea>
										</div>
										<br /> <br />
										<!-- 버튼 -->
										<div class="float-end" style="margin: auto;">
											<button type="button" onclick="careerRegist()"
												class="btn btn-primary" style="width: 100px;">추가</button>
											<button type="button" class="btn btn-outline-primary"
												data-bs-dismiss="modal"
												style="margin-left: 10px; width: 100px;">취소</button>
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
	memDetail();

	// 이력 조회  (상태+부서변경로그)
	function memDetail() { 
		var mem_id = ${loginId};
		console.log(mem_id);

		$.ajax({
			type : 'get',
			url : '/member/memDetail.ajax',
			data : {
				'mem_id' : mem_id
			},
			dataType : 'json',
			success : function(data) {
				console.log(data);

				drawWorkList(data);
				drawSchList(data);
				drawChangeList(data);
				drawStateList(data);
				drawAuthList(data);
			},
			error : function(e) {
				console.log("ERROR" + e);
			}
		});
	}//stateListCall() 

	// 조회 권한 로그 
	function drawAuthList(data) {
		var content = '';
		var list = data.authList;

		if (list != null) {
			for (var i = 0; i < list.length; i++) {
				if (list[i].category == "1") {
					content += '<tr>';
					content += '<td>부서</td>';
					content += '<td>' + list[i].name + '</td>';

					if (list[i].parti == 'Y') {
						content += '<td>"참여"</td>';
					} else {
						content += '<td>"조회"</td>';
					} 
					content += '</tr>';
				} else if (list[i].category == "2") {
					content += '<tr>';
					content += '<td>프로젝트</td>';
					content += '<td>' + list[i].name + '</td>';
					if (list[i].parti == 'Y') {
						content += '<td>"참여"</td>';
					} else {
						content += '<td>"조회"</td>';
					} 
					content += '</tr>';
				} else if (list[i].category == "3") {
					content += '<tr>';
					content += '<td>아티스트/연습생</td>';
					content += '<td>-</td>';
					if (list[i].parti == 'Y') {
						content += '<td>"참여"</td>';
					} else {
						content += '<td>"조회"</td>';
					} 
					content += '</tr>';
				}
			}
			$('#authList').empty();
			$('#authList').append(content);
		} else if (list == null || list.length == 0) {
			content += '<tr>';
			content += '<td colspan="3">해당 데이터가 없습니다.</td>';
			content += '</tr>';
			$('#authList').empty();
			$('#authList').append(content);
		}
	}

	// 상태 변경 로그
	function drawStateList(data) {
		var content = '';
		var list = data.stateList;

		if (list.length >= 1) {
			for (var i = 0; i < list.length; i++) {
				content += '<tr>';
				content += '<td>' + list[i].date + '</td>';
				content += '<td>' + list[i].state + '</td>'; 
				content += '<td>' + list[i].comment + '</td>';
				content += '</tr>';
			}
			$('#stateList').empty();
			$('#stateList').append(content);
		} else if (list.length == 0) {
			content += '<tr>';
			content += '<td colspan="3">해당 데이터가 없습니다.</td>';
			content += '</tr>';
			$('#stateList').empty();
			$('#stateList').append(content);
		}
	}

	// 부서,직급,직책 변경 로그 
	function drawChangeList(data) {
		var content = '';
		var list = data.changeList;

		if (list.length >= 1) {
			for (var i = 0; i < list.length; i++) {
				content += '<tr>';
				content += '<td>' + list[i].date + '</td>';
				content += '<td>' + list[i].dep_idx + '</td>';
				content += '<td>' + list[i].pos_idx + '</td>';
				content += '<td>' + list[i].duty_idx + '</td>';
				content += '<td>' + list[i].modi_idx + '</td>';
				content += '<td>' + list[i].comment + '</td>';
				content += '</tr>';
			}
			$('#changeList').empty();
			$('#changeList').append(content);
		} else if (list.length == 0) {
			content += '<tr>';
			content += '<td colspan="6">해당 데이터가 없습니다.</td>';
			content += '</tr>';
			$('#changeList').empty();
			$('#changeList').append(content);
		}

	}

	// 이력 그리기
	function drawWorkList(data) {
		var content = '';
		var list = data.careerList;

		if (list.length >= 1) {
			for (var i = 0; i < list.length; i++) {
				if (list[i].car_category == "이력") {
					content += '<tr>';
					content += '<td>' + list[i].start_date + '</td>';
					content += '<td>' + list[i].end_date + '</td>';
					content += '<td>' + list[i].car_name + '</td>';
					content += '<td>' + list[i].detail + '</td>';
					content += '<td><button type="button" id="'
							+ list[i].car_idx
							+ '" onclick="carDelete(this)" class="btn btn-xs float-end" name="career">삭제</button>';
					content += '</tr>';
				}
			}
			$('#workList').empty();
			$('#workList').append(content);
		} else if (list.length == 0) {
			content += '<tr>';
			content += '<td colspan="5">해당 데이터가 없습니다.</td>';
			content += '</tr>';
			$('#workList').empty();
			$('#workList').append(content);
		}
	}

	// 학력 그리기
	function drawSchList(data) {
		var content = '';
		var list = data.careerList;

		if (list.length >= 1) {
			for (var i = 0; i < list.length; i++) {
				if (list[i].car_category == "학력") {
					content += '<tr>';
					content += '<td>' + list[i].start_date + '</td>';
					content += '<td>' + list[i].end_date + '</td>';
					content += '<td>' + list[i].car_name + '</td>';
					content += '<td>' + list[i].detail + '</td>';
					content += '<td><button type="button" id="'
							+ list[i].car_idx
							+ '" onclick="carDelete(this)" class="btn btn-xs float-end" name="career">삭제</button>';
					content += '</tr>';
				}
			}
			$('#schoolList').empty();
			$('#schoolList').append(content);
		} else if (list.length == 0) {
			content += '<tr>';
			content += '<td colspan="5">해당 데이터가 없습니다.</td>';
			content += '</tr>';
			$('#schoolList').empty();
			$('#schoolList').append(content);
		}
	}

	// 등록 요청 
	function careerRegist() {
		var mem_id = $("#idDetail").text();
		var car_category = $('#car_category').val();
		// 태그 자체 가져오기 
		$start_date = $("input[name='start_date']");
		$end_date = $("input[name='end_date']");
		$car_name = $("input[id='car_name']");
		$detail = $("textarea[id='detail']");

		// 공란 여부 확인 
		if ($start_date.val() == '') {
			alert('시작일을 입력해 주세요.');
		} else if ($end_date.val() == '') {
			alert('종료일을 입력해 주세요.');
		} else if ($car_name.val() == '') {
			alert('회사/학교명을 입력해 주세요.');
			$content.focus();
		} else {
			console.log('서버로 전송');

			$.ajax({
				type : 'get',
				url : '/member/careerRegist.ajax',
				data : {
					start_date : $start_date.val(),
					end_date : $end_date.val(),
					car_name : $car_name.val(),
					detail : $detail.val(),
					car_category : car_category,
					mem_id : mem_id
				},
				dataType : 'JSON',
				success : function(success) {
					console.log(success);

					$('#modalCenter').modal("hide");
					$('#schoolList').empty();
					$('#workList').empty();
					memDetail();
				},
				error : function(e) {
					console.log("ERROR:" + e);
				}
			}); // ajax 
		}
	}

	// 이력 등록
	function workWrite() {
		console.log("이력 등록 요청");

		$('#modalAuthWrite').empty();
		$('input[id=car_category]').attr('value', "이력");
		//console.log($('#car_category').val());
		$('#modalCenterTitle').html("이력 추가");
		$('#modalCenter').modal("show");
	}

	// 학력 등록 
	function schoolWrite() {
		console.log("학력 등록 요청");

		$('input[id=car_category]').attr('value', "학력");
		$('#modalCenterTitle').html("학력 추가");
		$('#modalCenter').modal("show");
	}

	// 이력학력 삭제 
	function carDelete(elem) {
		var idx = $(elem).attr('id');
		//console.log(idx);
		elem.parentNode.parentNode.remove();

		$.ajax({
			type : 'get',
			url : '/member/careerDelete.ajax',
			data : {
				'car_idx' : idx
			},
			dataType : 'json',
			success : function(data) {
				console.log(data);

				alert("해당 데이터가 삭제되었습니다.");
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}

	// 모달 데이터 삭제 
	$('.modal').on('hidden.bs.modal', function(e) {
		console.log($(this));
		$(this).find('form')[0].reset();
	});
</script>
</html>
