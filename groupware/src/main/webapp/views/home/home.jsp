<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<style>
#vertical-example {
     width: auto;
     overflow: auto;
}
.text-nowrap {
    white-space: inherit !important !important; 
} 
#calendar > th,td{
	padding: 0rem 0rem;
	text-align: center;
} 
table > th,td,tr{
    text-align: center !important; 
}
#cal-card-body:hover {
    background: #f5f5f9de; 
    cursor: pointer;
 }
/*  #stock-body:hover{
 	background: #f5f5f9de; 
    cursor: pointer;
 } */
 #card-body-padding {
	 padding: 0rem 0rem !important; 
 
 } 
</style>
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
					
						<div class="row"> 
							<!-- 주식 크롤링 -->
							<div class="col-md-3">
								<div class="card h-100" >
									<div class="card-body" id="stock-body"> 
										<h5 >에스엠 <small class="text-muted">041510</small></h5><br/>
										<c:if test="${finance.icon eq '상승'}">
											<small class="badge rounded-pill bg-label-success" style="height: 30px;">
												<i class="bx bx-up-arrow-alt"></i>${finance.DungRakrate}% </small>									
										</c:if>
										<c:if test="${finance.icon eq '하락'}">
											<small class="badge rounded-pill bg-label-danger" style="height: 30px;">
												<i class="bx bx-down-arrow-alt"></i>${finance.DungRakrate}%	</small>									
										</c:if> 
										<h2 class="card-title mb-2">${finance.juga}</h2>
										<c:if test="${finance.vsyesterday_icon eq '상승'}">
											<span class="text-success fw-semibold">전일대비 <i class="bx bx-up-arrow-alt"></i> <!--  class="badge bg-label-warning rounded-pill" -->
											${finance.vsyesterday}</span>	
										</c:if>
										<c:if test="${finance.vsyesterday_icon eq '하락'}">
											<span class="text-danger fw-semibold">전일대비 <i class="bx bx-down-arrow-alt"></i>
											${finance.vsyesterday}</span>	
										</c:if>&nbsp;&nbsp;
										
										<br/>
										<dl class="row mt-2">
											<dt class="col-sm-5">시가</dt>
											<dd class="col-sm-7">${finance.siga} </dd>
	
											<dt class="col-sm-5">고가</dt>
											<dd class="col-sm-7">${finance.goga} </dd>
	
											<dt class="col-sm-5">저가</dt>
											<dd class="col-sm-7">${finance.zeoga} </dd>
	
											<dt class="col-sm-5 text-truncate">거래량</dt>
											<dd class="col-sm-7">${finance.georaeryang}</dd>
										</dl> 
									</div>
								</div>
							</div>
							<%-- <div class="col-md-6">
								<div class="card mb-4">
									<h5 class="card-header">주식</h5>
									<div class="card-body">
										<span><p>주가</p> ${finance.juga} </span>
										<span><p>등락률</p>${finance.DungRakrate} </span>
										<span><p>시가</p>${finance.siga} </span>
										<span><p>고가</p>${finance.goga} </span>
										<span><p>저가</p>${finance.zeoga} </span>
										<span><p>거래량</p>${finance.georaeryang} </span>
										<span><p>타입</p>${finance.stype} </span>
										<span><p>전일대비</p>${finance.vsyesterday} </span>
										<span><p>가져오는 시간</p>${finance.time} </span>
									</div>
									${finance.tmp}
								</div>
							</div> --%>
							
							<!-- 음원차트 크롤링 --> 
							<div class="col-md-9">
								<div class="card h-100">
									<h5 class="card-header">음원 TOP100</h5>
									<div class="text-nowrap" style="overflow-y: auto; overflow-x: hidden; height: 300px;" >
										<table class="table">
											<thead>
												<tr>
													<th>순위</th>
													<th></th>
													<th>이름</th>
													<th>가수</th>
													<th>앨범</th>
												</tr>
											</thead>
											<tbody class="table-border-bottom-0">
												<c:forEach items="${list}" var="list">
													<tr>
														<td>&nbsp;${list.rank }&nbsp;</td>
														<td><a><img width="60" height="60" src="${list.albumImg_temp }"></a></td>
														<td>${list.name_temp }</td>
														<td>${list.singer_temp }</td>
														<td>${list.album_temp }</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							</div> <!-- 1st row -->
							<p>&nbsp;</p>
							<div class="row">
							<!-- 캘린더 -->
							<div class="col-md-4" > <!-- display: block; -->
								<div class="card h-100" id="cal-card-body">
									<h5 class="card-header">캘린더</h5>
									<div class="card-body" >
										<div class="table-responsive text-nowrap">
											<table class="table table-sm" id="calendar" style="text-align: center; ">
												<thead>
													<tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>
												</thead>
												<tbody class="table-border-bottom-0"> 
													<tr>													
													<c:forEach var="i" begin="1" end="7" step="1">
														<c:choose>
															<c:when test="${i eq today}">
																<td ><span class="badge badge-center rounded-pill bg-primary">${i }</span></td>
															</c:when>
															<c:otherwise><td>${i }</td> </c:otherwise>
														</c:choose>
													</c:forEach> 
													</tr>
													<tr>
													<c:forEach var="i" begin="8" end="14" step="1">
														<c:choose>
															<c:when test="${i eq today}">
																<td ><span class="badge badge-center rounded-pill bg-primary">${i }</span></td>
															</c:when>
															<c:otherwise><td>${i }</td> </c:otherwise>
														</c:choose>
													</c:forEach> 
													</tr>
													<tr>
													<c:forEach var="i" begin="15" end="21" step="1">
														<c:choose>
															<c:when test="${i eq today}">
																<td ><span class="badge badge-center rounded-pill bg-primary">${i }</span></td>
															</c:when>
															<c:otherwise><td>${i }</td> </c:otherwise>
														</c:choose>
													</c:forEach> 
													</tr>
													<tr>
													<c:forEach var="i" begin="22" end="28" step="1">
														<c:choose>
															<c:when test="${i eq today}">
																<td ><span class="badge badge-center rounded-pill bg-primary">${i }</span></td>
															</c:when>
															<c:otherwise><td>${i }</td> </c:otherwise>
														</c:choose>
													</c:forEach> 
													</tr>
													<tr>
													<c:forEach var="i" begin="29" end="${days }" step="1">
														<c:choose>
															<c:when test="${i eq today}"><td style="color: white; background-color: #696cff;">${i }</td></c:when>
															<c:otherwise><td>${i }</td> </c:otherwise>
														</c:choose>
													</c:forEach> 
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>

							<!-- Todo --> 
							<div class="col-md-8">
								<div class="card h-100">
									<h5 class="card-header">TODO</h5>
									<div class="card-body" id="vertical-example"> 
										<div class="input-group mb-3" style="margin: 0 auto;">
								 	        <input type="text" id="todoInput" class="form-control" placeholder="내용을 입력하세요." aria-label="Recipient's username" aria-describedby="button-addon2">
											<button class="btn btn-outline-primary" type="button" id="button-addon2" onclick="todoWrite()">등록</button>
								        </div >
										<div class="list-group" id="todoList" style="overflow-y: auto; overflow-x: hidden; height: 200px;"> 
										</div>
									</div>
								</div>
							</div>
							</div>
							
							
							<p>&nbsp;</p>
							<div class="row">
							<!--  발신결제 내역 -->
							<div class="col-md-5">
								<div class="card overflow-hidden h-100">
									<h5 class="card-header">결재 상신 내역 </h5> 
									<div class="card-body"> <!-- id="vertical-example" -->
										<div class="text-nowrap" style="overflow-y: auto; overflow-x: hidden;">
											<table class="table table-hover">
												<thead>
													<tr>
														<th>결재명</th>
														<th>문서 상태</th>
														<th>진행 차수</th>
														<th>세부상태</th> 
													</tr>
												</thead>
												<tbody class="table-border-bottom-0" id="appr_docList"> 
												</tbody>
											</table>
										 
										</div>
									</div>
								</div>
							</div>
							 
							<!--  프로젝트 업무리스트 -->
							<div class="col-md-7">
								<div class="card overflow-hidden h-100"> <!-- style=" display: flex; height: 400px; " -->
									<h5 class="card-header">진행중인 업무</h5> 
									<div class="card-body">
										<div class="text-nowrap" style="overflow-y: auto; overflow-x: hidden;">
											<table class="table table-hover">
												<thead>
													<tr>
														<th>프로젝트</th>
														<th>업무</th>
														<th>시작</th>
														<th>마감</th> 
														<th>상태</th>
													</tr>
												</thead>
												<tbody class="table-border-bottom-0" id="prj_taskList"> 
												</tbody>
											</table> 
										</div>
									</div>
								</div>
							</div> 
							</div><!-- row -->
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
listAjax();
var content ='';

