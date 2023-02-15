<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../assets/css/Treant.css">
<link rel="stylesheet" href="../assets/css/tree.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="../assets/vendor/js/raphael.js"></script>
<script src="../assets/js/Treant.js"></script>


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
               <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light"></span>조직도</h4>

				
				
				<div class="chart" id="tree" style="width: 100%; height:100%;"></div>
				
				
				

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

	$.ajax({
		type:'get',
		url:'/orgChart.ajax',
		dataType:'json',
		success:function(data){
			console.log("ajax success!!");
			drawChart(data.list);
			console.log("아작스 : "+data.list);
		},
		error:function(e){
			console.log(e);
		}
	});


var total = {};
total.config = {
	container : '#tree', //표시할 요소
	connectors : { //연결 방식 : 선 
		type: 'step' //곡선으로 연결
	},
	node: {
		HTMLclass : 'nodeExample' //하나의 사람(노드)마다 주어질 클래스 이름
	}
};




function drawChart(list){
	console.log("list : {}",list);
	
	list.forEach(function(item){

			var obj = {};

			obj.image="/photo/"+item.new_file_name;

			if (item.stack == 'Y') {
				obj.stackChildren = true //true면 상하구조
			}

			obj.text = {};
			obj.text.name = item.mem_name;
			obj.text.team = item.dept_name;
			obj.text.title = item.duty_name;
			obj.text.phone = item.phone;
			obj.text.email = {
				'val' : item.email,
				'href' : 'mailto:' + item.email
			};
			console.log("담겨진 사람들... obj : {}",obj); //담겨진 사람들
			
			
			
			if (item.parent_id != null) { //부모가 있을 경우 
				console.log("부모가 있을때 !! 그 부모는 아이디는? : " +item.parent_id);
			
				if (total[item.parent_id] == null) { //total의 item의 parent_id가 없을때, 

					var result = list.find(function(elem) {
						return elem.mem_id == "2300000"; //elem의 id가 사장인걸 가져와라.. 
					});
					obj.parent = result;
					console.log("obj.parent = result    :    "+ result);
				} else {
					obj.parent = total[item.parent_id];
				}
			}
			
			total[item.mem_id] = obj
		});

		console.log(total);

		new Treant(Object.values(total));
	}
</script>
</html>




















