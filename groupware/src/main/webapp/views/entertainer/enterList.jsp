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
	width: 75%;
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
					<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light"></span>연습생</h4>


					
						
						
						<div>
							<div style="float: left;">
                       		 <button onclick="location.href='/entertainer/enterWriteForm.move'" class="btn btn-outline-primary">등록하기</button>
                       		 </div>
                        	<form action="/entertainer/enterSearch.move" method="post"><!-- d-flex -->
                            <fieldset style="margin: 3%;">
								<div>
									<button style="float: right;" class="btn btn-outline-primary">search</button>								
								</div>						
								<div>
                                    <input class="form-control" type="text" style="width: 30%" name="keyword" id="keyword" placeholder="이름을 입력 하세요" />									
								</div>
							</fieldset>
						</form>
						</div>
						
							
						

                <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
				<div class="row row-cols-1 row-cols-md-4 g-4 mb-5">
				<c:if test="${enterFileList.size()>0}">
				<c:forEach items="${enterFileList}" var="file" varStatus="status">
                <div class="col">
                  <div class="card h-100">
                    <a href="/entertainer/enterDetail.move?ent_idx=${file.num}">
                    <img src="/photo/${file.new_file_name}" class="card-img-top" src="../assets/img/elements/2.jpg" alt="Card image cap"/>
                    </a>
                    <div class="card-body">
                      <h5 class="card-title" style="text-align: center;">${enterList[status.index].name} | ${enterList[status.index].birth}</h5><br>
                      <h6>평균:<fmt:formatNumber value="${(enterList[status.index].tune
                      +enterList[status.index].beat
                      +enterList[status.index].sing
                      +enterList[status.index].rap
                      +enterList[status.index].face
                      +enterList[status.index].gesture
                      +enterList[status.index].dance
                      +enterList[status.index].acting)/8}" pattern=".0"/></h6>
                      <p class="card-text" id="tune">톤: ${enterList[status.index].tune}</p>
                      <p class="card-text" id="beat">박자: ${enterList[status.index].beat}</p>
                      <p class="card-text" id="sing">노래: ${enterList[status.index].sing}</p>
                      <p class="card-text" id="rap">랩: ${enterList[status.index].rap}</p>
                      <p class="card-text" id="face">표정: ${enterList[status.index].face}</p>
                      <p class="card-text" id="gesture">제스처: ${enterList[status.index].gesture}</p>
                      <p class="card-text" id="dance">춤: ${enterList[status.index].dance}</p>
                      <p class="card-text" id="acting">연기: ${enterList[status.index].acting}</p>
                      <p class="card-text">평가날짜 ${enterList[status.index].test_date}</p>
                    </div>
                  </div>
                </div>
                </c:forEach>
				</c:if>
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
