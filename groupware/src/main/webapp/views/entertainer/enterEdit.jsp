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
					<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">수정하기 /</span> ${enterList.name}</h4>




			<form action="/entertainer/enterEdit.do" method="POST" enctype="multipart/form-data" id="ent_test_form">
			<input type="hidden" name="ent_idx" value="${enterList.ent_idx}"/>
				<div class="card mb-4">
                    <div class="card-body">
                      
                      <div class="d-flex align-items-start align-items-sm-center gap-4">
                        <img
                          src="https://dummyimage.com/500x500/ffffff/000000.png&text=preview+image"
                          alt="user-avatar"
                          class="d-block rounded"
                          height="140"
                          width="115"
                          id="preview-image"
                        />
                        <div class="button-wrapper">
                            <input class="form-control" type="file" id="input-image" name="photo" value="${enterProFile.ori_file_name}"/>
                          <p class="text-muted mb-0">허용되는 파일 JPG, GIF 또는 PNG. 최대 크기 800K</p>
                        </div>
                      </div>
                      
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">이름</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="name" value="${enterList.name}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">성별</label>
                        <div class="col-md-10">
                           <div class="form-check form-check-inline mt-3">
                            <input  class="form-check-input"  type="radio"  name="gender"  id="inlineRadio1" value="남"
                              <c:if test="${enterList.gender == '남'}">checked</c:if>
                            />
                            <label class="form-check-label" for="inlineRadio1">남자</label>
                          </div>
                          <div class="form-check form-check-inline">
                            <input  class="form-check-input" type="radio" name="gender"  id="inlineRadio2" value="여"
                              <c:if test="${enterList.gender == '여'}">checked</c:if>
                            />
                            <label class="form-check-label" for="inlineRadio2">여자</label>
                          </div>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">생년월일</label>
                        <div class="col-md-10">
                          <input class="form-control" type="date" id="html5-text-input" name="birth" value="${enterList.birth}"/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">혈액형</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="blood" value="${enterList.blood}"/>
                        </div>
                        
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">키</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="height" value="${enterList.height}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">몸무게</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="weight" value="${enterList.weight}"/>
                        </div>
                      </div>
                     
                     <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">상태 </label> 
                         <div class="col-md-10">
                         <c:if test="${enterList.state eq 1}">
	                        <select id="selectBox" class="form-select" name="state"> 
							  <option value="1" selected>연습생</option>
							  <option value="2">아티스트</option>
							  <option value="0">퇴사</option>
	                        </select>
                        </c:if>
                        <c:if test="${enterList.state eq 2}">
	                        <select id="selectBox" class="form-select" name="state"> 
							  <option value="1" >연습생</option>
							  <option value="2" selected>아티스트</option>
							  <option value="0">퇴사</option>
	                        </select>
                        </c:if>
                     </div>
                     
                     <div class="mb-3 row" id = "art">
                        <label for="html5-text-input" class="col-md-2 col-form-label">아티스트 추가 입력란</label>
                        <div class="col-md-10">
                        <label for="html5-text-input" class="col-md-2 col-form-label">*데뷔일자</label>
                          <input class="form-control" type="date" id="html5-text-input" name="debut_date" value="${artList.debut_date}"/>
                       <label for="html5-text-input" class="col-md-2 col-form-label">*매니저</label> 
                        <button type="button" class="btn btn-outline-primary float-end" data-bs-toggle="modal" data-bs-target="#modalCenter" onclick="memListAjax()">선택</button>
                          
              <!-- 사원 선택 모달(매니저) -->          
               <div class="row">
                <div class="modal fade" id="modalCenter" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-lg"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalCenterTitle">매니저 선택</h5>		
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="row g-2">
								<div class="col mb-0">
									<label for="emailWithTitle" class="form-label">사원 리스트</label>
									<div class="list-group" id="memList"
										style="height: 300px; overflow: auto;"></div>
								</div>
								<div class="col mb-0">
									<label for="dobWithTitle" class="form-label">선택된 사원</label>
									<ul class="list-group" id="selMemList"
										style="height: 300px; overflow: auto;">
										<li class="list-group-item disabled">${artList.name}</li>
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
					<!-- 모달 끝 -->
							
						  </div>
						  <div class="row" id="confirmMemList"></div> 
                          
                          
                          
                          <label for="html5-text-input" class="col-md-2 col-form-label">*예명</label><br>
                          <input class="form-control" type="text" id="html5-text-input" name="stage_name" value="${artList.stage_name}"/>
                          
                        </div>
                      </div>
					 </div>
                  	 
						
						

						<div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">취미</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="hobby" value="${enterList.hobby}"/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">특기</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="skill" value="${enterList.skill}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">외국어능력</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="language" value="${enterList.language}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">특이사항</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="enter_com" value="${enterList.enter_com}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">계약날짜</label>
                        <div class="col-md-10">
                         <c:forEach items="${enterLog}" var="log">
                          <input class="form-control" type="date" id="html5-text-input" name="cont_start_date" value="${log.cont_start_date}"/> ~ 
                          <input class="form-control" type="date" id="html5-text-input" name="cont_end_date" value="${log.cont_end_date}"/>
                          <input class="form-control" type="text" id="html5-text-input" placeholder="활동내용을 입력해주세요." name="con_com" value="${log.con_com}"/> <br>
                      </c:forEach>
                         </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">활동이력<button type="button" id="bntAdd" class="btn btn-xs btn-primary">추가</button></label>
                        <div class="col-md-10">
                        <div>
                         <c:forEach items="${enterCareer}" var="career">
                          <input class="form-control" type="date" id="html5-text-input" name="career_start_date[]" value="${career.start_date}"/> ~ 
                          <input class="form-control" type="date" id="html5-text-input" name="career_end_date[]" value="${career.end_date}"/>
                          <input class="form-control" type="text" id="html5-text-input" placeholder="이력내용을 입력해주세요." name="career_content[]" value="${career.content}"/> <br>
                      </c:forEach>
                        </div>
                        <div class="append"></div>
                      </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="formFile" class="col-md-2 form-label">첨부파일</label>
                        <div class="col-md-10">
                          <input class="form-control" type="file" id="html5-text-input" name="files" multiple="multiple"/>
                          <c:forEach items="${enterFiles}" var="file">
                          <div id="prent"></div>
							<p class="delete">${file.ori_file_name} <button type="button" id="btnDelete" class="btn btn-xs btn-primary">삭제</button></p><br>
						  </c:forEach>
                        </div>
                      </div>      
                       <input type="button" onclick="history.go(-1)" class="btn btn-outline-primary float-end" style="display :inline-block;" value="취소"/>        
                  	  <button class="btn btn-outline-primary float-end" id="input_check" style="display :inline-block; margin-right: 5px;">수정</button>
                  	  
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

