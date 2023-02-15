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

			<h4 class="fw-bold py-3 mb-4">
				
					<c:choose>
							<c:when test="${list.dep_idx eq 1}"><span class="text-muted fw-light">부서 게시판 / </span>재무 </c:when>
							<c:when test="${list.dep_idx eq 2}"><span class="text-muted fw-light">부서 게시판 / </span>인사 </c:when>
							<c:when test="${list.dep_idx eq 3}"><span class="text-muted fw-light">부서 게시판 / </span>경영 </c:when>
							<c:when test="${list.dep_idx eq 4}"><span class="text-muted fw-light">부서 게시판 / </span>신인개발 </c:when>
							<c:when test="${list.dep_idx eq 5}"><span class="text-muted fw-light">부서 게시판 / </span>매니지먼트 </c:when>
							<c:otherwise>공지사항</c:otherwise>
					</c:choose>
			</h4>
			
			
			<!-- 만약 post_idx의 dep_idx가 99값일때 -> 공지사항 -->
				<div class="card mb-4">
					<div class="card-body">
						
					<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label-lg">제목</label>
					<div class="col-md-10">
						<input class="form-control-plaintext" type="text"
							value="${list.subject}" id="html5-text-input" readonly/>
					</div>
					</div>

					<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label-lg">작성자</label>
					<div class="col-md-10">
						<input class="form-control-plaintext" type="text"
							value="${list.dept_name} ${list.mem_name} ${list.pos_name}" id="html5-text-input" readonly/>
					</div>
					</div>
					
					<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label-lg">작성일</label>
					<div class="col-md-10">
						<div><p class="form-control-plaintext" onclick="timeStampCut(this)" id="ptagId">${list.date}</p></div>
					</div>
					</div>
					
					<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label-lg">조회수</label>
					<div class="col-md-10">
						<input class="form-control-plaintext" type="text"
							value="${list.cnt}" id="html5-text-input" readonly/>
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
										<a class="form-control-plaintext" href="/post/download.do?path=${path.new_file_name}">${path.ori_file_name}</a><br>
								</c:forEach>
							</div>
						</div>
					</c:if>


						<p style="height: 10px;">&nbsp;</p>
						<div>
							<c:choose>
								<c:when test="${list.dep_idx ne 99}">
									<button type="button" style="float: left;"
										onclick="location.href='/post/postList${list.dep_idx}.move'"
										class="btn btn-outline-primary" id="bntList">목록</button>
								</c:when>

								<c:when test="${list.dep_idx eq 99}">
									<button type="button"
										onclick="location.href='/noticeList.move'"
										class="btn btn-outline-primary" id="bntList">목록</button>
								</c:when>
							</c:choose>


							<c:if test="${sessionScope.loginId == list.mem_id}">
								<input type="button" value="수정"
									class="btn btn-primary float-end" id="btnEdit">
								<button type="button"
									class="btn btn-outline-primary float-end"
									style="margin-right: 10px;" id="btnDelete">삭제</button>
							</c:if>
						</div>


									<input type="hidden" id="post_idx" value="${list.post_idx}">
						</div> <!-- <div class="card-body"> -->
						</div> <!-- <div class="card mb-4"> -->
						
						
						
						<!-- 댓글 작성 -->
						<!-- 이 아래부터... dep_idx가 99가 아닌것들일때만, 댓글 작성 창 생김 -->
						<c:if test="${list.dep_idx ne 99}">
						<hr><br>
						<div class="input-group">
	                        <input id="content"
	                          type="text"
	                          class="form-control"
	                          placeholder="댓글을 입력하세요." />
	                        <button class="btn btn-outline-primary" type="button" id="comtSubmit">등록</button>
                      	</div>
                      	<br/><hr/>
						
						
						<!-- 댓글 목록 -->
						<div class="commentList">
							<!-- 댓글 리스트 공간 -->
						</div> 
						
						
						<!--      페이지......      -->
						<div class="card-body">
							<div class="demo-inline-spacing"> 
								<nav aria-label="Page navigation" style="text-align:center">
									<ul class="pagination justify-content-center" id="pagination">
									
									</ul>
								</nav>
							</div>
						</div>
						
						</c:if>

						
					</div> <!--<div class="container-xxl flex-grow-1 container-p-y"> -->

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
if(msg != ""){
	alert(msg);
}




//text editor 옵션
var text_editor_config = {};
text_editor_config.editorResizeMode = "none";
text_editor_config.toolbar = "simple";
//html 저장, 출력, PDF 저장, 코드 보기
text_editor_config.toolbar_simple = "{save, print, html2pdf, code}";

var editor = new RichTextEditor("#div_editor", text_editor_config);
editor.setReadOnly(); //읽기전용 옵션



var loginId='${sessionScope.loginId}'
var post_idx = ${list.post_idx}
var sessionDepName='${sessionScope.dep}' //로그인 아이디의 부서이름
var listDepName='${list.dept_name}' //글의 부서이름
var dep_idx = ${list.dep_idx} //글의 idx
var page ='';

