<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<style>

/* 구역 */
.section{
	width: 100%;
			}

.left {
	width: 70%;
	float: left;
    margin-left: 40px;
	
}

.left2{
	margin-left: 15%;
	margin-top: 2%;
	width: 50%;
	float: left;
}
.left3{
	width: 65%;
	float: left;
	padding-right: 26px;
	padding-left : 50px;
	border-radius: 10px;
}
.right {
	width: 30%;
	float: right;
}


.ul1{
    list-style:none;
}
 
.li1{
    float: left;
    margin-left: 20px;
}   
    
.mem{
	border: 1px solid;
	padding : 5px 10px;
	radius: 3px;
	background-color: white;
}

.mem1{
	padding: 5px 150px 5px 30px;
}

.tx {
    width: 100%;
    resize: none;
    height: 300px;
    border: none;
}

  .row1{
    padding-right: 0px;
    margin-right: 0px;
    margin-left: 0px;
    margin-top: 10px;
    padding-left: 0px;
  }
  
  	table, tr, td{
		border : 1px solid black;
		border-collapse: collapse;
		padding : 5px 10px;
	}
	
.table {
	margin-top: 30px;
	width: 600px;
	float: left;
	background-color: white;
	border-radius: 0.5rem;
	border-style: hidden;
}	
</style>
</head>
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
 
 
 
				<h1>${subject}</h1>

				<!--  상단 메뉴 탭 -->									
				  <nav class="navbar navbar-example navbar-expand-lg bg-light">
				    <div class="container-fluid">
					      <div class="collapse navbar-collapse" id="navbar-ex-4">
					        <div class="navbar-nav me-auto">
					          <a class="nav-item nav-link" href="/project/projectHome.move?prj_idx=${prj_idx}">홈</a>				          
					          <a class="nav-item nav-link" href="/project/projectPost.move?prj_idx=${prj_idx}">글</a>				          
					          <a class="nav-item nav-link" href="/project/projectTask.move?prj_idx=${prj_idx}">업무</a>
					          <a class="nav-item nav-link" href="/project/projectGanttChart.move?prj_idx=${prj_idx}">간트차트</a>
					          <a class="nav-item nav-link" href="/project/projectPoll.move?prj_idx=${prj_idx}">투표</a>
					          <a class="nav-item nav-link" href="/project/projectFeedback.move?prj_idx=${prj_idx}">피드백</a>
					        </div>
				        <form action="/project/projectPostSearch.do" method="post" class="d-flex">
				          <div class="input-group">
				          	<input type="hidden" name="prj_idx" value="${prj_idx}">				          
				            <input type="text" class="form-control" placeholder="글제목을 입력하세요." />
				            <button class="btn btn-outline-primary">검색</button>
				          </div>
				        </form>
				      </div>
				    </div>
				  </nav>

						
						
						
<!-- 						<div class="accordion-item card"> -->
<!-- 							<h2 -->
<!-- 								class="accordion-header text-body d-flex justify-content-between" -->
<!-- 								id="accordionIconOne"> -->
<!-- 								<button type="button" class="accordion-button collapsed" -->
<!-- 									data-bs-toggle="collapse" data-bs-target="#accordionIcon-1" -->
<!-- 									aria-controls="accordionIcon-1"> -->
<!-- 									카테고리 글제목 작성날짜 </button> -->
<!-- 							</h2> -->

<!-- 							<div id="accordionIcon-1" class="accordion-collapse collapse" -->
<!-- 								data-bs-parent="#accordionIcon"> -->
<!-- 								<div class="accordion-body"> -->


<!-- 									<div class="left3" id="closest"> -->
<!-- 										<table class="table"> -->
<!-- 											<tr style="border-style: none"> -->
<!-- 												<td style="border-style: none">작성자 작성날짜</td> -->
<!-- 												<td style="border-style: none"></td> -->
<!-- 												<td style="text-align: right; border-style: none"> -->
<!-- 												<input id="prj_post_Idx" type="hidden" value="3"/> -->

<!-- 												</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td style="border-style: dotted; font-weight: bold" -->
<!-- 													colspan=3>제목</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td style="border-style: none" colspan=3>내용</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td style="border-style: none"></td> -->
<!-- 											</tr> -->
<!-- 										</table> -->
<!-- 									</div> -->

<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
















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
