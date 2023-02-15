<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>

<html>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
							<span class="text-muted fw-light">사원관리 /</span> 사원등록
						</h4>

						<!-- 부트스트랩 -->
						<div class="col-xl">
							<div class="card mb-4">
								<div
									class="card-header d-flex justify-content-between align-items-center">
									<!-- 사원등록 헤더 -->
								</div>
								<div class="card-body">

									<!-- 사원 등록 포맷 -->
									<form action="/admin/memRegist.do" method="post"
										enctype="multipart/form-data" onsubmit="empty(event)">

										<!-- 프로필사진첨부+미리보기 -->
										<div class="mb-3">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-fullname">프로필 사진</label>
											<div class="row g-2">
												<img id="profilePreview" src=""
													style="width: auto; height: 200px; margin: auto; border-radius: 70%;" />

											</div>
										</div>

										<p>&nbsp;</p>

										<div class="mb-3">
											<input type="file" id="profileFile" class="form-control"
												name="profile" onchange="profileChange(event)"
												value="${profile}" style="width: 40%; margin: 0 auto;" /> <input
												id="imgId" class="imgUpload" disabled="disabled"
												onchange="readURL(this);" style="display: none;">
										</div>
										<!-- 프로필사진첨부+미리보기 /-->

										<!-- 아이디 input -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-fullname">ID</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<span id="basic-icon-default-ID" class="input-group-text"><i
														class="bx bxs-id-card"></i></span> <input type="text"
														id="idRegist" class="form-control" name="mem_id"
														placeholder="아이디를 입력하세요. (숫자 7자)"
														onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" />
													<button type="button" class="btn btn-outline-primary"
														onclick="idCheck()">중복 검사</button>
												</div>
											</div>
										</div>
										<input type="hidden" id="idCheckPut" value="N" readonly />
										<!-- 아이디 input /-->

										<!-- 이름 input -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-fullname">이름</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">

													<span id="basic-icon-default-fullname2"
														class="input-group-text"><i class="bx bx-user"></i></span>

													<input type="text" id="nameRegist" class="form-control"
														name="name" placeholder="이름 입력하세요" />

												</div>
											</div>
										</div>
										<!-- 이름 input /-->

										<!-- 직속 상급자 : bx bx-group -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-supervisor">직속 상급자</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">


													<span id="basic-icon-default-fullname2"
														class="input-group-text"><i class="bx bx-group"></i></span>
													<input type="text" id="supervSelectName"
														class="form-control" placeholder="직속 상급자를 선택해주세요" readonly />

													<!-- 저장소 상급자 아이디 여기있어요 -->
													<input type="text" id="supervRegist" class="form-control"
														name="parent_id" style="display: none;" readonly />
													<!-- 저장소 상급자 아이디 여기있어요 /-->

													<button type="button" class="btn btn-outline-primary"
														data-bs-toggle="modal" data-bs-target="#supervisorModal">
														등록</button>

												</div>
											</div>
										</div>
										<!-- 직속 상급자 / -->


										<!-- 서명첨부+미리보기 -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-fullname"
												style="margin: auto 0; display: block;">서명 이미지 </label>
											<div class="col">

												<img id="signPreview" src=""
													style="width: auto; height: 200px; margin: auto; padding: 30px; display: block;" />

												<input type="file" id="signFile" class="form-control"
													name="sign" onchange="signChange(event)" value="${sign}"
													style="margin: 0 auto;" /> <input id="signId"
													class="signImg" disabled="disabled"
													onchange="readURL(this);" style="display: none;">
											</div>

										</div>
										<!-- 서명첨부+미리보기 /-->


										<!-- 부서 셀렉트박스 // 활성화 Y인것만 리스트 콜 -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-dep">부서</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<span id="basic-icon-default-company2"
														class="input-group-text"><i class="bx bx-buildings"></i></span>

													<select id="depRegist" class="form-select depOptionList"
														name="dep_idx">
														<option value="blank">부서 선택</option>
													</select>
												</div>
											</div>
										</div>

										<!-- 직급 셀렉트박스 // 활성화 Y인것만 리스트 콜 -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-pos">직급</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<span id="basic-icon-default-company2"
														class="input-group-text"><i class="bx bx-buildings"></i></span>

													<select id="posRegist" class="form-select" name="pos_idx">
														<option value="blank">직급 선택</option>
													</select>
												</div>
											</div>
										</div>

										<!-- 직책 셀렉트박스 // 활성화 Y인것만 리스트 콜 -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-duty">직책</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<span id="basic-icon-default-company2"
														class="input-group-text"><i class="bx bx-buildings"></i></span>

													<select id="dutyRegist" class="form-select" name="duty_idx">
														<option value="blank">직책 선택</option>
													</select>
												</div>
											</div>
										</div>

										<!-- 입사 일자  -->
										<div class="mb-3 row">
											<label for="html5-date-input"
												class="col-md-2 col-form-label-lg">입사일</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<span id="basic-icon-default-company2"
														class="input-group-text"><i class="bx bx-buildings"></i></span>

													<input type="date" id="joinDate" class="form-control"
														name="join_date" />
												</div>
											</div>
										</div>
										<!-- 입사 일자 /  -->


										<!-- 주소 -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-address">주소</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<div class="input-group">
														<span id="basic-icon-default-fullname2"
															class="input-group-text"><i class="bx bx-home"></i></span>

														<input type="text" id="sample6_address"
															class="form-control" name="address"
															placeholder="주소를 선택해주세요" readonly />

														<button type="button" class="btn btn-outline-primary"
															onclick="sample6_execDaumPostcode()">검색</button>
													</div>
												</div>
											</div>
										</div>
										<!-- 주소 / -->

										<!-- 이메일 -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-email">이메일</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<span class="input-group-text"><i
														class="bx bx-envelope"></i></span> <input type="text"
														id="emailRegist" class="form-control" name="email"
														placeholder="이메일을 입력해주세요" />
												</div>
											</div>
										</div>
										<!-- 이메일 / -->

										<!-- 전화번호  -->
										<div class="mb-3 row">
											<label class="col-md-2 col-form-label-lg"
												for="basic-icon-default-phone">전화번호</label>
											<div class="col-md-10">
												<div class="input-group input-group-merge">
													<span id="basic-icon-default-phone2"
														class="input-group-text"><i class="bx bx-phone"></i></span>

													<input type="text" id="phoneRegist"
														class="form-control phone-mask" name="phone"
														placeholder="전화번호를 입력해주세요" />
												</div>
											</div>
										</div>
										<!-- 전화번호 / -->


										<div class="demo-inline-spacing ">
											<button type="button"
												onclick="location.href='/admin/memList.move'"
												class="btn btn-outline-primary float-end">취소</button>
											<button class="btn btn-primary float-end">등록</button>
										</div>

									</form>
								</div>
							</div>
						</div>
						<!-- 부트스트랩 /-->


						<!-- 직속 상급자 Modal -->
						<form name="supervisorModal">
							<div class="modal fade" id="supervisorModal" tabindex="-1"
								aria-hidden="true" data-bs-backdrop="static">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="modalCenterTitle">직속 상급자 선택</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal"></button>
										</div>
										<div class="modal-body">
											<div class="row">
												<div class="col mb-3">
													<label for="de.
													3.pListWithTitle"
														class="col-md-2 col-form-label-lg">부서</label>
													<!-- 부서 셀렉트박스 // 활성화 Y인것만 리스트 콜 -->
													<select id="depOptionList"
														class="form-select depOptionList"
														onchange="supervListCall(),getDepOption(this)">
													</select>

													<!-- 직속 상급자 리스트 -->
													<div class="card">
														<div class="table-responsive text-nowrap">
															<table class="table table-hover">
																<thead>
																	<tr>
																		<th>직급</th>
																		<th>사원명</th>
																	</tr>
																</thead>
																<tbody id="supervisorList">
																</tbody>
															</table>
														</div>
													</div>

													<!-- modal id,name 값 저장 -->
													<div class="col mb-3">
														<label for="superNameWithTitle"
															class="col-md-2 col-form-label-lg">선택된 사원</label> <input
															type="text" id="superSaveName" class="form-control"
															value="" readonly /> <input type="hidden"
															id="superSaveId" value="" class="form-control" readonly />
													</div>
													<!-- modal id,name 값 저장 /-->
												</div>
											</div>
										</div>
										<div class="modal-footer">

											<button type="button" class="btn btn-primary"
												onclick="superRegist()">등록</button>
										</div>
									</div>
								</div>
							</div>
						</form>
						<!-- 직속 모달 끝/-->

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
var checkName = '';
var option = 'Y';
var urlGo = '';

