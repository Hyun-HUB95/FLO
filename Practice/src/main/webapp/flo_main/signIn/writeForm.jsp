<!-- ✅✅✅✅✅BOARD테이블 생성 잊지 않기!!!!!!!!✅✅✅✅✅ -->

<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page contentType="text/html; charset=UTF-8"%>

<% 
	// 새로운 글 입력(num=0, ref=0, step=0, depth=0;)
	// 혹은 기존의 글에 새로운 글을 작성.(부모의 글에, 부모num=0, 부모ref=0, 부모step=0, 부모depth=0;)
	int num=0, ref=0, step=0, depth=0;

	try
	{ 
		if(request.getParameter("num")!=null)
	{
		num = Integer.parseInt(request.getParameter("num"));
		ref = Integer.parseInt(request.getParameter("ref"));
		step = Integer.parseInt(request.getParameter("step"));
		depth = Integer.parseInt(request.getParameter("depth"));
	}
		
		String filename1 = "";
		String origfilename1 = "";
		
%>

<%
	response.setContentType("text/html;charset=UTF-8");
	// String loginID = (String)session.getAttribute("loginID");
	String id = (String)session.getAttribute("id");
%>


<style>
	.board_writeForm
	{
		width: 100%;
		border: none;
		padding: 0;
	}
</style>



<!DOCTYPE html>
<html>
<head>
<title>My Board</title>
<link href="../style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../style.css">
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
</head>
<!--// 나중에 새글 답별글 구분하는 코드 추가 <1> -->
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
            <li><a href="signIn.jsp"><font size="3.5pt"><%=id %>님, 환영합니다.</font></a></li>
            <%} %>
            
            <li><a href="signUp.jsp">회원가입</a></li>
        </ul>
    </div>
         <br>
	<form method="post" name="writeForm" action="writeProc.jsp" onsubmit="return writeSave()" class="board_writeForm" enctype="multipart/form-data">
		<input type="hidden" name="num" value="<%=num%>"> <!-- num != 0이면 새롤운 글이 아님. -->
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="step" value="<%=step%>">
		<input type="hidden" name="depth" value="<%=depth%>">
		<table width="500" border="1" cellpadding="0" cellspacing="0" style="margin-left: 480px; color: #333333;">
			<tr>
				<td align="right"
						colspan="2"
						style="height:40px;">
					<a href="board.jsp"
							style="background:none;
											border: 1px solid #333333;
											border-radius: 5px;
											cursor: pointer;
											margin: 3px;
											padding: 3px;
											text-decoration: none;
											color: #333333;"
							onmouseover="this.style.backgroundColor='#f0f0f0';"
	    				onmouseout="this.style.backgroundColor='transparent';">
	    				목록으로
					</a>
				</td>
			</tr>
			<tr>
				<td style="width: 80px;" align="center">이름</td>
				<td>
					<input 
						type="text" 
						size="12" 
						maxlength="12"
						name="writer"
						style="width: 300px;
										margin-left: 7px;
										border: none;
										border-bottom: 1px solid #333333;
										outline: none;" />
				</td>
			</tr>
			<tr>
				<td style="width: 80px;" align="center">이메일</td>
				<td>
					<input
						type="text"
						size="30"
						maxlength="30"
						name="email"
						style="width: 300px;
										margin-left: 7px;
										border: none;
										border-bottom: 1px solid #333333;
										outline: none;" />
				</td>
			</tr>
			
			
			<tr>
				<td style="width: 80px;" align="center">제목</td>
				<td>
					<%
						if (request.getParameter("num") == null)
						{
					%>
				<input
					type="text"
					maxlength="50"
					name="subject"
					style="width: 300px;
									margin-left: 7px;
									border: none;
									border-bottom: 1px solid #333333;
									outline: none;" />

					<%
					} else {
					%>
				 	<input
					 	type="text"
					 	size="50"
					 	maxlength="50"
					 	name="subject"
						value="[답변]"
						style="width: 100px;" />
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td style="width: 80px;" align="center">내용</td>
				<!-- width 변경 -->
				<td>
					<textarea
						name="content"
						rows="13"
						cols="50"
						style="width: 400px;
										height: 400px;
										margin: 7px;
										border: 1px solid #333333;
										border-radius: 5px;
										outline: none;">
					</textarea>
				</td>
				<!-- width 변경 -->
			</tr>
			<tr>
				<td style="width: 80px;" align="center">비밀번호</td>
				<td>
					<input
						type="password"
						size="10"
						maxlength="10"
						name="pass"
						style="width: 300px;
										margin-left: 7px;
										border: none;
										border-bottom: 1px solid #333333;
										outline: none;" />
					</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
						<input type="hidden" name="filename1" value="<%=filename1%>">
						<input type="hidden" name="origfilename1" value="<%=origfilename1%>">
					<input type="file"
									name="filename1"
									value="파일"
									style="margin-left: 85px;
													margin-right: 40px" />
					<input type="submit"
									value="완료"
									onClick="window.location='board.jsp'"
									style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';" />
					<input type="reset"
									value="다시작성" 
									style="background: none;
													border: 1px solid #333333;
													border-radius: 5px;
													cursor: pointer;
													padding: 3px;
													margin: 3px;"
									onmouseover="this.style.backgroundColor='#f0f0f0';"
									onmouseout="this.style.backgroundColor='transparent';"/>
				<!-- <input type="button" value="목록" onClick="window.location=list.jsp?page=10"> -> 이런식으로 값을 추가해도 됨. 
								<input type="button" value="목록" onClick="window.location='board.jsp'">-->
				</td>
			</tr>
		</table>
		
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
	<!-- 예외처리<2> -->
<%
	} catch (Exception e)
	{
		e.printStackTrace();
	}
%>