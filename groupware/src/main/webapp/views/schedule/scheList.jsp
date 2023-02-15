<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<!-- fullcalendar css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<!-- fullcalendar 언어 설정관련 script -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<style>
.find-btn{
	text-align: center;
}
.find-btn1{
	display :inline-block;
}
/* #calendar{
	height: 60em;
	width: 80%;
	margin: auto;
} */
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
					<div class="container-xxl flex-grow-1 container-p-y" >
					<h4 class="fw-bold py-3 mb-4">
						<span class="text-muted fw-light">일정관리 /</span> 나의 일정
					</h4>

					<div class="card">
						<!-- 캘린더 -->

						<div class="find-btn">
							<!-- 드롭다운 -->
							<div class="btn-group" style="float: left;">
								<button type="button" id="dropdown"
									class="btn btn-outline-primary dropdown-toggle"
									data-bs-toggle="dropdown" aria-expanded="false">전체일정</button>
								<ul class="dropdown-menu">
									<li><a onclick="option(this.innerText)"
										class="dropdown-item" href="javascript:void(0);">전체일정</a></li>
									<li><a onclick="option(this.innerText)"
										class="dropdown-item" href="javascript:void(0);">내 일정</a></li>
									<li><a onclick="option(this.innerText)"
										class="dropdown-item" href="javascript:void(0);">부서 일정</a></li>
								</ul>
							</div>
							<!-- 등록버튼 -->
							<div class="btn-group" style="float: right;">
								<button type="button"
									onclick="location.href='/schedule/scheWriteForm.move'"
									id="regist" class="btn btn-outline-primary"
									aria-expanded="false">일정 등록</button>
							</div>
						</div>
						<br /> <br />

						<div id="calendar"></div>
					</div>	
						<!-- 모달 -->
						<div class="modal fade" id="modalCenter" tabindex="-1">
							<div class="modal-dialog">
								<form class="modal-content">
									<div class="modal-header" style="flex-direction: row-reverse">
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
										<h5 class="modal-title" id="modalCenterTitle" ></h5>
									</div>
									<div class="modal-body" id="scheModal"></div>
								</form>
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
var all = '전체일정';
calendar(all);

var today = new Date();
var fm_today = formatDate(today);
console.log(fm_today);

//날짜형태(yyyy-mm-dd)로 포맷
function formatDate(date) {
	//console.log(date);
	var d = new Date(date),

	month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d
			.getFullYear();

	if (month.length < 2)
		month = '0' + month;
	if (day.length < 2)
		day = '0' + day;

	return [ year, month, day ].join('-');
}

// 일정 불러오기 
function calendar(option) {
	//console.log(option);
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
		//contentHeight: 850, // 칸 높이 
		headerToolbar : { // 헤더에 표시할 툴 바
			start : 'prev next today',
			center : 'title',
			end : 'dayGridMonth,dayGridWeek,dayGridDay'
		},
		titleFormat : function(date) {
			return date.date.year + '년 ' + (parseInt(date.date.month) + 1)
					+ '월';
		},
		//initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
		events : function(info, successCallback, failureCallback) { // [{id : '1', title :'test', start : '2023-01-06', end : '2023-01-06',}, ],
			console.log("캘린더 통신!");
			$.ajax({
				type : 'post',
				url : '/schedule/list.ajax',
				data : {
					'option' : option
				},
				dataType : 'json',
				success : function(result) {
					//console.log(result);
					//console.log(result.scheList);
					var scheList = result.scheList;
					var events = [];

					for (var i = 0; i < scheList.length; i++) {
						if (scheList[i].main_idx == 1) { // 중분류 :소속 부서 
							events.push({
								id : scheList[i].sche_idx,
								title : scheList[i].subject,
								start : scheList[i].start_date,
								end : scheList[i].end_date,
								color : '#fff2d6',
								textColor : '#ffab00'
							});
						} else if (scheList[i].main_idx == 2) { // 소분류 :개인 
							events.push({
								id : scheList[i].sche_idx,
								title : scheList[i].subject,
								start : scheList[i].start_date,
								end : scheList[i].end_date,
								color : '#ebeef0',
								textColor : '#8592a3'
							});
						}
					} // end -for문
					//console.log(events);
					successCallback(events);

				}, // end -success
				errer : function(e) {
					console.log(e);
				}
			}); //ajax end
		}, // events function end
		eventClick : function(event) {
			var sche_idx = event.el.fcSeg.eventRange.def.publicId;
			var title = event.el.fcSeg.eventRange.def.title;
			console.log(event);
				
			// 상세보기 모달 
			$('#modalCenterTitle').html(title);
			$('#modalCenter').modal("show");
			detailModal(sche_idx);
		},
		selectable : true, // 달력 일자 드래그 설정가능
		droppable : true,
		editable : true,
		nowIndicator : true, // 현재 시간 마크
	});
	calendar.render();
};

// 필터 드롭다운 
function option(option) {
	document.getElementById("dropdown").innerHTML = option;
	//console.log(option);

	calendar(option);
}

