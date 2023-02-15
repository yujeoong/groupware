<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="../gantt/lib/jquery-ui-1.8.4.css" />
<link rel="stylesheet" type="text/css" href="../gantt/example/reset.css" />
<link rel="stylesheet" type="text/css" href="../gantt/jquery.ganttView.css" />
<style type="text/css">
	body {
		font-family: tahoma, verdana, helvetica;
		font-size: 0.8em;
		padding: 10px;
	}
</style>
<style>

/* 구역 */
.section{
	width: 100%;
			}

.left {
	width: 75%;
	float: left;
}

.left2{
	margin-left: 15%;
	margin-top: 2%;
	width: 50%;
	float: left;
}
.right {
	width: 25%;
	float: right;
}


.ul1{
    list-style:none;
}
 
.li1{
    float: left;
    margin-left: 20px;
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
				<h1> ${subject}</h1>
				
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
				      </div>
				    </div>
				  </nav>
				<p>&nbsp;</p>
				
				
				<!--  간트차트 -->
				<div class="card-group mb-5 card">
					<div id="ganttChart"></div>
				</div>
				
			</div>
			 <!-- end Content -->

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
    <!-- / Layout wrapper -->

</body>
<script type="text/javascript" src="../gantt/lib/date.js"></script>
<script type="text/javascript" src="../gantt/lib/jquery-ui-1.8.4.js"></script>
<script type="text/javascript" src="../gantt/jquery.ganttView.js"></script>
<script type="text/javascript"></script>

<script>
var prj_idx = ${prj_idx};

listAjax(prj_idx);

function listAjax(prj_idx){
	$.ajax({
		type:'get',
		url:'/project/taskList.ajax',
		data:{prj_idx: prj_idx},
		dataType:'json',
		success:function(data){
// 			console.log(data);
//			console.log(putList(data.task));
			$("#ganttChart").ganttView({ 
				data: putList(data.task),
				slideWidth: 1050,
			});
		},
		error:function(e){
			console.log("에러: "+e);
		}
	});
}


function putList(list){
	testData = [];
	for(var i=0; i<list.length; i++){
		let temp = {"id" : i+1, "name": list[i].name, "series":[]};
		temp.series.push({"name" : list[i].subject, "start":dateFormat(list[i].plan_start), "end": dateFormat(list[i].plan_end)});
		console.log(temp);
		testData.push(temp);
	}
	//console.log(content);
	return testData;
}

//date 포맷 변환
function dateFormat(timestamp) {
	var date = new Date(timestamp);
	var year = date.getFullYear()
	var month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
	var day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
	var returnDate = year + "," + month + "," + day;
	return returnDate;
}
</script>
</html>
