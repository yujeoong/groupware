<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>

<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css"> -->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<!-- <script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script> -->

</head>
<body>
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
							<span class="text-muted fw-light">전자결재/</span>결재양식 목록
						</h4>

						<!-- Hoverable Table rows -->
						<div class="card">
							<div class="demo-inline-spacing">
								<button type="button" class="btn btn-outline-primary float-end"
									onclick="location.href ='docFormRegist.move'">결재양식 생성</button>
							</div>
							<div class="table-responsive text-nowrap">
								<table class="table table-hover">
									<thead>
										<tr class="table_center">
											<th>번호</th>
											<th>제목</th>
											<th>사용수</th>
											<th></th>
										</tr>
									</thead>
									<tbody class="table-border-bottom-0" id="formList">
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
<!-- 								<option value="all">All</option> -->
								<option>제목</option>
							</select> <input type="text" class="form-control" placeholder="제목을 입력하세요."
								id="searchInput" />
							<button type="button" class="btn btn-secondary"
								onclick="search()">검색</button>
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
<script src="../pagination/jquery.twbsPagination.js" type="text/javascript"></script>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

	//첫페이지, 검색값 초기화
	var showPage = 1;
	var searchInput;

//$( document ).ready(function() {
listAjax(showPage);
//});
	
	//검색 클릭 시 실행
	function search(){
		searchInput=$("#searchInput").val();
		$('#pagination').twbsPagination('destroy');
		listAjax(1, searchInput);
	}
	
	function listAjax(page, searchInput) {
		//console.log("listAjax~~~~~"+page+"::"+searchInput);
		$.ajax({
			type : 'post',
			url : '/appr/formList.ajax',
			data : {'page': page,'searchInput': searchInput},
			dataType : 'json',
			success : function(data) {
				drawList(data.list);
				//console.log(searchInput+"검색어?11"+data.total);
				
				//페이징
				$('#pagination').twbsPagination({
					startPage : 1, //시작페이지
					totalPages : data.total, //총 페이지 수
					visiblePages : 5, //기본으로 보여줄 페이지 수
				}).on('page', function (event, page) {
					//console.log(searchInput+"onclick 검색어11111");
		            listAjax(page, searchInput);
		        });
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}
	
	function drawList(list) {
		content = '';
		loginLevel = ${sessionScope.level};
		if(list.length <1){
			content += '<tr class="table_center">';
			content += '<td>문서가 존재하지 않습니다.</td>';			
			content += '</tr>';			
		}else{			
		for (var i = 0; i < list.length; i++) {
			content += '<tr class="table_center">';
			//양식 번호
			content += '<td>' + list[i].form_idx + '</td>';

			//양식 제목
			content += '<td class="td_subject"><a href="/appr/apprRegist.move?form_idx='
					+ list[i].form_idx
					+ '"><strong>'
					+ list[i].subject
					+ '</strong></a></td>';

			//사용 수
			content += '<td>' + list[i].use + '</td>';

			//삭제 드롭다운
			//관리자면 보이게 하기
			content += '<td>';

			if(loginLevel<2){
				content += '<div class="dropdown">';
				content += '<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">';
				content += '<i class="bx bx-dots-vertical-rounded"></i>';
				content += '</button>';
				content += '<div class="dropdown-menu">';
				content += '<a class="dropdown-item" href="/appr/formDelete.do?form_idx='
						+ list[i].form_idx
						+ '"><i class="bx bx-trash-alt me-1"></i> 삭제</a>';
				content += '</div>';
				content += '</div>';
			}
			content += '</td></tr>';
		}
		}
		$('#formList').empty();
		$('#formList').append(content);

	}

</script>
</html>
