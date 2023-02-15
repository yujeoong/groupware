<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
					<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">연습생 /</span> 수정하기</h4>




			<form action="/enterEdit.do" method="POST" enctype="multipart/form-data">
				<div class="card mb-4">
                    <div class="card-body">
                    
                      <div class="mb-3 row">
                        <label for="formFile" class="col-md-2 form-label">프로필 사진</label>
                        <div class="col-md-10">
                          <input class="form-control" type="file" id="html5-text-input" name="photo" />
                          <c:forEach items="${singleList}" var="file">
										<img width="100" src="/photo/${file.newFileName}" />
						  </c:forEach>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">이름</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="name" value="${enter_dto.name}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">성별</label>
                        <div class="col-md-10">
                           <div class="form-check form-check-inline mt-3">
                            <input
                              class="form-check-input"
                              type="radio"
                              name="gender"
                              id="inlineRadio1"
                              value="남"
                              <c:if test="${enter_dto.gender == '남'}">checked</c:if>
                            />
                            <label class="form-check-label" for="inlineRadio1">남자</label>
                          </div>
                          <div class="form-check form-check-inline">
                            <input
                              class="form-check-input"
                              type="radio"
                              name="gender"
                              id="inlineRadio2"
                              value="여"
                              <c:if test="${enter_dto.gender == '여'}">checked</c:if>
                            />
                            <label class="form-check-label" for="inlineRadio2">여자</label>
                          </div>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">생년월일</label>
                        <div class="col-md-10">
                          <input class="form-control" type="date" id="html5-text-input" name="birth" value="${enter_dto.birth}"/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">혈액형</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="blood" value="${enter_dto.blood}"/>
                        </div>
                        
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">키</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="height" value="${enter_dto.height}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">몸무게</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="weight" value="${enter_dto.weight}"/>
                        </div>
                      </div>
                      
                     
                     <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">상태 </label> 
                         <div class="col-md-10">
                        <select id="selectBox" class="form-select" name="state">
                          <option value="" selected="selected">선택</option>
						  <option value="1">연습생</option>
						  <option value="2">아티스트</option>
						  <option value="0">퇴사</option>
                        </select>
                     </div>
                     
                     <div class="mb-3 row" id = "art">
                        <label for="html5-text-input" class="col-md-2 col-form-label">아티스트 추가 입력란</label>
                        <div class="col-md-10">
                          데뷔일:<input class="form-control" type="date" id="html5-text-input" name="debut_date" value="${enter_dto.debut_date}"/>
                          <input class="form-control" type="text" id="html5-text-input" name="mem_id" value="${enter_dto.mem_id}"/>
                          <input class="form-control" type="text" id="html5-text-input" name="stage_name" value="${enter_dto.stage_name}"/>
                        </div>
                      </div>
					 
					 </div>
                  	 
						
						

						<div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">취미</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="hobby" value="${enter_dto.hobby}"/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">특기</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="skill" value="${enter_dto.skill}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">외국어능력</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="language" value="${enter_dto.language}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">특이사항</label>
                        <div class="col-md-10">
                          <input class="form-control" type="text" id="html5-text-input" name="enter_com" value="${enter_dto.enter_com}"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">계약날짜</label>
                        <div class="col-md-10">
                          <input class="form-control" type="date" id="html5-text-input" name="cont_start_date" value="${enter_dto.cont_start_date}"/> ~ 
                          <input class="form-control" type="date" id="html5-text-input" name="cont_end_date" value="${enter_dto.cont_end_date}"/>
                          <input class="form-control" type="text" id="html5-text-input" placeholder="활동내용을 입력해주세요." name="cont_com"/ value="${enter_dto.cont_com}"> <br>
                         </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">활동이력<button type="button" id="bntAdd" class="btn btn-xs btn-primary">추가</button></label>
                        <div class="col-md-10">
                        <div>
                          <input class="form-control" type="date" id="html5-text-input" name="career_start_date[]" value="${enter_dto.career_start_date}"/> ~ 
                          <input class="form-control" type="date" id="html5-text-input" name="career_end_date[]" value="${enter_dto.career_end_date}"/>
                          <input class="form-control" type="text" id="html5-text-input" placeholder="이력내용을 입력해주세요." name="career_content[]" value="${enter_dto.career_content}"/> <br>
                        </div>
                        <div class="append"></div>
                      </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="formFile" class="col-md-2 form-label">첨부파일</label>
                        <div class="col-md-10">
                          <input class="form-control" type="file" id="html5-text-input" name="files" multiple="multiple"/>
                          <c:forEach items="${multiList}" var="file">
							<img width="100" src="/photo/${file.newFileName}" />
						  </c:forEach>
                        </div>
                      </div>              
                  	  <button class="btn btn-outline-primary" style="display :inline-block;">완료</button>
                  	  
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
	$(document)
			.ready(
					function() {
						var wrapper = $('.append');
						var fieldHTML = '<div><input type="date"name="career_start_date[]" value="${enter_dto.career_start_date}"/>~<input type="date" name="career_end_date[]" value="${enter_dto.career_end_date}"/><input type="text" name="career_content[]" placeholder="이력내용을 입력해주세요." value="${enter_dto.career_content}"/><input type="button" class="btnRemove" value="삭제"/></div>';
						$('.btnAdd').click(function() {
							$('.append').append(fieldHTML); // Add field

						});
						$(wrapper).on('click', '.btnRemove', function(e) {
							e.preventDefault();
							$(this).parent('div').remove(); // Remove field
						});
					});
	
	$(document).ready(function() {
		  $('#selectBox').change(function() {
		    var result = $('#selectBox option:selected').val();
		    if (result == '2') {
		      $('#art').show();
		    } else {
		      $('#art').hide();
		    }
		  }); 
		}); 
</script>
</html>