selDepCall(option,checkName);
selPosCall(option,checkName);
selDutyCall(option,checkName);

//아이디 중복검사
function idCheck(){
	const idCheck = $("#idRegist").val();
	
	if(idCheck.length > 6 && idCheck.length < 8){
	
		$.ajax({
	 		type:'POST',
	 		url:'/admin/idCheck.ajax',
	 		data:{idCheck},
	 		dataType:'JSON',
	 		success:function(data){
	 			console.log("중복 결과 : "+data);
	 			if(data == true){
	 				alert("중복이 아닙니다.\n회원가입을 계속 진행해주세요.");
	 				$("#idRegist").attr('readonly',true);
	 				$("#idCheckPut").val("Y");
	 			}else if(data == false){
	 				alert("아이디가 중복입니다.");
	 			}
	 		},
	 		error:function(e){
	 			console.log(e);
	 		}		
	 	});//ajax	
	 	
	}else if(idCheck == ''){
		alert('아이디를 입력해주세요');
	}else{
		alert('아이디 길이를 확인해주세요.')
	}
} //idCheck()


//공란 확인
function empty(e){
	 var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	 var phonRule = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/
	 
 	$email = $("#emailRegist");
	$pnum = $("#phoneRegist");
	
	/*
	 function phonChk(){
		 	var pnum = document.getElementById('mem_pnum').value;
		 	
		 	if(pnum.match(phonRule) == null || pnum =='010-0000-0000'){
		 		document.getElementById('phonChk').style.color = 'red';
		 		document.getElementById('phonChk').innerHTML = "! 휴대폰 번호에 하이픈(`-`)을 넣어 주세요"+"<br>"+"예)010-0000-0000";
		 	}else{
		 		document.getElementById('phonChk').style.color = "green";
		 		document.getElementById('phonChk').innerHTML = "휴대폰 번호 입력 조건을 충족하셨습니다."; 
		 	}
		 }
	*/
	
   if($("#profileFile").val() == ""){
   		e.preventDefault();
   		alert("프로필 사진을 등록해주세요.");
   	}else if($("#idRegist").val() == ""){
   		e.preventDefault();
   		alert("아이디를 입력해주세요.");
   		$("#idRegist").focus();
   	}else if($("#idCheckPut").val() == "N"){
   		e.preventDefault();
   		alert("아이디 중복체크를 진행해주세요.");	
   		$("#idRegist").focus();
   	}else if($("#nameRegist").val() == ""){		
   		e.preventDefault();
   		alert("이름을 입력해주세요.");
   		$("#nameRegist").focus();
   	}else if($("#depRegist").val() == "blank"){
   		e.preventDefault();
   		alert("부서를 입력해주세요.");
   		$("#depRegist").focus();
   	}else if($("#posRegist").val() == "blank"){
   		e.preventDefault();
   		alert("직급을 입력해주세요.");
   		$("#posRegist").focus();
   	}else if($("#dutyRegist").val() == "blank"){
   		e.preventDefault();
   		alert("직책을 입력해주세요.");
   		$("#dutyRegist").focus();
   	}else if($("#joinDate").val() == ""){
   		e.preventDefault();
   		alert("입사일을 입력해주세요.");
   		$("#joinDate").focus();
   	}else if($("#sample6_address").val() == ""){
   		e.preventDefault();
   		alert("주소를 입력해주세요.");
   		$("#sample6_address").focus();
   	}else if($("#emailRegist").val() == ""){
   		e.preventDefault();
   		alert("이메일을 입력해주세요.");
   		$("#emailRegist").focus();
 	}else if($("#emailRegist").val().match(emailRule) == null){
 		e.preventDefault();
 		alert("이메일 형식을 확인해 주세요");
 		$("#emailRegist").focus();
   	}else if($("#phoneRegist").val() == ""){
   		e.preventDefault();
   		alert("전화번호를 입력해주세요.");
   		$("#phoneRegist").focus();
 	}else if($("#phoneRegist").val().match(phonRule) == null){
 		e.preventDefault();
 		alert("핸드폰 번호에 하이픈(`-`을 넣어주세요\n ex) 010-1234-1234");
 		$("#phoneRegist").focus();
   	}else{
	  if(!confirm("사원을 등록하시겠습니까?")){
		  e.preventDefault();
	  } else {
		  return;
	  }
   	}
 }


