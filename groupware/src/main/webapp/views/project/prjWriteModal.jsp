<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

</head>
<body>
	<!-- Vertically Centered Modal -->


	<!-- 일반 글쓰기 모달 -->
	<!-- Modal -->
	<div id="modal">
		<div class="modal fade modalWindow" id="modalCenter1" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h6 class="modal-title" id="modalCenterTitle"
							style="font-weight: bold">글 작성</h6>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<hr>
					<form action="/project/postWrite.do" method="POST"
						enctype="multipart/form-data" id="post_regist_form">
						<div class="modal-body" style="padding-top: 0px;">
							<div class="row1">
								<input type="hidden" name="prj_idx" value="${prj_idx}">
							</div>
							<div class="row1">
								<input type="hidden" id="post_prj_post_idx" name="post_prj_post_idx" value="${prj_post_idx}">
							</div>							
							<div class="row1">
								<input type="text" id="post_subject"
									class="form-control" name="subject"
									placeholder="제목을 입력하세요." />
							</div>
							<div class="row1">
<!-- 							<div id="post_content"> -->
								<textarea id="post_content" class="form-control tx"
									name="content" placeholder="내용을 입력하세요."></textarea>
							</div>
							<div class="row1">
							<input class="form-control file" name="multipartFiles" type="file" id="formFileMultiple" multiple onchange="fileUpload()"/>
							</div>
							</div> 
							<br>
<!-- 							<div class="row1"> -->
<!-- 								<span>첨부 파일</span> <span class="fileList"></span> -->
<!-- 							</div> -->
						
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal" onclick="cancel()">취소</button>
							<button class="btn btn-primary" id="postRegist"
								>등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- 업무 글쓰기 모달 -->
	<!-- Modal -->
	<div class="modal fade modalWindow" id="modalCenter2" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title" id="modalCenterTitle"
						style="font-weight: bold">업무글 작성</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<hr>
				<form action="/project/taskWrite.do" method="POST" enctype="multipart/form-data" id="task_regist_form">
					<div class="modal-body" style="padding-top: 0px;">
						<div class="row1">
							<input type="hidden" name="prj_idx" value="${prj_idx}">
						</div>
						<div class="row1">
							<input type="text" id="task_subject"
								class="form-control" name="subject"
								placeholder="제목을 입력하세요." />
						</div>
						<div class="row1">
							<textarea id="task_content" class="form-control tx"
								name="content" placeholder="내용을 입력하세요."></textarea>
						</div>
						<div class="row1"></div>
						<div class="card-body" style="padding: 0">
							<div class="row gx-3 gy-2 align-items-center">
								<div class="col-md-3" style="width: 30%">
									<button id="showToastPlacement"
										class="btn btn-outline-primary d-block" disabled
										style="width: 118px">담당자</button>
								</div>
								<div class="col-md-3">
									<select name="mem_id" id="charge" class="form-select color-dropdown" style="width:226px" >
<!-- 										<option value="bg-primary" selected>Primary</option> -->
										<c:forEach items ="${list}" var="mem">
											<c:choose>
												<c:when test="${mem.mem_id eq sessionScope.loginId}">
													<option value="${mem.mem_id}" selected>${mem.depart}&nbsp;${mem.name}&nbsp;${mem.posit}&nbsp;</option>
												</c:when>
												<c:otherwise>
													<option value="${mem.mem_id}">${mem.depart}&nbsp;${mem.name}&nbsp;${mem.posit}&nbsp;</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="row1"></div>
						<div class="card-body" style="padding: 0">
							<div class="row gx-3 gy-2 align-items-center">
								<div class="col-md-3" style="width: 30%">
									<button class="btn btn-outline-primary d-block" disabled>업무시작일</button>
								</div>
								<div class="col-md-3">
									<input class="btn btn-outline-primary d-block form-control" id="task_start" name="plan_start" min="plan_start" style="width:227px" type="date">
								</div>
							</div>
							<div class="row1"></div>
							<div class="row gx-3 gy-2 align-items-center">
								<div class="col-md-3" style="width: 30%">
									<button class="btn btn-outline-primary d-block" disabled>업무종료일</button>
								</div>
								<div class="col-md-3">
									<input class="btn btn-outline-primary d-block" id="task_end" name="plan_end" min="plan_end" style="width:227px" type="date">
								</div>
							</div>
							<div class="row1"></div>
							<input class="form-control file" name="multipartFiles" type="file" id="formFileMultiple" multiple onchange="fileUpload()"/>
							
