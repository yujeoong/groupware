<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>

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
							<span class="text-muted fw-light">프로젝트 /</span> 프로젝트 수정
						</h4>

						<form action="/prjManage/edit.do" method="POST"
							id="project_regist_form">
							<!-- Form controls -->
							<div class="card mb-4">
								<div class="card-body">
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">프로젝트명</label>
										<div class="col-sm-10">
											<input type="text" class="form-control input_necessary" name="prj_subject"
												placeholder="프로젝트 이름을 입력하세요." value="${project.prj_subject}" />
										</div>
									</div>

									<!-- 프로젝트 번호 -->
									<input type="hidden" name="prj_idx" value="${project.prj_idx}" />

									<!-- 작성자 -->
									<input type="hidden" name="mem_id" value="${project.mem_id}" />

									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">프로젝트 설명</label>
										<div class="col-sm-10">
											<textarea class="form-control input_necessary" name="prj_content" rows="5">${project.prj_content}</textarea>
										</div>
									</div>

									<!-- 시작/종료 -->
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">프로젝트 시작 날짜</label>
										<div class="col-sm-4">
											<input class="form-control" type="date" id="start_date"
												name="prj_start_date" value="${project.prj_start_date}" />
										</div>
									</div>
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">프로젝트 종료 날짜</label>
										<div class="col-sm-4">
											<input class="form-control" type="date" id="end_date"
												name="prj_end_date" value="${project.prj_end_date}" />
										</div>
									</div>
									<p style="height: 10px;">&nbsp;</p>
									<button type="button" class="btn btn-outline-primary float-end"
										data-bs-toggle="modal" data-bs-target="#modalCenter"
										onclick="memListAjax()">추가/수정</button>
									<label class="col-form-label-lg">프로젝트 참여자</label>

									<%@ include file="../selMember.jsp"%>
									<div class="card">
										<div class="table-responsive text-nowrap">
											<table class="table table-hover">
												<thead>
													<tr class="table_center">
														<th>사원번호</th>
														<th>부서</th>
														<th>이름</th>
														<th>직책</th>
<!-- 														<th>직급</th> -->
														<th>참여 권한</th>
													</tr>
												</thead>
												<tbody class="table-border-bottom-0" id="confirmMemList">
												</tbody>
											</table>
										</div>
									</div>
									<!--/ Hoverable Table rows -->
									<p style="height: 10px;">&nbsp;</p>
									<button type="button" class="btn btn-primary float-end"
										onclick="form_regist()">수정</button>
									<button type="button" class="btn btn-outline-primary float-end"
										style="margin-right: 5px;" onclick="back()">취소</button>
								</div>
							</div>
						</form>
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
//이전페이지로 이동
	function back() {
		window.location.href= document.referrer;	
	}

	//참여자 리스트 가져오기
	authListAjax();
	tempList = [];
	selMemList = [];
	selMemCategory = "prj";
	
	function authListAjax() {
		$.ajax({
			type : 'get',
			url : '/prjManage/authList.ajax',
			data : {
				"prj_idx" : "${project.prj_idx}"
			},
			dataType : 'json',
			success : function(data) {
				selMemList = data;
				
				//작성자를 조회자리스트 0번째로 이동
				for (var i = 0; i < selMemList.length; i++) {
					if(selMemList[i].mem_id == ${project.mem_id}){
						var temp = selMemList[i];
						selMemList.splice(i,1);
						selMemList.unshift(temp);
					}
				}
				
				drawConfirmMemList(selMemList);
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}

	//drawConfirmMemList(selMemList);

	function drawConfirmMemList(list) {
		console.log("confirmMem출력");
		console.log(list);
		content = '';
		content += '<tr class="table_center">';
		//<td><input type="text" name="authorityDTOList[0].mem_id" value="${sessionScope.loginId}" class="form-control"></td>
		content += '<td><input type="text" name="authorityDTOList[0].mem_id" value="'+list[0].mem_id+'" class="form-control input-group-text" readonly></td>';
		content += '<td>' + list[0].dep_name + '</td>';
		content += '<td>' + list[0].name + '</td>';
		content += '<td>' + list[0].duty_name + '</td>';
//		content += '<td>' + list[0].pos_name + '</td>';
		content += '<td><input name="authorityDTOList[0].parti" class="form-check-input" type="checkbox" value="Y" id="defaultCheck1" checked="checked" onClick="return false;"/></td>';
		content += '</tr>';

		for (var i = 1; i < list.length; i++) {
			content += '<tr class="table_center">';
			content += '<td><input type="text" name="authorityDTOList['+i+'].mem_id" value="'+list[i].mem_id+'" class="form-control input-group-text" readonly></td>';
			content += '<td>' + list[i].dep_name + '</td>';
			content += '<td>' + list[i].name + '</td>';
			content += '<td>' + list[i].duty_name + '</td>';
//			content += '<td>' + list[i].pos_name + '</td>';
			if (list[i].parti == 'Y') {
				content += '<td><input name="authorityDTOList['+i+'].parti" class="form-check-input" type="checkbox" value="Y" id="defaultCheck1" checked="checked"/></td>';
			} else {
				content += '<td><input name="authorityDTOList['+i+'].parti" class="form-check-input" type="checkbox" value="Y" id="defaultCheck1" /></td>';
			}
			content += '</tr>';
		}

		$('#confirmMemList').empty();
		$('#confirmMemList').append(content);
	}
	
	
	//시작날짜 변경 시 종료날짜 속성 변경
	document.getElementById("start_date").onchange = function () {
	    var tempEnd = document.getElementById("end_date");
	    
	    var startDate = $('#start_date').val();
	    var endDate = $('#end_date').val();

	    //-을 구분자로 연,월,일로 잘라내어 배열로 반환
	    var startArray = startDate.split('-');
	    var endArray = endDate.split('-');   

	    //배열에 담겨있는 연,월,일을 사용해서 Date 객체 생성
	    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
	    var end_date = new Date(endArray[0], endArray[1], endArray[2]);

	    //날짜를 숫자형태의 날짜 정보로 변환하여 비교
	    if(start_date.getTime() > end_date.getTime()) {
	    	//시작날짜가 종료날짜보다 늦으면 종료날짜를 시작날짜로 변경한다.
		    tempEnd.value=this.value;
	    }
		tempEnd.setAttribute("min", this.value);
	    
	}
	function form_regist() {
		console.log("form_regist~~~");
		if (input_check()) { //공란체크		
			console.log("공란없음~~~");
			if (selMemList.length < 1) { //프로젝트 참여자 확인(생성자만 있어도 됨)
				alert("프로젝트 참여자를 추가하세요.");
			} else {
				if(confirm('수정 하시겠습니까?')) {
					$('form').submit(); //등록
					//$("#project_regist_form").submit();
			    }
			}
		}
	}
	
	//모든 값 입력되었는지 확인
function input_check(){
	var isRight = true;
	$("#project_regist_form").find(".input_necessary").each(function(index, item) {
		// 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
		if ($(this).val().trim() == '') {
			if($(this).attr("name") == 'prj_subject'){
				alert("프로젝트명을 입력하세요.");					
			}else if($(this).attr("name") == 'prj_content'){
				alert("프로젝트 설명을 입력하세요.");											
			}else{
				alert("해당 항목을 입력하세요.");
			}
			isRight = false;
			$(this).focus();
			return false;
		}
	});
	if (isRight) {
		return true;
	}
}
</script>
</html>
