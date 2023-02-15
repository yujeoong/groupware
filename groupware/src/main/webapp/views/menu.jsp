<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>

<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

<title>ELEVEN | GROUPWARE FOR ENTERTAINMENT</title>

<meta name="description" content="" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon"
	href="../assets/img/favicon/favicon.ico" />

<!-- Fonts -->
<!-- <link rel="preconnect" href="https://fonts.googleapis.com" /> -->
<!-- <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin /> -->
<!-- <link -->
<!-- 	href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" -->
<!-- 	rel="stylesheet" /> -->

<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet" href="../assets/vendor/css/core.css"
	class="template-customizer-core-css" />
<link rel="stylesheet" href="../assets/vendor/css/theme-default.css"
	class="template-customizer-theme-css" />
<link rel="stylesheet" href="../assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet"
	href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

<link rel="stylesheet"
	href="../assets/vendor/libs/apex-charts/apex-charts.css" />

<!-- Page CSS -->

<!-- Helpers -->
<script src="../assets/vendor/js/helpers.js"></script>

<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="../assets/js/config.js"></script>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!--     <script src="../assets/vendor/libs/jquery/jquery.js"></script> -->
</head>

<body>
        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
            <a href="/" class="app-brand-link">
              <span class="app-brand-logo demo">
                <svg
                  width="25"
                  viewBox="0 0 25 42"
                  version="1.1"
                  xmlns="http://www.w3.org/2000/svg"
                  xmlns:xlink="http://www.w3.org/1999/xlink"
                >
                  <defs>
                    <path
                      d="M13.7918663,0.358365126 L3.39788168,7.44174259 C0.566865006,9.69408886 -0.379795268,12.4788597 0.557900856,15.7960551 C0.68998853,16.2305145 1.09562888,17.7872135 3.12357076,19.2293357 C3.8146334,19.7207684 5.32369333,20.3834223 7.65075054,21.2172976 L7.59773219,21.2525164 L2.63468769,24.5493413 C0.445452254,26.3002124 0.0884951797,28.5083815 1.56381646,31.1738486 C2.83770406,32.8170431 5.20850219,33.2640127 7.09180128,32.5391577 C8.347334,32.0559211 11.4559176,30.0011079 16.4175519,26.3747182 C18.0338572,24.4997857 18.6973423,22.4544883 18.4080071,20.2388261 C17.963753,17.5346866 16.1776345,15.5799961 13.0496516,14.3747546 L10.9194936,13.4715819 L18.6192054,7.984237 L13.7918663,0.358365126 Z"
                      id="path-1"
                    ></path>
                    <path
                      d="M5.47320593,6.00457225 C4.05321814,8.216144 4.36334763,10.0722806 6.40359441,11.5729822 C8.61520715,12.571656 10.0999176,13.2171421 10.8577257,13.5094407 L15.5088241,14.433041 L18.6192054,7.984237 C15.5364148,3.11535317 13.9273018,0.573395879 13.7918663,0.358365126 C13.5790555,0.511491653 10.8061687,2.3935607 5.47320593,6.00457225 Z"
                      id="path-3"
                    ></path>
                    <path
                      d="M7.50063644,21.2294429 L12.3234468,23.3159332 C14.1688022,24.7579751 14.397098,26.4880487 13.008334,28.506154 C11.6195701,30.5242593 10.3099883,31.790241 9.07958868,32.3040991 C5.78142938,33.4346997 4.13234973,34 4.13234973,34 C4.13234973,34 2.75489982,33.0538207 2.37032616e-14,31.1614621 C-0.55822714,27.8186216 -0.55822714,26.0572515 -4.05231404e-15,25.8773518 C0.83734071,25.6075023 2.77988457,22.8248993 3.3049379,22.52991 C3.65497346,22.3332504 5.05353963,21.8997614 7.50063644,21.2294429 Z"
                      id="path-4"
                    ></path>
                    <path
                      d="M20.6,7.13333333 L25.6,13.8 C26.2627417,14.6836556 26.0836556,15.9372583 25.2,16.6 C24.8538077,16.8596443 24.4327404,17 24,17 L14,17 C12.8954305,17 12,16.1045695 12,15 C12,14.5672596 12.1403557,14.1461923 12.4,13.8 L17.4,7.13333333 C18.0627417,6.24967773 19.3163444,6.07059163 20.2,6.73333333 C20.3516113,6.84704183 20.4862915,6.981722 20.6,7.13333333 Z"
                      id="path-5"
                    ></path>
                  </defs>
                  <g id="g-app-brand" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                    <g id="Brand-Logo" transform="translate(-27.000000, -15.000000)">
                      <g id="Icon" transform="translate(27.000000, 15.000000)">
                        <g id="Mask" transform="translate(0.000000, 8.000000)">
                          <mask id="mask-2" fill="white">
                            <use xlink:href="#path-1"></use>
                          </mask>
                          <use fill="#696cff" xlink:href="#path-1"></use>
                          <g id="Path-3" mask="url(#mask-2)">
                            <use fill="#696cff" xlink:href="#path-3"></use>
                            <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-3"></use>
                          </g>
                          <g id="Path-4" mask="url(#mask-2)">
                            <use fill="#696cff" xlink:href="#path-4"></use>
                            <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-4"></use>
                          </g>
                        </g>
                        <g
                          id="Triangle"
                          transform="translate(19.000000, 11.000000) rotate(-300.000000) translate(-19.000000, -11.000000) "
                        >
                          <use fill="#696cff" xlink:href="#path-5"></use>
                          <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-5"></use>
                        </g>
                      </g>
                    </g>
                  </g>
                </svg>
              </span>
              <span class="app-brand-text demo menu-text fw-bolder ms-2">eleven</span>
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">
            <!-- Dashboard -->
            <li class="menu-item" id="menu_home">	
              <a href="/" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">HOME</div>
              </a>
            </li>
