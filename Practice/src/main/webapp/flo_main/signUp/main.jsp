<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.*" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="javax.*" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
    
    
    <title>가볍게, 나답게 FLO</title>

    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <script src="../carousel.js"></script>
    <link rel="stylesheet" href="../style.css">
        <link rel="stylesheet" href="style.css">

</head>
<body onload="carousel();">
    <div class="menu">
        <ul class="menu_contents_left">
            <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
            <li><a href="board.jsp">둘러보기_게시판</a></li>
            <li><a href="Flo_Main.html">보관함</a></li>
            <li><a href="Flo_Main.html">이용권</a></li>
        </ul>
        
        <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
            <li><a href="signIn.jsp">로그인</a></li>
            
            
            <li><a href="/Practice/flo_main/signUp/signUp.jsp">회원가입</a></li>
        </ul>
    </div>

    <!-- 회전목마 구간. -->
    <div class="slideShow">
        <!-- slideShow안에 3명의 자식. -->
         <!-- onmouseenter="" 안씀. -->
        <div class="slideShow_slides">
            <a href="#"><img src="../img/flo1.png" alt="slide-1"></a>
            <a href="#"><img src="../img/flo2.png" alt="slide-2"></a>
            <a href="#"><img src="../img/flo3.png" alt="slide-3"></a>
            <a href="#"><img src="../img/flo4.png" alt="slide-4"></a>
        </div>

        <!-- 아이콘. -->
        <div class="slideShow_nav">
            <a href="#" class="pre"><i class="fa-solid fa-circle-chevron-left"></i></a>
            <a href="#" class="next"><i class="fa-solid fa-circle-chevron-right"></i></a>
        </div>

        <div class="slideShow_indicator">
            <a href="#" class="active"><i class="fa-solid fa-circle-dot"></i></a>
            <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
            <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
            <a href="#"><i class="fa-solid fa-circle-dot"></i></a>
        </div>
    </div>
    
        <div id="testing"></div>

    <div id="fixed_icons">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
        <!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
    </div>
</body>
</html>