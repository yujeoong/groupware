<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" href="/res/style.css" />
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />
<script type="text/javascript" src="/richtexteditor/rte.js"></script>
<script type="text/javascript"
	src='/richtexteditor/plugins/all_plugins.js'></script>
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
						<h4 class="fw-bold py-3 mb-4" id="pageCategory">
							<span class="text-muted fw-light">전자결재 /</span> 기안 문서
						</h4>

						<form action="/appr/sign.do" method="POST">
							<!-- Form controls -->
							<div class="card mb-4">
								<div class="card-body">
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">결재 양식</label> 
										<div class="col-sm-10 col-form-label-lg">
										<span id="docFormName"></span> <input
											type="hidden" name="form_idx" id="docFormIdx">
										</div>
									</div>
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">기안 문서 제목</label> 
										<div class="col-sm-10 col-form-label-lg">
											<span id="docSubject"></span>
										</div>
									</div>
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">기안 날짜</label> 
										<div class="col-sm-10 col-form-label-lg">
											<span id="docRegDate"></span>
										</div>
									</div>
									<div class="row mb-3" id="reject_comment">
									</div>
									<label class="col-form-label-lg">결재 라인</label>
									<div class="row" id="confirmMemList"></div>
									<label for="exampleFormControlInput1" class="col-form-label-lg">문서
										내용</label>
									<div id="div_editor" style="height: 700px;"></div>
									
