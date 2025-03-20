<%@page import="com.flo.model.ProductsVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html;charset=UTF-8"%>  <!-- contentType 중복 제거 -->
<%@page import="java.*" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="javax.*" %>
<%@page import="com.flo.model.ProductsDAO"%>
<%@ page import="com.flo.model.CartDAO" %>
<%@ page import="com.flo.model.CartVO" %>
<%@ page import="java.util.*" %>



<%
// CartDAO 객체 생성하여 cartList를 가져옵니다.
CartDAO cartDAO = new CartDAO();
List<CartVO> cartList = cartDAO.selectAllCart();  // selectAllCart() 메서드에서 cartList를 가져옵니다.

    response.setContentType("text/html;charset=UTF-8");
    String id = (String) session.getAttribute("id");

    // 로그인 안 된 경우 alert 메시지 및 로그인 페이지로 리다이렉트
    if (id == null) {
%>
        <script>
            alert("로그인 후 이용해 주세요.");
            window.location.href = "signIn.jsp";  // 로그인 페이지로 리다이렉트
        </script>
<%
        return; // 이후 코드 실행을 막고 스크립트만 실행하도록 함
    }
%>
        
        <%
    String[] selectedProducts = request.getParameterValues("product[]");
    if (selectedProducts != null) {
        for (String product : selectedProducts) {
            out.println("선택된 상품: " + product);  // 상품 이름과 정보를 출력
            // 상품 처리 로직...
            String[] productDetails = product.split("\\|");
            String name = productDetails[0];
            String price = productDetails[1];
            int usePeriod = Integer.parseInt(productDetails[2]);

            CartVO cartVO = new CartVO();
            cartVO.setName(name);
            cartVO.setPrice(price);
            cartVO.setUsePeriod(usePeriod);
            boolean isAdded = cartDAO.addCart(cartVO);
            if (!isAdded) {
                out.println("상품 추가 실패: " + name);
            }
        }
    }
%>


    
<!DOCTYPE html>
<html lang="ko">
<head>
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
    <title>가볍게, 나답게 FLO</title>
 
    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <script src="../carousel.js"></script>
    <link rel="stylesheet" href="../style.css">
</head>
<body onload="carousel();">
<div class="menu">
    <ul class="menu_contents_left">
        <li><a href="main.jsp" class="logo">FLO</a></li>
        <li><a href="board.jsp">게시판</a></li>
        <li><a href="EproductsCart.jsp">Cart</a></li>
        <li><a href="EproductsForm.jsp">이용권</a></li>
    </ul>
    
    <ul class="menu_contents_center">
        <li><i class="fa-solid fa-magnifying-glass" style="color: #333333;"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
    </ul>

    <ul class="menu_contents_right">
        <li><a href="signIn.jsp"><%= id %>님, 환영합니다.</a></li>
        <li><a href="signUp.jsp">회원가입</a></li>
    </ul>
</div>
    
<br>
<br>

<%  // 로그인된 경우에만 아래 코드를 실행
    if (id != null) {
%>
    <h3 align="center" style="font-family: 'IBM Plex Sans', sans-serif; color: #333; font-weight: bold;"> <%= id %>님의 구입예정 목록</h3><BR>

    <div class="cart_list_div" align="center" style="width: 80%; margin: 0 auto;">
        <h2>장바구니</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>이용기간</th>
                    <th>총 가격</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Loop through the cartList and display each item
                    for (CartVO cart : cartList) {
                %>
                <tr>
                    <td><%= cart.getName() %></td>
                    <td><%= cart.getPrice() %>원</td>
                    <td><%= cart.getUsePeriod() %>개월</td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </div>

    <br>
    <a href="EproductsForm.jsp">이용권 목록으로 돌아가기</a>

<% 
    } else {
%>
    <script>
        alert("로그인이 필요합니다.");
        window.location.href = "signIn.jsp";  // 로그인 페이지로 리다이렉트
    </script>
<%
    }
%>






<div id="fixed_icons_bar"></div>

<div id="fixed_icons">
    <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i> 
    <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i> 
    <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
</div>

<br>
<br>
<hr id="footer_top">

</body>
</html>


    <footer>
        <div id="first">
            <ul id="first_ul">
                <li>　　　　　　　　　　　고객센터</li>
                <li>　　　　　　　　　　　공지사항</li>
                <li>　　　　　　　　　　　</li>
                <li>　　　　　　　　　　　</li>
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
                <li>　</li>
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