// 상세보기 모달 
function detailModal(sche_idx) {
	console.log('상세보기 요청');
	var detail;
	var loginId;

	// 제목 아작스로 보내서 데이터 꺼내오기~~ 
	$.ajax({
		type : 'post',
		data : {
			'sche_idx' : sche_idx
		},
		url : '/schedule/detail.ajax',
		dataType : 'json',
		success : function(data) {
			//console.log(data.loginId); // true/false
			//console.log(data.detail);

			drawDetail(data); // 모달에 데이터 띄우기 
		},
		error : function(e) {
			console.log(e);
		}
	});
}

// 데이터 띄우기 
function drawDetail(detail) {
	data = detail.detail;
	loginId = detail.loginId; // 작성자와 로그인아이디 일치여부 
	//console.log(data);
	//console.log(loginId); // true/false

	console.log("상세정보 띄우기");
	var content = '';
	var main_sort = '';
	var sub_sort = '';

	for (var i = 0; i < data.length; i++) {
		// 분류 이름
		if (data[i].main_idx == 1) { // 중분류 
			main_sort = '부서 일정';

			if (data[i].sub_idx == 1) { // 소분류 
				sub_sort = '미팅';
			} else if (data[i].sub_idx == 2) {
				sub_sort = '회의';
			} else if (data[i].sub_idx == 3) {
				sub_sort = '행사';
			} else if (data[i].sub_idx == 4) {
				sub_sort = '세미나';
			} else if (data[i].sub_idx == 5) {
				sub_sort = '기타';
			}
		} else if (data[i].main_idx == 2) {
			main_sort = '개인 일정';

			if (data[i].sub_idx == 7) { // 소분류 
				sub_sort = '반차';
			} else if (data[i].sub_idx == 8) {
				sub_sort = '휴가';
			} else if (data[i].sub_idx == 9) {
				sub_sort = '병가';
			} else if (data[i].sub_idx == 10) {
				sub_sort = '출장';
			} else if (data[i].sub_idx == 12) {
				sub_sort = '기타';
			}
		}

		content += '<div class="row">';
		content += '<label for="nameWithTitle" id="'
				+ data[i].sche_idx
				+ '" class="form-label" style="font-size: 1rem, width: 20%;">장소</label>';
		content += '<span type="text" id="nameWithTitle" class="form-control" >'
				+ data[i].location + '</span>';
		content += '</div>';
		content += '<div class="row">';
		content += '<label for="nameWithTitle" class="form-label" >분류</label>';
		content += '<span type="text" id="nameWithTitle" class="form-control" >'
				+ main_sort + ' / ' + sub_sort + '</span>';
		content += '</div>';
		content += '<div class="row">';
		content += '<label for="nameWithTitle" class="form-label">일시</label>';
		content += '<span type="text" id="nameWithTitle" class="form-control">'
				+ timeStampCut(data[i].start_date) + ' ~ ' + timeStampCut(data[i].end_date) + '</span>';
		content += '</div>';
		content += '<div class="row">';
		content += '<label for="nameWithTitle" class="form-label">내용</label>';
		content += '<span id="nameWithTitle" class="form-control" value="'+data[i].content+'">'
				+ data[i].content + '</span>';
		content += '</div><br/><br/>';
		if (loginId && data[i].main_idx == 2
				&& data[i].start_date > fm_today) { // 오늘 이전의 일정은 수정 삭제 버튼 안보임  schedule/scheUpdateForm
			console.log("개인 일정");
			content += '<div class="float-end" style="margin:auto;"><button type="button" onclick="location.href=\'/schedule/updateForm?sche_idx='
					+ data[i].sche_idx
					+ '\'" class="btn btn-primary" style="width: 100px;">수정</button>';
			content += '<button type="button" onclick="scheDelete('
					+ data[i].sche_idx
					+ ')" class="btn btn-outline-primary" style="margin-left: 10px; width: 100px;">삭제</button></div>';
		} else if (data[i].main_idx == 1 && data[i].start_date > fm_today) {
			content += '<div class="float-end" style="margin:auto;"><button type="button" onclick="location.href=\'/schedule/updateForm?sche_idx='
					+ data[i].sche_idx
					+ '\'" class="btn btn-primary" style="width: 100px;">수정</button>';
			content += '<button type="button" onclick="scheDelete('
					+ data[i].sche_idx
					+ ')" class="btn btn-outline-primary" style="margin-left: 10px; width: 100px;">삭제</button></div>';
		}
		//content += '</div>';
		//content += '</form>';
		$('#scheModal').empty();
		$('#scheModal').append(content);

	}
}

//상세보기 datetime 포맷 
function timeStampCut(timestamp){
    var date = new Date(timestamp);
    var year = date.getFullYear().toString(); // .slice(-2): 년도 뒤에 두자리
    var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
    var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
    var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
    var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
    var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
    var returnDate = year + "-" + month + "-" + day + " " + hour + ":" + minute;
    return returnDate;
 }

// 일정 삭제 요청
function scheDelete(idx) {
	var result = confirm("삭제하시겠습니까?");
	//console.log(idx);

	if (result) {
		console.log("삭제");

		$.ajax({
			type : 'post',
			data : {
				'sche_idx' : idx
			},
			url : '/schedule/delete.ajax',
			dataType : 'json',
			success : function(data) {
				console.log("삭제 성공!");
				//console.log(data.detail);
				//window.location.reload();
				$('#modalCenter').modal("hide");
				calendar(all);

			},
			error : function(e) {
				console.log(e);
			}
		});
	} else {
		modalOnOff();
	}
}
</script>
</html>






