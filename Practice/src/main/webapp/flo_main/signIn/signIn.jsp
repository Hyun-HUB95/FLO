<%@page import="com.flo.model.AdminVO"%>
<%@page import="com.flo.model.MemberVO"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.*" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="javax.*" %>

<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
	
/* 	AdminVO data = (AdminVO)session.getAttribute("id");
	data.setId(id); */
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
<%		if (id == null)
			{
%>
			<li><a href="signIn.jsp">로그인</a></li>
			<li><a href="signUp.jsp">회원가입</a></li>
			</ul>
			</div>
			<form method="post" action="signInProc.jsp">
        <div class="signIn" align="center">
            <div class="form-id inner-row v2">
                <input id="id" type="text" name="id" placeholder="아이디(이메일)" tabindex="0" autocomplete="on" autocorrect="off" spellcheck="false" class="inputTxt">
                <hr id="underLine">
                <br>
                <input id="pwd" name="pwd" type="password" placeholder="비밀번호" autocomplete="off" autocorrect="off" spellcheck="false" class="inputTxt">
                <hr id="underLine">
                <br>
                <span  style="color:#333333;"><input data-v-3b9efe22="" id="signinSavedId" type="checkbox">&nbsp;&nbsp;아이디 저장</span>
            </div>

            <!-- 소셜로그인시 넘어가는 링크까지는 넣어주기
            T ID - https://auth.skt-id.co.kr/v2/login?transaction_id=a3e23e28-0d01-4c52-8a7e-20508de0df25&state=193e2ae51f02d333137322d64&authenticator_type=SESSION&api_version=0 -->
            <br>
            <div class="signInBtn" align="center">
                <input id="signIn" type="submit" value="로그인"  style="cursor:pointer;">
            </div>
            <br>
            <br>

            <div class="findInfo" style="margin-left:110px;">
                <ul>
                    <li>
                        <a href="#">아이디 찾기</a>
                    </li>
                    <p>｜　</p>
                    <li>
                        <a href="#">비밀번호 찾기</a>
                    </li>
                </ul>
            </div>

            <div class="howToSignIn" align="center">
                <ul>
                    <li id="tSignIn">
                        <a href="#">T 아이디로 로그인</a>
                    </li>
                    <li id="phoneSignIn">
                        <a href="#">휴대폰 번호로 로그인</a>
                    </li>
                </ul>
                <span>이 사이트는 reCAPTCHA로 보호되며 Google 개인정보처리방침 및 서비스 약관이 적용됩니다.</span>
            </div>
        </div>
        </form>
<%
			} else if(id.equals("admin"))
			{
			// 관리자 계정일 때, adminPage로 Redirect
        response.sendRedirect("adminPage.jsp");
%>
<%-- 			<%@ include file="adminPage.jsp"%> --%>
			
			<%-- <li>
				<a href="signIn.jsp">
					<font size="2.5pt">관리자 <%=id%>님, 환영합니다.</font>
				</a>
			</li>
			<div id="welcome" align="center">
				<br>
				<br>
				<ul align="center">
					<li><a href="modifyForm.jsp">정보수정</a></li>
					<li><a href="deleteForm.jsp">회원탈퇴</a></li>
					<li><a href="logout.jsp">로그아웃</a></li>
				</ul>
			</div> --%>
<%
			} else
			{
%>
		<ul class="menu_contents_right">
			<li>
				<a href="signIn.jsp">
					<font size="3.5pt"><%=id%>님, 환영합니다.</font>
				</a>
			</li>
			<li><a href="signUp.jsp">회원가입</a></li>
	</ul>
				</div>

			<div id="welcome" align="center" style="color:#333333;">
			<br><br><br>
				<h3><%=id%>님 환영합니다.</h3>
				<br>
				<br>
				<ul align="center">
					<li><a href="modifyForm.jsp" style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;
													color:#333333;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';">정보수정</a></li>
					<li><a href="deleteForm.jsp" style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;
													color:#333333;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';">회원탈퇴</a></li>
					<li><a href="logout.jsp" style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;
													color:#333333;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';">로그아웃</a></li>
				</ul>
<%
			}
%>    
        <br>
        <br>
				<br>
			</div>
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
</html>