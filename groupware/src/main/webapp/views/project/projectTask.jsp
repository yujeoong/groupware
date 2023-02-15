<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<style>

/* 구역 */
.section{
	width: 100%;
			}

.left {
	width: 70%;
	float: left;
    margin-left: 40px;
	
}

.left2{
	margin-left: 15%;
	margin-top: 2%;
	width: 50%;
	float: left;
}
.left3{
	width: 65%;
	float: left;
	padding-right: 26px;
	padding-left : 50px;
	border-radius: 10px;
}
.right {
	width: 30%;
	float: right;
}


.ul1{
    list-style:none;
}
 

.li1{
    float: left;
    margin-left: 20px;
}   
    
.mem{
	border: 1px solid;
	padding : 5px 10px;
	radius: 3px;
	background-color: white;
	border-collapse: collapse;
}

.mem1{
	padding: 5px 150px 5px 30px;
}

.tx {
    width: 100%;
    resize: none;
    height: 200px;
    border: none;
}

  .row1{
    padding-right: 0px;
    margin-right: 0px;
    margin-left: 0px;
    margin-top: 10px;
    padding-left: 0px;
  }
  
.mem2{
/* 		border : 1px solid black; */
		border-collapse: collapse;
		padding: 5px 0px;
	}
	
.table {
	margin-top: 30px;
	width: 600px;
	float: left;
	background-color: white;
	border-radius: 0.5rem;
	border-style: hidden;
}	



</style>
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
 
 
 
				<h1> ${subject}</h1>

				<!--  상단 메뉴 탭 -->									
				  <nav class="navbar navbar-example navbar-expand-lg bg-light">
				    <div class="container-fluid">
					      <div class="collapse navbar-collapse" id="navbar-ex-4">
					        <div class="navbar-nav me-auto">
					          <a class="nav-item nav-link" href="/project/projectHome.move?prj_idx=${prj_idx}">홈</a>				          
					          <a class="nav-item nav-link" href="/project/projectPost.move?prj_idx=${prj_idx}">글</a>				          
					          <a class="nav-item nav-link" href="/project/projectTask.move?prj_idx=${prj_idx}">업무</a>
					          <a class="nav-item nav-link" href="/project/projectGanttChart.move?prj_idx=${prj_idx}">간트차트</a>
					          <a class="nav-item nav-link" href="/project/projectPoll.move?prj_idx=${prj_idx}">투표</a>
					          <a class="nav-item nav-link" href="/project/projectFeedback.move?prj_idx=${prj_idx}">피드백</a>
					        </div>
<!-- 				        <form action="/project/projectPostSearch.do" method="post" class="d-flex"> -->
<!-- 				          <div class="input-group"> -->
<%-- 				          	<input type="hidden" name="prj_idx" value="${prj_idx}">				           --%>
<!-- 				            <input type="text" class="form-control" placeholder="글제목을 입력하세요." /> -->
<!-- 				            <button class="btn btn-outline-primary" >검색</button> -->
<!-- 				          </div> -->
<!-- 				        </form> -->
				      </div>
				    </div>
				  </nav>
	  
				  
				  <!-- 전체 구역  left : 게시글리스트 right: 프로젝트 참여자 리스트 -->
				  <!-- prjPostHeader.jsp : 글작성버튼 + 참여자리스트 -->
				    <div class= "section">
 						<%@ include file="prjPostHeader.jsp" %>
    				</div>
						
						<!-- 업무글 리스트 가져오는 구역 -->

						<div id="taskList">			
						</div>			

							 				
				
	
	
	                    
                      
                        
			<%@ include file="prjWriteModal.jsp" %>
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
<script src="../assets/vendor/libs/jquery/jquery.js"></script>
<script src="../assets/vendor/libs/popper/popper.js"></script>
<script src="../assets/vendor/js/bootstrap.js"></script>
<script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="../assets/vendor/js/menu.js"></script>
<!-- endbuild -->
<!-- Vendors JS -->
<!-- Main JS -->
<script src="../assets/js/main.js"></script>
<!-- Page JS -->
<script src="../assets/js/ui-modals.js"></script>
<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