<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
            <!-- 직원 -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">마이페이지</span></li>
            
            
            <!-- 사원 정보  -->
            <li class="menu-item" id="menu_member">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">사원 정보</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_mem_detail">
                  <a href="/member/mem_detail.move" class="menu-link">
                    <div data-i18n="Basic Inputs">상세보기</div>
                  </a>
                </li>
              </ul>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_pwUpdate">
                  <a href="/member/pwUpdate.move" class="menu-link">
                    <div data-i18n="Basic Inputs">비밀번호 변경</div>
                  </a>
                </li>
              </ul>
            </li>
            
            <!-- 일정 관리 -->
            <li class="menu-item" id="menu_schedule">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">일정 관리</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_scheList">
                  <a href="/schedule/scheList.move" class="menu-link">
                    <div data-i18n="Basic Inputs">나의 일정</div>
                  </a>
                </li>
              </ul>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_scheWriteForm">
                  <a href="/schedule/scheWriteForm.move" class="menu-link">
                    <div data-i18n="Basic Inputs">일정 추가</div>
                  </a>
                </li>
              </ul>
            </li>


<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
            <!-- 결재문서 -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">전자결재</span></li>
            
            
            <li class="menu-item" id="menu_docFormList">
              <a href="/appr/docFormList.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">기안 문서 작성</div>
              </a>
            </li>
            
            <!-- 수신문서함 -->
            <li class="menu-item" id="menu_apprInbox">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">결재 수신함</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_apprWait">
                  <a href="/apprInbox/apprWait.move" class="menu-link">
                    <div data-i18n="Basic Inputs">결재 대기</div>
                  </a>
                </li>
              </ul>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_apprDone">
                  <a href="/apprInbox/apprDone.move" class="menu-link">
                    <div data-i18n="Basic Inputs">처리 완료</div>
                  </a>
                </li>
              </ul>
            </li>
            
            <!-- 발신문서함 -->
            <li class="menu-item" id="menu_apprSent">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">결재 상신함</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_apprInProgress">
                  <a href="/apprSent/apprInProgress.move" class="menu-link">
                    <div data-i18n="Basic Inputs">결재 진행중</div>
                  </a>
                </li>
              </ul>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_apprReject">
                  <a href="/apprSent/apprReject.move" class="menu-link">
                    <div data-i18n="Basic Inputs">결재 반려</div>
                  </a>
                </li>
              </ul>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_apprComplete">
                  <a href="/apprSent/apprComplete.move" class="menu-link">
                    <div data-i18n="Basic Inputs">결재 완료</div>
                  </a>
                </li>
              </ul>
            </li>


<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->

            <!-- 게시판 -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">게시판</span></li>
            
            
            <li class="menu-item" id="menu_noticeList">
              <a href="/noticeList.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">공지사항</div>
              </a>
            </li>
            
            <!-- 부서게시판 -->
            <li class="menu-item" id="menu_post">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">부서 게시판</div>
              </a>
              <ul class="menu-sub" id="depList">
                <li class="menu-item" id="menu_gantt">
                  <a href="/post/postList.move?dep_idx=1" class="menu-link">
                    <div data-i18n="Basic Inputs">부서게시판1</div>
                  </a>
              </ul>
            </li>
            <!-- 프로젝트 -->            
            <li class="menu-item" id="menu_prjManage">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Layouts">프로젝트</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_myProjectList">
                  <a href="/prjManage/myProjectList.move" class="menu-link">
                    <div data-i18n="Vertical Form">참여중인 프로젝트</div>
                  </a>
                </li>
                <li class="menu-item" id="menu_projectList">
                  <a href="/prjManage/projectList.move" class="menu-link">
                    <div data-i18n="Horizontal Form">전체 프로젝트</div>
                  </a>
                </li>
              </ul>
            </li>

