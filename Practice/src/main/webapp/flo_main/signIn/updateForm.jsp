<%@page import="com.flo.model.BoardDAO"%>
<%@page import="com.flo.model.BoardVO"%>
<%@page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	BoardVO bvo = new BoardVO();
	bvo.setNum(num);
%>
<%
	try
	{
		BoardDAO bdao = BoardDAO.getInstance();
		BoardVO article = bdao.selectBoardOneDB(bvo);
%>

<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
%>

<style>
	.board_updateForm
	{
		width: 100%;
		border: none;
		padding: 0;
	}
	
	#fixed_icons_bar,
	#fixed_icons
	{
		margin-left:-500px;
		width:1600px;
	}
</style>

<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
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
<link href="style.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="Bscript.js?timestamp=<%= System.currentTimeMillis() %>"></script>
<script language="JavaScript" src="Bscript.js?timestamp=<%= System.currentTimeMillis() %>"></script>
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
<%if (id == null) {%>
            <li><a href="signIn.jsp">로그인</a></li>
            <%} else{ %>
            <li><a href="signIn.jsp"><font size="2.5pt"><%=id %>님, 환영합니다.</font></a></li>
            <%} %>
            
            
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
             <br>

		<form method="post" name="writeform" action="updateProc.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()" class="board_updateForm">
		<input type="hidden" name="num" value="<%=article.getNum()%>">
			<table width="500" border="1" cellpadding="0" cellspacing="0" style="margin-left: 480px; color: #333333;">
				<tr>
					<td width="70" align="center">이 름</td>
					<td align="left" width="330"><input type="text" size="10"
						maxlength="10" name="writer" style="width: 300px;
										margin-left: 7px;
										border: none;
										border-bottom: 1px solid #333333;
										outline: none;" value="<%=article.getWriter()%>">
						<%-- <input type="hidden" name="num" value="<%=article.getNum()%>"> --%></td>
				</tr>
				<tr>
					<td width="70" align="center">제 목</td>
					<td align="left" width="330"><input type="text" size="40"
						maxlength="50" name="subject" style="width: 300px;
										margin-left: 7px;
										border: none;
										border-bottom: 1px solid #333333;
										outline: none;" value="<%=article.getSubject()%>"></td>
				</tr>
				<tr>
					<td width="70" align="center">Email</td>
					<td align="left" width="330"><input type="text" size="40"
						maxlength="30" name="email" style="width: 300px;
										margin-left: 7px;
										border: none;
										border-bottom: 1px solid #333333;
										outline: none;" value="<%=article.getEmail()%>"></td>
				</tr>
				<tr>
					<td width="70" align="center">내 용</td>
					<td align="left" width="330"><textarea name="content"
							rows="13" cols="40" style="width: 400px;
										height: 400px;
										margin: 7px;
										border: 1px solid #333333;
										border-radius: 5px;
										outline: none;">
<%=article.getContent()%></textarea></td>
				</tr>
				<tr>
					<td width="70" align="center">비밀번호</td>
					<td align="left" width="330"><input type="password" size="8"
						maxlength="12" name="pass" style="width: 300px;
										margin-left: 7px;
										border: none;
										border-bottom: 1px solid #333333;
										outline: none;"></td>
				</tr>
				<tr>
					<td colspan=2 align="center">
					<input type="submit" value="글수정" style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';">
					<input type="reset" value="다시작성" style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';">
					<input type="button" value="목록으로" onclick="document.location.href='board.jsp?pageNum=<%=pageNum%>'" style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';">
					</td>
				</tr>
			</table>
			
				<div id="fixed_icons_bar" style="margin-left:-500px; width:1600px;"></div>
    
    <div id="fixed_icons" style="margin-left:-500px; width:1600px;">
        <i class="fa-solid fa-play fa-2x" id="play_button" style="color: #333333;"></i>
        <i class="fa-solid fa-forward-step fa-2x" id="forward_button" style="color: #333333;"></i>
        <i class="fa-solid fa-backward-step fa-2x" id="backward_button" style="color: #333333;"></i>
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
<%
	} catch (Exception e)
	{
	}
%>
</body>
</html>
