<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="com.flo.model.BoardDAO"%>
<%@page import="com.flo.model.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page contentType="text/html; charset=UTF-8"%>

<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id2 = (String)session.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD MAIN</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="BoardTest.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
<script language="javascript" src="Bscript.js?timestamp=<%= System.currentTimeMillis() %>"></script>
</head>

<div class="menu">
    <ul class="menu_contents_left">
        <li><a href="main.jsp" class="logo">FLO</a></li>    <!--폰트 스타일 적용하기.-->
        <li><a href="board.jsp">게시판</a></li>
            <li><a href="EproductsCart.jsp">Cart</a></li>
            <li><a href="EproductsForm.jsp">이용권</a></li>
        </ul>
        
        <ul class="menu_contents_center">
            <li><i class="fa-solid fa-magnifying-glass"></i><input type="text" name="search" id="search" placeholder="       검색어를 입력하세요."></li>
        </ul>

        <ul class="menu_contents_right">
<%if (id2 == null) {%>
            <li><a href="signIn.jsp">로그인</a></li>
            <%} else{ %>
            <li><a href="signIn.jsp"><font size="2.5pt"><%=id2 %>님, 환영합니다.</font></a></li>
            <%} %>    
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
<body class="board_body">

    <div align="center" class="board_top">
        <h1>게시판</h1>
        <ul>
            <li><a href="#">공지사항</a></li>
            <li><a href="#">자주묻는 질문</a></li>
            <li><a href="#">응원함</a></li>
        </ul>
    </div>

    <div align="left" class="board_left" width="400px">
        <aside>
            <ul>
                <li><a href="writeForm.jsp">글쓰기</a></li>
                <li><a href="writeForm.jsp">자유게시판</a></li>
                <li><a href="writeForm.jsp">1:1 문의</a></li>
                <li><a href="writeForm.jsp">기타[TEST]</a></li>
                <li><a href="writeForm.jsp">기타[TEST]</a></li>
            </ul>
        </aside>
    </div>
           <%@ include file="list.jsp"%>
    <div id="fixed_icons_bar"></div>
    
    <div id="fixed_icons">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
        <!-- <a href="main.html"><span id=up_fixed><i class="fa-solid fa-arrow-up fa-2x"></i></span></a>
        <a href="main.html"><span id=settings_fixed><i class="fa-solid fa-gear fa-2x"></i></span></a> -->
    </div>

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
</body>
</html>