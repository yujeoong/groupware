<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html>
<head>
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
               <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">대분류 /</span> 소분류</h4>
				<h1>여기에작성하시오..prj_idx=1만 불러와봤음.</h1>
				<div class="card">
					<div id="ganttChart"></div>
					<br/><br/>
					<div id="eventMessage"></div>
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
<!-- <script type="text/javascript" src="../gantt/lib/jquery-1.4.2.js"></script> -->
<script type="text/javascript" src="../gantt/lib/date.js"></script>
<script type="text/javascript" src="../gantt/lib/jquery-ui-1.8.4.js"></script>
<script type="text/javascript" src="../gantt/jquery.ganttView.js"></script>
<script type="text/javascript">

//데이터 가져오기
var prj_idx = 1;

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
				slideWidth: 1000,
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
//https://github.com/thegrubbsian/jquery.ganttView
</script>
</html>
