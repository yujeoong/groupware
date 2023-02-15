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
					<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">아티스트</span></h4>
					
					
					<button onclick="location.href='/entertainer/enterWriteForm.move'" class="btn btn-outline-primary">등록하기</button>
					<button onclick="location.href='/artist/artistGroup.move'" class="btn btn-outline-primary">그룹등록</button>
						<form action="/artist/artSearch" method="post" class="d-flex">
							<fieldset>
								<select class="form-select" name="opt">
									<option value="" selected="selected">선택</option>
									<option value="name">이름</option>
									<option value="artg_name">그룹</option>
								</select> 
								<input type="text" name="keyword" placeholder="검색어를 입력 하세요" />
								<button class="btn btn-outline-primary">search</button>
							</fieldset>
						</form>
						

						<div class="row row-cols-1 row-cols-md-4 g-4 mb-5">
							<c:if test="${artSearchFileList.size()>0}">
								<c:forEach items="${artSearchFileList}" var="file" varStatus="status">
									<div class="col">
										<div class="card h-100">
											<img src="/photo/${file.new_file_name}" class="card-img-top"/>
											<div class="card-body">
												<h5 class="card-title">${artSearchList[status.index].name}</h5>
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