<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
            <!-- 연습생/아티스트 -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">엔터테이너</span></li>
            
            <li class="menu-item"  id="menu_artist">
              <a href="/artist/artistList.move" class="menu-link" id="menu_artistList">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">아티스트</div>
              </a>
            </li>
            
            <!-- 연습생 -->
            <li class="menu-item" id="menu_entertainer">
              <a href="/entertainer/enterList.move" class="menu-link" id="menu_enterList">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">연습생</div>
              </a>
            </li>

<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
            <!-- 기타 -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">기타사항</span></li>
           
            <!-- 사원 검색 -->
            <li class="menu-item" id="menu_memListAll">
              <a href="/memListAll.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">사원 검색</div>
              </a>
            </li>
            
            <!-- 조직도 -->
            <li class="menu-item" id="menu_orgChart">
              <a href="/orgChart.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">조직도</div>
              </a>
            </li>
            
            <!-- 시설 예약 -->
            <li class="menu-item" id="menu_facility">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Layouts">시설 예약</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item" id="menu_facList">
                  <a href="/facility/facList.move" class="menu-link">
                    <div data-i18n="Vertical Form">시설 리스트</div>
                  </a>
                </li>
                <li class="menu-item" id="menu_fac_bookList">
                  <a href="/facility/fac_bookList.move" class="menu-link">
                    <div data-i18n="Horizontal Form">시설 예약</div>
                  </a>
                </li>
              </ul>
            </li>

<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
            <!-- 관리자 -->
            <c:if test="${sessionScope.level eq 0 || sessionScope.level eq 1}">
            <li class="menu-header small text-uppercase"><span class="menu-header-text">관리자</span></li>
           
			<li class="menu-item" id="menu_admin">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Layouts">관리자</div>
              </a>
			<ul class="menu-sub">
			
            <!-- 관리자권한관리 -->            
            <c:if test="${sessionScope.level eq 0}">
            <li class="menu-item" id="menu_adminAuth">
              <a href="/admin/adminAuth.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">관리자 권한 관리</div>
              </a>
            </li>
            </c:if>
            <!-- 사원 정보 -->
            <li class="menu-item" id="menu_memList">
              <a href="/admin/memList.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">사원 관리</div>
              </a>
            </li>
            
            <!-- 부서 관리 -->
            <li class="menu-item" id="menu_depList">
              <a href="/admin/depList.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">부서 관리</div>
              </a>
            </li>
            
            <!-- 직책 관리 -->
            <li class="menu-item" id="menu_dutyList">
              <a href="/admin/dutyList.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">직책 관리</div>
              </a>
            </li>
            
            <!-- 직급 관리 -->
            <li class="menu-item" id="menu_posList">
              <a href="/admin/posList.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">직급 관리</div>
              </a>
            </li>
            
            <!-- 시설 관리 -->
            <li class="menu-item" id="menu_adminFacList">
              <a href="/admin/adminFacList.move" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">시설 관리</div>
              </a>
            </li>
            </ul>
</li>
            </c:if>
<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->
<!--  ---------------------------------------------------------------------------------------------------------------------------------------  -->

          </ul>
        </aside>
        <!-- / Menu -->

</body>
<script>
depList();
$(document).ready(function() {
	
	
	//pathname 받아오기(root, page 분리)
	var pathname = document.location.pathname;
	if(pathname == '/'){
		root = page = 'home';	
	}else{
		path = pathname.split('/');
		root = page = path[1].split('.')[0];
		if(path.length >2){
			page = path[2].split('.')[0];		
		}
	}
	
	//메뉴에 없는 페이지면 이전페이지의 menu active 그대로 유지
	var menu_main = root;
	//console.log(menu_main+"이라는 메뉴 active")
	if($("#menu_"+page).length > 0){
		//console.log(page+"라는 메뉴 있음")
		menu_sub = page;
		}else{
			menu_sub = document.referrer.split('/')[4].split('.')[0];
		}
	
	//메뉴 active 제거 후 추가
	//$('.menu-inner').find('.active').removeClass('active');
	$('#menu_'+menu_sub).addClass('active');
	$('#menu_'+menu_main).addClass('open');
	$('#menu_'+menu_main).addClass('active');
	
	});
	

//조회권한 있는 부서리스트 이름
function depList() {
	$.ajax({
		type : 'get',
		url : '/depList.ajax',
		dataType : 'json',
		success : function(data) {
			//console.log(data);
			depList ='';
			for(var i=0; i<data.length; i++){
				depList +='<li class="menu-item" id="menu_postList'+data[i].dep_idx+'">';
				depList +='<a href="/post/postList'+data[i].dep_idx+'.move" class="menu-link">';
				depList +='<div data-i18n="Basic Inputs">'+data[i].name+'</div></a></li>';
			}
			$('#depList').empty();
			$('#depList').append(depList);
		},
		error : function(e) {
			console.log("에러: " + e);
		}
	});
}
	
</script>
</html>