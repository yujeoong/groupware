<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<style>
.noti-unread {
	cursor: pointer;
}
</style>
</head>
<body>
	<!-- 	알림 모달 -->
	<div class="offcanvas offcanvas-end" data-bs-scroll="true"
		data-bs-backdrop="false" tabindex="-1" id="notiOffcanvas"
		aria-labelledby="offcanvasScrollLabel">
		<div class="offcanvas-header">
			<h5 id="offcanvasScrollLabel" class="offcanvas-title">Notifications</h5>
			<button type="button" class="btn-close text-reset"
				data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
				<ul class="nav nav-tabs nav-fill" role="tablist">
					<li class="nav-item">
						<button type="button" class="nav-link active" role="tab"
							data-bs-toggle="tab" data-bs-target="#navs-justified-home"
							aria-controls="navs-justified-home" aria-selected="true"
							onclick="notiInBoxAjax()">
							<i class="tf-icons bx bx-home"></i>수신 알림 <span
								class="badge rounded-pill badge-center h-px-20 w-px-20 bg-label-danger"
								id="unreadCount"></span>
						</button>
					</li>
					<li class="nav-item">
						<button type="button" class="nav-link" role="tab"
							data-bs-toggle="tab" data-bs-target="#navs-justified-profile"
							aria-controls="navs-justified-profile" aria-selected="false"
							onclick="notiSentListAjax()">
							<i class="tf-icons bx bx-user"></i> 발신 알림
						</button>
					</li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade show active" id="navs-justified-home"
						role="tabpanel">
						<ul class="list-group list-group-flush" id="notiList"></ul>
					</div>
					<div class="tab-pane fade" id="navs-justified-profile"
						role="tabpanel">
						<ul class="list-group list-group-flush" id="notiSentList"></ul>
					</div>
				</div>
	</div>
