<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							<span class="text-muted fw-light">전자결재 /</span> 결재양식 생성
						</h4>

						<form action="/appr/formRegist.do" method="POST"
							id="doc_regist_form">
							<!-- Form controls -->
							<div class="card mb-4">
								<div class="card-body">
									<div class="row mb-3">
										<label for="exampleFormControlInput1" class="col-sm-2 col-form-label-lg">결재양식 제목</label>
										<div class="col-sm-10">
										<input type="text" class="form-control doc_form" name="subject"
											placeholder="결재양식 제목을 입력하세요." />
										</div>
									</div>
									<p style="height: 20px;">&nbsp;</p>
									<label for="exampleFormControlInput1" class="col-form-label-lg">결재양식 내용</label>
									<div id="div_editor" style="height: 700px;"></div>
									<input type="hidden" class="doc_form" name="content">

									<!--/ Hoverable Table rows -->
									<p style="height:10px;">&nbsp;</p>
									<input type="button" value = "등록" class="btn btn-primary float-end" onclick="form_regist()">
									<button class="btn btn-outline-primary float-end" style="margin-right: 10px;" onclick="location.href='/appr/docFormList.move'">취소</button>
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
	var msg = "${msg}";
	if (msg != "") {
		alert(msg);
	}

	//옵션
	var text_editor_config = {};
	text_editor_config.editorResizeMode = "none";
	//text_editor_config.placeholder = "결재양식 내용을 입력하세요.";

	text_editor_config.file_upload_handler = function(file, pathReplace) {
		console.log(file); //파일 정보 확인 가능
		if (file.size > (1 * 1024 * 1024)) { //1MB이상의 사진일 경우
			alert("1MB 이상의 사진 업로드 불가");
			pathReplace("/assets/img/avatars/noimg.png"); //data의 이미지 경로를 변경
		}
	}

	var editor = new RichTextEditor("#div_editor", text_editor_config);

	function form_regist() {
		console.log("form_regist~~~");
		$('input[name="content"]').val(editor.getHTMLCode());
		if(input_check()){		//공란체크		
			if(confirm('등록 하시겠습니까?')) {
				$('form').submit();	//등록
		    }
		}

		/*
		우리가 이미지를 사용할 때 현재 data:image/... 형식을 사용한다.
		장점: 사용이 간단하다(이미지를 본문과 함께 DB에 저장 가능)
		단점: 용량제어가 쉽지 않다.
		 */
	}
	

	//모든 값 입력되었는지 확인
	function input_check(){
	        var isRight = true;
	        $("#doc_regist_form").find("input").each(function(index, item){
	        	console.log("공란확인?");
	            // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
	            if ($(this).val().trim() == '') {
	            	if($(this).attr("name") == 'subject'){
		                alert("양식 제목을 입력하세요.");      		
	            	}else{
		                alert("양식 내용을 입력하세요.");
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
