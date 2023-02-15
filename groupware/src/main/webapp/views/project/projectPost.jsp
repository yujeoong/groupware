<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="assets/vendor/fonts/boxicons.css" />
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
  
/*   	table, tr, td{ */
/* 		border : 1px solid black; */
/* 		border-collapse: collapse; */
/* 		padding : 5px 10px; */
/* 	} */
	
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


//파일 업로드 리스트 가져오기
function fileUpload(){
	var fileInput = document.getElementsByName("multipartFile");

	for( var i=0; i<fileInput.length; i++ ){
		if( fileInput[i].files.length > 0 ){
			for( var j = 0; j < fileInput[i].files.length; j++ ){
				console.log(fileInput[i].files[j].name); // 파일명 출력
				$('.fileList').append('<br>');
				$('.fileList').append(fileInput[i].files[j].name);

			}
		}
	}
}



  
//일반 글쓰기 모달 실행시 내용 초기화
$('#modalPost').on('click', function (){
	console.log('내용삭제');
	//$('.modalWindow').find('form')[0].children('#nameWithTitle').reset();
	$("#post_regist_form").attr("action","/project/postWrite.do");
	$('.modalWindow').find('#post_subject').val("");
	$('.modalWindow').find("#post_content").html("");

	$('.modalWindow').find('.fileList').text('');

});

	
postListCall();
//commListCall();
//일반글 리스트 출력
var loginId = '${sessionScope.loginId}';

function postListCall(){
var prj_idx = ${prj_idx}
	$.ajax({
		url:'/project/postList.ajax',
		data:{prj_idx: prj_idx},
		dataType:'JSON',
		success: function(data){
			//console.log(data);
			//console.log("글 리스트 : " + data);
			postdrawList(data)
			
		},
		error: function(e){
			console.log("에러 : " + e);
		}
	});
}


function postdrawList(data){
	var post = data.post;
	var fileList = data.fileList;
	var content = '';
	var idx = "";
	for(var i=0; i<post.length; i++){
		console.log(post);
		content +='<div class="left3" id="closest">';
		content +='<table class="table">';
		content +='<tr style="border-style:none">';
		content +='<input id="prj_post_Idx" type="hidden" value="'+post[i].prj_post_idx+'" >'		
		content += '<td style="border-style:none; padding-top: 50px; padding-left: 50px;">'+post[i].name+'&nbsp;&nbsp;&nbsp;'+timeStampCut(post[i].date)+'</td>';
		content += '<td style="border-style:none; padding-top: 50px;"></td>';
		content += '<td style="text-align:right; border-style:none; padding-top: 50px;padding-right: 50px;">'
		if(loginId==post[i].mem_id){
		content += '<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalCenter1" onclick="postDetail(this)">수정</button>';
		}
		content +='</td>';
		content += '</tr>';
		content +='<tr>';
		content += '<td style="border-style:dotted; font-weight:bold; padding-left: 50px;" colspan=3 >'+post[i].subject+'</td>';
		content += '</tr>';
		
		
		content +='<tr>';
		content += '<td style="border-style:none;padding-left: 50px;" colspan=3>'+post[i].content+'</td>';
		content += '</tr>';
		//여기까지

		
		//파일리스트 
		content += '<tr>';
		content += '<td id="fileList'+post[i].prj_post_idx+'" style="border-style:none;padding-left: 50px;" colspan=3>'		
		content += '</td>';
		content += '</tr>';		
		
		
		
		
		
		
		content +='<tbody id="CommList'+post[i].prj_post_idx+'"></tbody>';
		
		
		content += '<tr>';
		content += '<td style="border-style:dotted; padding: 20px 50px;" colspan=3 ><div class="input-group"><input type="text" class="comment form-control" placeholder="댓글을 입력하세요."><button class="btn btn-outline-primary" onclick="comtSubmit(this)">등록</button></div></td>';
		content +='</tr>';
		content += '</table>';
		content += '</div>';
 		idx = post[i].prj_post_idx;
 		console.log("확인 : "+idx);
 		postCommListCall(idx);
 		fileListCall(idx);
	}
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




//일반글 댓글 리스트 출력
function postCommListCall(elem){
	console.log("prj_post_idx 는" + elem);
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
 
 
// 댓글 가져오기, 해당 댓글 작성자일시에만 수정삭제 버튼 보이게 바꿔야함
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
		content += '<td style="text-align:right; ;padding-right: 50px;">'
		if(loginId == commList[i].mem_id){
		content += '<button class="btn btn-outline-primary" onclick="comtModify(this)">수정</button ><button class="btn btn-outline-primary comDel" onclick="comDel('+commList[i].prj_com_idx+')">삭제</button>';
		}
		content += '</td>';
		content += '</tr>';

	}
	$('#CommList'+post_idx).empty();
	$('#CommList'+post_idx).append(content);
}

//일반글 파일 리스트 출력
//var prj_idx = ${prj_idx};
//console.log(prj_idx);
// function fileListCall(){
// 		$.ajax({
// 			type:'GET',
// 			url:'/project/postList.ajax',
// 			data:{prj_idx, prj_idx},
// 			dataType:'JSON',
// 			success: function(data){
// 				console.log(data);
// 				//console.log("글 리스트 : " + data);
// 				postdrawList(data)
				
// 			},
// 			error: function(e){
// 				console.log("에러 : " + e);
// 			}
// 		});
// 	}




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

//일반글 수정하기
/*
function postUpdate(){
	console.log('아작스 실행해해해ㅐ데이터받으라고받아받아');
    //var tog = $("#toggle1").html();
	var subject = $(".subject").val()
	var content = $(".content").val()
	var prj_idx = ${prj_idx}
	var prj_post_Idx= $("#post_prj_post_idx").val()
	console.log(subject);
	console.log(content);
	console.log(prj_idx);
	console.log(prj_post_Idx);
	$.ajax({
		type: 'GET',
		url: '/project/postUpdate.ajax',
		data:{subject:subject, content:content, prj_idx: prj_idx, prj_post_idx: prj_post_idx},
		dataType:'JSON',
		success: function(data){
			console.log(data);
		},
		error: function(e){
			console.log(e);	
		}
	});
}
*/
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
						postListCall();
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
						postListCall();
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
						postListCall();
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
		postListCall();
	}






</script>
</html>
