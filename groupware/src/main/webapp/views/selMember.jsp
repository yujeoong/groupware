<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>

<html>

<body>
	<!-- Vertically Centered Modal -->
	<!-- 	<div class="col-lg-4 col-md-6" id="selMemModal"> -->
	<div id="selMemModal">
		<div class="mt-3">

			<!-- Modal -->
			<div class="modal fade" id="modalCenter" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-lg"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
						<c:set var="URL" value="${pageContext.request.requestURL}" />
							<c:choose>
								<c:when test="${fn:contains(URL, 'appr')}">
									<h5 class="modal-title" id="modalCenterTitle">결재 라인 추가/삭제</h5>
								</c:when>
								<c:when test="${fn:contains(URL, 'prj')}">
									<h5 class="modal-title" id="modalCenterTitle">프로젝트 참여 사원 추가/삭제</h5>
								</c:when>
								<c:when test="${fn:contains(URL, 'mail')}">
									<h5 class="modal-title" id="modalCenterTitle">받는 사원 추가/삭제</h5>
								</c:when>
								<c:otherwise>
									<h5 class="modal-title" id="modalCenterTitle">?사원 추가/수정</h5>						
								</c:otherwise>
							</c:choose>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="row g-2">
								<div class="col mb-0">
									<label for="emailWithTitle" class="form-label">사원 리스트</label>
									<div class="mb-3">

										<!-- 부서 셀렉트박스 // 활성화 Y인것만 리스트 콜 -->
										<select class="form-select" id="depOptionList"
											aria-label="Default select example">
										</select>

									</div>
									<div class="list-group" id="memList"
										style="height: 300px; overflow: auto;"></div>
								</div>
								<div class="col mb-0">
									<label for="dobWithTitle" class="form-label">선택된 사원</label>
									<div style="height: 54px;"></div>
									<ul class="list-group" id="selMemList"
										style="height: 300px; overflow: auto;">
										<li class="list-group-item disabled">선택된 사원이 없습니다.</li>
									</ul>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">취소</button>
							<button onclick="sendSelMemList()" type="button"
								class="btn btn-primary" data-bs-dismiss="modal">저장</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	allMemList = [];
	url = location.pathname;

	//사원 리스트 호출
	function memListAjax() {
		$.ajax({
			type : 'get',
			url : '/prjManage/memList.ajax',
			dataType : 'json',
			success : function(data) {
				allMemList = data.memList;
				drawMemList(data.memList);
				drawDepList(data.depList);
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}

	//부서리스트
	function drawDepList(list) {
		content = '';
		content += '<option value="all">전체</option>';
		for (var i = 0; i < list.length; i++) {
			content += '<option value="'+list[i].dep_idx+'">'
					+ list[i].dep_name + '</option>';
		}
		$('#depOptionList').empty();
		$('#depOptionList').append(content);
	}

	$("#depOptionList").on("change", function() {
		console.log("부서번호" + $(this).val());
		console.log(allMemList);
		var newMemList = [];
		if ($(this).val() == "all") {
			drawMemList(allMemList);
		} else {
			for ( var i in allMemList) {
				console.log("사원: " + i);
				console.log("사원부서번호: " + allMemList[i].dep_idx);
				if (allMemList[i].dep_idx == $(this).val()) {
					newMemList.push(allMemList[i]);
				}
			}
			console.log("새로운 리스트: " + newMemList);
			drawMemList(newMemList);
		}
	});

	//전체 사원 리스트
	function drawMemList(list) {
		console.log("사원리스트 출력");
		content = '';
		tempList = list;
		for (var i = 0; i < list.length; i++) {
			content += '<a ondblclick="addList(' + [ i ]
					+ ')" class="list-group-item list-group-item-action">';
			content += list[i].dep_name + '&nbsp' + list[i].name + '&nbsp'
					+ list[i].duty_name + '</a>';

			//글쓴이가 0번에 들어가는 경우(결재, 프로젝트 참여자)
			if(selMemCategory == 'appr' || selMemCategory == 'prj'){
				if (list[i].mem_id == '${sessionScope.loginId}') {
					selMemList.splice(0, 1, list[i]);
				}
			}
		}

		console.log("사원리스트띄울때 ~ selMemList:{}", selMemList);
		$('#memList').empty();
		$('#memList').append(content);
		drawSelMemList(selMemList);
	}

	//선택한 사원 리스트
	function drawSelMemList(list) {
		content = '';

		//	if(selMemList.length<1){
		//		content = '<li class="list-group-item disabled">선택된 사원이 없습니다.</li>';
		//	}
		content += '<li class="list-group-item d-flex justify-content-between align-items-center">';
		content += list[0].dep_name + '&nbsp' + list[0].name + '&nbsp'
				+ list[0].duty_name + '&nbsp' + '</li>';

		for (var i = 1; i < list.length; i++) {
			content += '<li class="list-group-item d-flex justify-content-between align-items-center">';
			content += list[i].dep_name + '&nbsp' + list[i].name + '&nbsp'
					+ list[i].duty_name;
			content += '<i onclick="removeList('
					+ [ i ]
					+ ')" class="menu-icon tf-icons bx bx-checkbox-minus"></i></li>';
		}
		$('#selMemList').empty();
		$('#selMemList').append(content);
	}

	//선택 사원 추가
	function addList(i) {
		
		//결재라인인 경우 최대 5명까지
		if(selMemCategory == 'appr' && selMemList.length > 5){
			alert("결재라인: 최대 6명까지 추가 가능합니다.")
		}else{
			//중복체크
			let overlay = false;
			let levelCheck = true;
			for ( let idx in selMemList) {
				if(selMemCategory == 'appr' && selMemList[idx].level >= tempList[i].level){
					levelCheck = false;
					console.log(selMemList[idx].level);
					console.log(tempList[i].level);
				}
				if (selMemList[idx].mem_id == tempList[i].mem_id) {
					overlay = true;
				}
			}
			
			if (!levelCheck){
				alert("직책이 더 높은 사원을 선택하세요.")
			}else if (overlay) {
				alert("이미 선택된 사원입니다.");
			} else {
				selMemList.push(tempList[i]);
				console.log("추가 후: {}", selMemList);
				drawSelMemList(selMemList);
			}			
		}
	}

	//선택 사원 삭제
	function removeList(i) {
		selMemList.splice(i, 1);
		drawSelMemList(selMemList);
	}

	//선택 사원 리스트 저장(모달 닫힘)
	function sendSelMemList() {
		console.log(selMemList);
		drawConfirmMemList(selMemList);
	}
</script>
</html>
