<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<style>
textarea.form-control {
	resize: none;
}
</style>
</head>

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
						<h4 id = "pathH4Name" class="fw-bold py-3 mb-4">
							<span id = "pathSpanName" class="text-muted fw-light">관리자 /</span> 사원 관리
						</h4>



						<!-- 멤버 리스트 -->
						<!-- Hoverable Table rows -->
						<div class="card">
							<!-- 등록 버튼 -->
							<div id="registBtnArea" class="demo-inline-spacing">
								<button type="button" class="btn btn-outline-primary float-end"
									onclick="location.href='/admin/memRegist.move'">등록</button>
								<!-- 사원 등록페이지로 이동 -->
							</div>
							<div class="table-responsive text-nowrap">
								<table class="table table-hover"
									style="text-align: center; table-layout: fixed;">
									<thead>
										<tr class="table_center">
											<th>아이디</th>
											<th>이름</th>
											<!-- 필터먹인 부서 -->
											<th>
												<div id="actDepDiv" class="nav-item dropdown">
													<a class="dropdown-toggle" href="javascript:void(0)"
														id="actDepAtag" role="button" data-bs-toggle="dropdown"
														aria-expanded="false" onclick="depFilterCall(this)">부서</a>
													<ul id="actDepList" class="dropdown-menu"
														aria-labelledby="navbarDropdown"
														style="text-align: center;">
													</ul>
												</div>
											</th>
											<!-- 필터먹인 직급 -->
											<th>
												<div id="actPosDiv" class="nav-item dropdown">
													<a class="dropdown-toggle" href="javascript:void(0)"
														id=actPosAtag role="button" data-bs-toggle="dropdown"
														aria-expanded="false" onclick="depFilterCall(this)">직급</a>
													<ul id="actPosList" class="dropdown-menu"
														aria-labelledby="navbarDropdown"
														style="text-align: center;">
													</ul>
												</div>
											</th>
											<!-- 필터먹인 직책 -->
											<th>
												<div id="actDutyDiv" class="nav-item dropdown">
													<a class="dropdown-toggle" href="javascript:void(0)"
														id="actDutyAtag" role="button" data-bs-toggle="dropdown"
														aria-expanded="false" onclick="depFilterCall(this)">직책</a>
													<ul id="actDutyList" class="dropdown-menu"
														aria-labelledby="navbarDropdown"
														style="text-align: center;">
													</ul>
												</div>
											</th>
											<th>이메일</th>
										</tr>
									</thead>
									<tbody id="listArea">

									</tbody>

								</table>
							</div>
						</div>
						<!--/ Hoverable Table rows -->

						<p style="height: 10px;">&nbsp;</p>
						<!-- 검색 -->
						<div id="searchForm" class="input-group input-group-merge"
							style="width: 50%; margin: 0 auto;">
							<span class="input-group-text"><i class="bx bx-search"></i></span>
							<select id="dropAtag" name="searchType"
								class="form-select-custom" style="text-align: center;">
								<option value="">검색조건</option>
								<option value="mem_id">아이디</option>
								<option value="name">이름</option>
							</select> <input type="text" class="form-control"
								placeholder="아이디 혹은 사원명을 입력해주세요" id="memNameSearch" value="" />

							<button type="button" class="btn btn-secondary"
								onclick="memSearch()">검색</button>
						</div>

						<!-- 페이지 네이션 -->
						<div class="demo-inline-spacing">
							<nav aria-label="Page navigation">
								<ul class=" justify-content-center" id="pagination">
								</ul>
							</nav>
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
<script src="../pagination/jquery.twbsPagination.js"
	type="text/javascript"></script>
<script>

var root = "${root}";

//사원 검색 진입 혹은 관리자가 아닐경우 등록버튼 안보이게
var getUserLevel = '<%=session.getAttribute("level")%>';

if(getUserLevel>2 || root == "member"){
	$("#registBtnArea").css("display","none");
	$('.atagStop').attr('onclick', '');
	$('#pathH4Name').text("사원검색");
	$('#pathSpanName').text("");
	console.log($(".atagStop").text());
}


 window.onload = function(){
	$(".input-group > .form-control, .input-group > .form-select").css("width","auto");
	$("#dropAtag").css("width",0);	
	
}


// 현재 보여줄 페이지 지정
var showPage = 1;//첫 페이지
var depOption = 'none';//부서 필터링 조건 없음
var posOption = 'none';//직급 필터링 조건 없음
var dutyOption = 'none';//직책 필터링 조건 없음
var searchWhat = ''; //검색어 없음
var searchOption = ''; //검색 조건 없음



