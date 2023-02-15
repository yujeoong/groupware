<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/res/style.css" />
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
			
 				<h4 class="fw-bold py-3 mb-4">
				
					<c:choose>
						<c:when test="${dep_idx eq 1}"><span class="text-muted fw-light">부서 게시판 / </span>재무 </c:when>
						<c:when test="${dep_idx eq 2}"><span class="text-muted fw-light">부서 게시판 / </span>인사 </c:when>
						<c:when test="${dep_idx eq 3}"><span class="text-muted fw-light">부서 게시판 / </span>경영 </c:when>
						<c:when test="${dep_idx eq 4}"><span class="text-muted fw-light">부서 게시판 / </span>신인개발 </c:when>
						<c:when test="${dep_idx eq 5}"><span class="text-muted fw-light">부서 게시판 / </span>매니지먼트 </c:when>
						<c:otherwise><span>공지사항</span></c:otherwise>
					</c:choose>
			</h4>
						
					
				
				<!-- Hoverable Table rows -->
				<div class="card">
					<div class="table-responsive text-nowrap">
					<span style="float : right;">
						<button  type="button" 
							<c:if test="${dep_idx eq '99' && sessionScope.level != null && sessionScope.level < 2 }">
								onclick="location.href='/post/writeForm.move?dep_idx=99'" 
							</c:if>
							<c:if test="${dep_idx ne null}">
								 onclick="location.href='./writeForm.move?dep_idx=${dep_idx}'" 
							</c:if>
								class="btn btn-outline-primary" value="${dep_idx}">글작성</button>
					</span>
						<table class="table table-hover">
							<thead>
								<tr class="table_center">
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody class="table-border-bottom-0" id="list">
							</tbody>
						</table>
					</div>
				</div>

				
				<!-- 검색 관련 -->
				<p style="height: 10px;">&nbsp;</p>
				<!-- 검색 -->
				<div id="searchForm" class="input-group input-group-merge"	style="width: 50%; margin: 0 auto;">
					<span class="input-group-text"><i class="bx bx-search"></i></span>
					<select id="searchType" name="searchType" class="form-select-custom" style="text-align: center;">
						<option value="1">제목</option>
						<option value="2">내용</option>
						<option value="3">작성자</option>
					</select>
					<input type="text" class="form-control" placeholder="검색어를 입력하세요." id="searchInput" />
					<button type="button" id="search" class="btn btn-secondary" onclick="search()">검색</button>
				</div>







				<!--      페이지네이션 추가하기      -->
				<div class="card-body">
					<div class="demo-inline-spacing"> 
						<nav aria-label="Page navigation" style="text-align:center">
							<ul class="pagination justify-content-center" id="pagination">
							
							</ul>
						</nav>
					</div>
				</div>


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
  
  
  
  
  
<script src="../pagination/jquery.twbsPagination.js" type="text/javascript"></script>  
<script>

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}





//현재 보여줄 페이지 지정
var showPage = 1; //보여지는 페이지를 1로 잡음
var searchType = '';
var searchInput = '';
var dep_idx = ${dep_idx};
listCall(showPage, dep_idx, searchType, searchInput);


function search(){
	
	if($("#searchInput").val() == ""){
		alert("검색어를 입력해주세요.");
	}else{
		searchInput = $("#searchInput").val(); //검색어 추출
		console.log("검색 버튼 클릭 >> 검색 내용은?? : "+searchInput);
		
		var searchType = $('#searchType option:selected').val();
		console.log("검색 버튼 클릭 >> 검색 옵션은?? : "+searchType);
		
		$("#pagination").twbsPagination('destroy');
		page = 1;
		dep_idx = ${dep_idx};
		console.log("검색 버튼 >> listCall")
		console.log("dep_idx???"+dep_idx)
		listCall(page, dep_idx, searchType, searchInput);
	}
}




//리스트 불러오기 
function listCall(page, dep_idx, searchType, searchInput) {	

var dep_idx = ${dep_idx};
var loginId = '${sessionScope.loginId}' 
console.log("dep_idx ddddd : "+dep_idx);
	
	showPage = page;
	console.log("showPage : "+ showPage);
	
	$.ajax({
		type : 'GET', 
		url : '/post/postList.ajax',
		data : {page:page, dep_idx : dep_idx, searchType:searchType, searchInput:searchInput},
		dataType : 'JSON', 
		success : function(data) { 
			console.log(data);
			
			$('#pagination').twbsPagination({
				startPage : 1, //시작페이지
				totalPages : data.total, //총 페이지 수
				visiblePages : 5, //기본으로 보여줄 페이지 수
			}).on('page', function (event, page) {
				//console.log(searchInput+"onclick 검색어11111");
	            listCall(page,dep_idx, searchType, searchInput);
	        });
			
			//리스트 띄우기
			drawList(data.list);

		},//end for success
		error : function(e) {
			console.log(e);
		}
	});//end for ajax
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



// 리스트 그리기
function drawList(list) {
	var content = '';
	
	if(list.length < 1){
		content += '<tr class="table_center">';
		content += '<td colspan = "5">게시글이 없습니다.</td>';
		content += '</tr>';
	$('#list').empty();
	$('#list').append(content); 
	}
	
	for (var i = 0; i < list.length; i++) {
		content += '<tr class="table_center">';
		content += '<td>'+list[i].post_idx+'</td>'; 
		content += '<td class="td_subject"><a href="../post/detail.move?post_idx='+list[i].post_idx+'">'+list[i].subject+'</a></td>'; 
		content += '<td>'+list[i].dept_name+' '+list[i].mem_name+' '+list[i].pos_name+'</td>'; 
		content += '<td>'+timeStampCut(list[i].date)+'</td>';
		content += '<td>'+list[i].cnt+'</td>';
		content += '</tr>';
	}
	$('#list').empty();
	$('#list').append(content); 
}




/* //페이징 그리기
function listPaging(page) { // page : 전체 페이지 
	console.log("showPage : ",showPage); // 현재 페이지 번호 
	var content = '';

	content += '<li class="page-item first"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
			+ 1
			+ '); return false;"><i class="tf-icon bx bx-chevrons-left"></i></a></li>';
	if (showPage - 1 > 0) {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
				+ (showPage - 1)
				+ '); return false;"><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	} else {
		content += '<li class="page-item prev"><a class="page-link" href="javascript:void(0);" ><i class="tf-icon bx bx-chevron-left"></i></a></li>';
	}
	for (var i = 0; i < page; i++) { // class="page-item active" : 선택 보라색 
		if (showPage == (i + 1)) {
			content += '<li class="page-item active"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
					+ (i + 1)
					+ '); return false;">'
					+ (i + 1)
					+ '</a></li>';
		} else {
			content += '<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
					+ (i + 1)
					+ '); return false;">'
					+ (i + 1)
					+ '</a></li>';
		}
	}
	if (showPage + 1 <= page) {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
				+ (showPage + 1)
				+ '); return false;"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	} else {
		content += '<li class="page-item next"><a class="page-link" href="javascript:void(0);"><i class="tf-icon bx bx-chevron-right"></i></a></li>';
	}
	content += '<li class="page-item last"><a class="page-link" href="javascript:void(0);" onclick="ComtCall('
			+ page
			+ '); return false;"><i class="tf-icon bx bx-chevrons-right"></i></a></li>';
	$('#pagination').empty();
	$('#pagination').append(content);
}
 */




 
</script>
</html>








