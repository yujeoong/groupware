<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>

<html>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
							<span class="text-muted fw-light">마이페이지 /</span> 비밀번호 변경
						</h4>



						<!-- 부트스트랩 -->
						<div class="col-xl">
							<div class="card mb-4">
								<div
									class="card-header d-flex justify-content-between align-items-center">
									<!-- 사원등록 헤더 -->
								</div>

								<div class="card-body">


									<!-- 기존 비밀번호 input -->

									<div class="mb-3"
										style="width: 60%; margin: 0 auto; padding: 10px 0 30px 0;">
										<label class="form-label" for="basic-icon-default-fullname">기존
											비밀번호</label>
										<div class="input-group input-group-merge">
											<span id="basic-icon-default-ID" class="input-group-text"><i
												class="bx bxs-id-card"></i></span> <input type="password"
												placeholder="기존 비밀번호를 입력해주세요" id="oldPw"
												class="form-control" name="oldPw" />


											<button type="button" class="btn btn-outline-primary"
												onclick="oldCheck()">확인</button>
										</div>
									</div>
									<!-- 기존 비밀번호 input /-->

									<hr id="newAreaLine" class="my-5" style="display: none;" />


									<!-- 변경 후 input -->
									<form action="/member/changePw.do" method="post"
										enctype="multipart/form-data" onsubmit="empty(event)">
										<div id="newArea" class="mb-3"
											style="display: none; padding: 30px 0 30px 0; width: 60%; margin: 0 auto;">

											<label class="form-label" for="basic-icon-default-fullname">새
												비밀번호</label>
											<div class="input-group input-group-merge">
												<span id="basic-icon-default-fullname2"
													class="input-group-text"><i class="bx bx-user"></i></span>
												<input type="password" id="newPw" class="form-control" name="pw"
													placeholder="비밀번호를 입력하세요"  onkeyup="trimVal(this);"/>
											</div>

											<div class="input-group input-group-merge"
												style="padding: 5px 0 0 0">
												<span id="basic-icon-default-fullname2"
													class="input-group-text"><i class="bx bx-user"></i></span>
												<input type="password" id="newPw2" class="form-control"
													placeholder="비밀번호를 한번 더 입력하세요" onkeyup="trimVal(this);"/>
											</div>
											<p>&nbsp;</p>
											<div>
												<button class="btn btn-outline-primary"
												style="display:block; margin:auto;"
													>확인 및 수정</button>
											</div>

										</div>
										<!-- 변경 후 input /-->
									</form>



								</div>
							</div>
						</div>
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
if(msg != ""){
	alert(msg);
}

//비밀번호 공백제거
function trimVal(elem){
	var id = $(elem).attr('id');
	console.log(id);
    var text = $('#'+id).val().replace(/ /gi, '');
    $('#'+id).val(text);
   
}

//기존 비밀번호 확인
function oldCheck() {
	//console.log("기존 확인");
	var pw = $("#oldPw").val();
	
	if(pw == null){
		alert("비밀번호를 입력해주세요.");
	}else{
		$.ajax({
			type:'POST',
			url:'/member/checkOld.ajax',
			data:{pw},
			dataType:'JSON',
			success:function(data){
				if(data.msg == 'success'){
					alert("비밀번호가 일치합니다.");
					$("#newArea").css('display','block');
					$("#newAreaLine").css('display','block');
					
				}else{
					alert("비밀번호가 일치하지 않습니다.");
					$("#oldPw").focus();
				}
	
			},
			error:function(e){
				console.log(e);
			}		
		});	
	}
}

//새 비밀번호 공란 확인
function empty(e){
	var pastPw = $("#newPw").val();
	var pastPw2 = $("#newPw2").val();
	
	var pw = pastPw.replace(/(\s*)/g, "");
	var pw2 = pastPw2.replace(/(\s*)/g, "");
	
	//정규화
	var reg = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
	
	console.log(pw);
	console.log(pw2);
	
 	if(pw != pw2){
 		alert("새 비밀번호가 일치하지 않습니다.");
 		e.preventDefault();
 		
 	}else if( pw == "" || pw2 == ""){
 		alert("비밀번호를 입력해주세요.");
 		e.preventDefault();
 		
 	}else if(pw.match(reg) == null){
 		alert("8자 이상의 영문+숫자 조합으로 생성해주세요.");
 		e.preventDefault();
 		
 	}else if(pw == pw2){
 		if(!confirm("비밀번호가 일치합니다. \n 변경하시겠습니까?")){
 			 e.preventDefault();
 		}else{
 			return;
 		}
 	}
}
	

</script>
</html>
