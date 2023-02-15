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
	height: 100vh;
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
}.tx {
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
  
  	table, tr, td{
		border : 1px solid black;
		border-collapse: collapse;
		padding : 5px 10px;
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
<%-- 				          	<input type="hidden" name="prj_idx" value="${prj_idx}"> --%>
<!-- 				            <input type="text" name="keyword" class="form-control" placeholder="글제목을 입력하세요." /> -->
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
						
						<!-- 일반글 리스트 가져오는 구역 -->

						<div id="postList">			
						</div>			

							 				
				
	<!-- 투표 참여자 목록 모달 -->
	<!-- Modal -->
	<div id="modal">
		<div class="modal fade modalWindow" id="pollCheck" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content" style="width:500px">
					<div class="modal-header">
						<h6 class="modal-title" id="modalCenterTitle"
							style="font-weight: bold">투표 현황</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<hr>
					
						<div class="modal-body" style="padding-top: 0px;">
							<div class="row1">
								<input type="hidden" name="prj_idx" value="${prj_idx}">
							</div>
							<div class="row1">
								<input type="hidden" id="post_prj_post_idx" name="post_prj_post_idx" value="${prj_post_idx}">
							</div>							
							<div class="row1" style="margin-bottom: 30px">
								<span id="sel_content" style="text-decoration: underline"></span>
								<span id="pollcount" style="color:gray; font-weight: bold;"></span>
							</div>
							<div id="pollMem"class="row1">
								
							</div>
						</div>

							<br>
				</div>
			</div>
		</div>
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


// //파일 업로드 리스트 가져오기
// function fileUpload(){
// 	var fileInput = document.getElementsByName("multipartFile");

// 	for( var i=0; i<fileInput.length; i++ ){
// 		if( fileInput[i].files.length > 0 ){
// 			for( var j = 0; j < fileInput[i].files.length; j++ ){
// 				console.log(fileInput[i].files[j].name); // 파일명 출력
// 				$('.fileList').append('<br>');
// 				$('.fileList').append(fileInput[i].files[j].name);

// 			}
// 		}
// 	}
// }

//일반 글쓰기 모달 실행시 내용 초기화
$('#modalPost').on('click', function (){
	console.log('내용삭제');
	//$('.modalWindow').find('form')[0].children('#nameWithTitle').reset();
	$("#post_regist_form").attr("action","/project/postWrite.do");
	$('.modalWindow').find('#post_subject').val("");
	$('.modalWindow').find("#post_content").html("");

	$('.modalWindow').find('.fileList').text('');

});

//업무글쓰기 버튼 클릭시 내용 초기화
$('#modalTask').on('click', function (){
	console.log('내용삭제');
	//$('.modalWindow').find('form')[0].children('#nameWithTitle').reset();
	$("#task_regist_form").attr("action","/project/taskWrite.do");
	$('.modalWindow').find('#task_subject').val("");
	$('.modalWindow').find("#task_content").html("");
 	$('.modalWindow').find("#task_start").val("");
 	$('.modalWindow').find("#task_end").val("");

 	document.getElementById('task_start').valueAsDate = new Date();
 	document.getElementById('task_end').valueAsDate = new Date();
 	var minDate = document.getElementById('task_start').valueAsDate; 	
 	var minDate2 = document.getElementById('task_end').valueAsDate; 	
 	document.getElementById('task_start').setAttribute("min", minDate);
 	document.getElementById('task_end').setAttribute("min", minDate2);
 	console.log(minDate);

 	//document.getElementById('task_end').valueAsDate = new Date();
 	//document.getElementById('task_start').valueAsDate = new Date();
//  	var minDate = document.getElementById('task_end').valueAsDate;
//  	document.getElementById('task_end').setAttribute("min", minDate); 	
 	
	$('.modalWindow').find('.fileList').text('');

});


HomeListCall();

function HomeListCall(){
var prj_idx = ${prj_idx};
	console.log('업무글 출력' + prj_idx);

	$.ajax({
		url:'/project/HomeList.ajax',
		data:{prj_idx: prj_idx},
		dataType:'JSON',
		success: function(data){
			console.log(data);
			drawHomeList(data.post)
		},
		error: function(e){
			console.log('데이터 가져오기 실패');
		}
	});
}



var curDate = timeStampCut(new Date())
console.log(curDate);
var loginId = '${sessionScope.loginId}'


function drawHomeList(post){
	var idx="";
	var content = "";
	for(var i=0; i<post.length; i++){
		console.log(post);
		content +='<div class="left3" id="closest">';
		content +='<table class="table">';
		content +='<tr style="border-style:none">';
		content +='<input id="prj_post_Idx" type="hidden" value="'+post[i].prj_post_idx+'" >'		
		content += '<td style="border-style:none; padding-top: 50px; padding-left: 50px;">'+post[i].writer+'&nbsp;&nbsp;&nbsp;'+timeStampCut(post[i].date)+'</td>';
		content += '<td style="border-style:none; padding-top: 50px;"></td>';	
		content += '<td style="text-align:right; border-style:none; padding-top: 50px;padding-right: 50px;">';
		
		if(loginId == post[i].mem_id && post[i].prj_cat_idx ==1){
		content += '<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalCenter1" onclick="postDetail(this)">수정</button>';			
		}else if(loginId == post[i].mem_id && post[i].prj_cat_idx ==2){
		content += '<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalCenter2" onclick="taskDetail(this)">수정</button>';
		}else if(loginId == post[i].mem_id && post[i].prj_cat_idx ==3 && curDate < timeStampCut(post[i].end_date)){
		content += '<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalCenter3" onclick="pollDetail(this)">수정</button>';
		}else if(loginId == post[i].mem_id && post[i].prj_cat_idx ==4){
		content += '<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalCenter4" onclick="feedbackDetail(this)">수정</button>';
		}
		
		content += '</td>';
		content += '</tr>';
		content += '<tr>';
		
		if(post[i].prj_cat_idx ==3){
			content += '<td style="border-style:dotted; font-weight:bold; padding-left: 50px;" colspan=3>'
				if(curDate < timeStampCut(post[i].end_date)){
					content += '<span class="badge bg-label-warning">진행중</span>&nbsp;'
				}else{
					content += '<span class="badge bg-label-secondary">마감</span>&nbsp;'
				}
			if(post[i].anon == 1){
				content += '<span class="anon" style="color:purple; margin-right: 5px;margin-left: 5px;">[익명]</span>'
			}
			content += '<span id="sub">'+post[i].subject+'</span>'
			content +='</td>';
		}else{
			content += '<td id="sub" style="border-style:dotted; font-weight:bold; padding-left: 50px;" colspan=3>'+post[i].subject+'</td>';
		}		
		content += '</tr>';
		
		if(post[i].prj_cat_idx == 2){//업무글 진행상태

			if(post[i].state==0){
				content +='<tr>';
				content += '<input id="task_ready" type="hidden" value="'+post[i].state+'">'
				content += '<td style="border-style:none; padding-left: 50px;" colspan=3>';
				content += '<button type="button" class="btn rounded-pill btn-warning" id="ready1" onclick="task_ready(this)">준비중</button>&nbsp';
				content += '<button type="button" class="btn rounded-pill btn-outline-info" id="ing1" onclick="task_ing(this)">진행중</button>&nbsp';
				content += '<button type="button" class="btn rounded-pill btn-outline-success" id="fin1" onclick="task_fin(this)">완료</button>';
				content += '</td>';
				content += '</tr>';	
			}else if(post[i].state==1){
				content +='<tr>';
				content += '<td style="border-style:none; padding-left: 50px;" colspan=3>';
	 			content += '<input id="task_ing" type="hidden" value="'+post[i].state+'">'
				content +='<button type="button" class="btn rounded-pill btn-outline-warning" id="ready2" onclick="task_ready(this)">준비중</button>&nbsp';
				content +='<button type="button" class="btn rounded-pill btn-info" id="ing2" onclick="task_ing(this)">진행중</button>&nbsp';
				content +='<button type="button" class="btn rounded-pill btn-outline-success" id="fin2" onclick="task_fin(this)">완료</button>&nbsp';
				content += '</td>';
				content += '</tr>';			
			}else{
				content +='<tr>';
				content += '<td style="border-style:none; padding-left: 50px;" colspan=3>';			
				content += '<input id="task_fin" type="hidden" value="'+post[i].state+'">'
				content +='<button type="button" class="btn rounded-pill btn-outline-warning" id="ready3" onclick="task_ready(this)">준비중</button>&nbsp';
				content +='<button type="button" class="btn rounded-pill btn-outline-info" id="ing3" onclick="task_ing(this)">진행중</button>&nbsp';
				content +='<button type="button" class="btn rounded-pill btn-success" id="fin3" onclick="task_fin(this)">완료</button>&nbsp';			
				content += '</td>';
				content += '</tr>';			
			}
			content +='<tr>';
			content += '<td style="border-style:none; padding-left: 50px;" colspan=3><button type="button" class="btn btn-outline-dark" readonly>'+post[i].charge+'</button></td>';
			content += '</tr>';
			content +='<tr>';
			content += '<td id="plan_start" style="border-style:none; padding-left: 50px; text-decoration: underline" colspan=2>'+post[i].plan_start+' 부터</td>';
			content += '</tr>';
			content +='<tr>';
			content += '<td id="plan_end" style="border-style:none; padding-left: 50px; text-decoration: underline" colspan=3>'+post[i].plan_end+' 까지</td>';
			content += '</tr>';
		}//업무글 진행상태
		
		content +='<tr>';
		content += '<td id="content" style="border-style:none; padding-left: 50px;" colspan=3>'+post[i].content+'</td>';
		content += '</tr>';
		
		
		
		//파일리스트 
		content += '<tr>';
		content += '<td id="fileList'+post[i].prj_post_idx+'" style="border-style:none;padding-left: 50px;" colspan=3>'		
		content += '</td>';
		content += '</tr>';	
		
		
		
		if(post[i].prj_cat_idx == 3){
			content += '<tr>';
			content +='<td id="end_date" style="border-style:dashed; color:red; padding-left: 50px;" colspan=3>'+timeStampCut(post[i].end_date)+' 까지 </td>'
			content += '</tr>';
			content += '<tr>'
			content += '<td style="border-style:dashed" colspan=3></td>'
			content += '</tr>'
			content += '<tbody border-style:none id ="SelList'+post[i].prj_post_idx+'" class="tbody"></tbody>';
			content += '<tbody id="CommList'+post[i].prj_post_idx+'"></tbody>';
		}else{
			content +='<tr>';
			content +='<td style="border-style:none"></td>';
			content += '</tr>';
			content +='<tbody id="CommList'+post[i].prj_post_idx+'"></tbody>';
		}
		content += '<tr>';
		content += '<td style="border-style:dotted; padding: 20px 50px;" colspan=3 ><div class="input-group"><input type="text" class="comment form-control" placeholder="댓글을 입력하세요."><button class="btn btn-outline-primary" onclick="comtSubmit(this)">등록</button></div></td>';
		content +='</tr>';
		content += '</table>';
		content += '</div>';
		
		idx = post[i].prj_post_idx;
		
		
		
		
		drawDoPoll(idx,post[i].anon);
		
		//taskCommListCall(idx);
		//pollCommListCall(idx);
		//feedbackCommListCall(idx);
		postCommListCall(idx);
 		fileListCall(idx);
		
		

		
		
		
		
		
	}//for문
	$('#postList').empty();
	$('#postList').append(content);
	
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



//투표 그리기
function drawDoPoll(elem,anon){
	console.log("prj_post_idx는" +elem);
	$.ajax({
		type:'GET',
		url:'/project/drawDoPoll.ajax',
		data: {prj_post_idx: elem},
		dataType :'JSON',
		success: function(data){
			console.log(data);
			drawPollDetail(data.selList, data.totalCount, data.selected, elem, anon);
		},
		error: function(e){
			console.log("투표 그리기 에러 : " + e);
			
		}
	});
}


function drawPollDetail(selList, totalCount, selected, idx, anon){
	console.log('익명기명' + anon);
	var content = '';
	
	content += '<tr>';
	content += '<td style="border-style:none"></td>';
	content += '<td style="border-style:none"></td>';
	content += '<td style="border-style:none; padding-right: 50px; padding-top:20px"><a style="color:purple" id="totalCount">'+totalCount+'명 참여</a></td>';
	content += '</tr>';
	
	
	for(var i=0; i<selList.length; i++){
		var pollcount = selList[i].pollcount;
		//var percent = pollcount / totalCount;
		//console.log("asdfafd"+percent);
		content +='<tr>';
		if(selected == selList[i].sel_content){
		content += '<input id="sel_idx" type="hidden" value="'+selList[i].sel_idx+'" >'
		content += '<td id="'+selList[i].sel_idx+'" class="content" style="border-style:none; color:blue; padding-left: 70px; font-weight:bold; text-decoration: underline">'+selList[i].sel_content+'<hr size="20" style="color:rgb(255,102,204); width:'+50*pollcount+'px"; align:left"></td>';
		}else if(selected !=null && selected !=selList[i].sel_content){
		content +='<input id="sel_Idx" type="hidden" value="'+selList[i].sel_idx+'" >'
		content += '<td style="border-style:none; padding-left: 70px;" class="content">'+selList[i].sel_content+'<hr size="20" style="color:rgb(255,102,204); width:'+50*pollcount+'px"; align:left"></td>';
		}else{
		content += '<input id="sel_Idx" type="hidden" value="'+selList[i].sel_idx+'" >'
		content += '<td style="border-style:none; padding-left: 70px;" class="content" ><input id="'+selList[i].sel_idx+'" class="form-check-input mt-0" type="radio" name="sel_content" value="'+selList[i].sel_content+'">'+selList[i].sel_content+'<hr size="20" style="color:rgb(255,102,204); width:'+50*pollcount+'px; align:left"></td>';			
		}
		//content += '<td style="border-style:none"><hr size="10" style="color:red; width:50px; align:left"></td>';
		content += '<td style="border-style:none"></td>';
		if(anon != 1){
		content += '<td style="border-style:none;"><a style="cursor:pointer" data-bs-toggle="modal" class="pollChk" data-bs-target="#pollCheck" onclick="pollChk(this)">'+selList[i].pollcount+'명</a></td>';
		}
		content += '</tr>';
	}
	content += '<div id="container" style="width: 100%; height: 400px; margin: 0"></div>';


	
	
	content += '<tr>'
	content += '<td style="padding-right:0; width:250px; border-style:none"></td>';
	if(selected != null){
	content += '<td style="padding-left:0; border-style:none"><button type="button" class="btn btn-outline-secondary" onclick="cancelPoll(this)">투표 취소하기</button></td>'
	}else{		
	content += '<td style="padding-left:0; border-style:none"><button type="button" class="btn btn-outline-secondary" onclick="doPoll(this)">투표하기</button></td>'
	}
	content += '<td style="border-style:none"></td>';
	content += '</tr>'
	content += '<tr><td style="border-style:none" colspan=3></td></tr>'

	
	
	$('#SelList'+idx).empty();
	$('#SelList'+idx).append(content);

}



//투표하기
function doPoll(elem){
	//var prj_idx = ${prj_idx}
	//var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	var pollPossible =$(elem).closest('#closest').find('span').html();
	var sel_idx = $('input[name="sel_content"]:checked').prop("id");
	//console.log(pollPossible);
	console.log('선택지 번호'+sel_idx);
	console.log(pollPossible);
	var state = "마감";

	if(pollPossible == state){
		alert('이미 종료된 투표입니다.');
		HomeListCall();
	}else{
	
		$.ajax({
			type:'GET',
			url:'/project/doPoll.ajax',
			data : {sel_idx: sel_idx},
			dataType : 'JSON',
			success : function(data){
				console.log('투표성공');
				HomeListCall();
			},
			error: function(e){
				console.log('투표실패' + e);
				HomeListCall();
			}		
		});
		
	}
	
}


//투표 취소하기
function cancelPoll(elem){
	//var prj_idx = ${prj_idx}
	var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	var pollPossible =$(elem).closest('#closest').find('span').html();
	//var sel_idx = $('input[name="sel_content"]:checked').prop("id");
	//console.log(pollPossible);
	console.log('내가 투표한 글의 글번호'+prj_post_idx);
	var state = "마감";

	if(pollPossible == state){
		alert('이미 종료된 투표입니다.');
		HomeListCall();
	}else{
	
		$.ajax({
			type:'GET',
			url:'/project/cancelPoll.ajax',
			data : {prj_post_idx: prj_post_idx},
			dataType : 'JSON',
			success : function(data){
				console.log('투표취소 성공');
				HomeListCall();
			},
			error: function(e){
				console.log('투표취소 실패' + e);
				HomeListCall();
			}		
		});
		
	}
	
}

//투표참여자 목록 모달 실행
function pollChk(elem){
	var sel_content = $(elem).parent().siblings(':eq(1)').text();
	var pollCount = $(elem).parent().text();
	var sel_idx = $(elem).parent().siblings(':eq(0)').val();
	//console.log(sel_content);
	//console.log(pollCount);
	//console.log(sel_idx);
		//var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	var anonChk = $(elem).closest('#closest').find('.anon').text();
	console.log(anonChk);
	var anon= '[익명]';
	if(anonChk == anon){
		//$('#pollCheck').modal('hide');
		//modal.style.display="none";
		//$(elem).removeAttr('data-bs-toggle');
		//setTimeout(function() {$('.modal').hide()}, 1);
		//$("#modal").remove();
		//$(".modal-backdrop").remove();
		//location.reload();
	}
	
	
	$("#sel_content").html(sel_content);
	$("#pollcount").html("("+pollCount+")");
	
	$.ajax({
		type:'get',
		url:'/project/pollMem.ajax',
		data:{sel_idx:sel_idx},
		dataType:'JSON',
		success: function(data){
			console.log(data);
			pollMemList(data.success);

		},
		error : function(e){
			console.log('멤버가져오기 실패' + e);
		}
		
	});

}


//모달 실행시 투표 참여자 리스트 불러오기
function pollMemList(data){
console.log('투표참여자목록');
console.log(data);
var content = '';	
	for(var i=0; i<data.length; i++){
		content += '<span>'
		content += data[i].depart +'&nbsp;'+ data[i].posit +'&nbsp;'+ data[i].name;
		content +='</span>'
		content +='<br>'
	}
	
	$('#pollMem').empty();
	$('#pollMem').append(content);
}




//투표글 수정 상세보기
function pollDetail(elem){
	console.log('업무글 수정 모달창');
	var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
	console.log(prj_post_idx);
	$.ajax({
		type:'GET',
		url:'/project/pollDetail.ajax',
		data: {prj_post_idx: prj_post_idx},
		dataType :'JSON',
		success: function(data){
			console.log(data.totalCount);
			if(data.totalCount == 0){
				
				var subject = $(elem).closest('#closest').find('#sub').text();
				var content = $(elem).closest('#closest').find('#content').text();

				$("#poll_subject").val(subject);
				$("#poll_content").html(content);				
				$("#poll_prj_post_idx").val(prj_post_idx);				
				
				//$("#input_check").attr("disabled", true);
				$("#poll_regist_form").attr("action","/project/pollUpdate.do");	

				
			}else{
				alert("투표한 참여자가 존재합니다.");
				setTimeout(function() {$('.modal').hide()}, 1);
				$(".modal-backdrop").remove();
				location.reload();
			}
			
		},
		error: function(e){
			console.log("totalcount에러 : " + e);
			
		}
	});
}

// 댓글 리스트 출력
function pollCommListCall(elem){
	console.log("prj_post_idx 는dddd"  + elem);
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

// 댓글 가져오기
function CommdrawList(post_idx, commList){
	console.log("댓글 그리기ddddd"+post_idx);
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
		content += '<td class="com_content"  style="padding-left: 50px>'+commList[i].com_content+'</td>';
		content += '<td><input class="comId" type="hidden" value="'+commList[i].memId+'"></td>'
		content += '<td style="text-align:right; padding-right: 50px;">';
		if(loginId == commList[i].mem_id){
		content += '<button class="btn btn-outline-primary" onclick="comtModify(this)">수정</button ><button class="btn btn-outline-primary comDel" onclick="comDel('+commList[i].prj_com_idx+')">삭제</button>';
		}
		content += '</td>';
		content += '</tr>';

	}
	$('#CommList'+post_idx).empty();
	$('#CommList'+post_idx).append(content);
}

// 댓글 쓰기
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
						HomeListCall();
					}else{
						alert("댓글 등록에 실패하였습니다.");
					}
				},
				error:function(e){
				}
			});
		}
	}
	
	
