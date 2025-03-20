<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, com.flo.model.ProductsInsertDAO, com.flo.model.ProductsInsertVO" %>

<%
	response.setContentType("text/html;charset=UTF-8");
	String admin = (String) session.getAttribute("id");
	if (admin == null || !admin.equals("admin"))
	{
    response.sendRedirect("signIn.jsp");
    return;
	}
%>


<html>
<head>
<link href="../style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../style.css">
<link href="style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../script.js?timestamp=<%= System.currentTimeMillis() %>"></script>
<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="signUp.css">
    <link rel="stylesheet" href="../style.css">
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">





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
    <title>상품 목록</title>
	<style>
		table
		{
			width: 700px; /* 너비 줄이기 */
			height: 200px;
			border-collapse: collapse;
			margin-top: 50px;
			margin-left: 50px;
			margin-right: 50px;
		}
		
		th, td
		{
			border: 1px solid black;
			border-right: none;
			border-left: none;
			padding: 8px;
			text-align: center;
		}
		
		.action-btn
		{
			padding: 5px 10px;
			text-decoration: none;
			color: white;
			background-color: #007BFF;
			border-radius: 3px;
			margin: 2px;
		}
		
		.delete-btn
		{
			background-color: #DC3545;
		}
	</style>
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
    <h2 align="center">상품 목록</h2>

    <%
        // DAO 객체 생성하여 selectProducts() 호출
        ProductsInsertDAO dao = new ProductsInsertDAO();
        ArrayList<ProductsInsertVO> productsList = dao.selectProducts();
        request.setAttribute("productsInsertList", productsList);
    %>

    <!-- 상품 목록을 테이블로 출력 -->
    <table>
        <thead>
            <tr>
                <th>NO.</th>
                <th>상품명</th>
                <th>상품 설명</th>
                <th>가격</th>
                <th>이미지</th>
                <th>등록일</th>
                <th>수정일</th>
                <th>　</th>
                                <th>　</th>
                <!-- 수정과 삭제 버튼을 위한 열 추가 -->
            </tr>
        </thead>
        <tbody>
            <!-- ${productsInsertList}로 전달된 상품 리스트를 반복문으로 출력 -->
            <c:forEach var="product" items="${productsInsertList}">
                <tr>
                    <td>${product.productId}</td> <!-- 상품 고유 ID -->
                    <td>${product.name}</td> <!-- 상품명 -->
                    <td>${product.description}</td> <!-- 상품 설명 -->
                    <td>${product.price}</td> <!-- 가격 -->
                    <td><img src="${pageContext.request.contextPath}/uploads/${product.imageUrl}" alt="상품 이미지" width="100"></td> <!-- 이미지 -->
                    <td>${product.createdAt}</td> <!-- 등록일 -->
                    <td>${product.updatedAt}</td> <!-- 수정일 -->
                    <td>　<td>
    <!-- 수정 버튼 -->
    <a href="productsListModifyForm.jsp?productId=${product.productId}" class="action-btn">수정</a>

    <!-- 삭제 버튼 -->
    <a href="productsDeleteProc.jsp?action=delete&productId=${product.productId}" class="action-btn delete-btn" onclick="return confirm('정말로 이 상품을 삭제하시겠습니까?');">삭제</a>
</td>

                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>


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