//time stamp 변환
function timeStampCut(timestamp) {
	var date = new Date(timestamp);
	var year = date.getFullYear().toString(); //년도 뒤에 두자리
	var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
	var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
	var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
	var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
	var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
	var returnDate = year + "-" + month + "-" + day + " " + hour + ":"
			+ minute;
	return returnDate;
}

// //모달 열때 내용 초기화
// $('#modalTask').on('click', function (){
// 	console.log('내용삭제');
// 	//$('.modalWindow').find('form')[0].children('#nameWithTitle').reset();
// 	$("#task_regist_form").attr("action","/project/taskWrite.do");
// 	$('.modalWindow').find('#task_subject').val("");
// 	$('.modalWindow').find("#task_content").html("");
//  	$('.modalWindow').find("#task_start").val("");
//  	$('.modalWindow').find("#task_end").val("");

//  	//document.getElementById('task_start').valueAsDate = new Date();
//  	//var minDate = document.getElementById('task_start').valueAsDate;
 	
//  	document.getElementById('task_start').setAttribute("min", minDate);
//  	document.getElementById('task_end').setAttribute("min", minDate);
//  	document.getElementById('task_end').valueAsDate = new Date();
//  	document.getElementById('task_start').valueAsDate = new Date();

//  	//  	var minDate = document.getElementById('task_end').valueAsDate;
// //  	document.getElementById('task_end').setAttribute("min", minDate); 	
 	
// 	$('.modalWindow').find('.fileList').text('');

// });






	
taskListCall();

var loginId = '${sessionScope.loginId}'

//업무글 리스트 출력
function taskListCall(){
	console.log('업무글 출력');
var prj_idx = ${prj_idx};
	$.ajax({
		url:'/project/taskList.ajax',
		data:{prj_idx: prj_idx},
		dataType:'JSON',
		success: function(data){
			//console.log(data);
			taskdrawList(data);
			console.log('업무글 출력 성공');
		},
		error: function(e){
			console.log("업무글리스트 출력 에러 : " + e);
		}
	});
}

