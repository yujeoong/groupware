<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
#nameWithTitle{
	margin-bottom: 10px;
}
.form-select, .form-control{
	margin-bottom: 15px;
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
				<div class="container-xxl flex-grow-1 container-p-y" >
				
				<h4 class="fw-bold py-3 mb-4">
					<span class="text-muted fw-light">시설 예약 /</span> 예약 조회
				</h4>
				<div class="card">
					
					<!-- 예약 버튼 --> 
					<div class="demo-inline-spacing" style="margin-bottom: 10px"> 
						<button type="button" id="regist" class="btn btn-outline-primary float-end"
							aria-expanded="false" onclick="fbRegist()" style="flex: 0 0 auto !important;">시설 예약</button> 
					</div>
					
					<!-- 캘린더 -->
					<div id="calendar"></div>
				</div>
					<!-- 모달 -->
					<div class="modal fade" id="modalCenter" tabindex="-1">
						<div class="modal-dialog">
							<form class="modal-content">
								<div class="modal-header" style="flex-direction: row-reverse">
									<button type="button" class="btn-close"
										data-bs-dismiss="modal" aria-label="Close"></button>
									<h5 class="modal-title" id="modalCenterTitle"></h5>
								</div>
								<div class="modal-body" id="fac_bookModal"></div>
							</form>
						</div>
					</div>

					</div> <!-- / Content -->

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
calendar();

var today = new Date();
var fm_today = formatDate(today);
var fm_todayTime = dateFormat(today);
console.log(today);
console.log(fm_today);
console.log(fm_todayTime);

//날짜형태(yyyy-mm-dd HH:mm)로 포맷
function dateFormat(date) {
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var hour = date.getHours();
    var minute = date.getMinutes(); 

    month = month >= 10 ? month : '0' + month;
    day = day >= 10 ? day : '0' + day;
    hour = hour >= 10 ? hour : '0' + hour;
    minute = minute >= 10 ? minute : '0' + minute; 

    return date.getFullYear() + '-' + month + '-' + day + 'T' + hour + ':' + minute;
}

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

//일정 불러오기 
function calendar(option) {
	//console.log(option);
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
		headerToolbar : { // 헤더에 표시할 툴 바
			start : 'prev next today',
			center : 'title',
			end : 'dayGridMonth,dayGridWeek,dayGridDay'
		},
		titleFormat : function(date) {
			return date.date.year + '년 ' + (parseInt(date.date.month) + 1)
					+ '월';
		},
		events : function(info, successCallback, failureCallback) { 
			console.log("캘린더 통신!");
			$.ajax({
				type : 'post',
				url : '/fac_book/fac_bookList.ajax',
				//data : { 'option' : option},
				dataType : 'json',
				success : function(result) {
					//console.log(result);
					//console.log(result.list);
					
					var fbList = result.list;
					var events = [];

					// 0:시설 1: 차량 2: 기타 
					for (var i = 0; i < fbList.length; i++) {
						if (fbList[i].type == 0) { 
							events.push({
								id : fbList[i].fb_idx,
								title : fbList[i].name,
								start : fbList[i].start_date,
								end : fbList[i].end_date,
								color : '#696cff',
								textColor : '#fff'
							});
						} else if (fbList[i].type == 1) {
							events.push({
								id : fbList[i].fb_idx,
								title : fbList[i].name,
								start : fbList[i].start_date,
								end : fbList[i].end_date,
								color : '#ffab00',
								textColor : '#fff'
							});
						} else if (fbList[i].type == 2) {
							events.push({
								id : fbList[i].fb_idx,
								title : fbList[i].name,
								start : fbList[i].start_date,
								end : fbList[i].end_date,
								color : '#8592a3',
								textColor : '#fff'
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
			var fb_idx = event.el.fcSeg.eventRange.def.publicId;
			var title = event.el.fcSeg.eventRange.def.title;
			console.log(event);
				
			// 상세보기 모달 
			$('#modalCenterTitle').html(title);
			$('#modalCenter').modal("show");
			detailModal(fb_idx);
		},
		selectable : true, // 달력 일자 드래그 설정가능
		droppable : true,
		editable : true,
		nowIndicator : true, // 현재 시간 마크
	});
	calendar.render();
};

// 예약 등록 모달 
function fbRegist(){
	console.log("예약하기");
	$('#modalCenterTitle').html("예약하기");
	$('#modalCenter').modal("show");
	
	var content ='';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" style="font-size: 1rem, width: 20%;">시설 종류</label>';
	content += '<select id="type" class="form-select" onchange="chageSelect()">';
	content += '<option value="nosel" selected>선택하세요.</option>';
	content += '<option value="0">시설</option>';
	content += '<option value="1">차량</option>';
	content += '<option value="2">기타</option>';		
	content += '</select>'; 
	content += '</div>';
	
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" >시설명</label>';
	content += '<select class="form-select" id="name">';
	content += '<option id="nameList" selected>선택하세요.</option>';
	content += '</select>';
	content += '</div>'; 
	
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">시작 일시</label>';
	content += '<div class="col-md-10" id="start_date">';
	content += '<input class="form-control end" type="datetime-local" id="html5-datetime-local-input" name="start_date" placeholder="시작 일시" />';
	content += '</div></div>';
	
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">종료 일시</label>';
	content += '<div class="col-md-10" id="end_date">';
	content += '<input class="form-control end" type="datetime-local" id="html5-datetime-local-input" name="end_date" placeholder="종료 일시" />';
	content += '</div></div>';
	
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">내용</label>';
	content += '<textarea id="content" class="form-control"></textarea>';
	content += '</div><br/><br/>';
	//  버튼 
	content += '<div class="float-end" style="margin:auto;"><button type="button" onclick="fbSubmit()" class="btn btn-primary" style="width: 100px;">등록</button>';
	content += '<button type="button" onclick="cancle()" class="btn btn-outline-primary" style="margin-left: 10px; width: 100px;">취소</button></div>';
	$('#fac_bookModal').empty();
	$('#fac_bookModal').append(content);
	
	
}

//예약등록 시설명 선택
function chageSelect(){
	console.log("type selected!!");
	
	var type = document.getElementById('type').value;
	var nameList;
	var content = '';
	console.log(type);
	
	if(type == 'nosel'){
		content += '<option id="nameList" selected>선택하세요.</option>';
		$('#name').empty();
		$('#name').append(content);	
	} else{
		nameList = fbName(type);
		
		for(var i=0; i<nameList.length; i++){
			content += '<option id="name">'+nameList[i]+'</option>';
		}
		$('#name').empty();
		$('#name').append(content);		
	}
}

//등록 
function fbSubmit(){
	console.log("submit!");
	// 태그 자체 가져오기 
	$type	= $("select[id='type']");
	$name	= $("select[id='name']");
	$start_date 	= $("input[name='start_date']");
	$end_date 	= $("input[name='end_date']");
	$content 	= $("textarea[id='content']"); 
	
	// 예약시간 중복 체크
	console.log("overlapCheck!");
	var cnt = overlapCheck($start_date.val(), $end_date.val(), $name.val());
	//console.log(cnt);
	
	// 공란 여부 확인 
 	if($type.val()=='선택하세요.'){
		alert('시설 종류를 선택해 주세요.');
		$subject.focus();
	} else if($name.val()=='선택하세요.'){
		alert('시설명을 선택해 주세요.');
	} else if($start_date.val() < fm_todayTime){
		alert(fm_todayTime+' 이후의 날짜를 선택하세요.');
	} else if($end_date.val()==''){
		alert('종료일시를 선택해 주세요.'); 
	} else if($start_date.val() > $end_date.val()){
		alert('선택한 시작일시 이후의 종료일시를 선택하세요.'); 
	} else if(cnt > 0){
		alert('예약일시 중복.. 예약일시를 변경해주세요.');
	} else if($content.val()==''){
		alert('내용을 입력해 주세요.');
		$content.focus();
	} else{
		var result = confirm('등록 하시겠습니까?'); // ture/false
		if(result){
			console.log('서버로 전송'); 
			
			// ajax 전송
			$.ajax({
				type:	'POST',
				url:	'/fb_book/fbRegist.ajax',
				data:	{
					name : $name.val(),
					start_date : $start_date.val(),
					end_date : $end_date.val(),
					content : $content.val()
				},
				dataType: 'JSON',
				success: function(success){
					console.log(success);
					
					if(success.success > 0){
						alert("예약 성공!!");
					} else if(success.success == 0){
						alert("예약 실패..");	
					}
					$('#modalCenter').modal("hide");
					calendar();
				},
				error: function(e){
					console.log(e);
				} 
			}); // ajax 
			
		} else {
			location.href = "/fac_book/fac_bookList.move";
		}// end -confirm
		
	}  
} // end -submit()


//상세보기 모달 
function detailModal(fb_idx) {
	//console.log('상세보기 요청');
	var detail;
	var loginId;

	// 제목 아작스로 보내서 데이터 꺼내오기
	$.ajax({
		type : 'post',
		data : {'fb_idx' : fb_idx},
		url : '/fac_book/fbDetail.ajax',
		dataType : 'json',
		success : function(data) {
			//console.log(data.loginId); // true/false
			//console.log(data);

			drawDetail(data); // 모달에 데이터 띄우기 
		},
		error : function(e) {
			console.log(e);
		}
	});

}

// 상세보기 데이터 띄우기 
function drawDetail(detail) {
	data = detail.list;
	//console.log(data);
	loginId = detail.loginId; // 작성자와 로그인아이디 일치여부 
	//console.log(loginId); // true/false

	//console.log("상세정보 띄우기");
	var content = '';
	var fac_idx;
	var type = '';
	
	if(data[0].type == '0'){
		type ='시설';
	} else if(data[0].type == '1'){
		type ='차량';
	} else if(data[0].type == '2'){
		type ='기타';
	}
	//console.log(type);
	content += '<div class="row">';
	content += '<label for="nameWithTitle" id="'+ data[0].fb_idx+ '" class="form-label" style="font-size: 1rem, width: 20%;">시설 종류</label>';
	content += '<span type="text" id="nameWithTitle" class="form-control" >'+type+ '</span>';
	content += '</div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" >시설명</label>';
	content += '<span type="text" id="nameWithTitle" class="form-control" >'+ data[0].name + '</span>';
	content += '</div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" >예약자</label>';
	content += '<span type="text" id="nameWithTitle" class="form-control" >'+ detail.reserveId + '</span>';
	content += '</div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">일시</label>';
	content += '<span type="text" id="nameWithTitle" class="form-control">'+ timeStampCut(data[0].start_date) + ' ~ ' + timeStampCut(data[0].end_date) + '</span>';
	content += '</div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">내용</label>';
	content += '<span id="nameWithTitle" class="form-control">'+ data[0].content + '</span>';
	content += '</div><br/><br/>';
	// 수정/삭제 버튼 
	if (loginId && data[0].start_date > fm_today) { // 오늘 이전의 일정은 수정 삭제 버튼 안보임 
		content += '<div class="float-end" style="margin:auto;"><button type="button" onclick="fbUpdateModal('+data[0].fb_idx+ ')" class="btn btn-primary" style="width: 100px;">수정</button>';
		content += '<button type="button" onclick="fbDelete('
				+ data[0].fb_idx
				+ ')" class="btn btn-outline-primary" style="margin-left: 10px; width: 100px;">삭제</button></div>';
	} 
	$('#fac_bookModal').empty();
	$('#fac_bookModal').append(content);
	
}

// 상세보기 datetime 포맷 
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

// 수정 모달
function fbUpdateModal(idx){
	//console.log("수정 모달 요청 :"+ idx);
	
	$.ajax({
		type : 'get',
		data : {'fb_idx' : idx},
		url : '/fac_book/fbDetail.ajax',
		dataType : 'json',
		success : function(data) {
			console.log("수정 데이터!");
			//console.log(data.detail);
			
			drawUpdateForm(data);
		},
		error : function(e) {
			console.log(e);
		}
	});
	
}

// 수정 데이터  
function drawUpdateForm(detail){
	console.log("수정 폼 요청");
	//console.log(detail);
	$('#modalCenterTitle').html("수정하기");
	
	var content = '';
	var type = '';
	var nameList;
	
	if(data[0].type == '0'){ // name
		$("#typeOption").val("0").prop('selected', true);
		$('#typeOption option:eq(시설)').prop('selected', true); 
		type ='시설';
		nameList = fbName(0);
		//console.log(nameList);
		
	} else if(data[0].type == '1'){
		$('#typeOption option:eq(1)').prop('selected', true); 
		type ='차량';
		nameList = fbName(1);
	} else if(data[0].type == '2'){
		$("#nameOption").val("2").prop("selected", true);
		type ='기타';
		nameList = fbName(2);
	}
	//console.log(type);
	//content += '<div style="text-align: center; margin-bottom: 10px; color: #6a6cff;"><b>수정하기</b></div>';
	content += '<div class="row">';
	content += '<label for="nameWithTitle" id="'+ data[0].fb_idx+ '" class="form-label" style="font-size: 1rem, width: 20%;">시설 종류</label>';
	content += '<select id="type" class="form-select" onchange="chageSelect()">';
	if(data[0].type == '0'){
		content += '<option id="typeOption" value="0" selected>시설</option>';
		content += '<option id="typeOption" value="1">차량</option>';
		content += '<option id="typeOption" value="2">기타</option>';		
	} else if(data[0].type == '1'){
		content += '<option id="typeOption" value="0">시설</option>';
		content += '<option id="typeOption" value="1" selected>차량</option>';
		content += '<option id="typeOption" value="2">기타</option>';		
	} else if(data[0].type == '2'){
		content += '<option id="typeOption" value="0">시설</option>';
		content += '<option id="typeOption" value="1">차량</option>';
		content += '<option id="typeOption" value="2" selected>기타</option>';		
	}
	content += '</select>'; 
	content += '</div>';
	
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" >시설명</label>';
	content += '<select class="form-select" id="name">';
	for(var i=0; i<nameList.length; i++){
		if(data[0].name == nameList[i]){
			content += '<option id="nameOption" selected>'+nameList[i]+'</option>';
		} else{
			content += '<option id="nameOption">'+nameList[i]+'</option>';		
		}
	}
	content += '</select>';
	content += '</div>';
	
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label" >예약자</label>';
	content += '<input type="text" id="mem_id" class="form-control" value="'+ detail.reserveId + '" readonly>';
	content += '</div>';
	
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">시작 일시</label>';
	content += '<div class="col-md-10" id="start_date">';
	content += '<input class="form-control end" type="datetime-local" id="html5-datetime-local-input" name="start_date" value="'+data[0].start_date+'" placeholder="시작 일시" />';
	content += '</div></div>';
	
	content += '<div class="mb-3 row">';
	content += '<label for="html5-datetime-local-input" class="col-md-2 col-form-label">종료 일시</label>';
	content += '<div class="col-md-10" id="end_date">';
	content += '<input class="form-control end" type="datetime-local" id="html5-datetime-local-input" name="end_date" value="'+data[0].end_date+'" placeholder="종료 일시" />';
	content += '</div></div>';
	
	content += '<div class="row">';
	content += '<label for="nameWithTitle" class="form-label">내용</label>';
	content += '<textarea id="content" class="form-control">'+ data[0].content + '</textarea>';
	content += '</div><br/><br/>';
	//  버튼 
	content += '<div style="margin:auto;"><button type="button" onclick="fbUpdate('+ data[0].fb_idx+ ')" class="btn btn-primary" style="width: 100px;">완료</button>';
	content += '<button type="button" onclick="cancle('
			+ data[0].fb_idx
			+ ')" class="btn btn-outline-primary" style="margin-left: 10px; width: 100px;">취소</button></div>';
	$('#fac_bookModal').empty();
	$('#fac_bookModal').append(content);

}

// 공란,중복 체크 
function fbUpdate(fb_idx) {
	console.log("수정 요청 :" + fb_idx);

	// 태그 자체 가져오기 
	$type	= $("select[id='type']");
	$name	= $("select[id='name']");
	$start_date 	= $("input[name='start_date']");
	$end_date 	= $("input[name='end_date']");
	$content 	= $("textarea[id='content']"); 
	
	// 예약시간 중복 체크
	console.log("예약시간 중복체크");
	var cnt = overlapCheck($start_date.val(), $end_date.val(), $name.val());
	console.log(cnt);

	if ($start_date.val() < fm_today) {
		alert(fm_today + ' 이후의 날짜를 선택하세요.');
	} else if ($start_date.val() > $end_date.val()) {
		alert('시작일시 이후의 종료일시를 선택하세요.');
	} else if(cnt > 0){
		console.log(cnt);
		alert('예약일시 중복.. 예약일시를 변경해주세요.');
	} else {
		var result = confirm('수정하시겠습니까?'); // ture/false
		if (result) {
			console.log('서버로 전송');

			// 오브젝트 변수 생성
			/* var param = {};
			param.type = $type.val();
			param.name = $name.val();
			param.start_date = $start_date.val();
			param.end_date = $end_date.val();
			param.content = $content.val(); */

			// ajax 전송
			$.ajax({
				type : 'POST',
				url : '/fac_book/update.ajax',
				data : {
					type : $type.val(),
					name : $name.val(),
					start_date : $start_date.val(),
					end_date : $end_date.val(),
					content : $content.val(),
					fb_idx : fb_idx
				},
				dataType : 'JSON',
				success : function(data) {
					console.log(data);

					$('#modalCenter').modal("hide");
					calendar();
				},
				error : function(e) {
					console.log(e);
				}
			}); // ajax 
		} else {
			location.href = "/schedule/scheList.move";
			}// end -confirm
	}
	
}

function update(fb_idx){
	console.log("update :{}"+fb_idx);
	var result = confirm('수정하시겠습니까?'); // ture/false
	if (result) {
		console.log('서버로 전송');

		// 오브젝트 변수 생성
		var param = {};
		param.type = $type.val();
		param.name = $name.val();
		param.start_date = $start_date.val();
		param.end_date = $end_date.val();
		param.content = $content.val();

		// ajax 전송
		$.ajax({
			type : 'POST',
			url : '/fac_book/update.ajax',
			data : {
				type : $type.val(),
				name : $name.val(),
				start_date : $start_date.val(),
				end_date : $end_date.val(),
				content : $content.val(),
				fb_idx : fb_idx
			},
			dataType : 'JSON',
			success : function(data) {
				console.log(data);
				// 수정 성공 > 다시 상세보기 그리기 
				calendar();
				detailModal(data.fbDetail[0].fb_idx);
			},
			error : function(e) {
				console.log(e);
			}
		}); // ajax 
	} else {
		location.href = "/schedule/scheList.move";
		}// end -confirm
}
	
//수정 시 입력된 datetime format 
function datetimeFormat(datatime){
	console.log(datatime);
    return datatime.replace(' ', 'T').substring(0, 16);
}

// 예약시간 중복 체크 
function overlapCheck(start_date, end_date, name) {
	console.log("중복 체크");
	//var start_date = {};
	//var end_date = {};
	var overlapCheck;

	$.ajax({
		type : 'post',
		url : '/fac_book/overlapCheck.ajax',
		data : {start_date : start_date, end_date:end_date, name:name},
		dataType : 'json',
		async : false, // 비동기로 통신할 수 있도록 
		success : function(data) {
			//console.log(data);
			//console.log(data.overlapCheck);
			//start_date = data.start_date;
			//end_date = data.end_date;
			overlapCheck = data.overlapCheck;

		},
		error : function(e) {
			console.log(e);
		}
	});

	//console.log(overlapCheck);
	return overlapCheck; 
}

// 수정- type에 따른 사용 가능한 시설명 가져오기
function fbName(type) {
	console.log("시설명 뽑기 :" + type);
	var nameList;
	$.ajax({
		type : 'get',
		data : {
			'type' : type
		},
		url : '/fac_book/nameList.ajax',
		dataType : 'json',
		async : false, // 비동기로 통신할 수 있도록 
		success : function(data) {
			//console.log(data.nameList);
			nameList = data.nameList;

		},
		error : function(e) {
			console.log(e);
		}
	});
	//console.log(nameList);
	return nameList;
}

// 수정 취소 
function cancle() {
	$('#modalCenter').modal("hide");
	calendar();
}

// 일정 삭제 
function fbDelete(idx) {
	console.log('삭제 요청');

	var result = confirm("삭제하시겠습니까?");

	if (result) {
		console.log(idx + "삭제");

		$.ajax({
			type : 'post',
			data : {
				'fb_idx' : idx
			},
			url : '/fac_book/fbDelete.ajax',
			dataType : 'json',
			success : function(data) {
				console.log("삭제 성공!");

				$('#modalCenter').modal("hide");
				calendar();

			},
			error : function(e) {
				console.log(e);
			}
		});
	} else {
		modalOnOff();
	}
}

//일정 삭제 요청
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
				window.location.reload();

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
