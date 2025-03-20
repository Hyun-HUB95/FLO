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

<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
%>
    
    
    <title>가볍게, 나답게 FLO</title>

    <script src="https://kit.fontawesome.com/b551008ea2.js" crossorigin="anonymous"></script>
    <script src="../carousel.js"></script>
    <link rel="stylesheet" href="../style.css">
    
    <style>
     .top_detail_title > a,
     .top_detail_info > a
     {
     	text-decoration: none;
     	color: #333333;
     }
     
     .top_detail_info > span
     {
     	text-decoration: none;
     	color: #969696;
     }
    </style>

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
<%
	if (id == null)
	{
%>
            <li><a href="signIn.jsp">로그인</a></li>
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
<%
	} else if(id.equals("admin"))
	{
	// 관리자 계정일 때, adminPage로 Redirect
	response.sendRedirect("adminPage.jsp");
%>
	
<%
	} else
	{
%>
            <li><a href="signIn.jsp"><font size="2.5pt"><%=id %>님, 환영합니다.</font></a></li>
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
<%
	}
%>
    
  <!-- 오늘 발매 음악 상세. -->
	 <div class="top_detail">
        <div class="top_detail_img">
            <a href="#">
                <img src="main_images/Main_albums_1.jpg" alt="Main_albums_1">
            </a>
        </div>
        <div class="top_detail_title">
            <a href="#"><h2>Cold Wind, Warm Breeze</h2></a>
            <div class="top_detail_info">
                <a href="#"><h4>Angelina danilova</h4></a>
                <span style="color: #333333;">&</span>
                <a href="#"><h4>마커스 웨이 (Marcus Way)</h4></a>
                <br>
                <span>싱글인디 ｜ 포크</span>
                <span>2025.01.08</span>
            </div>
        </div>
        
        <!-- <ul>
            <li><a href="#"><h2>Cold Wind, Warm Breeze</h2></a></li>
            <li><a href="#"><h4>Angelina danilova</h4></a></li>
            <span>&</span>
            <li><a href="#"><h4>마커스 웨이 (Marcus Way)</h4></a></li>
        </ul> -->
    </div>

    <div class="btn_div" style="margin-left: 90px;">
        <input type="button" value="상세보기" >
        <input type="button" value="수록곡">
    </div>
    
    <div class="body_detail_01">
        <a href="#"><h4>▷전체듣기</h4></a>

        <table class="main_today_albums" style="color:#333333;">
            <tr>
                <td>
                    <input type="checkbox" id="un">
                </td>
                <td>
                    <span>번호</span>
                </td>
                <td>
                    <span>곡/앨범</span>
                </td>
                <td></td>
                <td>
                    <span>아티스트</span>
                </td>
                <td>
                    <span>듣기</span>
                </td>
                <td>
                    <span>재생목록</span>
                </td>
                <td>
                    <span>내리스트</span>
                </td>
                <td>
                    <span>더보기</span>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="checkbox" id="un">
                </td>
                <td align="center">
                    <span>1</span>
                </td>
                <td>
                    <a href="#"><img src="main_images/Main_albums_1.jpg" alt="Main_albums_1"></a>
                </td>
                
                <td>
                    <a href="#">
                        <p id="title"><span style="color: red;">TITLE</span> Wind, Warm Breeze</p>
                        <br>
                        <span>Cold Wind, Warm Breeze</span>
                    </a>
                </td>
                <td>
                    <a href="#">
                        <span>Angelina danilova & 마커스 웨이 (Marcus Way)</span>
                    </a>
                </td>
            </tr>
        </table>
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