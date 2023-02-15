<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href="/res/style.css" />
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script type="text/javascript" src="/richtexteditor/rte.js"></script>
<script type="text/javascript"
	src='/richtexteditor/plugins/all_plugins.js'></script>
</head>
<body>
  <!-- Layout wrapper 메뉴 들어가게 하고 싶으면 .. layout-without-menu-->
  <div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
      <!-- Menu -->
		<%@ include file="../menu.jsp" %>
      <!-- Layout container -->
      <div class="layout-page">
        <!-- Header -->
		<%@ include file="../header.jsp" %>
        <!-- / Header -->

				<!-- Content wrapper -->
				<div class="content-wrapper">
					<!-- Content -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">쪽지 /</span> 새 쪽지
						</h4>
						
						<div class="container">
							<form name="form" id="form" method="POST" action="/mail/regist.do" enctype="multipart/form-data">

								<div class="card mb-4">
									<div class="card-body">

										<div class="row mb-3">
											<label class="col-sm-2 col-form-label-lg" for="basic-default-name">제목</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해 주세요." />
											</div>
										</div>

										<div class="mb-3 row">
											<label for="html5-text-input" class="col-md-2 col-form-label-lg">보낸사람</label>
											<div class="col-md-10">
												<div>
													<input type="text" class="form-control" id="sender_id" name="sender_id" value="${sessionScope.loginId}" readonly />
												</div>
											</div>
										</div>

										<div class="mb-3 row">
											<label for="html5-text-input" class="col-md-2 col-form-label-lg">받는사람</label>
											<div class="col-sm-10">
												<button type="button" class="btn btn-outline-primary float-end"
												data-bs-toggle="modal" data-bs-target="#modalCenter" 
												onclick="memListAjax()">추가/수정</button>
											</div>
										</div>
													
											<div class="row">
												<%@ include file="../selMember.jsp"%>
											</div>
											
											<div class="row" id="confirmMemList"></div>		

											<div class="input-group input-group-merge">
												<div id="div_editor" style="height: 500px;"></div>
												<input type="hidden" class="doc_form" name="content"><br/>
											</div>
											
											<!-- 첨부파일 -->
											<div class="row mb-3">
												<label class="col-sm-2 col-form-label-lg">첨부 파일</label>
												<div class="col-sm-3">
													<input class="form-control" type="file" id="file_input" name="files" multiple />
													<div id="file_preview"></div>
												</div>
											</div>
											

											<!-- 전송/취소 버튼 -->
											<p style="height:10px;">&nbsp;</p>
													<input type="button" value = "전송" class="btn btn-primary float-end" onclick="form_regist()">
													<button type="button" class="btn btn-outline-primary float-end" style="margin-right: 10px;" onclick="history.back()">취소</button>
													

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
var msg = "${msg}";
if (msg != "") {
	alert(msg);
}




//선택한 사원 초기값(0번에 로그인한 사람)
//session에서 받아와서 아이디 이름 등 변경
selMemList = [ {
	mem_id : '',
	name : '',
	dep_name : '',
	duty_name : ''
} ];

selMemCategory = "mail";

//선택된 사원 리스트 출력
drawConfirmMemList(selMemList);

function drawConfirmMemList(list) {
	console.log("confirmMem출력");
	console.log(list);
	content = '';
	for (var i = 1; i < list.length; i++) {
		content += '<div class="mb-3 col-md-2">';
		content += '<div class="input-group">';
		content += '<span class="input-group-text">' + (i) + '</span>';
		content += '<input type="text" class="form-control" id="rcpName" value="'+list[i].name+'" readonly />';
		content += '</div>';
		content += '</div>';
		content += '<input type="hidden" name="apprLineDTOList['+i+'].mem_id" value="'+list[i].mem_id+'"/>';
		content += '<input type="hidden" name="apprLineDTOList['+i+'].order" value="'+i+'"/>';
	}
	$('#confirmMemList').empty();
	$('#confirmMemList').append(content);

}



//텍스트 에디터 - 옵션
var text_editor_config = {};
text_editor_config.editorResizeMode = "none";

text_editor_config.file_upload_handler = function(file, pathReplace) {
	console.log(file); //파일 정보 확인 가능
	if (file.size > (1 * 1024 * 1024)) { //1MB이상의 사진일 경우
		alert("1MB 이상의 사진 업로드 불가");
		pathReplace("/assets/img/avatars/noimg.png"); //data의 이미지 경로를 변경
	}
}


//텍스트 에디터
var editor = new RichTextEditor("#div_editor",text_editor_config);


	//전송 버튼 클릭시 
	function form_regist() {
		$('input[name="content"]').val(editor.getHTMLCode());
		if (input_check()) { //공란체크		
			if (selMemList.length < 2) { //받는사람을 선택하기 (0번째 공란 제외)
				alert("받는사람을 추가하세요.");
			} else {
				if (confirm('전송 하시겠습니까?')) {
					$('form').submit(); //등록
				}
			}
		}
	}
	
	
function input_check(){
	if(form.title.value == ""){
		form.title.focus();
		alert("제목을 입력하세요.");
		return false;
	} else if(form.content.value == ""){
		form.content.focus();
		alert("내용을 입력하세요.");
		return false;
	} else {
		return true;
	}
}


//첨부파일 미리보기
var fileInput = document.getElementById('file_input');
var dataTranster = new DataTransfer();
$('#file_input').on('change',function(){
	console.log("change~~");
	console.log(dataTranster);
	var fileList = event.target.files;
	for(var i = 0; i < fileList.length; i++){
		dataTranster.items.add(fileList[i]);
		$('#file_preview').append('<p id='+fileList[i].lastModified+'>'+fileList[i].name+'<a data-index='+fileList[i].lastModified+' onClick="fncRemove(this)" class="file-remove"><i class="bx bx-trash-alt me-1"></i></a></p>');
		console.log("파일입니다 "+fileList[i].lastModified);
	}
	fileInput.files = dataTranster.files;
	console.log(dataTranster);
	console.log(fileInput.files);
});

//첨부파일 삭제
function fncRemove(obj){
	var removeTargetId = obj.dataset.index;
	var fileList = fileInput.files;
	console.log(fileInput.files);

	console.log(dataTranster);
	for(var i = 0; i < dataTranster.files.length; i++){
		if(removeTargetId == dataTranster.files[i].lastModified){
			dataTranster.items.remove(i);
		}
	}
	console.log(dataTranster);
	fileInput.files = dataTranster.files;
	$("#"+removeTargetId).remove();
	console.log("파일삭제 "+removeTargetId);
	console.log(fileInput.files);
	console.log(dataTranster);
	
}
	
	
	
	

</script>
</html>
















