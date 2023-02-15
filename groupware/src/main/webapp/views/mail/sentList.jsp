<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
               <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">쪽지 /</span> 보낸쪽지함</h4>
 
				<br>

				<nav aria-label="breadcrumb">
					<a class="breadcrumb-item" href="./receivedList.move">
						<span>받은쪽지함 </span>
					</a>						
					<a href="./sentList.move">
						<span> / 보낸쪽지함</span>
					</a>				
					<button style= "float: right;" type="button" onclick="location.href='./writeForm.move'" class="btn btn-outline-primary" id="btnSave">새쪽지</button>
				</nav>

				<hr>
				<div class="card">
				<!-- Hoverable Table rows -->
				<div class="table-responsive text-nowrap">
				<div align="right">
					<button type="button" onclick="del()" class="btn btn-outline-primary" id="btnDelete">삭제</button>
				</div>
						<table class="table table-hover">
							<thead>
								<tr class="table_center">
									<th><input type="checkbox" id="checkboxAll" name="checkboxAll" onclick="setCheckbox(this)" /></th>
									<th>제목</th>
									<th>보낸시간</th>
									<th>읽음</th>
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
					</select>
					<input type="text" class="form-control" placeholder="검색어를 입력하세요." id="searchInput" />
					<button type="button" id="search_mail" class="btn btn-secondary" onclick="search_mail()">검색</button>
				</div>
				
				
				<!--      페이지네이션     -->
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

var showPage = 1; //현재 보여주는 페이지를 1로 잡음
var searchType = '';
var searchInput = '';
listCall(showPage, searchType, searchInput);


function search_mail(){
	
	if($("#searchInput").val() == ""){
		alert("검색어를 입력해주세요.");
	}else{
		searchInput = $("#searchInput").val(); //검색어 추출
		console.log("검색 버튼 클릭 >> 검색 내용은?? : "+searchInput);
		
		var searchType = $('#searchType option:selected').val();
		console.log("검색 버튼 클릭 >> 검색 옵션은?? : "+searchType);
		
		$("#pagination").twbsPagination('destroy');
		page = 1;
		cat = 2;
		console.log("검색 버튼 >> listCall")
		listCall(page, cat, searchType, searchInput);
	}
	
}


//보낸 메일 리스트 출력
function listCall(page, cat, searchType, searchInput) {
	showPage = page;
	$.ajax({
		type : 'post', 
		url : '/mail/list.ajax',
		data : {page:page, cat:2, searchType:searchType, searchInput:searchInput},
		dataType : 'JSON', 
		success : function(data) { 
			console.log(data);
			
			$('#pagination').twbsPagination({
				startPage : 1, //시작페이지
				totalPages : data.total, //총 페이지 수
				visiblePages : 5 //기본으로 보여줄 페이지 수
			}).on('page', function (event, page) {
	            listCall(page, cat, searchType, searchInput);
	        });
			
			//리스트 띄우기
			drawList(data.list);
			
		}, //end for success
		error : function(e) {
			console.log(e);
		}
	}); //end for ajax
}



function timeStampCut(timestamp) {
	var date = new Date(timestamp);
	var year = date.getFullYear().toString(); //년도 네자리
	var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
	var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
	var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
	var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
	var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
	var returnDate = year + "-" + month + "-" + day + " " + hour + ":" + minute;
	return returnDate;
}


//메일 리스트 그리기
function drawList(list) {
	var content = '';
	
	if(list.length < 1){
		content += '<tr class="table_center">';
		content += '<td colspan = "4">쪽지가 없습니다.</td>';
		content += '</tr>';
	$('#list').empty();
	$('#list').append(content); 
	}
	
	for (var i = 0; i < list.length; i++) {
		content += '<tr class="table_center">';
		content += '<td><input type="checkbox" id="checkbox" name="'+list[i].receiver_id+'" value="'+list[i].mail_idx+'"/></td>'; 
		content += '<td class="td_subject"><a style = "color:#697a8d;" href="detail.move?mail_idx='+list[i].mail_idx+'">'+list[i].title+'</a></td>'; 
		content += '<td>'+ timeStampCut(list[i].date) +'</td>';
		content += '<td id="'+list[i].mail_idx+'" onclick="goMailidx(this)">'+list[i].list_readList+"명 / "+list[i].list_ttlList+"명"+'</td>'; // 읽은사람 수 /쪽지 받은 전체 수
		content += '</tr>';
	}	
	$('#list').empty();
	$('#list').append(content); 
}



function del(){
	var state = confirm("쪽지를 삭제하시겠습니까?");
	if(!state){
		return false;
	}
	var chkArr = [];
	$('input[type="checkbox"]:checked').each(function(mail_idx){
		if($(this).val() != 'on'){
			chkArr.push($(this).val());
		}
	});
	
	
	$.ajax({
		type : 'GET', 
		url : '/mail/delete.ajax',
		data:{delList:chkArr, cat:2},
		dataType : 'JSON', 
		success : function(data) { 
			console.log(data);
			if(data.msg != ""){
				alert(data.msg);
			}
			listCall(showPage, searchType, searchInput);
		},
		error : function(e) {
			console.log(e);
			alert("삭제할 쪽지가 없습니다.");
		}
	});
	
}

	 
	 
/* 전체, 개별 체크박스 선택 설정 */
function setCheckbox(){

	// 전체 체크박스 클릭 시 개별 체크박스 선택
	$("input:checkbox[name='checkboxAll']").click(function(){
		if($(this).is(":checked")){
			$("input:checkbox[id='checkbox']").prop("checked", true);
		} else {
			$("input:checkbox[id='checkbox']").prop("checked", false);
		}
	});
		
	// 개별 체크박스 클릭 시 전체 체크박스 선택
	$("input:checkbox[id='checkbox']").click(function(){ 
		var checkboxLen 	   = $("input:checkbox[id='checkbox']").length; // 개별 체크박스의 개수
		var checkboxCheckedLen = $("input:checkbox[id='checkbox']:checked").length; // 개별 체크박스 중 선택된 체크박스의 개수
		if(checkboxLen == checkboxCheckedLen){
			$("input:checkbox[name='checkboxAll']").prop("checked", true);
		} else {
			$("input:checkbox[name='checkboxAll']").prop("checked", false);
		}
	});
} 
	


	
	
	
	
	
	
</script>
</html>








