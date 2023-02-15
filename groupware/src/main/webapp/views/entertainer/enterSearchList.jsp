<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#keyword{
	float: right;
	display: inline-block;
	width: 78%;
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
					<div class="container-xxl flex-grow-1 container-p-y">
					<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">연습생</span></h4>


						<button onclick="location.href='enterWriteForm.move'" class="btn btn-outline-primary">등록하기</button>
						<form action="/entertainer/enterSearch" method="post" class="offset-8">
							<fieldset>
								<div>
									<button style="float: right;" class="btn btn-outline-primary">search</button>								
								</div>						
								<div>
									<input class="form-control" type="text" name="keyword" id="keyword" placeholder="이름을 입력 하세요" />
								</div>
							</fieldset>
						</form>


				<div class="row row-cols-1 row-cols-md-4 g-4 mb-5">
				<c:if test="${enterSearchFileList.size()>0}">
				<c:forEach items="${enterSearchFileList}" var="file" varStatus="status">
                <div class="col">
                  <div class="card h-100">
                  	<a href="/entertainer/enterDetail.move?ent_idx=${file.num}">
                    <img src="/photo/${file.new_file_name}" class="card-img-top" src="../assets/img/elements/2.jpg" alt="Card image cap" />
                   	</a>
                    <div class="card-body">
                      <h5 class="card-title" style="text-align: center;">${enterSearchList[status.index].name} | ${enterSearchList[status.index].birth}</h5><br>
                      <p class="card-text">톤: ${enterSearchList[status.index].tune}</p>
                      <p class="card-text">박자: ${enterSearchList[status.index].beat}</p>
                      <p class="card-text">노래: ${enterSearchList[status.index].sing}</p>
                      <p class="card-text">랩: ${enterSearchList[status.index].rap}</p>
                      <p class="card-text">표정: ${enterSearchList[status.index].face}</p>
                      <p class="card-text">제스처: ${enterSearchList[status.index].gesture}</p>
                      <p class="card-text">춤: ${enterSearchList[status.index].dance}</p>
                      <p class="card-text">연기: ${enterSearchList[status.index].acting}</p>
                      <p class="card-text">평가날짜 ${enterSearchList[status.index].test_date}</p>
                    </div>
                  </div>
                </div>
                </c:forEach>
				</c:if>
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
	
</script>
</html>