//프로필 미리보기
 function idolImgChange(event){
    document.getElementById("imgId").value =  document.getElementById("profileFile").value;
    let reader = new FileReader();
    reader.onload = function(e) {
       document.getElementById("profilePreview").setAttribute("src", e.target.result);
    };
    reader.readAsDataURL(event.target.files[0]);
 }
 
//부서 listCall
 function selDepCall(option,checkName){
 	console.log("셀렉트 부서");
 	checkName = '부서';
 	$.ajax({
 		type:'GET',
 		url:'/admin/adminDepList',
 		data:{option},
 		dataType:'JSON',
 		success:function(data){
 			console.log("부서 옴 : "+data.list);
 			drawSelBox(data.list,checkName);
 		},
 		error:function(e){
 			console.log(e);
 		}		
 	});	
 }//selDepCall()

 // 직급 listCall
 function selPosCall(option,checkName){
 	console.log("셀렉트 직급");
 	checkName = '직급';
 	$.ajax({
 		type:'GET',
 		url:'/admin/posList.ajax',
 		data:{option},
 		dataType:'JSON',
 		success:function(data){
 			console.log("직급 옴 : "+data.list);
 			drawSelBox(data.list,checkName);
 		},
 		error:function(e){
 			console.log(e);
 		}		
 	});	
 }//selPosCall()

 // 직책 listCall
 function selDutyCall(option,checkName){
 	 console.log("직책 리스트콜");
 	checkName = '직책';
 	$.ajax({
 		type:'GET',
 		url:'/admin/dutyList.ajax',
 		data:{option},
 		dataType:'JSON',
 		success:function(data){
 			console.log("직책 옴 : "+data.list);
 			drawSelBox(data.list,checkName);
 		},
 		error:function(e){
 			console.log(e);
 		}		
 	});	
 }//dutyListCall()