//hoisting
AdminMemListCall(showPage,searchWhat,searchOption,depOption,posOption,dutyOption);

function AdminMemListCall(page,searchWhat,searchOption,depOption,posOption,dutyOption){
	console.log("사원리스트콜");
	console.log("page : "+page);
	console.log("searchWhat : "+searchWhat);
	console.log("searchOption : "+searchOption);
	console.log("depOption : "+depOption);
	console.log("posOption : "+posOption);
	console.log("dutyOption : "+dutyOption);
	
	var urlGo = "";
	
	if(root == "admin"){
		urlGo = '/admin/memList.ajax';
	}else if(root == "member"){
		urlGo = '/member/memList.ajax';
	}
	
	$.ajax({
		type:'POST',
		url:urlGo,
		data:{page, 
				searchWhat,
				searchOption,
				depOption,
				posOption,
				dutyOption}, 
		dataType:'JSON',
		success:function(data){
			console.log(data);
			console.log(data.list);
			console.log(data.total);
			console.log(data.page);
			
			//추가됨 :  페이지 네이션
			$('#pagination').twbsPagination({
				startPage : 1, //시작페이지
				totalPages : data.total, //총 페이지 수
				visiblePages : 5, //기본으로 보여줄 페이지 수
			}).on('page', function (event, page) {
				AdminMemListCall(page,searchWhat,searchOption,depOption,posOption,dutyOption); // 리스트콜
	        });;
	        
			drawList(data);
			
		},
		error:function(e){
			console.log(JSON.stringify(e));
		}		
	});	
}//AdminMemListCall(page)

//사원 리스트 그리기
function drawList(data){
	var list = data.list;
	var content='';
	var type='';
	console.log(list.length);
	
	if(list.length < 1){
		content += '<tr class="table_center">';
		content += '<td colspan ="6">해당 조건에 만족하는 사원이 없습니다.</td>';  //사원 아이디
		content += '</tr>';
		
	$('#listArea').empty();
	$('#listArea').append(content);
	}
		
	for(i=0;i<list.length;i++){
	  
			content += '<tr id="drawListTr" class="table_center">';
			content += '<td>'+list[i].mem_id+'</td>';  //사원 아이디
			if('${root}' == 'member'){
				content += '<td>'+list[i].name+'</td>'; //상세보기			
			}else{
				content += '<td><a role="button" href="/admin/memDetail.move?mem_id='+list[i].mem_id+'" class = "atagStop">'+list[i].name+'</a></td>'; //상세보기
			}
			content += '<td>'+list[i].depname+'</td>';	//부서
			content += '<td>'+list[i].posname+'</td>';	//직급
			content += '<td>'+list[i].dutyname+'</td>';	//직책	
			content += '<td>'+list[i].email+'</td>';	//이메일	
			content += '</tr>';
			
		$('#listArea').empty();
		$('#listArea').append(content);
		
	}
	
	if(getUserLevel>2 || root == "member"){
		console.log($(".atagStop").text());
		$('.atagStop').attr('href','#');
	}

	
}//drawList(AdminFaclist)


/*
//페이징그리기 
function listPaging(data) { // page : 전체 페이지 
	var page = data.total; 
	var showPage = data.page;
	
	console.log(page); // 전체 페이지 
	console.log(showPage); // 현재 showPage 
	
	var content = '';

	content += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="AdminMemListCall('
			+ 1
			+ ',searchWhat,searchOption,depOption,posOption,dutyOption); return false;"><i class="tf-icon bx bx-chevrons-left"></i></a></li>';
	if (showPage - 1 > 0) {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="AdminMemListCall('
				+ (showPage - 1)
				+ ',searchWhat,searchOption,depOption,posOption,dutyOption); return false;"><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	} else {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" ><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	}
	for (var i = 0; i < page; i++) { // class="page-item active" : 선택 보라색 
		if (showPage == (i + 1)) {
			content += '<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="AdminMemListCall('
					+ (i + 1)
					+ ',searchWhat,searchOption,depOption,posOption,dutyOption); return false;">'
					+ (i + 1)
					+ '</a></li>';
		} else {
			content += '<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="AdminMemListCall('
					+ (i + 1)
					+ ',searchWhat,searchOption,depOption,posOption,dutyOption); return false;">'
					+ (i + 1)
					+ '</a></li>';
		}
	}
	if (showPage + 1 <= page) {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="AdminMemListCall('
				+ (showPage + 1)
				+ ',searchWhat,searchOption,depOption,posOption,dutyOption); return false;"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	} else {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	}
	content += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="AdminMemListCall('
			+ page
			+',searchWhat,searchOption,depOption,posOption,dutyOption); return false;"><i class="tf-icon bx bx-chevrons-right"></i></a></li>';
			
	$('#pagination').empty();
	$('#pagination').append(content);
}
*/