function listAjax(){
	$.ajax({
		type:'get',
		url:'/home/list.ajax',
		dataType:'json',
		success:function(data){
			//console.log(data); 
			todoDraw(data.todoList);
			apprDraw(data);
			taskDraw(data.prj_taskList); 
		},
		error:function(e){
			console.log("에러: "+e);
		}
	});
}

// 프로젝트 업무 리스트
function taskDraw(taskList){
	content = ''; 
	console.log(taskList.length);
	if(taskList.length ==0){
		content += '<tr>';
		content += '<td colspan="5">진행중인 프로젝트 업무가 없습니다.</td>';
		content += '</tr>';
		$('#prj_taskList').empty(); 
		$('#prj_taskList').append(content);
	} else if(taskList.length > 0){
		for(var i=0; i<taskList.length; i++){ 
			content += '<tr>';
			content += '<td><strong>'+taskList[i].prj_subject+'</strong></td>';
			content += '<td>'+taskList[i].task_subject+'</td>';
			content += '<td>'+taskList[i].start+'</td>';
			content += '<td>'+taskList[i].end+'</td>';  
			if(taskList[i].state == '0'){
				content += '<td> <span class="badge bg-label-primary me-1">준비중</span></td>';			
			} else if(taskList[i].state == '1'){
				content += '<td> <span class="badge bg-label-warning me-1">진행중</span></td>';		
			} else if(taskList[i].state == '2'){
				content += '<td> <span class="badge bg-label-secondary">완료</span></td>';		
			} 
			content += '</tr>';
		}
		$('#prj_taskList').empty(); 
		$('#prj_taskList').append(content);		
	}
}