//부서/직책/직급 그리기
function drawSelBox(selBox,checkName){
	var content='';
	console.log(checkName);
		
	if(checkName == '부서'){
		content +='<option value="blank">부서 선택</option>';		
	}else if(checkName == '직급'){
		content +='<option value="blank">직급 선택</option>';		
	}else if(checkName == '직책'){
		content +='<option value="blank">직책 선택</option>';		
	}
	
	for(i=0;i<selBox.length;i++){
		if(checkName == '부서'){
			content +='<option value="'+selBox[i].dep_idx+'">'+selBox[i].name+'</option>';   
			$('.depOptionList').empty();
			$('.depOptionList').append(content);
			
		}else if(checkName == '직급'){
			content +='<option value="'+selBox[i].pos_idx+'">'+selBox[i].name+'</option>';
			$('#posRegist').empty();
			$('#posRegist').append(content);
			
		}else if(checkName == '직책'){
			content +='<option value="'+selBox[i].duty_idx+'">'+selBox[i].name+'</option>';
			$('#dutyRegist').empty();
			$('#dutyRegist').append(content);
		}
	
	}
}//drawSelBox(DepList)


function supervListCall(){
	var selName = document.getElementById("depOptionList");
	var depIdx = selName.options[selName.selectedIndex].value;
	
	$.ajax({
		type:'GET',
		url:'/admin/supervList.ajax',
		data: {depIdx}, 
		dataType:'JSON',
		success:function(data){
			//console.log(data);
			//console.log(data.list);
			drawSuperList(data.list);
			
		},
		error:function(e){
			console.log(e);
		}		
	});	
	
}//supervListCall()