$("#input_check").click(function(){
	 if($('#list').val()==''){
 		alert("공백은 안됩니당");
 		return false;
	 }else{

		 $("#ent_test_form").submit();
	 }

});

$('input[type=radio][name=artg_idx]').on('click',function(){
	var chkValue = $('input[type=radio][name=artg_idx]:checked').val();
	console.log(chkValue);
});

$(document).ready(function(){
    var wrapper = $('.append');
    var fieldHTML = '<div><input class="form-control" type="date" value="Sneat" id="html5-text-input" name="career_start_date[]"/> ~ <input class="form-control" type="date" value="Sneat" id="html5-text-input" name="career_end_date[]"/><input class="form-control" type="text" id="html5-text-input" placeholder="이력내용을 입력해주세요." name="career_content[]"/><input type="button" class="btn btn-outline-primary" id="btnRemove" value="삭제"/></div>';
    $('#bntAdd').click(function(){
            $('.append').append(fieldHTML); // Add field
        
    });
    $(wrapper).on('click', '#btnRemove', function(e){
        e.preventDefault();
        $(this).parent('div').remove(); // Remove field
    });
});


$(document).ready(function() {
	  $('#selectBox').change(function() {
	    var result = $('#selectBox option:selected').val();
	    if (result == '2') {
	      $('#art').show();
	    } else {
	      $('#art').hide();
	    }
	  }); 
	}); 
	
