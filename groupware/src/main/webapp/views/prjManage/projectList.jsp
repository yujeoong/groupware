<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>

<html>

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
                <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">프로젝트 / </span>
                <c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
                <c:if test="${fn:contains(path, 'myProjectList')}">참여중인 프로젝트</c:if>
                <c:if test="${fn:contains(path, 'projectList')}">전체 프로젝트</c:if>
                </h4>
 
			<!-- Hoverable Table rows -->
              <div class="card">
                <div class="demo-inline-spacing">
                	<c:choose>
						<c:when test="${sessionScope.duty_level eq 0}">
						</c:when>
						<c:otherwise>
		                	<button type="button" class="btn btn-outline-primary float-end" onclick="location.href ='projectRegist.move'">프로젝트 생성</button>
						</c:otherwise>
					</c:choose>
                </div>
                <div class="table-responsive text-nowrap">
                  <table class="table table-hover">
                    <thead>
                      <tr class="table_center">
                      	<th>번호</th>
                        <th>프로젝트명</th>
                        <th>기간</th>
                        <th>상태</th>
                        <th>진행률</th>
                        <th> </th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id="prjList">
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
var listCat = 'allList';
if(document.location.pathname.includes('myProjectList')){
	listCat = 'myList';
}

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

	//첫페이지, 검색값 초기화
	var showPage = 1;
	var searchInput;

	//검색 클릭 시 실행
	function search(){
		searchInput=$("#searchInput").val();
		$('#pagination').twbsPagination('destroy');
		listAjax(listCat, showPage, searchInput);
	}


listAjax(listCat, showPage);

//프로젝트 리스트 호출
function listAjax(listCat, page, searchInput){
	$.ajax({
		type:'post',
		url:'/prjManage/list.ajax',
		data: {'listCat': listCat,
				'page': page,
				'searchInput': searchInput	
		},
		dataType:'json',
		success:function(data){
// 			console.log(data);
			drawList(data.list);
			
			//페이징
			$('#pagination').twbsPagination({
				startPage : 1, //시작페이지
				totalPages : data.total, //총 페이지 수
				visiblePages : 5, //기본으로 보여줄 페이지 수
			}).on('page', function (event, page) {
	            listAjax(listCat, page, searchInput);
	        });

			
		},
		error:function(e){
			console.log("에러: "+e);
		}
	});
}

function drawList(list){
	content ='';
	
	if (list.length < 1) {
		content += '<tr><td colspan="6">프로젝트가 존재하지 않습니다.</td></tr>';
	}
	for(var i=0; i<list.length; i++){
		content += '<tr class="table_center">';
		content += '<td>'+list[i].prj_idx+'</td>';
		//프로젝트 이름
		content += '<td class="td_subject"><a href="/project/projectHome.move?prj_idx='+list[i].prj_idx+'"><strong>'+list[i].prj_subject+'</strong></a></td>';
		
		//프로젝트 기간
		content += '<td>'+list[i].prj_start_date+'&nbsp ~ &nbsp'+list[i].prj_end_date+'</td>';
		
		//프로젝트 상태
		const start_date = new Date(list[i].prj_start_date);
		const end_date = new Date(list[i].prj_end_date);
		if(new Date<start_date){
			content += '<td><span class="badge bg-label-primary me-1">준비중</span></td>';	
		}else if(new Date>end_date){
			content += '<td><span class="badge bg-label-secondary me-1">마감</span></td>';				
		}else{
			content += '<td><span class="badge bg-label-success me-1">진행중</span></td>';			
		}
		
		//프로젝트 진행률
		if(list[i].taskPercent != null){	
			content += '<td>'+Math.ceil(list[i].taskPercent)+'%</td>';
		}else{
			content += '<td>0%</td>';
		}
		
		//수정 드롭다운
		//로그인아이디와 작성자아이디 비교
		content += '<td>';
		if('${sessionScope.loginId}' == list[i].mem_id && new Date<=end_date){
			content += '<div class="dropdown">';
			content += '<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">';
			content += '<i class="bx bx-dots-vertical-rounded"></i>';
			content += '</button>';
			content += '<div class="dropdown-menu">';
			content += '<a class="dropdown-item" href="/prjManage/projectEdit.move?prj_idx='+list[i].prj_idx+'"><i class="bx bx-edit-alt me-1"></i> 수정</a>';		
			content += '</div>';
			content += '</div>';
		}
		content += '</td>';		
		content += '</tr>';		
	}
	
	$('#prjList').empty();
	
	$('#prjList').append(content);

}

</script>
</html>