function taskdrawList(data){
	var task = data.task;
	//var fileList = data.fileList;
	var content = '';
	var idx = "";
	for(var i=0; i<task.length; i++){
		//console.log(task);
		content +='<div class="left3" id="closest">';
		content +='<table class="table">';
		content +='<tr style="border-style:none">';
		content +='<input id="prj_post_Idx" type="hidden" value="'+task[i].prj_post_idx+'" >'		
		content += '<td style="border-style:none; padding-top: 50px;padding-left: 50px;">'+task[i].name+'&nbsp;&nbsp;&nbsp;'+timeStampCut(task[i].date)+'</td>';
		content += '<td style="border-style:none; padding-top: 50px;"></td>';
		content += '<td style="text-align:right; border-style:none; padding-top: 50px; padding-right: 50px;">';
		if(loginId == task[i].mem_id){
		content += '<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalCenter2" onclick="taskDetail(this)">수정</button>';
		}
		content += '</td>';
		content += '</tr>';
		content +='<tr>';
		content += '<td id="sub" style="border-style:dotted; font-weight:bold; padding-left: 50px;" colspan=3>'+task[i].subject+'</td>';
		content += '</tr>';	
		
		if(task[i].state==0){
			content +='<tr>';
			content += '<input id="task_ready" type="hidden" value="'+task[i].state+'">'
			content += '<td style="border-style:none; padding-left: 50px;" colspan=3>';
			content += '<button type="button" class="btn rounded-pill btn-warning" id="ready1" onclick="task_ready(this)">준비중</button>&nbsp';
			content += '<button type="button" class="btn rounded-pill btn-outline-info" id="ing1" onclick="task_ing(this)">진행중</button>&nbsp';
			content += '<button type="button" class="btn rounded-pill btn-outline-success" id="fin1" onclick="task_fin(this)">완료</button>';
			content += '</td>';
			content += '</tr>';	
		}else if(task[i].state==1){
			content +='<tr>';
			content += '<td style="border-style:none; padding-left: 50px;" colspan=3>';
 			content += '<input id="task_ing" type="hidden" value="'+task[i].state+'">'
			content +='<button type="button" class="btn rounded-pill btn-outline-warning" id="ready2" onclick="task_ready(this)">준비중</button>&nbsp';
			content +='<button type="button" class="btn rounded-pill btn-info" id="ing2" onclick="task_ing(this)">진행중</button>&nbsp';
			content +='<button type="button" class="btn rounded-pill btn-outline-success" id="fin2" onclick="task_fin(this)">완료</button>&nbsp';
			content += '</td>';
			content += '</tr>';			
		}else{
			content +='<tr>';
			content += '<td style="border-style:none; padding-left: 50px;" colspan=3>';			
			content += '<input id="task_fin" type="hidden" value="'+task[i].state+'">'
			content +='<button type="button" class="btn rounded-pill btn-outline-warning" id="ready3" onclick="task_ready(this)">준비중</button>&nbsp';
			content +='<button type="button" class="btn rounded-pill btn-outline-info" id="ing3" onclick="task_ing(this)">진행중</button>&nbsp';
			content +='<button type="button" class="btn rounded-pill btn-success" id="fin3" onclick="task_fin(this)">완료</button>&nbsp';			
			content += '</td>';
			content += '</tr>';			
		}
		
		content +='<tr>';
		content += '<td style="border-style:none; padding-left: 50px;" colspan=3><button type="button" class="btn btn-outline-dark" readonly>'+task[i].charge+'</button></td>';
		content += '</tr>';
		content +='<tr>';
		content += '<td id="plan_start" style="border-style:none; padding-left: 50px; text-decoration: underline" colspan=2>'+task[i].plan_start+' 부터</td>';
		content += '</tr>';
		content +='<tr>';
		content += '<td id="plan_end" style="border-style:none; padding-left: 50px; text-decoration: underline" colspan=3>'+task[i].plan_end+' 까지</td>';
		content += '</tr>';		
		
		
		content +='<tr>';
		content += '<td id="content" style="border-style:none; padding-left: 50px;" colspan=3>'+task[i].content+'</td>';
		content += '</tr>';			
		//여기까지 했음
		
		content +='<tr>';
		content +='<td style="border-style:none; padding-left: 50px;"></td>';
		content += '</tr>';
		
		
		//파일리스트 
		content += '<tr>';
		content += '<td id="fileList'+task[i].prj_post_idx+'" style="border-style:none;padding-left: 50px;" colspan=3>'		
		content += '</td>';
		content += '</tr>';			
		
		
		content +='<tbody id="CommList'+task[i].prj_post_idx+'"></tbody>';
		
		
		content += '<tr>';
		content += '<td style="border-style:dotted; padding: 20px 50px;" colspan=3 ><div class="input-group"><input type="text" class="comment form-control" placeholder="댓글을 입력하세요."><button class="btn btn-outline-primary" onclick="comtSubmit(this)">등록</button></div></td>';
		content +='</tr>';
		content += '</table>';
		content += '</div>';
		idx = task[i].prj_post_idx;
		//console.log("확인 : "+idx);
		taskCommListCall(idx);
 		fileListCall(idx);
	}
	$('#taskList').empty();
	$('#taskList').append(content);
	
}


function fileListCall(idx){
	console.log('파이리ㅣㅣㅣㅣ');
	console.log(idx);
	$.ajax({
		type:'GET',
		url:'/project/fileListCall.ajax',
		data:{prj_post_idx: idx},
		dataType:'JSON',
		success: function(data){
			console.log(data);
			fileDrawList(idx, data.files)
		},
		error: function(e){
			console.log("에러 : " + e);
		}
	});
	
}

//파일 리스트 가져오기
function fileDrawList(idx, files){
	var content ='';
	console.log('파일그려줘어어어ㅓ');
	for(var i=0; i<files.length; i++){

		content += '<a href="/project/download.do?path='+files[i].new_file_name+'" style="margin-right: 10px;">'+files[i].ori_file_name+'</a>'

	}
	$('#fileList'+idx).empty();
	$('#fileList'+idx).append(content);
}



//time stamp 변환
function timeStampCut(timestamp) {
	var date = new Date(timestamp);
	var year = date.getFullYear().toString(); //년도 뒤에 두자리
	var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
	var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
	var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
	var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
	var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
	var returnDate = year + "-" + month + "-" + day + " " + hour + ":"
			+ minute;
	return returnDate;
}

	
	