<!-- 									<div class="float-end"> -->
<!-- 										<label class="form-label">공개 여부</label> <input type="radio" -->
<!-- 											class="form-check-input" name="open" id="openY" value="Y" -->
<!-- 											disabled /> 공개 <input type="radio" class="form-check-input" -->
<!-- 											name="open" id="openN" value="N" disabled /> 비공개 -->
<!-- 									</div> -->
									<!-- 공개 여부 -->
									<div class="row mb-3">
										<label class="col-sm-2 col-form-label-lg">공개 여부</label>
										<div class="col-sm-10 col-form-label-lg">
											<input type="radio"
											class="form-check-input" name="open" id="openY" value="Y" disabled /> 공개
										<input type="radio" class="form-check-input" name="open" id="openN"
											value="N" disabled/> 비공개
										</div>
									</div>
									
									<!-- 첨부파일 -->
									<div class="row mb-3" id="fileList">
									</div>
									
									
									<p style="height: 30px;">&nbsp;</p>
									<a class="float-start" href="javascript:history.back();">리스트</a>
									<!--/ Hoverable Table rows -->
									<!-- 기안문서번호 -->
									<input type="hidden" id="doc_idx" name="doc_idx">
									<!-- 결재(2) or 반려(3) -->
									<input type="hidden" id="appr_state" name="appr_state" value="2">
									<div id="apprButton" class="float-end">
										<button type="button" class="btn btn-outline-secondary"
											data-bs-toggle="modal" data-bs-target="#rejectModal">반려</button>
										<input type="submit" class="btn btn-outline-primary" value="결재" onclick="return confirm('결재 하시겠습니까?')" />
									</div>
								</div>
							</div>


						<!-- Vertically Centered Modal -->
						<div class="col-lg-4 col-md-6">
							<small class="text-light fw-semibold">Vertically centered</small>
							<div class="mt-3">
								<!-- Modal -->
								<div class="modal fade" id="rejectModal" tabindex="-1"
									aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="modalCenterTitle">반려 - 의견 추가</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<div class="row">
													<div class="col mb-3">
														<input type="text" class="form-control" name="reject_comment"
															placeholder="의견을 추가해주세요." />
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-outline-secondary"
													data-bs-dismiss="modal">취소</button>
												<button type="button" class="btn btn-primary" onclick="reject()">반려</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						</form>
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
	var msg = "${msg}";
	if (msg != "") {
		alert(msg);
	}

	//editor 내에 결재라인
	var apprLine = '';

	const url = location.search;
	var params = new URLSearchParams(url);
	mainCat = document.referrer.split('/')[3];
	subCat = document.referrer.split('/')[4].split('.')[0];
	doc_idx = params.get('doc_idx');
	//	console.log("doc_idx: "+doc_idx+mainCat+subCat);

	//페이지 상단 이름 구분
	var subCatName;
	switch (subCat) {
	case 'apprWait':
		subCatName = '결재 수신함 / 결재 대기';
		break;
	case 'apprDone':
		subCatName = '결재 수신함 / 처리 완료';
		break;
	case 'apprInProgress':
		subCatName = '결재 상신함 / 결재 진행중';
		break;
	case 'apprReject':
		subCatName = '결재 상신함 / 결재 반려';
		break;
	case 'apprComplete':
		subCatName = '결재 상신함 / 결재 완료';
		break;
	default:
		subCatName = '전자 결재';
		break;
	}
	$('#pageCategory').html(
			'<span class="text-muted fw-light">' + subCatName
					+ ' /</span> 상세보기');

	//기안문서 디테일 호출
	detailAjax(doc_idx);
	function detailAjax(doc_idx) {
		$.ajax({
			type : 'get',
			url : '/appr/apprDetail.ajax',
			data : {
				'doc_idx' : doc_idx
			},
			dataType : 'json',
			success : function(data) {
				console.log(data.apprLineList);
				drawConfirmMemList(data.apprLineList);
				drawDetail(data.apprDoc);
				drawFileList(data.fileList);
			},
			error : function(e) {
				console.log("에러: " + e);
			}
		});
	}

	//기안문서 디테일 출력
	function drawDetail(doc) {
		//양식제목
		$('#docFormName').text('[' + doc.form_idx + '] ' + doc.form_name);
		//양식번호
		$('#docFormIdx').val(doc.form_idx);

		//문서 번호
		$('#doc_idx').val(doc.doc_idx);

		//문서 제목
		$('#docSubject').text(doc.subject);
		
		//기안 날짜
		$('#docRegDate').text(timeStampCut(doc.reg_date));
		//내용 - text editor 입력창에 불러온 내용 넣기
		editor.setHTMLCode(apprLine + doc.content);

		//공개여부
		$('#open' + doc.open).attr('checked', true);
		if (subCat == 'apprWait') {
			//결재대기문서는 변경가능
			$('#openY').attr("disabled", false);
			$('#openN').attr("disabled", false);
		}

		//결재반려버튼
		if (subCat != 'apprWait') {
			$('#apprButton').html('');
		}
		
		//반려문서 상세보기일 시 반려코멘트
		if(subCat == 'apprReject'){
			rjContent = '';
			rjContent += '<label class="col-sm-2 col-form-label-lg">반려 사유</label>';
			rjContent += '<div class="col-sm-10 col-form-label-lg"><span>'+doc.comment+'</span></div>';
			$('#reject_comment').append(rjContent);
		}
		
	}

	//결재라인 출력
	function drawConfirmMemList(list) {
		//결재라인 보여지는 목록
		content = '';

		//결재라인 texteditor 내에 추가될 부분
		apprTable = '<div style="float:right;"><p></p><table><tbody>';
		apprMemInfo = '<tr><td rowspan="3" colspan="1" style="font-weight: bold; text-align:center;width:30px;">결<br>재</td>';
		apprSign = '<tr>';
		apprDate = '<tr>';

		for (var i = 0; i < list.length; i++) {
			apprMemInfo += '<td style="text-align: center;">' + list[i].dep_name + '&nbsp' + list[i].duty_name + '</td>';

			content += '<div class="mb-3 col-auto" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="right" data-bs-html="true" title="'+list[i].dep_name+'&nbsp'+list[i].name+'&nbsp'+list[i].duty_name+'">';
			content += '<div class="input-group">';
			if (list[i].state == 0) {
				apprDate += '<td></td>';
				apprSign += '<td></td>';
				content += '<span class="input-group-text btn-outline-secondary">'
						+ (i + 1) + '</span>';
				content += '<span class="input-group-text btn-outline-secondary">'
						+ list[i].name + '</span>';
			} else if (list[i].state == 1) {
				apprDate += '<td></td>';
				apprSign += '<td style="text-align: center;">결재중</td>';
				//결재 상세순서 입력
				$('#appr_order').val(i);
				$('#total_order').val(list.length);
				content += '<span class="input-group-text btn-outline-primary">'
						+ (i + 1) + '</span>';
				content += '<span class="input-group-text btn-outline-primary">'
						+ list[i].name + '</span>';
			} else if (list[i].state == 2) {
				apprSign += '<td><div style="text-align: center;"><img src="/photo/'+list[i].sign_file+'" style="width: auto; height: 70px; max-width: 70px; margin-left:10%;" /></div><div style="text-align: center;">'+list[i].name+'</div></td>';
				apprDate += '<td style="text-align: center;">' + timeStampCut(list[i].app_date) + '</td>';
				content += '<span class="input-group-text btn-outline-success">'
						+ (i + 1) + '</span>';
				content += '<span class="input-group-text btn-outline-success">'
						+ list[i].name + '</span>';
			} else if (list[i].state == 3) {
				apprSign += '<td style="text-align: center;">반려</td>';
				apprDate += '<td style="text-align: center;">' + timeStampCut(list[i].app_date) + '</td>';
				content += '<span class="input-group-text btn-outline-danger">'
						+ (i + 1) + '</span>';
				content += '<span class="input-group-text btn-outline-danger">'
						+ list[i].name + '</span>';
			}
			content += '</div></div>';
		}
		apprMemInfo += '</tr>';
		apprSign += '</tr>';
		apprDate += '</tr>';
		apprTableEnd = '</tbody></table></div><p style="clear:both;">&nbsp;</p>';

		apprLine = apprTable + apprMemInfo + apprSign + apprDate + apprTableEnd;
		$('#confirmMemList').empty();
		$('#confirmMemList').append(content);
	}
	
	
	//파일 리스트 출력
	function drawFileList(list){
		content = '';
		if(list.length>0){
			content += '<label class="col-sm-2 col-form-label-lg">첨부 파일</label><div class="col-sm-3 col-form-label-lg">';
		
			for (var i = 0; i < list.length; i++) {
				content += '<a href="/main/download.do?newName='+list[i].new_file_name+'&oriName='+list[i].ori_file_name+'">'+list[i].ori_file_name+'</a><br>';
			}
			//<div id="file_preview"></div>
			content += '</div>';
		}
		$('#fileList').empty();
		$('#fileList').append(content);
	}

	//text editor 옵션
	var text_editor_config = {};
	text_editor_config.editorResizeMode = "none";
	text_editor_config.toolbar = "simple";
	//html 저장, 출력, PDF 저장, 코드 보기
	text_editor_config.toolbar_simple = "{save, print, html2pdf, code}";

	var editor = new RichTextEditor("#div_editor", text_editor_config);
	editor.setReadOnly(); //읽기전용 옵션

	//반려하기
	function reject() {
		//문서 번호
		if(confirm('반려 하시겠습니까?')) {
			$('#appr_state').val('3');
			$('#openY').attr('checked', false);
			$('#openN').attr('checked', true);
			$('form').submit();
	    }
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
		var returnDate = year + "-" + month + "-" + day + " " + hour + ":"
				+ minute;
		return returnDate;
	}
</script>
</html>
