<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href="/res/style.css" />
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

						<div class="container-xxl flex-grow-1 container-p-y">
							<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지 /</span> 쪽지함</h4>

					

						<div class="container">

							<div class="card mb-4">
								<div class="card-body">
									
									<div class="mb-3 row">
									<label for="html5-text-input" class="col-md-2 col-form-label-lg">제목</label>
									<div class="col-md-10">
										<input class="form-control-plaintext" type="text"
											value="${list.title}" id="html5-text-input" readonly/>
									</div>
									</div>
									
									<div class="mb-3 row">
									<label for="html5-text-input" class="col-md-2 col-form-label-lg">보낸사람</label>
									<div class="col-md-10">
										<input class="form-control-plaintext" type="text"
											value="${list.dept_name} ${list.mem_name} ${list.pos_name}" id="html5-text-input" readonly/>
										<input type="hidden" value="${list.sender_id}" />
									</div>
									</div>
									
									<div class="mb-3 row">
									<label for="html5-text-input" class="col-md-2 col-form-label-lg">받은시간</label>
									<div class="col-md-10">
										<div><p class="form-control-plaintext" onclick="timeStampCut(this)" id="ptagId">${list.date}</p></div>
									</div>
									</div>

									<div class="mb-3 row">
									<label for="html5-text-input" class="col-md-2 col-form-label-lg">받는사람</label>
									<div class="col-md-10">
										<p class="form-control-plaintext"><c:forEach items="${rcpList}" var="rcpList"	varStatus="status">
												${rcpList.dept_name} ${rcpList.mem_name} ${rcpList.pos_name}<c:if test="${status.last eq false}">,&nbsp;</c:if>
											</c:forEach></p>
									</div>
									</div>
									

									<div id="div_editor" style="height: 400px;">
										<span class="input-group-text" style="height: 282px;">${list.content}</span>
									</div>


									<c:if test = "${files.size()>0}">
									<br>
									<div class="mb-3 row">
										<label for="html5-text-input" class="col-md-2 col-form-label-lg">첨부파일</label>
										<div class="col-md-10" class="col-md-2 col-form-label-lg">
											<c:forEach items="${files}" var="path" varStatus="files">	
												 	<a class="form-control-plaintext" href="/mail/download.do?path=${path.new_file_name}">${path.ori_file_name}</a><br>
											</c:forEach>
										</div>
									</div>
								</c:if>
									
									
									
									<p style="height:10px;">&nbsp;</p>
										<input type="button" value = "답장" class="btn btn-primary float-end"  id="btnReply">
										<button type="button" class="btn btn-outline-primary float-end" style="margin-right: 10px;" id="btnList" 
													onclick="location.href='./receivedList.move'">목록</button>
					
		

									<input type="hidden" id="post_idx" value="${list.mail_idx}">
								</div> <!-- <div class="card-body"> -->
								</div> <!-- <!-- <div class="card mb-4"> -->
								
							<c:if test="${sessionScope.loginId eq list.sender_id}">
							<hr>
							<div class="card mb-4">	
								<div class="card-body">
									<div id=checkingList>
										<p><strong>읽은사람 (${fn:length(read_list)} 명)</strong></p> 
											<p><c:forEach items="${read_list}" var="read_list"	varStatus="status">
												${read_list.dept_name} ${read_list.mem_name} ${read_list.pos_name}<c:if test="${status.last eq false}">,&nbsp;</c:if>
											</c:forEach> </p>
										<br>
										<p><strong>안읽은사람 (${fn:length(unread_list)} 명)</strong></p>
											<p><c:forEach items="${unread_list}" var="unread_list"	varStatus="status">
												${unread_list.dept_name} ${unread_list.mem_name} ${unread_list.pos_name}<c:if test="${status.last eq false}">,&nbsp;</c:if>
											</c:forEach></p>
									</div>
								</div>
							</div>
							</c:if>
							

							
							
								<input type="hidden" name="mail_idx" value="${list.mail_idx}">
						</div> <!-- <div class="container"> -->
						</div> <!-- <div class="container-xxl flex-grow-1 container-p-y"> -->


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

window.onload = function timeStampCut(){
		var timestamp = $("#ptagId").text();
		console.log("실행확인2");
		console.log(timestamp);
	var date = new Date(timestamp);
	var year = date.getFullYear().toString(); //년도 뒤에 두자리
	var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
	var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
	var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
	var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
	var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
	var returnDate = year + "-" + month + "-" + day + " " + hour + ":" + minute;
			
	//return returnDate;
	console.log(returnDate);
	$("#ptagId").text(returnDate);
	}



//text editor 옵션
var text_editor_config = {};
text_editor_config.editorResizeMode = "none";
text_editor_config.toolbar = "simple";
//html 저장, 출력, PDF 저장, 코드 보기
text_editor_config.toolbar_simple = "{save, print, html2pdf, code}";

var editor = new RichTextEditor("#div_editor", text_editor_config);
editor.setReadOnly(); //읽기전용 옵션



$("#btnReply").on("click",function(){
	var result = confirm('답장하시겠습니까?');
    if(result) {
    	location.href='./replyForm.move?mail_idx=${list.mail_idx}';
    }else{
    	return false;
    }
});
	



</script>
</html>