// 결재발신 문서 
function apprDraw(data){
	content = '';
	console.log(data);
	var appr_docList = data.appr_docList;
	if(appr_docList.length < 1){
		content += '<tr>';
		content += '<td colspan="4">해당 데이터가 없습니다.</td>';
		content += '</tr>';
	}else{
		for(var i=0; i<appr_docList.length; i++){
			if(appr_docList[i].doc_state=='1'){ 
				content += '<tr>';
				content += '<td><strong>'+appr_docList[i].subject+'</strong></td>';
				content += '<td><span class="badge bg-label-primary me-1">진행중</span></td>';			
				content += '<td>'+appr_docList[i].order+' 차 진행중</td>';  
				if(appr_docList[i].detail_state == '0'){
					content += '<td> <span class="badge bg-label-primary me-1">진행대기</span></td>';			
				} else if(appr_docList[i].detail_state == '1'){
					content += '<td> <span class="badge bg-label-primary me-1">진행중</span></td>';		
				} else if(appr_docList[i].detail_state == '2'){
					content += '<td> <span class="badge bg-label-success">결재완료</span></td>';		
				} else if(appr_docList[i].detail_state == '3'){
					content += '<td> <span class="badge bg-label-danger">반려</span></td>';		
				}
				content += '</tr>';
			} else if(appr_docList[i].doc_state == '2' | appr_docList[i].doc_state == '3'){
				content += '<tr>';
				content += '<td><strong>'+appr_docList[i].subject+'</strong></td>';
				if(appr_docList[i].doc_state == '2'){
					content += '<td><span class="badge bg-label-success">결재완료</span></td>';			
				} else if(appr_docList[i].doc_state == '3'){
					content += '<td><span class="badge bg-label-danger">반려</span></td>';			
				}
				content += '<td>'+appr_docList[i].order+' 차 진행</td>';
				if(appr_docList[i].detail_state == '2'){
					content += '<td> <span class="badge bg-label-secondary">결재완료</span></td>';		
				} else if(appr_docList[i].detail_state == '3'){
					content += '<td> <span class="badge bg-label-danger">반려</span></td>';		
				}
				content += '</tr>';
			}
		}
	}
		$('#appr_docList').empty(); 
		$('#appr_docList').append(content);
}

