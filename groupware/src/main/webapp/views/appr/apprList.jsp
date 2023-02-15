<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>

<html>

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
							<span class="text-muted fw-light"> <c:set var="path"
									value="${requestScope['javax.servlet.forward.servlet_path']}" />
							<c:choose>
							<c:when test="${fn:contains(path, 'apprWait')}">결재 수신함 / </span>결재 대기
							</c:when>
							<c:when test="${fn:contains(path, 'apprDone')}">결재 수신함 / </span>처리 완료</c:when>
							<c:when test="${fn:contains(path, 'apprInProgress')}">결재 상신함 / </span>결재 진행중</c:when>
							<c:when test="${fn:contains(path, 'apprReject')}">결재 상신함 / </span>결재 반려</c:when>
							<c:when test="${fn:contains(path, 'apprComplete')}">결재 상신함 / </span>결재 완료</c:when>
							<c:otherwise>여긴어딘가요../</c:otherwise>
							</c:choose>
						</h4>

						<!-- Hoverable Table rows -->
						<div class="card">
							<div class="demo-inline-spacing">
								<!--            <button type="button" class="btn btn-outline-primary" onclick="location.href ='docFormRegist.move'">결재양식 생성</button> -->
							</div>
							<div class="table-responsive text-nowrap">
								<table class="table table-hover">
									<thead>
										<tr class="table_center">
											<th>번호</th>
											<th>제목</th>
											<c:if test="${fn:contains(path, 'apprInbox')}">
												<th>기안자</th>
											</c:if>
											<th>기안날짜</th>
											<th>상태</th>
											<th>공개여부</th>
										</tr>
									</thead>
									<tbody class="table-border-bottom-0" id="apprList">
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

	var mainCat = (document.location.pathname).split('/')[1];
	var subCat = (document.location.pathname).split('/')[2].split('.')[0];
	
	//검색 클릭 시 실행
	function search(){
		searchInput=$("#searchInput").val();
		$('#pagination').twbsPagination('destroy');
		listAjax(subCat, showPage, searchInput);
	}
	

	//기안문서 리스트 호출
	listAjax(subCat, showPage);
	function listAjax(subCat, page, searchInput) {
		//console.log("listAjax호출~~~"+subCat+ page+ searchInput)
		$.ajax({
			type : 'post',
			url : '/appr/apprList.ajax',
			data : {
				'subCat' : subCat,
				'page': page,
				'searchInput': searchInput
			},
			dataType : 'json',
			success : function(data) {
				// 			console.log(data);
				drawList(data.list);
				
				//페이징
				$('#pagination').twbsPagination({
					startPage : 1, //시작페이지
					totalPages : data.total, //총 페이지 수
					visiblePages : 5, //기본으로 보여줄 페이지 수
				}).on('page', function (event, page) {
					//console.log(searchInput+"onclick 검색어11111");
		            listAjax(subCat, page, searchInput);
		        });
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}

	function drawList(list) {
		content = '';
		if (list.length < 1) {
			content += '<tr><td colspan="6">문서가 존재하지 않습니다.</td></tr>';
		}
		for (var i = 0; i < list.length; i++) {
			content += '<tr class="table_center">';
			//번호,제목,기안자,기안날짜,상태,공개여부

			//문서 번호
			content += '<td>' + list[i].doc_idx + '</td>';

			//문서 제목
			content += '<td class="td_subject"><a href="/' + mainCat
					+ '/apprDetail.move?doc_idx=' + list[i].doc_idx
					+ '"><strong>' + list[i].subject + '</strong></a></td>';

			//기안자
			if (mainCat == 'apprInbox') {
				content += '<td>' + list[i].mem_id + '</td>';
			}

			//기안 날짜
			content += '<td>' + timeStampCut(list[i].reg_date) + '</td>';

			//상태
			if (list[i].state == 1) {
				content += '<td><span class="badge bg-label-primary me-1">진행중</span></td>';
			} else if (list[i].state == 2) {
				content += '<td><span class="badge bg-label-success me-1">결재 완료</span></td>';
			} else if (list[i].state == 3) {
				content += '<td><span class="badge bg-label-danger me-1">반려</span></td>';
			}

			//공개 여부
			if (list[i].open == "Y") {
				content += '<td><span class="badge badge-center bg-label-success">Y</span></td>';
			} else if (list[i].open == 'N') {
				content += '<td><span class="badge badge-center bg-label-danger">N</span></td>';
			}
		}

		$('#apprList').empty();
		$('#apprList').append(content);

	}
	
	//time stamp 변환
	function timeStampCut(timestamp) {
		var date = new Date(timestamp);
		var year = date.getFullYear().toString();
		var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
		var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
		var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
		var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
		var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
		var returnDate = year + "-" + month + "-" + day;
		return returnDate;
	}
</script>
</html>