// 댓글 수정
function comtModify(modifyBtn){
	console.log('댓글수정');
var comment = $(modifyBtn).closest("tr").find(".com_content").html();
console.log(comment);
	var content = '<input type="text" name="upt_comment" style="width: 350px" class="upt_comment" value="">';
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
						HomeListCall();
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

//투표글 댓글 삭제
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
						HomeListCall();
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
		HomeListCall();
	}


	function postCommListCall(elem){
		console.log("prj_post_idx 는" + elem);
			$.ajax({
				type:'GET',
				url:'/project/postCommList.ajax',
				data:{prj_post_idx: elem},
				dataType:'JSON',
				success: function(data){
					console.log('확인ㄴㄴㄴ'+data);
					console.log(data);
					CommdrawList(elem, data.commList)
				},
				error: function(e){
					console.log("에러 : " + e);
				}
			});
		}
	 
	 
	//투표댓글 가져오기, 해당 댓글 작성자일시에만 수정삭제 버튼 보이게 바꿔야함
	function CommdrawList(post_idx, commList){
		console.log("댓글 그리기"+post_idx);
		console.log(commList);
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
			content += '<td class="com_content" style="padding-left: 50px">'+commList[i].com_content+'</td>';
			content += '<td><input class="comId" type="hidden" value="'+commList[i].memId+'"></td>'
			content += '<td style="text-align:right; padding-right: 50px;">'
			if(loginId == commList[i].mem_id){
			content += '<button class="btn btn-outline-primary" onclick="comtModify(this)">수정</button ><button class="btn btn-outline-primary comDel" onclick="comDel('+commList[i].prj_com_idx+')">삭제</button>';
			}
			content += '</td>';
			content += '</tr>';

		}
		$('#CommList'+post_idx).empty();
		$('#CommList'+post_idx).append(content);
	}	

	//일반글 수정 상세보기
	function postDetail(elem){
		console.log('일반글 수정 모달창');	
		var prj_idx = ${prj_idx}
		var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
		//var post_subject = $(elem).closest('#closest').find('#prj_post_Idx').val();

			$.ajax({
				type:'GET',
				url:'/project/postDetail.ajax',
				data:{prj_idx: prj_idx, prj_post_idx: prj_post_idx},
				dataType:'JSON',
				success: function(data){
					//console.log(data);			
					$("#post_subject").val(data.subject);
					$("#post_content").html(data.content);
					$("#post_prj_post_idx").val(data.prj_post_idx);
					//$("#post_regist_form").removeAttribute("action");
					$("#post_regist_form").attr("action","/project/postUpdate.do");
					
				},
				error: function(e){
					console.log("에러 : " + e);
				}
			});
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
				HomeListCall();
			},
			error: function(e){
				console.log(e);
				HomeListCall();
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
				HomeListCall();
			},
			error: function(e){
				console.log(e);
				HomeListCall();
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
				HomeListCall();
			},
			error: function(e){
				console.log(e);
				HomeListCall();
			}
		});
	}	



	var tempList;
	//투표글 수정 상세보기
	function pollDetail(elem){
		console.log('투표글 수정 모달창');
		var prj_post_idx = $(elem).closest('#closest').find('#prj_post_Idx').val();
		var poll_end = $(elem).closest('#closest').find('#end_date').text();
		var end_date = poll_end.substr(0,16);
		console.log(end_date);
		console.log(prj_post_idx);
		$.ajax({
			type:'GET',
			url:'/project/pollDetail.ajax',
			data: {prj_post_idx: prj_post_idx},
			dataType :'JSON',
			success: function(data){
				console.log(data.totalCount);
				console.log(data.selList);
				if(data.totalCount == 0){
					var subject = $(elem).closest('#closest').find('#sub').text();
					var content = $(elem).closest('#closest').find('#content').text();
					console.log('여기서부터');
					console.log(subject,content);
					$("#upt_poll_subject").val(subject);
					$("#upt_poll_content").html(content);				
					$("#upt_poll_prj_post_idx").val(prj_post_idx);
					$("#poll_end").val(end_date);
					drawSelectList(data.selList);
					
					//$("#input_check").attr("disabled", true);
					$("#poll_update_form").attr("action","/project/pollUpdate.do");	

					
				}else{
					alert("투표한 참여자가 존재합니다.");
					setTimeout(function() {$('.modal').hide()}, 1);
					$(".modal-backdrop").remove();
					location.reload();
				}
				
			},
			error: function(e){
				console.log("totalcount에러 : " + e);
				
			}
		});
	}	
	
	
</script>
</html>