function drawSuperList(supervList){
	var content='';
	
	if(supervList.length == 0){
		content = '<tr><td colspan="2"> 해당하는 사원이 없습니다 </td></tr>';
		$('#supervisorList').empty();
		$('#supervisorList').append(content);
	}
	
	for(i=0;i<supervList.length;i++){
		content +='<tr id="drawListTr" class="'+supervList[i].mem_id+' '+supervList[i].name+'" onclick="saveSuperId(this)">';
		content +='<td>'+supervList[i].posname+'</td>';
		content +='<td id="facListComment">'+supervList[i].name+'</td>'				
		content +='</tr>';     
	
	$('#supervisorList').empty();
	$('#supervisorList').append(content);
	$('#suparSave').val('');
	}
}//drawList(AdminFaclist)

function saveSuperId(elem){
	console.log(elem);
	var classId = elem.classList[0];
	var className = elem.classList[1];
	console.log(className);
	$('#superSaveId').val(classId);
	$('#superSaveName').val(className);
}

//직속 상급자 입력
function superRegist(){
	console.log("상급자 등록");
	var superVisorId = $('#superSaveId').val();
	var superVisorName = $('#superSaveName').val();
	
	//공란 확인
	if(superVisorId == ''){
		alert('사원을 선택해주세요');
	}
	
	$('#supervRegist').val(superVisorId);
	$('#supervSelectName').val(superVisorName);
	
	//이름 골라
	$('#supervisorModal').modal('hide'); //모달 닫힘
	$('#supervisorModal').on('hidden.bs.modal', function (elem) {
		document.forms['supervisorModal'].reset(); //모달이 닫힐 때 값 초기화
	});
	
}//superRegist


//카카오 주소 API 
function sample6_execDaumPostcode(){
    new daum.Postcode({
        oncomplete: function(data) {
        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R' || data.userSelectedType === 'J') { // 사용자가 주소를 선택했을 경우
                addr = data.roadAddress;
           $("#sample6_address").val(addr);
        	}
       }
    }).open();
}//카카오 주소 API 

//직속상급자 부서정보 > 부서에 담기
function getDepOption(elem){
	console.log("부서정보담기");
	var getDep = $(elem).attr('id');
	var depName = $('#'+getDep+' option:selected').text();
	var depVal = $('#'+getDep+' option:selected').val();
	//console.log("depName : "+depName);
	
	$("#depRegist option:selected").text(depName);
	$("#depRegist option:selected").val(depVal);

	//$("#셀렉트박스ID option:selected").val();
}

//프로필 사진 미리보기
function profileChange(event){
   document.getElementById("imgId").value =  document.getElementById("profileFile").value;
   var reader = new FileReader();
   reader.onload = function(e) {
      document.getElementById("profilePreview").setAttribute("src", e.target.result);
   };
   reader.readAsDataURL(event.target.files[0]);
}




//서명 이미지 미리보기
function signChange(event){
   document.getElementById("signId").value =  document.getElementById("signFile").value;
   var reader = new FileReader();
   reader.onload = function(e) {
      document.getElementById("signPreview").setAttribute("src", e.target.result);
   };
   reader.readAsDataURL(event.target.files[0]);
}





</script>
</html>
