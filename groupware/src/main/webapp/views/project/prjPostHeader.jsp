<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

.right {
	width: 30%;
	float: right;
	height: 100vh;
}


</style>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
	<div class="left" style="padding-top: 20px;">
		<div class="section2">
			<div class="left2">
						<c:if test="${authority ==1}">
				<nav class="navbar navbar-example navbar-expand-lg prj-bg-light2 ">
					<div class="container-fluid">
						<div class="collapse navbar-collapse" id="navbar-ex-4">
							<div class="navbar-nav me-auto">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="nav-item nav-link btn prj-btn-primary bx bx-edit-alt bx-xs modalShow"
									id="modalPost" data-bs-toggle="modal" data-bs-target="#modalCenter1" style="color:black;">글</a>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<a class="nav-item nav-link btn prj-btn-primary bx bx-list-ul bx-xs modalShow"
									data-bs-toggle="modal" data-bs-target="#modalCenter2" style="color:black;" id="modalTask">업무</a> 
									&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<a class="nav-item nav-link btn prj-btn-primary bx bx-check-circle bx-xs modalShow"
									data-bs-toggle="modal" data-bs-target="#modalCenter3" style="color:black;" id="modalPoll">투표</a> 
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="nav-item nav-link btn prj-btn-primary bx bx-paper-plane bx-xs modalShow"
									data-bs-toggle="modal" data-bs-target="#modalCenter4"  style="color:black;" id="modalFeedback" onclick="feedbackAjax()">피드백</a>

							</div>
						</div>
					</div>
				</nav>
			</c:if>
			</div>
		</div>
	</div>


	     	<input type="hidden" name="authority" value="${authority}">



	<div class="right">
		<h4 class="mt-2 text-muted" style="font-weight: bold" >참여자</h4>
		<div class="card mb-4">
				<div class=" card-body">
				<c:forEach items="${list}" var="mem">
				<div class="row" style="margin-bottom:2px">
					<div class=" col-9">
						<p class="card-text">
							${mem.depart}&nbsp;${mem.name}&nbsp;${mem.posit}
						</p>
					</div>
					<div class=" col-3">
						<button class="btn rounded-pill btn-icon btn-secondary float-end" onclick="location.href='../mail/writeForm.move'"><span class="tf-icons bx bx-envelope"></span></button>
					</div>
				</div>
			</c:forEach>
				</div>
		</div>
	</div>


	<!--         				<div class="right"> -->
	<!--         					<br> -->
	<!--         					<div></div> -->
	<!--         					<span>참여자</span> -->
	<!--         					<table class="mem"> -->
	<%--         						<c:forEach items="${list}" var="mem"> --%>
	<!--         						<tr> -->
	<%--         							<td class="mem1">${mem.depart}&nbsp;${mem.name}&nbsp;${mem.position}</td> --%>
	<!--         							<td><button class="btn btn-outline-primary" onclick="location.href='../mail/writeForm.move'">쪽지</button></td> -->
	<!--         						</tr> -->
	<%--         						</c:forEach> --%>
	<!--         					</table> -->
	<!--         				</div> -->
</body>
<script>

//피드백 작성기간 확인 
function feedbackAjax(){
var prj_idx = ${prj_idx}
	$.ajax({
		type: 'get',
		url : '/project/dateCheck.ajax',
		data:{prj_idx:prj_idx},
		dataType: 'json',
		success : function(data){
			console.log(data);
			if(data==true){

			}else{
				//$('#modalCenter4').on('show.bs.modal', function (e) {	
// 				$('#modalCenter4').removeAttr('data-bs-toggle');
// 				$('#modalCenter4').removeAttr('data-bs-target');
				
				alert("피드백 작성기간이 아닙니다.");
				setTimeout(function() {$('.modal').hide()}, 1);
				$(".modal-backdrop").remove();
				location.reload();
			}
			
		},
		error : function(e){
			console.log("에러 : " + e);
		}
	});
	
}

</script>
</html>