function readImage(input) {
    // 인풋 태그에 파일이 있는 경우
    if(input.files && input.files[0]) {
        // 이미지 파일인지 검사 (생략)
        // FileReader 인스턴스 생성
        const reader = new FileReader()
        // 이미지가 로드가 된 경우
        reader.onload = e => {
            const previewImage = document.getElementById("preview-image")
            previewImage.src = e.target.result
        }
        // reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    }
}
// input file에 change 이벤트 부여
const inputImage = document.getElementById("input-image")
inputImage.addEventListener("change", e => {
    readImage(e.target)
})





	selMemList = [];

	//사원 리스트 호출
	function memListAjax() {
		$.ajax({
			type : 'get',
			url : '/prjManage/memList.ajax',
			dataType : 'json',
			success : function(data) {
				drawMemList(data.memList);
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}
	/*
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
	*/

	//전체 사원 리스트
	 function drawMemList(list) {
		console.log("사원리스트 출력");
		content = '';
		tempList = list;
		for (var i = 0; i < list.length; i++) {
			if(list[i].dep_idx == 5){
			
			content += '<a ondblclick="addList(' + [ i ]
					+ ')" class="list-group-item list-group-item-action">';
			content += list[i].dep_name + '&nbsp' + list[i].name + '&nbsp'
					+ list[i].duty_name + '</a>';
			}
		}

		console.log("사원리스트띄울때 ~ selMemList:{}", selMemList);
		$('#memList').empty();
		$('#memList').append(content);
	}

	//선택한 사원 리스트
	function drawSelMemList(list) {
		content = '';

		if(selMemList.length<1){
			content = '<li class="list-group-item disabled">선택된 사원이 없습니다.</li>';
		}else{
			content += '<li class="list-group-item d-flex justify-content-between align-items-center">';
			content += list[0].dep_name + '&nbsp' + list[0].name + '&nbsp'+ list[0].duty_name;
			content += '<i onclick="removeList()" class="menu-icon tf-icons bx bx-checkbox-minus"></i></li>';
		}
		$('#selMemList').empty();
		$('#selMemList').append(content);
	}

	//선택 사원 추가
	function addList(i) {
		console.log("추가추가"+selMemList)
		if(selMemList.length >0){
			alert("1명만 선택 가능합니다.")
		}else{
			selMemList.push(tempList[i]);
		}
		drawSelMemList(selMemList);
	}

	//선택 사원 삭제
	function removeList() {
		selMemList.splice(0, 1);
		drawSelMemList(selMemList);
	}

	//선택 사원 리스트 저장(모달 닫힘)
	function sendSelMemList() {
		console.log("모달을닫거라");
		console.log(selMemList);
		drawConfirmMemList(selMemList);
	} 
	
	drawConfirmMemList(selMemList);

	function drawConfirmMemList(list) {
		console.log("confirmMem출력");
		console.log(list);
		content = '';
		for (var i = 0; i < list.length; i++) {
			content += '<div class="mb-3 col-md-2">';
			content += '<div class="input-group">';
			content += '<span class="input-group-text">' + (i + 1) + '</span>';
			content += '<input type="text" id="list" class="form-control" value="'+list[i].name+'" readonly />';
			content += '</div>';
			content += '</div>';
			content += '<input type="hidden" name="mem_id" value="'+list[i].mem_id+'"/>';
		}
		$('#confirmMemList').empty();
		$('#confirmMemList').append(content);

	}
</script>
</html>