console.log("loginId : "+ "${sessionScope.loginId}");
console.log("post_idx : "+ "${list.post_idx}");
console.log("sessionDepName : "+ "${sessionScope.dep}");
console.log("listDepName : "+ "${list.dept_name}");
console.log("dep_idx : "+ "${list.dep_idx}");


//댓글 작성
$("#comtSubmit").click(function(){
	//로그인 id 부서이름과 가져온 글의 idx가 다를때,, 작성권한 없음
	if(sessionDepName != listDepName){
		alert('댓글 작성 권한이 없습니다.');
		return false;
	}
	
	var content = document.getElementById("content").value;
	if(content=='null'||content==''){
		alert('내용을 입력하세요.');
	}else{
		$.ajax({
			type:'post',
			url:'/post/detail/comtRegist.ajax',
			data:{content:content, post_idx:post_idx, page:page},
			datatype:'JSON',
			success:function(data){
				if(data.success>0){
					var showPage = 1; //보여지는 페이지 
					ComtCall(showPage);
					document.getElementById("content").value=""; //input 창 내용 지우기
					console.log("ajax 성공 -- post_idx : "+post_idx);
					console.log("ajax 성공 -- page : "+showPage);
				}else{
					alert("댓글 등록에 실패하였습니다.");
				}
			}, error:function(e){
			}
		});
	}
})	



//현재 보여줄 페이지 지정
var showPage = 1; //보여지는 페이지 
ComtCall(showPage);



//댓글 리스트 출력
function ComtCall(page) {
	console.log("댓글 리스트 출력 post_idx : "+ post_idx);
	console.log("댓글 리스트 출력 page : "+ page);
	
	showPage=page;
	console.log("댓글 리스트 출력 showPage : "+ showPage);
	
	$.ajax({
		type : 'post',
		url : '/post/detail/comtListCall.ajax',
		data : {post_idx : post_idx, page : page},
		datatype : 'JSON',
		success : function(data) {
			console.log(data);
			
			//리스트 띄우기
			drawList(data.comtList);
			//페이징
			listPaging(data.total);

	
		}, //end for success
		error : function(e) {
			console.log(e);
		}
	}); //end for ajax
}