</body>
<script>
	//수신알림 리스트 가져오기
	function notiInBoxAjax() {
		$.ajax({
			type : 'get',
			url : '/noti/notiInBox.ajax',
			//data:{"prj_idx":"${project.prj_idx}"},
			dataType : 'json',
			success : function(data) {
				drawNotiInBox(data);
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}

	var unread;

	//수신알림 리스트 출력
	function drawNotiInBox(list) {
		//console.log("drawNotiInBox출력 ~~~~~~");
		//console.log(list);
		content = '';
		unread = 0;
		content += '<a class="text-end noti-unread" id="readAll">모두읽음</a>'
		if(list.length<1){
			content += '<li class="list-group-item">수신한 알림이 없습니다.</li>';
		}
		for (var i = 0; i < list.length; i++) {
			if (list[i].state == 'N') {
				unread += 1;
				content += '<li class="list-group-item list-group-item-primary noti-unread" id="'+list[i].noti_idx+'">';
			} else {
				content += '<li class="list-group-item">';
			}
			content += '<strong>' + list[i].content + '</strong>';
			content += '<div class="d-flex justify-content-between w-100">';
			content += '<small> 발신자 ' + list[i].dep_name + '&nbsp'
					+ list[i].name + '&nbsp' + list[i].pos_name + '</small>';
			//var date = new Date(list[i].date);
			content += '<small>' + timeStampCut(list[i].date) + '</small>';
			content += '</div>';
			content += '</li>';
		}
		$('#unreadCount').text(unread);
		$('#notiList').empty();
		$('#notiList').append(content);
	}

	//발신알림 리스트 가져오기
	function notiSentListAjax() {
		$.ajax({
			type : 'get',
			url : '/noti/notiSentList.ajax',
			//data:{"prj_idx":"${project.prj_idx}"},
			dataType : 'json',
			success : function(data) {
				//console.log(data.notiSentList);
				drawNotiSentList(data.notiSentList);
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}

	//발신알림 리스트 출력
	function drawNotiSentList(list) {
		content = '';
		if(list.length<1){
			content += '<li class="list-group-item">발신한 알림이 없습니다.</li>';
		}
		for (var i = 0; i < list.length; i++) {
			read_rcp = '';
			unread_rcp = '';
			var read_rcp_count = 0;
			for (var j = 0; j < list[i].rcpList.length; j++) {
				if (list[i].rcpList[j].state == 'Y') {
					read_rcp_count += 1;
					read_rcp += '<li class="dropdown-item">'
							+ list[i].rcpList[j].dep_name + '&nbsp'
							+ list[i].rcpList[j].name + '&nbsp'
							+ list[i].rcpList[j].pos_name
							+ '&nbsp<i class="bx bx-check"></i></li>';
				} else {
					unread_rcp += '<li class="dropdown-item">'
							+ list[i].rcpList[j].dep_name + '&nbsp'
							+ list[i].rcpList[j].name + '&nbsp'
							+ list[i].rcpList[j].pos_name + '&nbsp</li>';
				}
			}
			content += '<a class="list-group-item list-group-item-action"id="'+list[i].noti_idx+'">';
			content += '<strong>' + list[i].content + '</strong>';
			content += '<div class="d-flex justify-content-between w-100">';
			content += '<small>';
			content += '<button type="button" class="btn btn-xs btn-outline-secondary dropdown-toggle" ';
			content += 'data-bs-toggle="dropdown" aria-expanded="false">';
			content += '수신확인 ' + read_rcp_count + '/' + list[i].rcpList.length
					+ '</button>';
			content += '<ul class="dropdown-menu">';
			content += unread_rcp;
			if (read_rcp_count > 0 && list[i].rcpList.length - read_rcp_count != 0) {
				content += '<hr class="dropdown-divider" />';
			}
			content += read_rcp;
			content += '</ul>';
			content += '</small>';
			content += '<small>' + timeStampCut(list[i].date) + '</small>';
			content += '</div>';
			content += '</a>';
		}
		$('#notiSentList').empty();
		$('#notiSentList').append(content);
	}

	//알림 읽음으로 변경 이벤트(단일,전체)
	$(document).on(
			'click',
			'.noti-unread',
			function() {
				//console.log("읽음처리해보자고"+$(this).attr('id'));
				$.ajax({
					type : 'GET',
					url : '/noti/readNoti.ajax',
					//async : false,
					data : {
						noti_idx : this.id
					},
					context : this,
					dataType : 'JSON',
					success : function(data) {
						if (data > 0) {
							if (this.id != 'readAll') {
								$(this).removeClass(
										'list-group-item-primary noti-unread');
								unread -= 1;
							} else {
								$('.noti-unread').removeClass(
										'list-group-item-primary noti-unread');
								unread = 0;
							}
							$('#unreadCount').text(unread);
						}
					},
					error : function(e) {
						console.log(e);
					}
				});
			})

	//time stamp 변환
	function timeStampCut(timestamp) {
		var date = new Date(timestamp);
		var year = date.getFullYear().toString();
		var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
		var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
		var hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
		var minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
		var second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
		var returnDate = year + "-" + month + "-" + day + " " + hour + ":"
				+ minute;
		return returnDate;
	}

	/*
	 let subscribeUrl = "http://loca
	lhost:8080/sub";

	 $(document).ready(
	 function() {

	 if (sessionStorage.getItem("mytoken") != null) {
	 let token = sessionStorage.getItem("mytoken");
	 let eventSource = new EventSource(subscribeUrl + "?token=" + token);

	 eventSource.addEventListener("addComment", function(event) {
	 let message = event.data;
	 //$('#noti_button').parents('li').find('.avatar-online').removeClass('avatar-online');
	 $('#noti_button').removeClass('btn-secondary');
	 //$('#noti_button').addClass('btn-primary');
	
	 //alert(message);
	 })

	 eventSource.addEventListener("error", function(event) {
	 eventSource.close()
	 })
	 }
	 })
	 */
</script>
</html>