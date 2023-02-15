<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>

<head>

</head>

<body>
	<nav
		class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
		id="layout-navbar">
		<div
			class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
			<a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
				<i class="bx bx-menu bx-sm"></i>
			</a>
		</div>

		<div class="navbar-nav-right d-flex align-items-center"
			id="navbar-collapse">

			<ul class="navbar-nav flex-row align-items-center ms-auto">
				<!-- 쪽지 아이콘 -->
				<li class="nav-item lh-1 me-3">
					<button type="button"
						class="btn rounded-pill btn-icon btn-secondary" onclick="location.href='/mail/receivedList.move'">
						<span class="tf-icons bx bx-envelope"></span>
					</button>
				</li>

				<li class="nav-item lh-1 me-3 avatar avatar-away">
					<button type="button" class="btn rounded-pill btn-icon btn-primary"
						id="noti_button" data-bs-toggle="offcanvas"
						data-bs-target="#notiOffcanvas" aria-controls="offcanvasScroll" onclick="notiInBoxAjax()">
						<span class="tf-icons bx bx-bell"></span>
					</button>
				</li>

				<!-- User -->
				<li class="nav-item navbar-dropdown dropdown-user dropdown"><a
					class="nav-link dropdown-toggle hide-arrow"
					href="javascript:void(0);" data-bs-toggle="dropdown">
<!-- 					<img src="../assets/img/avatars/1.png" class="w-px-40 h-auto rounded-circle" /> -->
					<img src="/photo/${sessionScope.profileImg}" class="w-px-40 h-auto rounded-circle"/>
				</a>
					<ul class="dropdown-menu dropdown-menu-end">
						<li><a class="dropdown-item" href="/member/mem_detail.move">
								<div class="d-flex">
									<div class="flex-shrink-0 me-3">
										<img src="/photo/${sessionScope.profileImg}" alt
											class="w-px-40 h-auto rounded-circle" />
									</div>
									<div class="flex-grow-1">

										<!-- 세션 추가수정 필요 -->
										<span class="fw-semibold d-block">${sessionScope.name}</span> 
										<span class="fw-semibold d-block">ID: ${sessionScope.loginId}</span> 
										<small class="text-muted">${sessionScope.dep}</small>
									</div>
								</div>
						</a></li>
						<li>
							<div class="dropdown-divider"></div>
						</li>
						<li><a class="dropdown-item" href="/logout.do">
								<i class="bx bx-power-off me-2"></i> <span class="align-middle">로그아웃</span>
						</a></li>
					</ul></li>
				<!--/ User -->
			</ul>
		</div>
	</nav>

	<!-- 	알림 모달 -->
	<%@ include file="noti/notiOffcanvas.jsp" %>
</body>
<script>
</script>
</html>