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

<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    ProductsInsertDAO dao = new ProductsInsertDAO();
    ProductsInsertVO product = dao.selectProducts()
                                     .stream()
                                     .filter(p -> p.getProductId() == productId)
                                     .findFirst()
                                     .orElse(null);
    if (product == null) {
        out.println("<script>alert('상품을 찾을 수 없습니다.'); window.location.href='productsList.jsp';</script>");
        return;
    }
%>

<html>
<head>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../style.css">
    <script language="javascript" src="../script.js?timestamp=<%= System.currentTimeMillis() %>"></script>
    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 목록</title>
    <style>
        table {
            width: 800px;
            height:200px;
            border-collapse: collapse;
            margin-top:50px;
            margin-left:50px;
            margin-right:50px;
        }
        th, td {
            border: 1px solid black;
            border-right:none;
            border-left:none;
            padding: 8px;
            text-align: center;
        }
        .action-btn {
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            background-color: #007BFF;
            border-radius: 3px;
            margin: 2px;
        }
        .delete-btn {
            background-color: #DC3545;
        }
    </style>
</head>
<body>
<div class="menu">
    <ul class="menu_contents_left">
        <li><a href="adminMainPage.jsp" class="logo">FLO</a></li>
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
        <li>
            <a href="signIn.jsp">
                <font size="2.5pt">관리자 <%=admin%>님, 환영합니다.</font>
            </a>
        </li>
        <li><a href="signUp.jsp">회원가입</a></li>
    </ul>
</div>

<h2 align="center">상품 수정</h2>

<form action="productsListModifyProc.jsp" method="post" enctype="multipart/form-data">
    <!-- 상품 ID를 hidden input으로 전달 -->
    <input type="hidden" name="productId" value="<%= product.getProductId() %>" />

    <div>
        <label for="name">상품명</label>
        <input type="text" id="name" name="name" value="<%= product.getName() %>" required />
    </div>

    <div>
        <label for="description">상품 설명</label>
        <textarea id="description" name="description" required><%= product.getDescription() %></textarea>
    </div>

    <div>
        <label for="price">가격</label>
        <input type="number" id="price" name="price" value="<%= product.getPrice() %>" step="0.01" required />
    </div>

    <div>
        <label for="imageUrl">기존 이미지</label><br/>
        <img src="${pageContext.request.contextPath}/uploads/<%= product.getImageUrl() %>" alt="기존 이미지" width="100" /><br/>
        <label for="newImage">새 이미지 (선택)</label>
        <input type="file" id="newImage" name="newImage" />
    </div>

    <button type="submit">수정 완료</button>
</form>


<div id="fixed_icons_bar"></div>

<div id="fixed_icons">
    <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i> 
    <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i> 
    <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
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
