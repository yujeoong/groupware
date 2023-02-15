<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
					<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light"></span>평가등록하기</h4>





					<form action="/entertainer/enterTestRegist.do" method="POST" id="ent_test_form">
					 <input type="hidden" name="ent_idx" value="${enterTest.ent_idx}"/>
					<div class="card mb-4">
                    <div class="card-body">
                    
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">음정</label>
                        <div class="col-md-10">
                          <input id="tune" value="" class="form-control" type="number" placeholder="1~10" name="tune"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">박자</label>
                        <div class="col-md-10">
                          <input id="beat" value="" class="form-control" type="number" placeholder="1~10" name="beat"/>
                        </div>
                        
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">가창력</label>
                        <div class="col-md-10">
                          <input id="sing" value="" class="form-control" type="number" placeholder="1~10" name="sing"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">음색</label>
                        <div class="col-md-10">
                          <input id="tnoe" value="" class="form-control" type="number" placeholder="1~10" name="tone"/>
                        </div>
                      </div>
                      

						<div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">랩</label>
                        <div class="col-md-10">
                          <input id="rap" value="" class="form-control" type="number" placeholder="1~10" name="rap"/>
                        </div>
                      </div>
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">표정</label>
                        <div class="col-md-10">
                          <input id="face" value="" class="form-control" type="number" placeholder="1~10" name="face"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">제스처</label>
                        <div class="col-md-10">
                          <input id="gesture" value="" class="form-control" type="number" placeholder="1~10" name="gesture"/>
                        </div>
                      </div>
                      
                      <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">춤</label>
                        <div class="col-md-10">
                          <input id="dance" value="" class="form-control" type="number" placeholder="1~10" name="dance"/>
                        </div>
                      </div>
                      
                       <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">연기</label>
                        <div class="col-md-10">
                          <input id="acting" value="" class="form-control" type="number" placeholder="1~10" name="acting"/>
                        </div>
                      </div>
                      
                       <div class="mb-3 row">
                        <label for="html5-text-input" class="col-md-2 col-form-label">코맨트</label>
                        <div class="col-md-10">
                          <input id="test_com" value="" class="form-control" type="text" name="test_com"/>
                        </div>
                      </div>
                      <input type="button" onclick="history.go(-1)" class="btn btn-outline-primary float-end" style="display :inline-block;" value="취소"/>
                  	  <button class="btn btn-outline-primary float-end" id="input_check" style="display :inline-block; margin-right: 5px;">완료</button>
                  	  
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
	
	 
	 $("#input_check").click(function(){
		 if($('#tune').val()=='' || $('#beat').val()==''
			 || $('#sing').val()=='' || $('#tone').val()=='' || $('#rap').val()=='' 
			 || $('#face').val()=='' || $('#gesture').val()=='' || $('#dance').val()=='' 
	 		|| $('#acting').val()==''){
	 		alert("공백은 안됩니당");
	 		return false;
		 }else{
	
			 $("#ent_test_form").submit();
		 }
	
	 });
	
</script>
</html>
