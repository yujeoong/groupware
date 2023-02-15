<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
               <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">아티스트 /</span> 그룹등록</h4>



						   <form action="/artist/artistGroup.do" method="POST" id="ent_test_form">
							<div class="col-md-6">
								<div class="card mb-4">
									<h5 class="card-header">Group Name</h5>
									<div class="card-body">
										<div class="form-floating">
										 <input name ="artg_name" type="text" class="form-control" id="idRegist" placeholder="ex) 핑클" aria-describedby="floatingInputHelp" />
                                            <button type="button" class="btn btn-outline-primary" onclick="idCheck()">중복 검사</button>
											<label for="floatingInput">Name</label>
											<div id="floatingInputHelp" class="form-text">새로운 그룹 이름을 한글로 등록해주세요.</div>
										</div>
										<button class="btn btn-outline-primary float-end" id="input_check" style="display :inline-block;">완료</button>
									</div>
								</div>
							</div>

						</form>






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
<script>

//그룹이름 중복검사
function idCheck(){
    const idCheck = $("#idRegist").val();
    
        $.ajax({
             type:'POST',
             url:'/group/idCheck.ajax',
             data:{idCheck},
             dataType:'JSON',
             success:function(data){
                 console.log("중복 결과 : "+data);
                 if(data == true){
                     alert("등록 가능한 이름입니다.");
                     $("#idRegist").attr('readonly',true);
                     $("#input_check").click(function(){
                         $("#ent_test_form").submit();
                     });
                 }else if(data == false){
                     alert("중복된 이름입니다");
                     $("#input_check").click(function(){
                         return false;
                     });
                 }
             },
             error:function(e){
                 console.log(e);
             }        
         });//ajax    
         
} //idCheck()


</script>
</html>