//업무글 댓글 리스트 출력
function taskCommListCall(elem){
	//console.log("prj_post_idx 는" + elem);
		$.ajax({
			type:'GET',
			url:'/project/postCommList.ajax',
			data:{prj_post_idx: elem},
			dataType:'JSON',
			success: function(data){
				//console.log(data);
				CommdrawList(elem, data.commList)
			},
			error: function(e){
				console.log("에러 : " + e);
			}
		});
	}

//댓글 가져오기, 해당 댓글 작성자일시에만 수정삭제 버튼 보이게 바꿔야함
function CommdrawList(post_idx, commList){
	//console.log("댓글 그리기"+post_idx);
	//console.log(commList);
	var content = '';
	for(var i=0; i<commList.length; i++){
		console.log(commList);
		content +='<tr>';
		content += '<td style="border-style:none; padding-left: 50px;">'+commList[i].name+'&nbsp;&nbsp;&nbsp;'+timeStampCut(commList[i].com_date)+'</td>';
		content += '<td style="border-style:none"></td>';
		content += '<td style="border-style:none"><input class="prj_com_Idx" type="hidden" value="'+commList[i].prj_com_idx+'"></td>';
		//content += '<td><button onclick="comtModify(this)">수정</button ><button>삭제</button></td>';
		content += '</tr>';
		content +='<tr id="child">';
		content += '<td style="padding-left: 50px" class="com_content">'+commList[i].com_content+'</td>';
		content += '<td><input class="comId" type="hidden" value="'+commList[i].memId+'"></td>'
		content += '<td style="text-align:right; ;padding-right: 50px;">';
		if(loginId == commList[i].mem_id){
		content += '<button class="btn btn-outline-primary" onclick="comtModify(this)">수정</button ><button class="btn btn-outline-primary comDel" onclick="comDel('+commList[i].prj_com_idx+')">삭제</button>';
		}
		content += '</td>';
		content += '</tr>';

	}
	$('#CommList'+post_idx).empty();
	$('#CommList'+post_idx).append(content);
}

//댓글 쓰기
function comtSubmit(elem){
console.log("댓그르으르");
var comment = $(elem).closest('#closest').find('.comment').val();
console.log("댓글나와라: " + comment);
var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	if(comment=='null'||comment==''){
	alert('내용을 입력하세요');
	}else{
		$.ajax({
				type:'POST',
				url:'/project/comtSubmit.ajax',
				data:{comment:comment, prj_post_idx:prj_post_idx},
				datatype:'JSON',
				success:function(data){
					if(data.success>0){
						//commListCall();
						taskListCall();
					}else{
						alert("댓글 등록에 실패하였습니다.");
					}
				},
				error:function(e){
				}
			});
		}
	}
	
	
//댓글 수정
function comtModify(modifyBtn){
	console.log('댓글수정');
var comment = $(modifyBtn).closest("tr").find(".com_content").html();
console.log(comment);
	var content = '<input type="text" name="upt_comment"  style="width: 350px" class="upt_comment" value="">';
	var com_comment = $(modifyBtn).parent().prev().prev().append(content);
	
	//$(comment).find("span").hide();
	//$(comment).find("input").prop("type","text");
	$(modifyBtn).html("저장");
	modifyBtn.setAttribute("onclick","modify(this)");
	$(modifyBtn).closest("tr").find("button.comDel").html("취소");
	$(modifyBtn).closest("tr").find("button.comDel").attr("onclick","comCancel()");	
	//$(modifyBtn).closest("tr").find("input.c").prop("type","text")
	$(modifyBtn).closest("tr").find("input.upt_comment").attr("value",comment);
}	
	
	function modify(modifyBtn){
		var comment = $(modifyBtn).closest("tr").find(".com_content").children(".upt_comment").val();
		console.log('수정할코멘트 ' + comment);
		var prj_com_idx = $(modifyBtn).closest("tr").prev().find(".prj_com_Idx").val();
		console.log('코멘트idx ' + prj_com_idx);
		if(comment=='null'||comment==''){
			alert('댓글을 입력해 주세요');
		}else{
			$.ajax({
				type:'POST',
				url:'/project/comtModify.ajax',
				data:{
					comment : comment,
					prj_com_idx : prj_com_idx
				},
				datatype:'JSON',
				success:function(data){
					if(data.success>0){
						taskListCall();
						alert("댓글이 수정되었습니다.");
					}else{
						alert("댓글 수정을 실패하였습니다.");				
					}
				},
				error:function(e){
					alert("ajax error");
				}
			});
		}
	}	

