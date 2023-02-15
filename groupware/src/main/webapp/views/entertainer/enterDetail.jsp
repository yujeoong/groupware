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
               <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">연습생 /</span> 상세보기</h4>


						<button onclick="location.href='/entertainer/enterEdit.move?ent_idx=${enterList.ent_idx}'" class="btn btn-outline-primary">수정하기</button>
						<button onclick="location.href='/entertainer/enterTest.move?ent_idx=${enterList.ent_idx}'" class="btn btn-outline-primary float-end">평가등록</button>


						 
						
							<div class="row row-cols-md-4 mb-5" style="flaot:left;">
							<div class="col">
								<div class="card h-100">
									<img src="/photo/${enterProFile.new_file_name}"
										class="card-img-top" src="../assets/img/elements/2.jpg"
										alt="Card image cap" />
									<div class="card-body">
										<p><strong class="card-text" style="text-aline:center;">${enterList.name}</strong></p>
										<p></p>
										<p class="card-text">생년월일:${enterList.birth}</p>
										<p class="card-text">성별: ${enterList.gender}</p>
										<p class="card-text">키: ${enterList.height}</p>
										<p class="card-text">몸무게: ${enterList.weight}</p>
										<p class="card-text">혈액형: ${enterList.blood}</p>
										<p class="card-text">취미: ${enterList.hobby}</p>
										<p class="card-text">특지:${enterList.skill}</p>
										<p class="card-text">외국어: ${enterList.language}</p>
									</div>
								</div>
							</div>
							
							
							
							<div class="col">
                            <div class="card overflow-hidden mb-4" style="height: 300px;width:320%;">							
								<div class="card-body" id="vertical-example" style="overflow: auto;">
									<table class="table">
										<thead>
											<tr>
												<th><strong>평가일자</strong></th>
												<th><strong>음정</strong></th>
												<th><strong>박자</strong></th>
												<th><strong>노래</strong></th>
												<th><strong>톤</strong></th>
												<th><strong>랩</strong></th>
												<th><strong>표정</strong></th>
												<th><strong>제스처</strong></th>
												<th><strong>춤</strong></th>
												<th><strong>연기</strong></th>
											</tr>
										</thead>
										<tbody class="table-border-bottom-0">
										<c:forEach items="${enterTest}" var="test">
											<tr>
												<td>${test.test_date}</td>
												<td>${test.tune}</td>
												<td>${test.beat}</td>
												<td>${test.sing}</td>
												<td>${test.tone}</td>
												<td>${test.rap}</td>
												<td>${test.face}</td>
												<td>${test.gesture}</td>
												<td>${test.dance}</td>
												<td>${test.acting}</td>
											</tr>
											<tr>
												<th><strong>comment: ${test.test_com}</strong></th>
											</tr> 
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							
							
							
							<div class="col" >
                            <div class="card overflow-hidden mb-4" style="height: 465px;width:165%;">							
								<div class="card-body" id="vertical-example" style="overflow: auto;">
									<table class="table">
										<h4>활동이력</h4>
										<thead>
											<tr>
												<th><strong>시작일자</strong></th>
												<th><strong>종료일자</strong></th>
												<th><strong>내용</strong></th>
											</tr>
										</thead>
										<tbody class="table-border-bottom-0">
										<c:forEach items="${enterCareer}" var="career">
											<tr>
												<td>${career.start_date}</td>
												<td>${career.end_date}</td>
												<td>${career.content}</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							</div>
							
						
						</div>
						
							<div class="col">
                            <div class="card overflow-hidden mb-4" style="height: 230px;width:150%; margin-top: 324px; left: 60%;">							
								<div class="card-body" id="vertical-example" style="overflow: auto;">
									<table class="table">
										<h4>계약일/만료일</h4>
										<thead>
											<tr>
												<th><strong>시작일자</strong></th>
												<th><strong>종료일자</strong></th>
												<th><strong>내용</strong></th>
											</tr>
										</thead>
										<tbody class="table-border-bottom-0">
										<c:forEach items="${enterLog}" var="log">
											<tr>
												<td>${log.cont_start_date}</td>
												<td>${log.cont_end_date}</td>
												<td>${log.con_com}</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							</div>
							
							<div class="col">
                            <div class="card overflow-hidden mb-4" style="height: 230px;width:150%; margin-top: 560px; right: 50%">							
								<div class="card-body" id="vertical-example" style="overflow: auto;">
									<table class="table">
										<h4>첨부파일</h4>
										<tbody class="table-border-bottom-0">
										<c:forEach items="${enterFiles}" var="file">
											<a href="/main/download.do?newName=${file.new_file_name}&oriName=${file.ori_file_name}'">${file.ori_file_name}</a><br>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							</div>
					</div>
						
						






















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

</script>
</html>