<!-- 							<input type="file" class="file" name="multipartFile" -->
<!-- 								multiple="multiple" onchange="fileUpload()"> <br> -->
<!-- 							<div class="row1"> -->
<!-- 								<span>첨부 파일</span> <span class="fileList"></span> -->
<!-- 							</div> -->
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-secondary"
								data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" id="taskRegist"
								>등록</button>
						</div>
					</div>	
				</form>
			</div>
		</div>
	</div>


	<!-- 투표 글쓰기 모달 -->
	<!-- Modal -->
	<div class="modal fade modalWindow" id="modalCenter3" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title" id="modalCenterTitle"
						style="font-weight: bold">투표글 작성</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<hr>
				<form action="/project/pollWrite.do" method="POST"
					enctype="multipart/form-data" id="poll_regist_form">
					<div class="modal-body" style="padding-top: 0px;">
						<div class="row1">
							<input type="hidden" name="prj_idx" value="${prj_idx}">
						</div>
							<div class="row1">
								<input type="hidden" id="poll_prj_post_idx" name="poll_prj_post_idx" value="${prj_post_idx}">
							</div>												
						<div class="row1">
							<input type="text" id="poll_subject"
								class="form-control" name="subject"
								placeholder="제목을 입력하세요." />
						</div>
						<div class="row1">
							<textarea id="poll_content" class="form-control tx"
								name="content" placeholder="내용을 입력하세요."></textarea>
						</div>
						<div class="row1" id="extcount">
							<input type="text" name="ext[]" style="margin-bottom:7px" class="form-control input"
								placeholder="선택지를 입력해 주세요.">
						 	<input
								type="text" name="ext[]" style="margin-bottom:7px" class="form-control input"
								placeholder="선택지를 입력해 주세요.">
								
							<div class="row1 append1"></div>
							
						<button type="button" class="btn btn-primary add_btn">+ 투표 선택지 추가</button>	
						</div>
						<div class="row1"></div>
							<div class="row gx-3 gy-2 align-items-center">
								<div class="col-md-3" style="width: 30%">
									<button class="btn btn-outline-primary d-block" disabled>투표마감일</button>
								</div>
								<div class="col-md-3">
									<input class="btn btn-outline-primary d-block" id="poll_end" name="poll_end" style="width:227px" type="datetime-local">	
								</div>
							</div>
						<div class="row1"></div>
							<div class="row gx-3 gy-2 align-items-center">
								<div class="col-md-3" style="width: 30%">
									<button class="btn btn-outline-primary d-block" style="padding-left: 25px; padding-right: 25px;" disabled>익명 투표</button>
								</div>
								<div class="form-check form-switch mb-2 col-md-3" style="width: 24%;padding-left: 44px;">
									<input class="form-check-input" type="checkbox" name="anon" value="1"
										id="input_check" style="height: 24px; width: 42px;"> 
									<input class="form-check-input" type="hidden" name="anon" value="0"
										id="input_check_hidden" style="height: 24px; width: 42px;"> 
								</div>
								
								
							</div>
								
		
						<div class="row1">
							<input class="form-control file" name="multipartFiles"
								type="file" id="formFileMultiple" multiple
								onchange="fileUpload()" />
						</div>
<!-- 						<div class="row1"> -->
<!-- 							<span>첨부 파일</span> <span class="fileList"></span> -->
<!-- 						</div> -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary"
							data-bs-dismiss="modal">취소</button>
<!-- 						<button type="button" class="btn btn-primary" id="pollRegist" -->
<!-- 							>등록</button> -->
							<input type="submit" class="btn btn-primary" id="pollRegist" value="등록">
							
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 피드백 글쓰기 모달 -->
	<!-- Modal -->
	<div class="modal fade modalWindow" id="modalCenter4" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h6 class="modal-title" id="modalCenterTitle"
						style="font-weight: bold">피드백 작성</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<hr>
				<form action="/project/feedbackWrite.do" method="POST"
					enctype="multipart/form-data" id="feedback_regist_form">
					<div class="modal-body" style="padding-top: 0px;">
						<div class="row1">
							<input type="hidden" name="prj_idx" value="${prj_idx}">
						</div>
							<div class="row1">
								<input type="hidden" id="feedback_prj_post_idx" name="feedback_prj_post_idx" value="${prj_post_idx}">
							</div>												
						<div class="row1">
							<input type="text" id="feedback_subject"
								class="form-control" name="subject"
								placeholder="제목을 입력하세요." />
						</div>
						<div class="row1">
							<textarea id="feedback_content" class="form-control tx content"
								name="content" placeholder="내용을 입력하세요."></textarea>
						</div>

						<div class="row1">
							<input class="form-control file" name="multipartFiles" type="file" id="formFileMultiple" multiple onchange="fileUpload()"/>
						</div> 
						
<!-- 						<div class="row1"> -->
<!-- 							<span>첨부 파일</span> <span class="fileList"></span> -->
<!-- 						</div> -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary"
							data-bs-dismiss="modal">취소</button>
						<button class="btn btn-primary" id="feedbackRegist"
							>등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