//페이징 그리기
function listPaging(page) { // page : 전체 페이지 
	console.log("showPage : "+showPage); // 현재 페이지 번호 
	var content = '';

	content += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
			+ 1
			+ '); return false;"><i class="tf-icon bx bx-chevrons-left"></i></a></li>';
	if (showPage - 1 > 0) {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
				+ (showPage - 1)
				+ '); return false;"><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	} else {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" ><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	}
	for (var i = 0; i < page; i++) { // class="page-item active" : 선택 보라색 
		if (showPage == (i + 1)) {
			content += '<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
					+ (i + 1)
					+ '); return false;">'
					+ (i + 1)
					+ '</a></li>';
		} else {
			content += '<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
					+ (i + 1)
					+ '); return false;">'
					+ (i + 1)
					+ '</a></li>';
		}
	}
	if (showPage + 1 <= page) {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
				+ (showPage + 1)
				+ '); return false;"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	} else {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	}
	content += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
			+ page
			+ '); return false;"><i class="tf-icon bx bx-chevrons-right"></i></a></li>';
	$('#pagination').empty();
	$('#pagination').append(content);
}



window.onload = function timeStampCut(){
	var timestamp = $("#ptagId").text();
	console.log("실행확인2");
	console.log(timestamp);
var date = new Date(timestamp);
var year = date.getFullYear().toString();
var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
var returnDate = year + "-" + month + "-" + day + " " + hour + ":" + minute;

console.log(returnDate);
$("#ptagId").text(returnDate);
		
return returnDate;
}



//session.dept_idx != 현재 게시판 번호        (서로 다르면 댓글 작성 권한 없음)

/* 댓글 작성자일때만 수정 삭제 추가하기 */
/* 카테고리가 부서게시판이고 참여권한 없을때!!!!! ....  댓글 작성할 수 없습니다...  */

//댓글 그리기
function drawList(comtList){
	var content=''; 
	console.log("댓글 불러오기기기기")
	for(var i=0; i<comtList.length; i++){
	
		//var noAuthority = comtList[i].xxxxx; //만약 category가 부서게시판이고, 참여권한이 없을때!  
			//if(noAuthority =="xxxx"){
		//	content += 			'댓글을 작성할 수 없습니다.';						
		//	}else	{
			
		//content += '<p>'+comtList[i].mem_id+'</p>';	    
		content += '<div id="comtDiv">';
		content += '<p>'+comtList[i].dept_name+' '+comtList[i].mem_name+' '+comtList[i].pos_name+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' 
						+timeStamp(comtList[i].date)+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'; //부서 이름 직급
	        if(loginId==comtList[i].mem_id){
	        content += '<a style="cursor: pointer; color : #696cff;" onclick="comtModify(this)">수정</a>&nbsp;&nbsp;&nbsp;&nbsp;'; 
	       	}
	        if(loginId==comtList[i].mem_id){
	        content += '<a style="cursor: pointer; color : #696cff;"  onclick="comDel('+comtList[i].com_idx+')" id="comDel">삭제</a>';
	     	}
	    content += '</p>';
		content += '<p class="com_content" id="com_content">'+comtList[i].content+'</p>'; 		//댓글 내용
		content += '<input type="hidden" class="com_idx" value="'+comtList[i].com_idx+'">';  //댓글 번호 (숨김)
		content += '<input type="hidden" class="post_idx" value="'+comtList[i].post_idx+'">';  //글 번호 (숨김)
        //content += '<input type="hidden" id="comtModifyInput">';
		content += '</div>';
		//	}
		content += '<hr>';
	}	
	console.log("댓글 그리기 ~~ comtList :{}", comtList);
	$(".commentList").empty();
	$(".commentList").append(content); //넣음
}


//댓글 수정 버튼 파람 가져오기
 function comtModify(modifyBtn){ //수정 버튼을 눌렀을때
	
	var content = $(modifyBtn).closest("#comtDiv").find("#com_content").text(); //댓글 내용 가져오기
	$(modifyBtn).closest("#comtDiv").find("#com_content").html("<input type='text' value='"+content+"' id='editDo'>");
	$(modifyBtn).html("저장"); //'수정' 버튼 '저장'으로 이름 변경
	modifyBtn.setAttribute("onclick","modify(this)"); // 속성을 바꿈
	$(modifyBtn).closest("#comtDiv").find("#comDel").html("취소"); //삭제 버튼을 취소로 이름 변경
	$(modifyBtn).closest("#comtDiv").find("#comDel").attr("onclick","comCancel()"); //취소로 속성을 바꿈	
	
	
	
	//$(modifyBtn).find("input#comtModifyInput").prop("type","text"); 
	//$(modifyBtn).find("input#comtModifyInput").attr("value",content); 

	console.log("comtModify 실행 111: "+content);
}





//댓글 수정하기
function modify(modifyBtn){
	var content = $(modifyBtn).closest("#comtDiv").find("input#editDo").val();
	console.log("수정할 코멘트 : "+content);
	
	var com_idx = $(modifyBtn).closest("#comtDiv").find("input.com_idx").val();
	if(content=='null'||content==''){
		alert('댓글을 입력해 주세요.');
	}else{
		$.ajax({
			type:'POST',
			url:'/post/detail/comEdit.ajax',
			data:{
				content : content,
				com_idx : com_idx
			},
			datatype:'JSON',
			success:function(data){
				if(data.success>0){
					var showPage = 1; //보여지는 페이지 
					ComtCall(showPage);
					//ComtCall(post_idx, page);
					alert("댓글이 수정되었습니다.");
				}else{
					alert("댓글 수정에 실패하였습니다.");				
				}
			},
			error:function(e){
				alert("ajax error");
			}
		});
	}
}	





//댓글 삭제
function comDel(com_idx){
	console.log(com_idx);
	if(confirm("삭제 하시겠습니까?")){
		$.ajax({
			type:'POST',
			url:'/post/detail/comDelete.ajax',
			data:{com_idx : com_idx},
			datatype:'JSON',
			success:function(data){
				if(data.success>0){
					var showPage = 1; //보여지는 페이지 
					ComtCall(showPage);
					//ComtCall(post_idx, page);
				}else{
					alert("댓글 삭제에 실패하였습니다.");				
				}
			},
			error:function(e){
				alert("ajax error");
			}
		});
	}
}		

//댓글 수정 취소
function comCancel(){
	//ComtCall(post_idx, page);
	var modifyCancel = confirm("댓글 수정을 취소하시겠습니까?");
	if (modifyCancel) {
		ComtCall(showPage);
	}
}



function timeStamp(timestamp){
	var date = new Date(timestamp);
	var year = date.getFullYear().toString();
	var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
	var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
	var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
	var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
	var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
	var returnDate = year + "-" + month + "-" + day + " " + hour + ":" + minute;
return returnDate;
}





//글 삭제
function del(){
	var state = confirm("글을 삭제하시겠습니까?");
	if(!state){
		return false;
	}

	
	$.ajax({
		type : 'GET', 
		url : 'del',
		data:{'delList':chkArr},
		dataType : 'JSON', 
		success : function(data) { 
			console.log(data);
			if(data.msg != ""){
				alert(data.msg);
				listCall(1);
			}
		},
		error : function(e) {
			console.log(e);
			alert("삭제할 글이 없습니다.");
		}
	});
	
}



//글 삭제 버튼 confirm창 
$("#btnDelete").on("click",function(){
	var result = confirm('삭제하시겠습니까?');
    if(result) {
    	location.href='./delete.do?post_idx=${list.post_idx}&dep_idx=${list.dep_idx}';
    }else{
    	return false;
    }
});

//글 수정 버튼 confirm창 
$("#btnEdit").on("click",function(){
	var result = confirm('수정하시겠습니까?');
    if(result) {
    	location.href='./editForm.move?post_idx=${list.post_idx}';
    }else{
    	return false;
    }
});



</script>
</html>










