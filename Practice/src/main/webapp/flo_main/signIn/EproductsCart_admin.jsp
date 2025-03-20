<%@page import="com.flo.model.ProductsVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.*" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="javax.*" %>
<%@page import="com.flo.model.ProductsDAO"%>


<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
	
/*     NO NUMBER(3),
    NAME VARCHAR2(100), -- pk & fk.
    PRICE VARCHAR2(50),
    USE_PERIOD NUMBER(3),   -- fk.
    TOTAL_PRICE NUMBER(6) */
	
		int no = (Integer)request.getAttribute("no");
    String name = (String)request.getAttribute("name");
    String price = (String)request.getAttribute("price");
    int usePeriod = (Integer)request.getAttribute("usePeriod");
/*     List<ProductsVO> pList =(List<ProductsVO>)request.getAttribute("productsList"); */

ProductsDAO pdao = new ProductsDAO();
ProductsVO pvo = new ProductsVO();

ArrayList <ProductsVO> pList = pdao.selectAllProducts();
    
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
            <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="writeForm.jsp">게시판</a></li>
            <li><a href="EproductsCart.jsp">Cart</a></li>
            <li><a href="EproductsForm.jsp">이용권</a></li>
        </ul>
        
        <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
            <li><a href="signIn.jsp"><%=id %>님, 환영합니다.</a></li>
            
            
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
    
    <br>
		<br>
<%
if(id!=null)
{
	%>
<h3 align="center"><%=id %>님의 구입예정 목록</h3><BR>
<%-- <%	
	for (ProductsVO p : pList)
	{
%> --%>

<div class=cart_list_div align="center">
<%
	}out.println(pList.toString());
%>

</div>


	
<%-- 	<div class=cart_div>
	<ul class=cart_ul>
	<li><span>NO. <%=no %></span></li>
	<li><span>상품명. <%=name %></span></li>
	<li><span>가격. <%=price %></span></li>
	<li><span>이용기간. <%=usePeriod %></span></li>
	</ul>
	</div> --%>
	
<%-- <%
	}
} else
{
	
	}

%> 
 --%>
		<div id="fixed_icons_bar"></div>

		<div id="fixed_icons">
			<i class="fa-solid fa-play fa-2x" id="play_button"
				style="color: #333333;"></i> <i
				class="fa-solid fa-forward-step fa-2x" id="forward_button"
				style="color: #333333;"></i> <i
				class="fa-solid fa-backward-step fa-2x" id="backward_button"
				style="color: #333333;"></i>
			<!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
		</div>
	</form>
	<br>
         <br>
     <hr id="footer_top">

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