// todolist 
function todoDraw(todoList){
	content = ''; 
	
	for(var i=0; i<todoList.length; i++){
		content += '<label class="list-group-item">';
		if(todoList[i].done == 'N'){
			//console.log(todoList[i].done);															
			content += '<input class="form-check-input me-1" type="checkbox" onclick="checkbox(this)" id="'+todoList[i].todo_idx+'" name="todo" value="'+todoList[i].done+'" /><input type="text" id="todoCont" value="'+todoList[i].content+'" class="col-sm-9" style="border: white; color: #697a8d;"> <button type="button" onclick="todoDelete(this)" class="btn btn-xs float-end">삭제</button>'
						+'<button type="button" onclick="todoEdit(this)" class="btn btn-xs float-end">수정</button>';
		} else if(todoList[i].done == 'Y'){
			content += '<input class="form-check-input me-1" type="checkbox" onclick="checkbox(this)" id="'+todoList[i].todo_idx+'" name="todo" value="'+todoList[i].done+'" checked /><input type="text" id="todoCont" value="'+todoList[i].content+'" class="col-sm-9" style="border: white; color: #697a8d;"> <button type="button" onclick="todoDelete(this)" class="btn btn-xs float-end">삭제</button>'
						+'<button type="button" onclick="todoEdit(this)" class="btn btn-xs float-end">수정</button>';
		}
		content += '</label> ';
	}
	$('#todoList').empty(); 
	$('#todoList').append(content);
}

// todo 등록 
function todoWrite(){
	content = ''; 
	var todoInput = document.getElementById('todoInput').value;
	
	if(todoInput == null || todoInput ==''){	
		alert("등록할 내용이 없습니다.");
	} else{
		$.ajax({
			type:'get',
			url:'/home/todoRegist.ajax',
			data: {'content':todoInput},
			dataType:'json',
			success:function(data){
				console.log(data);
				if(data.success > 0){ listAjax();}
				document.getElementById('todoInput').value=''; // input 공백 처리  
			},
			error:function(e){
				console.log("에러: "+e);
			}
		});
	}
}

// todo 수정 요청 
function todoEdit(elem){
	var parent = elem.parentNode;
	var input = parent.childNodes[1];
	var content = input.value;
	var done = parent.childNodes[0].value;
	var idx = parent.childNodes[0].id;
	//console.log(idx);   
	
	$.ajax({
		type:'get',
		url:'/home/todoEdit.ajax',
		data: {'content':content, 'done':done, 'idx':idx},
		dataType:'json',
		success:function(data){
			//console.log(data);
			listAjax();
		},
		error:function(e){
			console.log("에러: "+e);
		}
	}); 
}

// todo checkbox 
function checkbox(elem){
	console.log(elem.id);
	console.log(elem.value);
	if(elem.value=='N'){
		elem.value='Y';
	} else if(elem.value=='Y'){
		elem.value='N';
	}
	$.ajax({
		type:'get',
		url:'/home/todoDoneEdit.ajax',
		data: {'done':elem.value, 'idx':elem.id},
		dataType:'json',
		success:function(data){
			//console.log(data);
			listAjax();
		},
		error:function(e){
			console.log("에러: "+e);
		}
	}); 
}

// todo 삭제(숨김)
function todoDelete(elem) {
	//console.log($("input[name=todo]").prop("id"));
	var idx = $("input[name=todo]").prop("id");
	console.log(idx);
	elem.parentNode.remove();

	$.ajax({
		type : 'get',
		url : '/home/todoDelete.ajax',
		data : {
			'todo_idx' : idx
		},
		dataType : 'json',
		success : function(data) {
			//console.log(data);
		},
		error : function(e) {
			console.log("에러: " + e);
		}
	});
}

// 페이지 이동 
$('#cal-card-body').on("click", function(){ 
	location.href="/schedule/scheList.move";
}); 
</script>
</html>
