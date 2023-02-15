<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script type="text/javascript" src="/richtexteditor/rte.js"></script>
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
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
               		<span class="text-muted fw-light">부서 게시판 / 
		              	<c:choose>
							<c:when test="${param.dep_idx eq 1}">재무 / </c:when>
							<c:when test="${param.dep_idx eq 2}">인사 / </c:when>
							<c:when test="${param.dep_idx eq 3}">경영 / </c:when>
							<c:when test="${param.dep_idx eq 4}">신인개발 / </c:when>
							<c:when test="${param.dep_idx eq 5}">매니지먼트 / </c:when>
		              		<c:otherwise>공지사항</c:otherwise>
					</c:choose>
					</span>
		              글작성

				</h4>

				
					<div class="container">
						<form name="form" id="form" method="POST" action="/post/regist.do" enctype="multipart/form-data">
	
							<div class="card mb-4">
								<div class="card-body">

									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg" for="basic-default-name">제목</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력해 주세요." />
											<input type="hidden" name="dep_idx" value="${param.dep_idx}"/>
										</div>
									</div>	


									<div class="mb-3 row">
										<label for="html5-text-input" class="col-md-2 col-form-label-lg">작성자</label>
										<div class="col-md-10">
											<div>
												<input type="text" class="form-control" id="mem_id" name="mem_id" value="${sessionScope.loginId}" readonly />
											</div>
										</div>
									</div>	



									<div class="input-group input-group-merge speech-to-text">
										<div id="div_editor" style="height: 500px;"></div>
											<input type="hidden" class="doc_form" name="content" />
											
									</div>	
									
									
									<div class="mb-3 row">
											<label for="html5-text-input" class="col-md-2 col-form-label-lg">첨부파일</label>
											<div class="col-md-10">
												<div>
													<input type="file" name="files" multiple="multiple" />
												</div>
											</div>
									</div>
								
									
									<p style="height:10px;">&nbsp;</p>
										<input type="button" value = "작성" class="btn btn-primary float-end" onclick="form_regist()">
										<button type="button" class="btn btn-outline-primary float-end" style="margin-right: 10px;" onclick="history.back()">취소</button>
													
								</div>
							</div>
						</form>
					</div>
	
				
			</div>
            <!-- / Content -->

            <!-- Footer -->
				<%@ include file="../footer.jsp" %>
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

//글 등록
function form_regist() {
	$('input[name="content"]').val(editor.getHTMLCode());
	if (input_check()) { //공란체크		
			if (confirm('작성 하시겠습니까?')) {
				$('form').submit(); //등록
			}
		}
	}
	


function input_check(){
	if(form.title.value == ""){
		form.subject.focus();
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







</script>
</html>
