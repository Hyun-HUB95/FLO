<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	response.setContentType("text/html;charset=UTF-8");
	String admin = (String) session.getAttribute("id");
	if (admin == null || !admin.equals("admin"))
	{
    response.sendRedirect("signIn.jsp");
    return;
	}
%>

<!DOCTYPE html>
<html>
<head>
    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <script src="../carousel.js"></script>
    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="style.css">

		<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="signIn.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
		
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta charset="UTF-8">
		
		
<title>관리자 상품등록 페이지</title>
		<sytle>
		
		
		
		</sytle>
</head>
<body>
	<div class="menu">
		<ul class="menu_contents_left">
			<li><a href="adminMainPage.jsp" class="logo">FLO</a></li>
			<!--폰트 스타일 적용하기.-->
			<li><a href="board_admin.jsp">게시판</a></li>
			<li><a href="adminInsert.jsp">상품등록</a></li>
			<li><a href="productsList.jsp">이용권</a></li>
		</ul>

		<ul class="menu_contents_center">
			<li><i class="fa-solid fa-magnifying-glass"></i><input
				type="text" name="search" id="search"
				placeholder="       검색어를 입력하세요."></li>
		</ul>

		<ul class="menu_contents_right">
			<!-- 관리자 계정일 때 -->
			<li>
				<a href="signIn.jsp">
					<font size="2.5pt">관리자 <%=admin%>님, 환영합니다.</font>
				</a>
			</li>
			<li><a href="signUp.jsp">회원가입</a></li>
		</ul>
	</div>
	<div align="center">
	<h2>상품 등록</h2>
	<br>
	<form action="adminInsertProc.jsp" method="post" enctype="multipart/form-data">
		<div style="display: flex; justify-content: space-between; align-items: center; width: 100%; margin-bottom: 10px;">
			<label style="width: 30%;">상품명:</label>
			<input type="text" name="name" required style="flex: 1; border: none; border-bottom: 1px solid #000;">
		</div>

		<div style="display: flex; justify-content: space-between; align-items: center; width: 100%; margin-bottom: 10px;">
			<label style="width: 30%;">상품 설명:</label>
			<textarea name="description" required style="flex: 1; border: none; border-bottom: 1px solid #000; resize: none;"></textarea>
		</div>

		<div style="display: flex; justify-content: space-between; align-items: center; width: 100%; margin-bottom: 10px;">
			<label style="width: 30%;">가격:</label>
			<input type="number" name="price" step="0.01" required style="flex: 1; border: none; border-bottom: 1px solid #000;">
		</div>

		<div style="display: flex; justify-content: space-between; align-items: center; width: 100%; margin-bottom: 10px;">
			<label style="width: 30%;">이미지:</label>
			<input type="file" name="image" accept="image/*" required style="flex: 1;">
		</div>

		<br>
		<input type="submit" value="등록">
	</form>
</div>



	<div id="fixed_icons_bar"></div>

	<div id="fixed_icons">
		<i class="fa-solid fa-play fa-2x" id="play_button"
			style="color: #333333;"></i> <i
			class="fa-solid fa-forward-step fa-2x" id="forward_button"
			style="color: #333333;"></i> <i
			class="fa-solid fa-backward-step fa-2x" id="backward_button"
			style="color: #333333;"></i>
	</div>

	<br>
			<hr id="footer_top">
			<footer>
				<div id="first">
					<ul id="first_ul">
						<li>고객센터</li>
						<li>공지사항</li>
						<li></li>
						<li></li>
					</ul>
				</div>

				<div id="second">
					<ul id="second_ul">
						<li>FLO 서비스</li>
						<li>FLO 크리에이터 스튜디오</li>
						<li>FLO 플레이어 다운로드</li>
						<li>서비스 소개</li>
					</ul>
				</div>

				<div id="third">
					<ul id="third_ul">
						<li>기업 정보</li>
						<li>회사소개</li>
						<li>인재 채용</li>
						<li></li>
					</ul>
				</div>

				<div id="fourth">
					<ul id="fourth_ul">
						<li>문의</li>
						<li>마케팅・광고・제휴 문의</li>
						<li>서비스 이용 문의</li>
						<li>음원 유통 문의</li>
					</ul>
				</div>
			</footer>
</body>
</html>