//댓글 삭제
	function comDel(prj_com_idx){
		console.log(prj_com_idx);
		if(confirm("삭제 하시겠습니까?")){
			$.ajax({
				type:'POST',
				url:'/project/comDelete.ajax',
				data:{prj_com_idx :prj_com_idx},
				datatype:'JSON',
				success:function(data){
					if(data.success>0){
						taskListCall();
					}else{
						alert("댓글 삭제를 실패하였습니다.");				
					}
				},
				error:function(e){
					alert("ajax error");
				}
			});
		}
	}		
	function comCancel(){ //수정 취소
		taskListCall();
	}
	
	


//업무글 수정 상세보기
function taskDetail(elem){
	console.log('업무글 수정 모달창');	
	var prj_idx = ${prj_idx}
	var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	var subject = $(elem).closest('#closest').find('#sub').text();
	var content = $(elem).closest('#closest').find('#content').text();
	var plan_start = $(elem).closest('#closest').find('#plan_start').text();
	var plan_end = $(elem).closest('#closest').find('#plan_end').text();
	var real_plan_start = plan_start.substr(0, 10);
	var real_plan_end = plan_end.substr(0, 10);
	
	//var date1 = new Date(real_plan_start);
	//var date2 = new Date(real_plan_end);
	//console.log(date1);
	//console.log(date2);
	
	//console.log('찍혀라'+prj_idx+ prj_post_idx)
	console.log(subject)
	console.log(content);
	console.log(real_plan_start);
	console.log(real_plan_end);
	//console.log(plan_end);
	$("#task_prj_post_idx").val(prj_post_idx);
	$("#task_subject").val(subject);
	$("#task_content").html(content);
	$("#task_start").val(real_plan_start);
	$("#task_end").val(real_plan_end);

	$("#task_regist_form").attr("action","/project/taskUpdate.do");	

	}	

// 업무상태 준비중으로 바꾸기
function task_ready(elem){
	console.log('업무상태 준비중으로 바꾸기');
	//var task_state = $(elem).parent().prev().val(); 업무상태 
	var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	console.log(prj_post_idx);
	
	$.ajax({
		type:'GET',
		url:'/project/stateUpdate_task_ready.ajax',
		data: {prj_post_idx: prj_post_idx},
		dataType:'JSON',
		success: function(data){
			console.log('업무상태변경완');
			taskListCall();
		},
		error: function(e){
			console.log(e);
			taskListCall();
		}
	});
}


//업무상태 진행중으로 바꾸기
function task_ing(elem){
	console.log('업무상태 진행중으로 바꾸기');
	//var task_state = $(elem).parent().prev().val(); 업무상태 
	var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	console.log(prj_post_idx);
	
	$.ajax({
		type:'GET',
		url:'/project/stateUpdate_task_ing.ajax',
		data: {prj_post_idx: prj_post_idx},
		dataType:'JSON',
		success: function(data){
			console.log('업무상태변경완');
			taskListCall();
		},
		error: function(e){
			console.log(e);
			taskListCall();
		}
	});
}

//업무상태 완료로 바꾸기
function task_fin(elem){
	console.log('업무상태 완료로 바꾸기');
	//var task_state = $(elem).parent().prev().val(); 업무상태 
	var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	console.log(prj_post_idx);
	
	$.ajax({
		type:'GET',
		url:'/project/stateUpdate_task_fin.ajax',
		data: {prj_post_idx: prj_post_idx},
		dataType:'JSON',
		success: function(data){
			console.log('업무상태변경완');
			taskListCall();
		},
		error: function(e){
			console.log(e);
			taskListCall();
		}
	});
}


	
	



</script>
</html>