<script>
// document.getElementById('plan_start').valueAsDate = new Date();
// var minDate = document.getElementById('plan_start').valueAsDate = new Date();
// document.getElementById('plan_start').setAttribute("min", minDate);
// document.getElementById('plan_end').valueAsDate = new Date();
// var minDate = document.getElementById('plan_end').valueAsDate = new Date();
// document.getElementById('plan_end').setAttribute("min", minDate);


//일반 글쓰기 모달 실행시 내용 초기화
$('#modalPost').on('click', function (){
	console.log('내용삭제');
	//$('.modalWindow').find('form')[0].children('#nameWithTitle').reset();
	$("#post_regist_form").attr("action","/project/postWrite.do");
	$('.modalWindow').find('#post_subject').val("");
	$('.modalWindow').find("#post_content").html("");

	$('.modalWindow').find('.fileList').text('');

});

//일반 글쓰기 입력값 체크 여부.
$(function(){
    $("#postRegist").click(function(){
        var isRight = true;

        $("#post_regist_form").find("input[type=text]").each(function(index, item){
            // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
            if ($(this).val().trim() == '') {
                alert("제목을 입력하세요.");
                isRight = false;
                $(this).focus();
                return false;
            }else{
		        $("#post_regist_form").find("textarea").each(function(index, item){
		            // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
		            if ($(this).val().trim() == '') {
		                alert("내용을 입력하세요.");
		                isRight = false;
		                $(this).focus();
		                return false;
		            }else{
		            	console.log("빈칸없음");
		                $("#post_regist_form").submit();
		            }
		        });
            }
        });

        if (!isRight) {
            return false;
        }

        $(this).prop("disabled", true);
        $(this).prop("disabled", false);
    });
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


//업무 글쓰기 입력값 체크 여부.
$(function(){
    $("#taskRegist").click(function(){
        var isRight = true;

        $("#task_regist_form").find("input[type=text]").each(function(index, item){
            // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
            if ($(this).val().trim() == '') {
                alert("제목을 입력하세요.");
                isRight = false;
                $(this).focus();
                return false;
            }else{
		        $("#task_regist_form").find("textarea").each(function(index, item){
		            // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
		            if ($(this).val().trim() == '') {
		                alert("내용을 입력하세요.");
		                isRight = false;
		                $(this).focus();
		                return false;
		            }else{
		            	console.log("빈칸없음");
		                $("#task_regist_form").submit();
		            }
		        });
            }
        });

        if (!isRight) {
            return false;
        }

        $(this).prop("disabled", true);
        $(this).prop("disabled", false);
    });
});


//피드백 입력값 체크
$(function(){
    $("#feedbackRegist").click(function(){
        var isRight = true;

        $("#feedback_regist_form").find("input[type=text]").each(function(index, item){
            // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
            if ($(this).val().trim() == '') {
                alert("제목을 입력하세요.");
                isRight = false;
                $(this).focus();
                return false;
            }else{
		        $("#feedback_regist_form").find("textarea").each(function(index, item){
		            // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
		            if ($(this).val().trim() == '') {
		                alert("내용을 입력하세요.");
		                isRight = false;
		                $(this).focus();
		                return false;
		            }else{
		            	console.log("빈칸없음");

		                $("#feedback_regist_form").submit();

		            }
		        });
            }
        });

        if (!isRight) {
            return false;
        }

        $(this).prop("disabled", true);
        $(this).prop("disabled", false);
    });
});

//선택지 Min n Max Nos.
$(document).ready(function(){
    var maxField = 5; //최대 개수
    var wrapper = $('.append1');
    var extcnt = 2; // 최초 카운트 1
   //var fieldHTML = '<input type="text" name="ext[]" value="" style="margin-bottom:7px" class="form-control input" placeholder="선택지를 입력해 주세요."> <a href="#" class="remove_btn">삭제버튼</a>';
    var fieldHTML = '<div class="selection"><input type="text" name="ext[]" style="margin-bottom:7px" class="form-control input" placeholder="선택지를 입력해 주세요."><button type="button" class="bx bx-x btn-outline-secondary remove_btn" style="margin-bottom:7px"></button></div>';
    $('.add_btn').click(function(){
        if(extcnt < maxField){
            extcnt++; // 숫자 증가
            $('.append1').append(fieldHTML); // Add field
            //$('#extcount').html("(" + extcnt + "개)");
        }
    });
    $(wrapper).on('click', '.remove_btn', function(e){
		console.log('삭제삭제');    	
        e.preventDefault();
        $(this).parent('div.selection').remove(); // Remove field
        extcnt--; // 카운트 감소
       // $('#extcount').html("(" + extcnt + "개)");
    });
});	

//투표 마감시간 현재시간으로
document.getElementById('poll_end').value=new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().slice(0, 16);

if(document.getElementById("input_check").checked) {
    document.getElementById("input_check_hidden").disabled = true;
}

</script>
</html>