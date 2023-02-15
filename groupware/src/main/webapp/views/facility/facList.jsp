<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<style>
#facDetail{ /* 리스트 시설상태 css */
	margin-bottom: 20px;
    padding-top: 10px;
    height: 30px;
}
span#facDetail.form-control{ /* 상세보기 span css */
	margin-bottom: 20px;
    padding-top: 10px;
    height: 50px;
}
.form-label{ /* 상세보기 label css */
	font-size: large;
}
.badge bg-label-primary {
	width: 90px;
    padding-top: 20px;
}
.table th, td{	/* 리스트 제목 내용 */
	text-align: center;
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
					<div class="container-xxl flex-grow-1 container-p-y" style="height: 40%; "> <!-- 본문높이수정  -->

					
						<!--  시설 리스트 -->
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">시설예약 /</span> 시설 리스트
						</h4>

						<!-- 필터 드롭다운 -->
						<div class="btn-group" style="margin-bottom: 10px;">
							<button type="button" id="dropdown"
									class="btn btn-outline-primary dropdown-toggle"
									data-bs-toggle="dropdown" aria-expanded="false">전체 보기</button>
								<ul class="dropdown-menu">
									<li><a onclick="facOption(this.innerText)"
										class="dropdown-item" href="javascript:void(0);">전체 보기</a></li>
									<li><a onclick="facOption(this.innerText)"
										class="dropdown-item" href="javascript:void(0);">시설</a></li>
									<li><a onclick="facOption(this.innerText)"
										class="dropdown-item" href="javascript:void(0);">차량</a></li>
									<li><a onclick="facOption(this.innerText)"
										class="dropdown-item" href="javascript:void(0);">기타</a></li>
								</ul>
						</div>

						<div class="card">
							<div class="table-responsive text-nowrap">
								<table class="table">
									<thead>
										<tr>
											<th>시설 번호</th>
											<th>시설명</th>
											<th>시설 종류</th>
											<th>시설 상태</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody id="listArea" class="table-border-bottom-0">
									</tbody>
								</table>
							</div>		
						</div>
					</div><br/>
					
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					<p>&nbsp;</p>
					
					
					<!-- 검색 박스 --> 
					<div class="input-group input-group-merge" id="facSearchDiv"
						style="width: 50%; margin: 0 auto;">
						<span class="input-group-text" id="basic-addon-search31"><i
							class="bx bx-search"></i></span> 
							
							
							<input type="text"
							class="form-control" placeholder="시설명을 입력해주세요"
							aria-label="Search..." aria-describedby="basic-addon-search31"
							value="" id="facNameSearch" />
							
							
						<button type="button" class="btn btn-secondary"
							onclick="facSearch(this)">검색</button>
	
					</div>
					
					<!-- 페이징 -->
					<div id="card-body" style="height: 15%;">
					<div class="demo-inline-spacing"> 
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination justify-content-center" id="pagination">
							
							</ul>
						</nav>
					</div>
					</div>
					
					<!-- 모달 -->
					<div class="modal fade"  id="modalUpdate" tabindex="-1">
						<div class="modal-dialog">
							<form class="modal-content">
								<div class="modal-header">
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div id="facilityDetailModal" class="modal-body"></div>
							</form>
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
var option = 'none'; 
var showPage = 1; // 현재 보여줄 페이지 지정
var searchWhat = ''; //검색 조건 없음
facList(showPage, option, searchWhat); //showPage, option, searchWhat

//필터 드롭다운 
function facOption(optionVal) {
	console.log(optionVal);
	document.getElementById("dropdown").innerHTML = optionVal;
	option = optionVal;
	showPage = 1;
	facList(showPage, optionVal);
}

// 시설 리스트
function facList(page) { // option
	showPage = page;
	console.log("시설 리스트");
	
	if(option=='전체 보기'){
		option = 'none';
	}else if(option=='시설'){
		option = '0';
	}else if(option=='차량'){
		option = '1';
	}else if(option=='기타'){
		option = '2';
	}
	
	console.log(page);
	console.log(option);
	console.log(searchWhat);

	$.ajax({
		type : 'get',
		url : '/facility/faclist.ajax',
		data : {
			page : page,
			option : option,
			searchWhat : searchWhat
		},
		dataType : 'json',
		success : function(result) {
			console.log(result);

			// list 띄우기 
			facDrawList(result.list);
			// 페이징  
			listPaging(result.total);

		}, // end -success
		errer : function(e) {
			console.log(e);
		}
	}); //ajax end
}

// 페이징그리기 
function listPaging(page) { // page : 전체 페이지 
	console.log(showPage); // 현재 페이지 
	var content = '';

	content += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="facList('
			+ 1
			+ '); return false;"><i class="tf-icon bx bx-chevrons-left"></i></a></li>';
	if (showPage - 1 > 0) {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="facList('
				+ (showPage - 1)
				+ '); return false;"><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	} else {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" ><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	}
	for (var i = 0; i < page; i++) { // class="page-item active" : 선택 보라색 
		if (showPage == (i + 1)) {
			content += '<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="facList('
					+ (i + 1)
					+ '); return false;">'
					+ (i + 1)
					+ '</a></li>';
		} else {
			content += '<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="facList('
					+ (i + 1)
					+ '); return false;">'
					+ (i + 1)
					+ '</a></li>';
		}
	}
	if (showPage + 1 <= page) {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="facList('
				+ (showPage + 1)
				+ '); return false;"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	} else {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	}
	content += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="facList('
			+ page
			+ '); return false;"><i class="tf-icon bx bx-chevrons-right"></i></a></li>';
	$('#pagination').empty();
	$('#pagination').append(content);
}

// 리스트그리기
function facDrawList(facList) {
	//console.log(facList);
	console.log(option);
	var content = '';
	var type = '';

	for (i = 0; i < facList.length; i++) {
		if (facList[i].type == '0') {
			type = '시설';
		} else if (facList[i].type == '1') {
			type = '차량';
		} else if (facList[i].type == '2') {
			type = '기타';
		}

		content += '<tr id="drawListTr">';
		content += '<td>' + facList[i].fac_idx + '</td>';
		content += '<td><i class="fab fa-bootstrap fa-lg text-primary me-3"></i> <strong id = "facListName">'
				+ facList[i].name + '</strong></td>'; //시설명
		content += '<td id = "facListType">' + type + '</td>';
		if (facList[i].state == '사용가능' || facList[i].state == '사용 가능') {
			content += '<td><span class="badge bg-label-primary" id="facDetail">'
					+ facList[i].state + '</span></td>';
		} else if (facList[i].state == '사용중' || facList[i].state == '사용 중') {
			content += '<td><span class="badge bg-label-warning" id="facDetail">'
					+ facList[i].state + '</span></td>';
		} else if (facList[i].state == '사용불가'
				|| facList[i].state == '사용 불가') {
			content += '<td><span class="badge bg-label-secondary" id="facDetail">'
					+ facList[i].state + '</span></td>';
		}
		content += '<td><button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalUpdate" onclick="detailModal('
				+ facList[i].fac_idx + ')">상세보기</button>';
		content += '</tr>';
		$('#listArea').empty();
		$('#listArea').append(content);
	}
	window.scrollTo({
		top : 0,
		behavior : "smooth"
	});
}

// 상세보기 모달
function detailModal(fac_idx) {
	//console.log(fac_idx);
	var detail;
	
	// 제목 아작스로 보내서 데이터 꺼내오기~~ 
	$.ajax({
		type : 'get',
		data : {
			'fac_idx' : fac_idx
		},
		url : '/facility/facDetail.ajax',
		dataType : 'json',
		success : function(data) {
			console.log(data);

			drawDetail(data.result); // 모달에 데이터 띄우기 
		},
		error : function(e) {
			console.log(e);
		}
	});
}

//데이터 띄우기 
function drawDetail(data) {
	console.log(data);
	//console.log(loginId); // true/false

	console.log("상세정보 띄우기");
	var content = '';
	var type = '';

	if (data.type == '0') {
		type = '시설';
	} else if (data.type == '1') {
		type = '차량';
	} else if (data.type == '2') {
		type = '기타';
	}

	// modal-body
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" style="font-size: 1rem, width: 20%;">시설 종류</label>';
	content += '<span type="text" id="facDetail" class="form-control" >' + type + '</span>';
	content += '</div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" >시설명</label>';
	content += '<span type="text" id="facDetail" class="form-control">' + data.name + '</span>';
	content += '</div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">시설 상태</label>';

	if (data.state == '사용가능' || data.state == '사용 가능') {
		content += '<td><span class="badge bg-label-primary" id="facDetail">'
				+ data.state + '</span></td>';
	} else if (data.state == '사용중' || data.state == '사용 중') {
		content += '<td><span class="badge bg-label-warning" id="facDetail">'
				+ data.state + '</span></td>';
	} else if (data.state == '사용불가' || data.state == '사용 불가') {
		content += '<td><span class="badge bg-label-secondary" id="facDetail">'
				+ data.state + '</span></td>';
	}
	content += '</div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">비고</label>';
	content += '<span type="text" id="facDetail" class="form-control">' + data.comment + '</span>';
	content += '</div><br/><br/>';
	$('#facilityDetailModal').empty();
	$('#facilityDetailModal').append(content);

}


//시설명 검색 
function facSearch(elem) {
	console.log(elem);
	searchWhat = $(elem).closest("#facSearchDiv").find("#facNameSearch").val();
	console.log(searchWhat);
	facList(showPage,option,searchWhat);
}	
</script>
</html>






