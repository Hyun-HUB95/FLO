<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.*" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="javax.*" %>
<%@page import="com.flo.model.ProductsDAO"%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@taglib tagdir="/WEB-INF/tags" prefix="product" %> --%>


<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
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
		<script>
		   function payment()
		   {
			   if ( name && price !== null && usePeriod !== 0)
		         alert('이용권을 담았습니다. 장바구니로 이동합니다.');
		         location.href ='EproductsCart.jsp';
		   }
	</script>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="menu">
        <ul class="menu_contents_left">
            <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="board.jsp">게시판</a></li>
            <li><a href="EproductsCart.jsp">Cart</a></li>
            <li><a href="EproductsForm.jsp">이용권</a></li>
        </ul>
        
         <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass" style="color: #333333;"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
            <li><a href="signIn.jsp"><font size="3.5pt"><%=id %>님 환영합니다.</font></a></li>
            
            
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
    
    <br>
		<br>


<h2 align="center" style="color:#333333; font-family: 'IBM Plex Sans', sans-serif; font-weight: bold;">FLO 이용권</h2>
<form action="EproductsCart.jsp" method="POST" class="products_form" style="color:#333333; padding-top:10px;">
    <div class="products_div" style="margin-top: 20px; margin-left: -30px;">
        <ul class="products_ul" style="list-style-type: none; padding: 0; width: 100%;">

            <!-- 첫 번째 상품 -->
            <li style="display: flex; align-items: center; margin-bottom: 15px; border-radius: 8px; margin-right:100px;">
                <img alt="12개월 특별 할인권" src="../img/12개월 특별 할인권.jpg" style="width: 1200px; height: 120px; margin-right: 20px; border-radius: 8px;">
                <div>
                    <h4 style="margin: 0; font-size: 18px; color: #333; font-weight: bold;">12개월 특별 할인권</h4>
                    <p style="margin: 5px 0; font-size: 14px; color: #777; white-space: nowrap;">가격: 14,000원 | 이용기간: 12개월</p>
                    <label><input type="checkbox" name="product[]" value="12개월 특별 할인권"> 선택</label>
                </div>
            </li>

            <!-- 두 번째 상품 -->
            <li style="display: flex; align-items: center; margin-bottom: 15px; border-radius: 8px; margin-right:100px;">
                <img alt="FLO 첫 달 100원" src="../img/FLO 첫 달 100원.jpg"  style="width: 1200px; height: 120px; margin-right: 20px; border-radius: 8px;">
                <div style="width: 600px;">
                    <h4 style="margin: 0; font-size: 18px; color: #333; font-weight: bold;">FLO 첫 달 100원</h4>
                    <p style="margin: 5px 0; font-size: 14px; color: #777; white-space: nowrap;">가격: 100원 | 이용기간: 1개월</p>
                    <label><input type="checkbox" name="product[]" value="FLO 첫 달 100원"> 선택</label>
                </div>
            </li>

            <!-- 세 번째 상품 -->
            <li style="display: flex; align-items: center; margin-bottom: 15px; border-radius: 8px; margin-right:150px;">
                <img alt="지식 콘텐츠와 음악을 한 번에" src="../img/지식 콘텐츠와 음악을 한 번에.jpg" style="width: 1200px; height: 120px; margin-right: 20px; border-radius: 8px;">
                <div style="width: 600px;">
                    <h4 style="margin: 0; font-size: 18px; color: #333; font-weight: bold;">지식 콘텐츠와 음악을 한 번에</h4>
                    <p style="margin: 5px 0; font-size: 14px; color: #777; white-space: nowrap;">가격: 9,000원 | 이용기간: 12개월</p>
                    <label><input type="checkbox" name="product[]" value="지식 콘텐츠와 음악을 한 번에"> 선택</label>
                </div>
            </li>

            <!-- 네 번째 상품 -->
            <li style="display: flex; align-items: center; margin-bottom: 15px; border-radius: 8px; margin-right:100px;">
                <img alt="모바일 무제한 스트리밍" src="../img/모바일 무제한 스트리밍.jpg" style="width: 1200px; height: 120px; margin-right: 20px; border-radius: 8px;">
                <div style="width: 600px;">
                    <h4 style="margin: 0; font-size: 18px; color: #333; font-weight: bold;">모바일 무제한 스트리밍</h4>
                    <p style="margin: 5px 0; font-size: 14px; color: #777; white-space: nowrap;">가격: 6,900원 | 이용기간: 1개월</p>
                    <label><input type="checkbox" name="product[]" value="모바일 무제한 스트리밍"> 선택</label>
                </div>
            </li>
        </ul>

        <input type="submit" value="장바구니 추가" 
        							style="background:none;
											border: 1px solid #333333;
											border-radius: 5px;
											cursor: pointer;
											margin-top: 20px;
											margin-left: 665px;
											padding: 10px;
											text-decoration: none;
											color: #333333;"
							onmouseover="this.style.backgroundColor='#f0f0f0';"
	    				onmouseout="this.style.backgroundColor='transparent';">
    </div>
		
		 	<div id="fixed_icons_bar"></div>
    
    <div id="fixed_icons">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
        <!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
    </div>
</form>



	<br>
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