//필터링 클릭하면 조건 생성 > 필터 리스트 호출
function depFilterCall(elem) {
	var option = 'Y';
	
	console.log(elem);
	var checkName = $(elem).text();
	console.log(checkName);
	
	filterCall(checkName,option);
}

//필터 리스트 호출
function filterCall(checkName,option){
	console.log("필터링리스트콜");
	var urlGo = '';
	
	//url 
	if(checkName == '부서'){
		urlGo ='/admin/adminDepList.ajax'
	}else if(checkName == '직급'){
		urlGo ='/admin/posList.ajax'
	}else if(checkName == '직책'){
		urlGo ='/admin/dutyList.ajax'
	}
	
	$.ajax({
		type:'GET',
		url:urlGo,
		dataType:'JSON',
		data:{checkName,
				option},
		success:function(data){
			console.log(data);
			console.log(data.list);
			drawFilter(data.list,checkName);			
			
		},
		error:function(e){
			console.log(e);
		}		
	});	
}//filterCall(page)

//필터 리스트 뿌리기
function drawFilter(depList,checkName){
	var content='';
		
	if(checkName == '부서'){
		content +='<li><button type="button" class="dropdown-item" name="depFilter" onclick="showWhatFilter(this)" value="none">부서 전체</button></li>';
	
	}else if(checkName == '직급'){
		content +='<li><button type="button" class="dropdown-item" name="posFilter" onclick="showWhatFilter(this)" value="none">직급 전체</button></li>';

	}else if(checkName == '직책'){
		content +='<li><button type="button" class="dropdown-item" name="dutyFilter" onclick="showWhatFilter(this)" value="none">직책 전체</button></li>';

	}
		
	for(i=0;i<depList.length;i++){
		
		if(checkName == '부서'){
			content +='<li><button type="button" class="dropdown-item" name="depFilter" onclick="showWhatFilter(this)" value="'+depList[i].dep_idx+'">'+depList[i].name+'</button></li>';
			$('#actDepList').empty();
			$('#actDepList').append(content);
		}else if(checkName == '직급'){
			content +='<li><button type="button" class="dropdown-item" name="posFilter" onclick="showWhatFilter(this)" value="'+depList[i].pos_idx+'">'+depList[i].name+'</button></li>';
			$('#actPosList').empty();
			$('#actPosList').append(content);
		}else if(checkName == '직책'){
			content +='<li><button type="button" class="dropdown-item" name="dutyFilter" onclick="showWhatFilter(this)" value="'+depList[i].duty_idx+'">'+depList[i].name+'</button></li>';
			$('#actDutyList').empty();
			$('#actDutyList').append(content);
		}
		$(".table-responsive").css("overflow-x","clip");
	}
}//drawFilter


// 사원 필터링
function showWhatFilter(elem) {
	$("#memNameSearch").val(''); //검색창 초기화
	
	 console.log(elem);
	 var thatName = $(elem).attr('name'); 
	 var thatVal = $(elem).val();//필터 idx 가져오기
	 var thatText = $(elem).text(); // 필터 이름 가져오기

	 if(thatName == 'depFilter'){//부서필터
		 depOption = $(elem).val();
		 $("#actDepAtag").text(thatText);
	 	
	 }else if(thatName == 'posFilter'){//직급필터
		 posOption = $(elem).val();
		 $("#actPosAtag").text(thatText);
		 
	 }else if(thatName == 'dutyFilter'){//직책
		 dutyOption = $(elem).val();
		 $("#actDutyAtag").text(thatText);
		 
	 } 
	 
	 $('#pagination').twbsPagination('destroy'); // 추가됨 :  페이지 네이션 => 이게 있어야 페이지 네이션 됨

	 AdminMemListCall(showPage,searchWhat,searchOption,depOption,posOption,dutyOption);
}


//사원 검색
function memSearch() {

if($("#memNameSearch").val() == ""){
	alert("검색어를 입력해주세요.");
}else{
	searchWhat = $("#memNameSearch").val(); // 검색어
	
	var searchOption = $('#dropAtag option:selected').val();
	console.log("옵션 :"+searchOption);
	
	$('#pagination').twbsPagination('destroy'); // 추가됨 :  페이지 네이션
	
	page = 1;
	//검색어 검색조건 보내기
	AdminMemListCall(page,searchWhat,searchOption,depOption,posOption,dutyOption);
	}	

}
</script>
</html>
