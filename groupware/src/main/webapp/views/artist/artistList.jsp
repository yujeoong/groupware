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
#keyword {
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
						<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light"></span>아티스트</h4>


                        <div style="margin-bottom: 5px;">
						<button onclick="location.href='/entertainer/enterWriteForm.move'" class="btn btn-outline-primary">등록하기</button>
						<button onclick="location.href='/artist/artistGroup.move'" class="btn btn-outline-primary">그룹등록</button>
						</div>
						<!-- <div class="offset-8">
							 <fieldset style="margin: 5%">
                                <select class="form-select" style="width: 23%" name="opt">
									<option value="" selected="selected">선택</option>
									<option value="name">이름</option>
									<option value="artg_name">그룹</option>
								</select>
								<button class="btn btn-outline-primary">search</button>
								<input class="form-control" type="text" name="keyword" id="keyword" placeholder="검색어를 입력 하세요" />
							</fieldset>
						</div>
						<form action="/artist/artSearch.move" method="post" class="offset-8">
						</form> -->





						<div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
							<c:if test="${artistFileList.size()>0}">
								<c:forEach items="${artistFileList}" var="file"
									varStatus="status">
									<div class="col">
											<a href="/artist/artistDetail.move?ent_idx=${file.num}">
												<img src="/photo/${file.new_file_name}" class="card-img-top" />
											</a>
											<div class="card-body">
												<h5 class="card-title" style="text-align: center;">${artistList[status.index].name}
													| ${artistList[status.index].artg_name}</h5>
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
